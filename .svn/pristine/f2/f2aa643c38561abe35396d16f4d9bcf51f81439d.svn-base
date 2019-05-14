package com.tss.squatch
{
	import com.asfusion.mate.events.Dispatcher;
	import com.tss.squatch.events.*;
	
	import spark.components.Image;
	
	public class smap extends Image
	{
		private var dispatcher:Dispatcher = new Dispatcher();
		
		public function smap()
		{
			super();
			var siteEvent:SiteEvent = new SiteEvent(SiteEvent.NEWSITE, true, true);
			siteEvent.x = -98.34325;
			siteEvent.y = 41.234234;
			siteEvent.description = "Test site";
			
			dispatcher.dispatchEvent(siteEvent);
		}
	}
}