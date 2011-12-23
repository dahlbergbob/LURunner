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