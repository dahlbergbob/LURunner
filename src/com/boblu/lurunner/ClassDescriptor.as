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
package com.boblu.lurunner 
{
	/**
	 * Parses a qualified name of a function into separate parts
	 * @author Bob Dahlberg
	 */
	public class ClassDescriptor 
	{
		private var _package:String;
		private var _function:String;
		private var _class:String;
		
		/**
		 * Parse a new class name
		 * @param	qualifiedName	The qualified name of the function
		 */
		public function ClassDescriptor( qualifiedName:String )
		{
			init( qualifiedName );
		}
		
		/**
		 * Parses the name into packagr, class and function
		 * @param	qualifiedName	The qualified name of the function
		 */
		private function init( qualifiedName:String ):void 
		{
			var packClass:Array = qualifiedName.split( "::" );
			var classFunc:Array = String( packClass[1] ).split( "." );
			_package 	= packClass[0];
			_class 		= classFunc[0];
			_function 	= classFunc[1];
		}
		
		/** @return	The package name where the function is */
		public function get packageName():String 
		{
			return _package;
		}
		
		/** @return	The function name */
		public function get functionName():String 
		{
			return _function;
		}
		
		/** @return	The class name where the function is */
		public function get className():String 
		{
			return _class;
		}
	}
}