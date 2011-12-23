package com.boblu.test.runner.ui 
{
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.AntiAliasType;
	import flash.text.GridFitType;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	/**
	 * A text util class
	 * @author Bob Dahlberg
	 */
	public class Text extends TextField 
	{
		/**
		 * Creates a new text
		 * @param	textValue	The text to display
		 * @param	selectable	true if the text should be selectable
		 */
		public function Text( textValue:String, selectable:Boolean = true )
		{
			super();
			autoSize = TextFieldAutoSize.LEFT;
			textColor = 0xffffff;
			var txtFormat:TextFormat = new TextFormat( "Consolas", 11 );
			defaultTextFormat = txtFormat;
			antiAliasType = AntiAliasType.ADVANCED;
			gridFitType = GridFitType.PIXEL;
			this.selectable = selectable;
			text = textValue;
		}
		
		/** Set the align of the text */
		public function set align( align:String ):void
		{
			var tf:TextFormat = getTextFormat();
			tf.align = align;
			setTextFormat( tf, -1, text.length );
			defaultTextFormat = tf;
		}
	}
}