////////////////////////////////////////////////////////////////////////////////
//=BEGIN LICENSE MIT
//
// Copyright (c) 2012, Original author & contributors
// Original author : AS3 Utils author & contributors
// Contributors: Andras Csizmadia -  http://www.vpmedia.eu (HaXe port)
//
// Permission is hereby granted, free of charge, to any person obtaining
// a copy of this software and associated documentation files (the
// "Software"), to deal in the Software without restriction, including
// without limitation the rights to use, copy, modify, merge, publish,
// distribute, sublicense, and/or sell copies of the Software, and to
// permit persons to whom the Software is furnished to do so, subject to
// the following conditions:
// 
// The above copyright notice and this permission notice shall be
// included in all copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
// NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
// LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
// OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
// WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//  
//=END LICENSE MIT
////////////////////////////////////////////////////////////////////////////////
package utils;

import flash.display.DisplayObject;
import flash.system.Capabilities;

class CapabilitiesUtil
{

    /**
     * Returns a player and environment info string.
     */
    public static function getPlayerInfo():String
    {
        var debugger:String = (Capabilities.isDebugger) ? ' / Debugger' : '';
        var info:String =
            Std.string("Flash Platform: " + Capabilities.version + " / " + Capabilities.playerType + debugger + " / " + Capabilities.os + " / " + Capabilities.screenResolutionX + "x" + Capabilities.screenResolutionY);
        return info;
    }


    /**
     * Determines if the runtime environment is an Air application.
     * @return true if the runtime environment is an Air application
     * @author Aaron Clinger
     * @author Shane McCartney
     * @author David Nelson
     */
    public static function isAirApplication():Bool {
        return Capabilities.playerType == "Desktop";
    }

    /**
     * Determines if the SWF is running in the IDE.
     * @return true if SWF is running in the Flash Player version used by the external player or test movie mode
     * @author Aaron Clinger
     * @author Shane McCartney
     * @author David Nelson
     */
    public static function isIDE():Bool {
        return Capabilities.playerType == "External";
    }
    
    /**
     * Indicates whether the running OS is a Mac
     * @return
     */
    public static function isMac():Bool
    {
        return Capabilities.os.toLowerCase().indexOf("mac os") != -1;
    }
    
    /**
     * Indicates whether the running OS is a PC
     * @return
     */
    public static function isPC():Bool
    {
        return Capabilities.os.toLowerCase().indexOf("mac os") == -1;
    }
    
   /**
     * Determines if the SWF is running in a browser plug-in.
     * @return true if SWF is running in the Flash Player browser plug-in
     * @author Aaron Clinger
     * @author Shane McCartney
     * @author David Nelson
     */
    public static function isPlugin():Bool {
        return Capabilities.playerType == "PlugIn" || Capabilities.playerType == "ActiveX";
    }

    /**
     * Determines if the SWF is running in the StandAlone player.
     * @return true if SWF is running in the Flash StandAlone Player
     * @author Aaron Clinger
     * @author Shane McCartney
     * @author David Nelson
     */
    public static function isStandAlone():Bool {
        return Capabilities.playerType == "StandAlone";
    }

    /**
     * Determines if the SWF is being served on the internet.
     * Example code:
     *      <pre>
     *          trace(isWeb(_root));
     *      </pre>
     * @param location DisplayObject to get location of
     * @return true if SWF is being served on the internet
     * @author Aaron Clinger
     * @author Shane McCartney
     * @author David Nelson
     */
    public static function isWeb(location:DisplayObject):Bool {
        return location.loaderInfo.url.substr(0, 4) == "http";
    }

    
}