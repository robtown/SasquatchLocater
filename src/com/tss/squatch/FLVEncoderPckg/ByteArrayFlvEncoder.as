package  com.tss.squatch.FLVEncoderPckg
{
	import flash.utils.ByteArray;

	/**
	 * Encodes FLV's into a ByteArray
	 */
	public class ByteArrayFlvEncoder extends FlvEncoder
	{
		public function ByteArrayFlvEncoder($frameRate:Number)
		{
			super($frameRate);
		}
		
		public function get byteArray():ByteArray
		{
			return _bytes as ByteArray;
		}
		
		public override function kill():void
		{
			super.kill();
			byteArray.length = 0;
		}
		
		protected override function makeBytes():void
		{
			_bytes = new ByteableByteArray();
		}
	}
}
