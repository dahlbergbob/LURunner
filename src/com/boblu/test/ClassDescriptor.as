package com.boblu.test 
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