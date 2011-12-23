package com.boblu.test.runner.ui 
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