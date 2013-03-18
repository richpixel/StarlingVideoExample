package
{
	import com.adobe.video.AIRMobileVideo;
	
	import flash.desktop.NativeApplication;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.system.Capabilities;
		
	import starling.core.Starling;
	import starling.events.Event;
	import starling.textures.Texture;
	
	
	public class StarlingVideoExample extends Sprite
	{				
		// properties
		private var _starling:Starling;
		private var _stageVideoPlayer:AIRMobileVideo;
		
		// Startup image for SD screens
		[Embed(source="system/startup.jpg")]
		private static var Background:Class;
		
		// Startup image for HD screens
		[Embed(source="system/startupHD.jpg")]
		private static var BackgroundHD:Class;
		
		
		////////////////////////////////////////////////////////////
		// CONSTRUCTOR				
		public function StarlingVideoExample()
		{
			super();
						
			// set general properties
			
			var stageWidth:int  = 320;
			var stageHeight:int = 480;
			var iOS:Boolean = Capabilities.manufacturer.indexOf("iOS") != -1;
			
			Starling.multitouchEnabled = true;  // useful on mobile devices
			Starling.handleLostContext = !iOS;  // not necessary on iOS. Saves a lot of memory!
			
			// create a suitable viewport for the screen size
			// 
			var viewPort:Rectangle = new Rectangle(0, 0, stage.fullScreenWidth, stage.fullScreenHeight);
			
			// scaleFactor is only used for the initial background image
			var scaleFactor:int = stage.fullScreenWidth < 480 ? 1 : 2; // midway between 320 and 640
			
			// While Stage3D is initializing, the screen will be blank. To avoid any flickering, 
			// we display a startup image now and remove it below, when Starling is ready to go.
			// This is especially useful on iOS, where "Default.png" (or a variant) is displayed
			// during Startup. You can create an absolute seamless startup that way.
			// 
			// These are the only embedded graphics in this app. We can't load them from disk,
			// because that can only be done asynchronously - i.e. flickering would return.
			// 
			// Note that we cannot embed "Default.png" (or its siblings), because any embedded
			// files will vanish from the application package, and those are picked up by the OS!
			
			var background:Bitmap = scaleFactor == 1 ? new Background() : new BackgroundHD();
			Background = BackgroundHD = null; // no longer needed!
			
			background.x = 0;
			background.y = 0;
			background.width  = stage.fullScreenWidth;
			background.height = stage.fullScreenHeight;
			background.smoothing = true;
			addChild(background);
			
			// create a video player
			_stageVideoPlayer = new AIRMobileVideo(stage);
			
			// launch Starling
			_starling = new Starling(StarlingRoot, stage, viewPort);
			_starling.simulateMultitouch  = false;
			_starling.enableErrorChecking = false;
			
			_starling.addEventListener(starling.events.Event.ROOT_CREATED, function():void
			{
				removeChild(background);
				
				var root:StarlingRoot = _starling.root as StarlingRoot;
				root.start();
				
				_starling.start();

				// try playing a video - we have to make stage3D invisible in order to see the StageVideo below
				_starling.stage3D.visible = false;
				
				// stopping starling also make senses since the stage is invisible, but not necessary to view video
				//_starling.stop();
				
				_stageVideoPlayer.playVideo("video/lft.mp4");
			});
			
			
			// When the game becomes inactive, we pause Starling; otherwise, the enter frame event
			// would report a very long 'passedTime' when the app is reactivated. 
			NativeApplication.nativeApplication.addEventListener(
				flash.events.Event.ACTIVATE, function (e:*):void { _starling.start(); });
			
			NativeApplication.nativeApplication.addEventListener(
				flash.events.Event.DEACTIVATE, function (e:*):void { _starling.stop(); });	
			
		}
		
		////////////////////////////////////////////////////////////
		// EVENT HANDLERS				
		
		////////////////////////////////////////////////////////////
		// GETTERS/SETTERS				
		
		
	}
}