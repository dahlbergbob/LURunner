package com.boblu.lurunner.runner.ui 
{
	import flash.display.Shape;
	
	/**
	 * A colored grahic util
	 * @author Bob Dahlberg
	 */
	public class Color extends Shape 
	{
		/**
		 * Creates a new graphic rectangle in the specified color.
		 * @param	color	The color to draw the rectangle in, defaults to white.
		 */
		public function Color( color:uint = 0xffffff )
		{
			drawColor( color );
		}
		
		/**
		 * Draws the actual rectangle
		 * @param	color	The color in which to draw the rectangle
		 */
		private function drawColor( color:uint ):void 
		{
			graphics.beginFill( color );
			graphics.drawRect( 0, 0, 4, 5 );
			graphics.endFill();
		}
	}
}