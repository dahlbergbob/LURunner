package com.boblu.test.runner.ui 
{
	import com.boblu.test.ClassDescriptor;
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.IBitmapDrawable;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormatAlign;
	import org.flexunit.runner.IDescription;
	
	/**
	 * A graphical list item to display the status of one test
	 * @author Bob Dahlberg
	 */
	public class ListItem extends Sprite 
	{
		public static const COLUMN_MARGIN:Number = 5;
		
		public static const COLUMN_COUNT:int = 4;
		private static var _columnWidths:Vector.<int> = new <int>[0,0,0,0];
		protected var _columns:Vector.<Column> = new Vector.<Column>();
		
		private var _width:Number;
		protected var _open:Boolean;
		protected var _hitter:Sprite;
		protected var _line:Shape;
		protected var _icon:Shape;
		protected var _description:IDescription;
		protected var _class:ClassDescriptor;
		protected var _previous:ListItem;
		
		protected var _timeText:Text;
		protected var _atText:Text;
		protected var _messageText:Text;
		
		protected var _statusColumn:Column;
		protected var _timeColumn:Column;
		protected var _functionColumn:Column;
		protected var _messageColumn:Column;
		
		/**
		 * Creates a new ListItem
		 * @param	description		The description of the test
		 * @param	time			The time it took for the test to execute
		 */
		public function ListItem( description:IDescription, time:int = 0 )
		{
			initialize( description, time );
		}
		
		/**
		 * Initialize the graphics
		 * @param	description		The description of the test
		 * @param	time			The time it took for the test to execute
		 */
		private function initialize( description:IDescription, time:int ):void 
		{
			addEventListener( Event.CHANGE, onContentChange );
			
			_open 			= false;
			_description 	= description;
			_class 			= new ClassDescriptor( _description.displayName );
			
			_icon = new Shape();
			_icon.graphics.beginFill( 0x000000 );
			_icon.graphics.drawRect( 2, 6, 12, 12 );
			_icon.graphics.endFill();
			
			_line = new Shape();
			_line.graphics.beginFill( 0xffffff, .4 );
			_line.graphics.drawRect( 0, 0, 1000, 1 );
			_line.graphics.endFill();
			
			_hitter = new Sprite();
			_hitter.graphics.beginFill( 0xff0099, 0 );
			_hitter.graphics.drawRect( 0, 0, 1000, 24 );
			_hitter.graphics.endFill();
			_hitter.buttonMode = true;
			_hitter.addEventListener( MouseEvent.CLICK, onBoardClick );
			
			_timeText 		= new Text( "| "+ time +"ms" );
			_atText 		= new Text( "| "+ _class.className +"."+ _class.functionName +"()", false );
			_messageText	= new Text( "| " );
			
			_messageText.y = _atText.y = _timeText.y = 4;
			
			setUpColumns();
			
			addChild( _line );
			addChild( _hitter );
			updateGUI();
		}
		
		/**
		 * Updates the graphics when the content changes
		 * @param	e	The change event
		 */
		private function onContentChange( e:Event ):void 
		{
			update();
		}
		
		/** Layouts the colums that a ListItem is displayed on */
		protected function setUpColumns():void
		{
			var i:int;
			for( i = 0; i < COLUMN_COUNT; i++ )
			{
				_columns.push( new Column() );
				addChild( _columns[i] );
			}
			
			_columns[0].addContent( _icon );
			_columns[1].addContent( _timeText );
			_columns[2].addContent( _atText );
			_columns[3].addContent( _messageText );
			
			update();
		}
		
		/**
		 * Returns the column width of a a specific column 
		 * @param	index	The index of the column to return the width
		 * @return			The width of the column
		 */
		public static function getColumnWidth( index:int ):int
		{
			return _columnWidths[index];
		}
		
		/** Updates the actual columns with the width and positions the columns. */
		public function updateColumnWidth():void 
		{
			var j:int = 1;
			for( var i:int = 0; i < COLUMN_COUNT; i++, j++ )
			{
				_columns[i].width = _columnWidths[i];
				if( j < _columns.length )
				{
					_columns[j].x = _columns[i].x + _columns[i].width + COLUMN_MARGIN;
				}
			}
		}
		
		/**
		 * Handles click on the ListItem to either open or close the item. Then updates the GUI.
		 * @param	e	The MouseEvent
		 */
		protected function onBoardClick( e:MouseEvent ):void 
		{
			if( _open )
			{
				close();
			}
			else 
			{
				open();
			}
			_open = !_open;
			updateGUI();
			dispatchEvent( new Event( Event.OPEN ) );
		}
		
		/** Update the list item position and columns */
		public function update():void 
		{
			if( _previous != null )
			{
				y = _previous.y + _previous.height;
			}
			for( var i:int = 0; i < COLUMN_COUNT; i++ )
			{
				_columnWidths[i] = Math.max( _columns[i].width, _columnWidths[i] );
			}
		}
		
		/** Updates the GUI */
		private function updateGUI():void
		{
			if( !_open )
			{
				_hitter.height = _atText.height;
			}
			else
			{
				_hitter.height = height - 7;
			}
			_hitter.width = _width;
			_line.width = _width;
			positionUnder( _line, _hitter, 6 );
		}
		
		/** Traces out a descriptive debug-message for the ListItem */
		protected function debugtrace():void	{	trace( _description.displayName +":" );		}
		
		/** Abstract open ListItem */
		protected function open():void			{	trace( "Override open" );					}
		/** Abstract close ListItem */
		protected function close():void 		{	trace( "Override close" );					}
		
		/**
		 * Changes the color of a DisplayObject
		 * @param	item	The DisplayObject to change color on
		 * @param	color	The new color
		 */
		protected function changeColor( item:DisplayObject, color:uint ):void
		{
			var ct:ColorTransform = new ColorTransform();
			ct.color = color;
			item.transform.colorTransform = ct;
		}
		
		/** @inheritDoc */
		override public function get height():Number 				{	return super.height;	}
		override public function set height( value:Number ):void	{	/* IGNORED */			}
		
		/** @inheritDoc */
		override public function get width():Number 				{	return super.width;				}
		override public function set width( value:Number ):void		{	_width = value;	updateGUI();	}
		
		/** The previous ListItem in the list. */
		public function get previous():ListItem					{	return _previous;	}
		public function set previous( value:ListItem ):void		{	_previous = value;	}
		
		/**
		 * Position one item under the previous item with an optional extra margin
		 * @param	item			The item to place beneath the other
		 * @param	previousItem	The item to used for positioning the first item
		 * @param	extraMargin		Extra margin to put before the item.
		 */
		protected function positionUnder( item:DisplayObject, previousItem:DisplayObject, extraMargin:Number = 0 ):void
		{
			item.y = previousItem.y + previousItem.height + extraMargin;
		}
	}
}



import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.text.TextFormatAlign;

/**
 * A class representing a Column
 */
class Column extends Sprite
{
	private var _content:DisplayObject;
	private var _width:Number = 0;
	private var _align:String = TextFormatAlign.LEFT;
	
	/**
	 * Align the content in a column, Left or Right.
	 */
	public function set align( value:String ):void
	{
		_align = ( value == TextFormatAlign.RIGHT ) ? value : TextFormatAlign.LEFT;
		update();
	}
	
	/**
	 * Add content to the column.
	 * @param	content		A DisplayObject to use as content
	 */
	public function addContent( content:DisplayObject ):void
	{
		_content = addChild( content );
		if( _content.width > _width )
		{
			width = _content.width;
		}
	}
	
	/** @inheritDoc */
	override public function get width():Number
	{
		_width = Math.max( _width, _content.width );
		return _width;
	}
	override public function set width( value:Number ):void
 	{
		_width = value;
		update();
	}
	
	/** Updates the content in the column according to width and align */
	private function update():void
	{
		if( _content != null )
		{
			_content.x = 0;
			if( _align == TextFormatAlign.RIGHT )
			{
				_content.x = _width - _content.width;
			}
		}
	}
}