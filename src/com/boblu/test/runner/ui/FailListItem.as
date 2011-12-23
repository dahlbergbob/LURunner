package com.boblu.test.runner.ui 
{
	import flash.events.Event;
	import org.flexunit.runner.notification.Failure;
	
	/**
	 * A list item for failed tests that contains information about the failing operation.
	 * @author Bob Dahlberg
	 */
	public class FailListItem extends ListItem 
	{
		private var _failure:Failure;
		private var _stack:Text;
		
		/**
		 * Creates a new ListItem for failed tests
		 * @param	failure		The failure description from FlexUnit
		 * @param	time		The time it took for the test to run
		 */
		public function FailListItem( failure:Failure, time:int = 0 )
		{
			super( failure.description, time );
			initialize( failure );
		}
		
		/**
		 * Builds the information about the test and parses the Failure from FlexUnit to describe it in a single line.
		 * Creates the graphics for the item
		 * @param	failure		The failure description from FlexUnit
		 */
		private function initialize( failure:Failure ):void 
		{
			_failure = failure;
			changeColor( _icon, 0xcc0000 );
			
			var index:int 	= _failure.stackTrace.indexOf( _class.className );
			var line:String = _failure.stackTrace.substring( index, _failure.stackTrace.indexOf( "]", index ) );
			var loc:String 	= line.substring( line.lastIndexOf( ":" ) + 1 );
			
			if( isNaN( Number( loc ) ) || loc.length < 1 )
				loc = "";
			else
				loc = ":"+ loc;
			
			_atText.appendText( loc );
			_messageText.appendText( _failure.exception.message );
			dispatchEvent( new Event( Event.CHANGE ) );
		}
		
		/** @inheritDoc */
		override protected function debugtrace():void 
		{
			super.debugtrace();
			trace( _failure.stackTrace );
		}
		
		/** Opens the graphics to display the stack of the failure */
		override protected function open():void 
		{
			if( _stack == null )
			{
				_stack 	= new Text( _failure.stackTrace );
				positionUnder( _stack, _atText );
				positionUnder( _line, _stack );
				_stack.wordWrap = true;
			}
			
			addChild( _stack );
		}
		
		/** Closes the graphics to hide the stack of the failure */
		override protected function close():void 
		{
			if( contains( _stack ) )
			{
				removeChild( _stack );
			}
		}
	}
}