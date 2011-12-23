package com.boblu.lurunner
{
	import com.boblu.lurunner.runner.List;
	import com.boblu.lurunner.runner.ui.Color;
	import com.boblu.lurunner.runner.ui.FailListItem;
	import com.boblu.lurunner.runner.ui.Header;
	import com.boblu.lurunner.runner.ui.IgnoreListItem;
	import com.boblu.lurunner.runner.ui.StatusBar;
	import com.boblu.lurunner.runner.ui.SuccessListItem;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.utils.getTimer;
	import org.flexunit.runner.IDescription;
	import org.flexunit.runner.notification.Failure;
	import org.flexunit.runner.notification.IRunListener;
	import org.flexunit.runner.Result;
	
	/**
	 * The Loose Unit Runner for displaying the test results without MXML
	 * @author Bob Dahlberg
	 */
	public class LURunner extends Sprite implements IRunListener 
	{
		public static const SUCCESS:uint 	= 0x009900;
		public static const FAILED:uint 	= 0xcc0000;
		public static const IGNORED:uint 	= 0xff9900;
		
		private var _color:Color;
		private var _successCol:Color;
		private var _ignoredCol:Color;
		private var _failedCol:Color;
		
		private var _statusBar:StatusBar;
		
		private var _width:Number;
		private var _testFailed:Boolean;
		private var _resultList:List;
		
		private var _success:Array 	= [];
		private var _failed:Array 	= [];
		private var _ignored:Array 	= [];
		
		private var _sucessTime:Array = [];
		private var _failedTime:Array = [];
		
		private var _timeKeeper:int = -1;
		private var _testTimeKeeper:int = -1;
		
		private var _header:Header;
		private var _testCount:int;
		private var _currentTest:int;
		
		/**
		 * Creates a new LURunner instance
		 */
		public function LURunner()
		{
			init();
		}
		
		/** Sets up the GUI elements */
		private function init():void 
		{
			_header 	= new Header( 0x222222 );
			_resultList	= new List();
			
			_color 		= new Color( 0x222222 );
			_statusBar	= new StatusBar();
			
			_testCount = 0;
			_currentTest = 0;
			
			addChildren( _color, _resultList, _header, _statusBar );
			addEventListener( Event.ADDED_TO_STAGE, onAdded );
		}
		
		/**
		 * Adds functionality to the runner shell
		 * @param	e	The onAdded event
		 */
		private function onAdded(e:Event):void 
		{
			removeEventListener( Event.ADDED_TO_STAGE, onAdded );
			stage.addEventListener( Event.RESIZE, onResize );
			stage.addEventListener( KeyboardEvent.KEY_DOWN, onKeyDown );
			onResize();
		}
		
		/**
		 * Called when a test run i started
		 * @param	description		The FlexUnit Description of the test
		 */
		public function testRunStarted( description:IDescription ):void
		{
			_testCount = description.testCount;
			if( _timeKeeper < 0 )
			{
				_timeKeeper = getTimer();
			}
		}
		
		/**
		 * Called when a test is ignored
		 * @param	description		The FlexUnit Description of the test
		 */
		public function testIgnored( description:IDescription ):void
		{
			updateTestCount();
			_ignored.push( description );
		}
		
		/**
		 * Called when ever a test is started
		 * @param	description		The FlexUnit Description of the test
		 */
		public function testStarted( description:IDescription ):void
		{
			updateTestCount();
			_testFailed = false;
			_success.push( description );
			_testTimeKeeper = getTimer();
		}
		
		/**
		 * Updates the testcount and sends that information to the header to display
		 */
		private function updateTestCount():void
		{
			_currentTest++;
			_header.runningTest( _currentTest, _testCount );
		}
		
		/**
		 * Called when a test assumtion fails
		 * @param	failure		The FlexUnit Failure
		 */
		public function testAssumptionFailure( failure:Failure ):void
		{
			trace( "## testAssumptionFailure: "+ failure.message );
		}
		
		/**
		 * Called when a test fails
		 * @param	failure		The FlexUnit Failure of the test
		 */
		public function testFailure( failure:Failure ):void
		{
			_testFailed = true;
			_success.pop();
			_failed.push( failure );
		}
		
		/**
		 * Called when ever a test has finished (only happens if the tests fails or succeeds)
		 * @param	description		The FlexUnit Description of the test
		 */
		public function testFinished( description:IDescription ):void
		{
			var time:int = ( getTimer() - _testTimeKeeper );
			if( _testFailed )
			{
				_failedTime.push( time );
			}
			else
			{
				_sucessTime.push( time );
			}
		}
		
		/**
		 * Called when a test run is finished
		 * Updates the list, header and status bar with the result data
		 * @param	result		The result of the test run
		 */
		public function testRunFinished( result:Result ):void
		{
			var i:int;
			for( i = 0; i < _failed.length; i++ )
			{
				var failItem:FailListItem = new FailListItem( _failed[i], _failedTime[i] );
				_resultList.addItem( failItem );
			}
			for each( var ignored:IDescription in _ignored )
			{
				var ignoreItem:IgnoreListItem = new IgnoreListItem( ignored );
				_resultList.addItem( ignoreItem );
			}
			for( i = 0; i < _success.length; i++ )
			{
				var listItem:SuccessListItem = new SuccessListItem( _success[i], _sucessTime[i] );
				_resultList.addItem( listItem );
			}
			
			_resultList.update();
			
			_statusBar.update( _success.length, _failed.length, _ignored.length );
			_header.result( result.runCount, result.failureCount, result.ignoreCount );
			_header.timeTaken( getTimer() - _timeKeeper );
		}
		
		/**
		 * Handles key down events to perform actions on keyboard shortcuts, right now the only functionallity is scrolling
		 * @param	e	The KeyboardEvent 
		 */
		private function onKeyDown( e:KeyboardEvent ):void 
		{
			if( stage == null ) return;
			
			if( stage.stageHeight - getListStartY() < _resultList.height )
			{
				var move:Number = 0;
				if( e.keyCode == Keyboard.DOWN )
				{
					move = -10;
				}
				else if( e.keyCode == Keyboard.UP )
				{
					move = 10;
				}
				
				move = ( e.ctrlKey ) ? move * 10 : move;
				move = ( e.shiftKey ) ? move * 10 : move;
				_resultList.y += move;
				
				if( _resultList.y > getListStartY() )
				{
					_resultList.y = getListStartY();
				}
				else if( _resultList.y < ( stage.stageHeight ) - _resultList.height )
				{
					var available:Number = ( stage.stageHeight - getListStartY() );
					_resultList.y = getListStartY();
					_resultList.y += available - _resultList.height;
				}
			}
			else
			{
				_resultList.y = getListStartY();
			}
		}
		
		/**
		 * Handles stage resize
		 * @param	e	The resize event
		 */
		private function onResize( e:Event = null ):void
		{
			_width = stage.stageWidth;
			_header.width	= _width;
			_color.width 	= _width;
			_color.height 	= stage.stageHeight;
			
			_statusBar.y = _header.height;
			_resultList.y = getListStartY();
			_resultList.width = _width;
		}
		
		/**
		 * Returns the start y for the list (under the header)
		 * @return	The y of the list
		 */
		public function getListStartY():Number
		{
			return _header.height + _statusBar.height;
		}
		
		/**
		 * A function for adding several children in one call
		 * @param	... childs		The DisplayObject's to add as childs
		 */
		private function addChildren( ... childs ):void
		{
			for each( var child:DisplayObject in childs )
			{
				addChild( child );
			}
		}
	}
}