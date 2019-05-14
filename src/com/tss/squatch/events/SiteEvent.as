package com.tss.squatch.events
{
	import flash.events.Event;
	
	public class SiteEvent extends Event
	{
		
		public static const NEWSITE:String = "siteEvent_NewSite";
		public static const DELETESITE:String = "siteEvent_DeleteSite";
		public static const MOVESITE:String = "siteEvent_MoveSite";
		
		private var _x:Number;
		private var _y:Number;
		private var _description:String;
		
		public function SiteEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}

		public function get description():String
		{
			return _description;
		}

		public function set description(value:String):void
		{
			_description = value;
		}

		public function get y():Number
		{
			return _y;
		}

		public function set y(value:Number):void
		{
			_y = value;
		}

		public function get x():Number
		{
			return _x;
		}

		public function set x(value:Number):void
		{
			_x = value;
		}

	}
}