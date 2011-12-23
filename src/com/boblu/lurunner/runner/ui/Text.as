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