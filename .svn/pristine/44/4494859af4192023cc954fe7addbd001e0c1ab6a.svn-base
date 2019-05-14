package com.tss.squatch.utils
{
	import com.tss.squatch.events.CameraEvent;
	
	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.media.Sound;
	import flash.utils.ByteArray;
	import flash.events.SampleDataEvent;
	
	
	//	import mx.controls.Alert;
	//	import mx.controls.Image;
	import spark.components.Image
		
		public class TSSAudio extends Image
		{
			private var _label:String;
			private var _image:Image;
			private var _bitmap:Bitmap;
			private var _soundBytes:ByteArray;
			private var volume:Number;
			private var pan:Number;
			private var soundMap:Object;
			
			public function get soundBytes():ByteArray
			{
				return _soundBytes;
			}
			
			public function set soundBytes(value:ByteArray):void
			{
				_soundBytes = value;
			}
			
			public function TSSAudio()
			{
				super();
				this.addEventListener(MouseEvent.CLICK, playEcho);
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
			
			private function playEcho(event:MouseEvent):void
			{
				this.volume = 1;
				this.pan = 1;
				this.soundMap = new Object();
				startPlayback();
			}
			
			private function startPlayback():void
			{
				var soundCopy:ByteArray = new ByteArray();
				soundCopy.writeBytes(this.soundBytes);
				soundCopy.position = 0;
				var sound:Sound = new Sound();
				this.soundMap[sound] = soundCopy;
				sound.addEventListener(SampleDataEvent.SAMPLE_DATA, onSamplePlayback);
				sound.play();
			}
			
			private function onSamplePlayback(event:SampleDataEvent):void
			{
				var sound:Sound = event.target as Sound;
				var soundCopy:ByteArray = ByteArray(this.soundMap[sound]);
				for (var i:int = 0; i < 8192 && soundCopy.bytesAvailable > 0; i++)
				{
					var sample:Number = soundCopy.readFloat();
					event.data.writeFloat(sample);
					event.data.writeFloat(sample);
				}
			}
		}
}