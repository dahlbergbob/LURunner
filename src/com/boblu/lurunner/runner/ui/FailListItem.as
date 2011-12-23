/*
 * Loose Unit Runner (LURunner)
 * Copyright (C) 2011 Bob Dahlberg
 * 
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */
package com.boblu.lurunner.runner.ui 
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