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