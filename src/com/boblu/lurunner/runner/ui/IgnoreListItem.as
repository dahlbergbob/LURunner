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
	 * Creates a ListItem for ignored tests
	 * @author Bob Dahlberg
	 */
	public class IgnoreListItem extends ListItem 
	{
		/**
		 * Creates the ListItem
		 * @param	description		The FlexUnit description of the test
		 */
		public function IgnoreListItem( description:IDescription )
		{
			super( description );
			initialize();
		}
		
		/** Creates the ignore GUI icon. */
		private function initialize():void 
		{
			changeColor( _icon, 0xff9900 );
		}
		
	}

}