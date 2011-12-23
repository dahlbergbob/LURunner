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
	import org.flexunit.runner.IDescription;
	
	/**
	 * A ListItem for succeeded tests
	 * @author Bob Dahlberg
	 */
	public class SuccessListItem extends ListItem 
	{
		/**
		 * Creates the ListItem
		 * @param	description	The FlexUnit description of the test
		 * @param	time		The time it took for the test to execute
		 */
		public function SuccessListItem( description:IDescription, time:int = 0 )
		{
			super( description, time );
			initialize();
		}
		
		/** Change the color of the ListItem icon to success color */
		private function initialize():void 
		{
			changeColor( _icon, 0x00cc00 );
		}
	}
}