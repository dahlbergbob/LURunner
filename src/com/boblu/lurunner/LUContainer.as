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
package com.boblu.lurunner 
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
	/**
	 * Abstract container for setting up testing
	 * @author Bob Dahlberg
	 */
	public class LUContainer extends Sprite 
	{
		/** Creates a new LUContainer */
		public function LUContainer() 
		{
			if( stage != null )
			{
				addEventListener( Event.ADDED_TO_STAGE, init );
			}
			else
			{
				init();
			}
		}
		
		/**
		 * Starts the continer, either on added to stage or directly
		 * @param	e	The added to stage event
		 */
		private function init( e:Event = null ):void 
		{
			if( e != null )
			{
				removeEventListener( Event.ADDED_TO_STAGE, init );
			}
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align		= StageAlign.TOP_LEFT;
			
			setup();
			start();
		}
		
		/** 
		 * Abstract function to setup your tests.
		 * This is typically where you create your LURunner, adds all suits in an array and adds the runner to the stage.
		 */
		protected function setup():void 
		{
			throw new Error( "Override me" );
		}
		
		/**
		 * Abstract function for starting your tests 
		 * This is where you should create your core, add the LURunner to it and runs it.
		 */
		protected function start():void 
		{
			throw new Error( "Override me" );
		}
	}
}