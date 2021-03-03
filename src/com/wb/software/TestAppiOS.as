package com.wb.software 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	
	[SWF(width="640", height="480", frameRate="60")]

	public final class TestAppiOS extends Sprite
	{
		// swf metadata values (must match above!)
		private const SWF_WIDTH     :int = 640;
		private const SWF_HEIGHT    :int = 480;
		private const SWF_FRAMERATE :int = 60;

		// stored objects
		private var m_app       :TestApp      = null;
		private var m_messenger :iOSMessenger = null;
		private var m_ane       :iOSANE       = null;
		
		// constants
		private const IOS_TEST_CODE :int = 0x105;
		
		// launch image
		[Embed(source="../../../../LaunchImg.png", mimeType="image/png")]
		private var LaunchImage :Class;

		// default constructor
		public function TestAppiOS()
		{
			// defer to superclass
			super();
			
			// load launch image
			var launchImg :Bitmap = new LaunchImage();
			
			// create messenger
			m_messenger = new iOSMessenger(this,
										   SWF_WIDTH,
										   SWF_HEIGHT,
										   SWF_FRAMERATE);
			
			// create main app
			m_app = new TestApp(this,
								m_messenger,
								WBEngine.OSFLAG_IOS,
								false, // renderWhenIdle
								launchImg,
								true); // testMode
			
			// listen for added-to-stage
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		// addNativeExtensions() -- get native extensions up & running
		private function addNativeExtensions() :Boolean
		{
			// create extensions
			m_ane = new iOSANE();
			
			// perform test
			if(m_ane.testANE(IOS_TEST_CODE) != IOS_TEST_CODE)
			{
				// throw error
				throw new Error("com.wb.software.TestAppiOS.addNativeExtensions(): " +
								"ANE function test failed");
				
				// fail
				return(false);
			}
			
			// keep screen on
			m_ane.keepScreenOn();
			
			// ok
			return(true);
		}
		
		// getANE() -- get reference to native extensions
		public function getANE() :iOSANE
		{
			// return object
			return(m_ane);
		}
		
		// getApp() -- get reference to base app
		public function getApp() :TestApp
		{
			// return object
			return(m_app);
		}
		
		// onAddedToStage() -- callback for added-to-stage notification
		private function onAddedToStage(e :Event) :void
		{
			// verify app
			if(!m_app)
				return;
			
			// add native extensions
			m_app.goingNative = addNativeExtensions();		
			
			// initialize app
			m_app.init();
		}
	}
}
