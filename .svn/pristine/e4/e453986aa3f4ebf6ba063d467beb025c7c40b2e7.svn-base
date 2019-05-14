package com.tss.squatch
{
	import spark.components.Image;

	import com.tss.squatch.events.CameraEvent;
	import com.asfusion.mate.events.Dispatcher;
	
	public class sPicture extends Image
	{
		private var dispatcher:Dispatcher = new Dispatcher();

		public function sPicture()
		{
			super();
			
			var tmpEvent:CameraEvent = new CameraEvent(CameraEvent.OPENCONTROL, true, true);
			dispatcher.dispatchEvent(tmpEvent);

		}
		
	}
}