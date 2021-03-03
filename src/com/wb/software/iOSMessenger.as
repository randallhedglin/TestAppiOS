package com.wb.software
{
	public class iOSMessenger extends WBMessenger
	{
		// calling class
		private var m_caller :TestAppiOS = null;
		
		// default constructor
		public function iOSMessenger(caller       :TestAppiOS,
									 swfWidth     :int,
									 swfHeight    :int,
									 swfFrameRate :int)
		{
			// defer to superclass
			super(swfWidth,
				  swfHeight,
				  swfFrameRate);
			
			// save caller
			m_caller = caller;
		}
		
		// send() -- override specific to this app
		override public function send(message :String, ...argv) :int
		{
			// verify caller
			if(!m_caller)
				return(0);
			
			// get native extensions
			var ane :iOSANE = m_caller.getANE();
			
			// verify native extensions
			if(!ane)
				return(0);
			
			// check message
			if(message)
			{
				// process message
				switch(message)
				{
				// getLongestDisplaySide()
				case("getLongestDisplaySide"):
						
					// return the value
					return(ane.getLongestDisplaySide());
						
				// messageBox()
				case("messageBox"):
						
					// check content
					if(argv.length != 2)
						break;
						
					// display message box
					ane.messageBox(argv[0] as String, argv[1] as String);
						
					// ok
					return(1);
				}
			}
			
			// throw error
			throw new Error("com.wb.software.iOSMessenger.send(): " +
				"Internal message cannot be sent due to invalid data: " +
				message);
			
			// failed
			return(0);
		}
	}
}