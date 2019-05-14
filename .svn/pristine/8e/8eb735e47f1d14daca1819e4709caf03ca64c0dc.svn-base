package com.tss.squatch.utils
{
	import com.adobe.audio.format.WAVWriter;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filesystem.*;
	import flash.media.Camera;
	import flash.media.Video;
	import flash.text.*;
	import flash.utils.ByteArray;
	
	import mx.graphics.codec.PNGEncoder;
	
	public class FileUtility
	{
		private static const VOICE_MEMOS_DIR:String = "/sdcard/SquatchMap/VoiceMemos/";
		private static const PICTURES_DIR:String = "/sdcard/SquatchMap/Pictures/";
		private static const MOVIES_DIR:String = "/sdcard/SquatchMap/Movies/";
		
		public function FileUtility()
		{
		}
		
		public function WritePicture(aName:String, aBmp:Bitmap):void
		{
			var fTemp:File = new File(PICTURES_DIR + aName);
			var fsTemp:FileStream = new FileStream();
			fsTemp.open(fTemp, FileMode.WRITE);
			var pngEnc:PNGEncoder = new PNGEncoder();
			var fileData:ByteArray = pngEnc.encode(aBmp.bitmapData);
			fsTemp.writeBytes(fileData, 0, 0);
			fsTemp.close();
		}
		
		public function saveToWAV(soundBytes:ByteArray, fileName:String):void
		{
			var writer:WAVWriter = new WAVWriter();
			var fTemp:File = new File(VOICE_MEMOS_DIR + fileName);
			var fsTemp:FileStream = new FileStream();
			fsTemp.openAsync(fTemp, FileMode.WRITE);
			writer.processSamples(fsTemp, soundBytes, 44000);
			fsTemp.close();
		}
		
		public function openFile(aName:String):String
		{
			var fTemp:File = new File(aName);
			var stream:FileStream = new FileStream();
			stream.open(fTemp, FileMode.READ);
			var fileText:String = stream.readUTFBytes(stream.bytesAvailable);
			return fileText;
		}
	}
}