package com.boblu.lurunner.runner.ui 
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * The status bar that displays in a bar how many tests that have failed, succeded or that have been ignored.
	 * @author Bob Dahlberg
	 */
	public class StatusBar extends Sprite
	{
		public static const FAIL:uint 		= 0xcc0000;
		public static const IGNORE:uint 	= 0xff9900;
		public static const SUCCESS:uint 	= 0x00cc00;
		
		private var _failedUI:Shape;
		private var _ignoredUI:Shape;
		private var _succeededUI:Shape;
		
		private var _countFailed:Number = 0;
		private var _countIgnored:Number = 0;
		private var _countSucceeded:Number = 0;
		
		/** Creates a new StatusBar */
		public function StatusBar()
		{
			super();
			init();
		}
		
		/** Adds all statuses to the display list */
		private function init():void 
		{
			addEventListener( Event.ADDED_TO_STAGE, onAdded );
			_failedUI = addChild( getShape( FAIL ) ) as Shape;
			_ignoredUI = addChild( getShape( IGNORE ) ) as Shape;
			_succeededUI = addChild( getShape( SUCCESS ) ) as Shape;
		}
		
		/**
		 * Creates a square in the color sent in
		 * @param	color	The color on the square	
		 * @return			The colored square
		 */
		private function getShape( color:uint ):Shape 
		{
			var returner:Shape = new Shape();
			returner.graphics.beginFill( color );
			returner.graphics.drawRect( 0, 0, 6, 6 );
			returner.graphics.endFill();
			return returner;
		}
		
		/**
		 * Adds resize handler
		 * @param	e
		 */
		private function onAdded( e:Event ):void 
		{
			removeEventListener( Event.ADDED_TO_STAGE, onAdded );
			stage.addEventListener( Event.RESIZE, onResize );
			onResize();
		}
		
		/**
		 * Resizes the bar to fill the entire stage
		 * @param	e	The resize event
		 */
		private function onResize( e:Event = null ):void 
		{
			var total:Number = _countFailed + _countIgnored + _countSucceeded;
			var width:Number = stage.stageWidth;
			
			_failedUI.width 	= ( _countFailed / total ) * width;
			_ignoredUI.width 	= ( _countIgnored / total ) * width;
			_succeededUI.width 	= ( _countSucceeded / total ) * width;
			
			_succeededUI.x 	= _failedUI.width;
			_ignoredUI.x 	= _failedUI.width + _succeededUI.width;
		}
		
		/**
		 * Updates the bar with the current number of successed, failed and ignored tests
		 * @param	success		The number of succeeded tests
		 * @param	failed		The number of failed tests
		 * @param	ignored		The number of ignored tests
		 */
		public function update( success:Number, failed:Number, ignored:Number ):void
		{
			_countFailed = failed;
			_countIgnored = ignored;
			_countSucceeded = success;
			onResize();
		}
	}
}