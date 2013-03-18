package
{	
	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.sampler.Sample;
	import flash.system.Capabilities;
	import flash.utils.getQualifiedClassName;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.utils.AssetManager;
		
	public class StarlingRoot extends Sprite
	{
		// Image on native overlay
		[Embed(source="system/Overlay.png")]
		private static var SampleImage:Class;
				
		public function StarlingRoot()
		{
			super();
		}
		
		public function start():void
		{									
			var sampleImage:Bitmap = new SampleImage();
			sampleImage.x = 20;
			sampleImage.y = 320;
			Starling.current.nativeOverlay.addChild(sampleImage);
			
		}
		
		
	}
	
}