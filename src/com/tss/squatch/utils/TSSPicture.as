package com.tss.squatch.utils
{
	import com.tss.squatch.events.CameraEvent;
	
	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	//	import mx.controls.Alert;
	//	import mx.controls.Image;
	
	import spark.components.Image
		
		
		public class TSSPicture extends Image
		{
			private var _label:String;
			private var _image:Image;
			private var _bitmap:Bitmap;
			
			
			public function TSSPicture()
			{
				super();
				this.addEventListener(MouseEvent.CLICK, openFullImage);
			}
			
			public function get bitmap():Bitmap
			{
				return _bitmap;
			}
			
			public function set bitmap(value:Bitmap):void
			{
				_bitmap = value;
			}
			
			public function get image():Image
			{
				return _image;
			}
			
			public function set image(value:Image):void
			{
				_image = value;
			}
			
			public function get label():String
			{
				return _label;
			}
			
			public function set label(value:String):void
			{
				_label = value;
			}
			
			private function openFullImage(e:Event):void
			{
				var tmpEvent:CameraEvent = new CameraEvent(CameraEvent.OPENIMAGE, true, true);
				tmpEvent.tsspicture = this;
				dispatchEvent(tmpEvent);
			}
		}
}