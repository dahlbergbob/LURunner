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
	import flash.display.Shape;
	import flash.display.Sprite;
	
	/**
	 * The UI Header of the testrunner
	 * @author Bob Dahlberg
	 */
	public class Header extends Sprite 
	{
		private var _color:Color;
		private var _title:Text;
		private var _time:Text;
		private var _result:Text;
		
		/**
		 * Creates a new header with a background color
		 * @param	backgrounColor	The background color
		 */
		public function Header( backgrounColor:uint ) 
		{
			init( backgrounColor );
		}
		
		/**
		 * Creates hard coded texts for the header
		 * @param	backgrounColor	The background color
		 */
		private function init( backgroundColor:uint ):void 
		{
			_title 	= new Text( "LURunner [BETA]", false );
			_time 	= new Text( " " );
			_result = new Text( "Starting your tests" );
			_color 	= new Color( backgroundColor );
			
			addChild( _color );
			addChild( _time );
			addChild( _title );
			addChild( _result );
		}
		
		/**
		 * Updates the header text of which tests is currently running
		 * @param	currentTest		The number of the current test
		 * @param	totalTests		Total tests count
		 */
		public function runningTest( currentTest:int, totalTests:int ):void
		{
			_time.text		= " ";
			_result.text 	= "Running test "+ currentTest +" of "+ totalTests;
		}
		
		/**
		 * Displays the result of the tests in the header
		 * @param	runCount		Number of tests run
		 * @param	failureCount	Number of tests failed
		 * @param	ignoreCount		Number of tests ignored
		 */
		public function result( runCount:int, failureCount:int, ignoreCount:int ):void 
		{
			if( failureCount < 1 && ignoreCount < 1 )
			{
				_result.text = "Success! All "+ runCount +" tests succeeded";
			}
			else if( failureCount > 0 )
			{
				_result.text = "Try again! "+ failureCount +" of "+ runCount +" tests failed!";
			}
			else if( failureCount < 1 && ignoreCount > 0 )
			{
				_result.text = "Success.. or is it?! You are ignoring "+ ignoreCount +" tests!";
			}
			_color.height 	= super.height;
			_color.width 	= super.width;
		}
		
		/**
		 * Adds the total time all tests took
		 * @param	ms	The total time in milli seconds
		 */
		public function timeTaken( ms:int ):void 
		{
			_time.text = "Test time: "+ ms +"ms";
		}
		
		/** @inheritDoc */
		override public function set width(value:Number):void 
		{
			_result.y = _title.height - 3;
			_time.y = _result.y + _result.height - 3;
			_color.width = value;
		}
	}
}