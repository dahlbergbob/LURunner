package com.boblu.test.runner
{
	import com.boblu.test.runner.ui.ListItem;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * A list class that handles several list items
	 * @author Bob Dahlberg
	 */
	public class List extends Sprite
	{
		private var _columnsWidth:Vector.<int>;
		
		/** Creates a new List */
		public function List()
		{
			super();
			_columnsWidth = new Vector.<int>();
			_columnsWidth.push( 0, 0, 0, 0 );
		}
		
		/**
		 * Add a ListItem to the list
		 * @param	item	The ListItem to add to the list
		 */
		public function addItem( item:ListItem ):void
		{
			var affected:Boolean = false;
			if( numChildren > 0 )
			{
				item.previous = getChildAt( numChildren-1 ) as ListItem;
			}
			
			item.addEventListener( Event.OPEN, onOpenClose );
			item.addEventListener( Event.CHANGE, onColumnChange );
			
			addChild( item );
			item.update();
		}
		
		/** Updates column widths if necessary */
		public function update():void 
		{
			onColumnChange();
		}
		
		/**
		 * Handles when the column width of any item in the list changes and affects all items in the list.
		 * @param	e	The change event
		 */
		private function onColumnChange( e:Event = null ):void 
		{
			for( var i:int = 0; i < numChildren; i++ )
			{
				ListItem( getChildAt( i ) ).updateColumnWidth();
			}
		}
		
		/**
		 * Handles positioning of the list items in the list when an item is opened or closed
		 * @param	e	The open/close event
		 */
		private function onOpenClose( e:Event ):void 
		{
			var index:int = getChildIndex( DisplayObject( e.currentTarget ) );
			for( var i:int = index; i < numChildren; i++ )
			{
				var item:ListItem = ListItem( getChildAt( i ) );
				item.update();
			}
		}
		
		/** @inheritDoc */
		override public function set width( value:Number ):void 
		{
			for( var i:int = 0; i < numChildren; i++ )
			{
				ListItem( getChildAt( i ) ).width = value;
			}
		}
	}
}