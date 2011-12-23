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