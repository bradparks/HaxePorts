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
import flash.net.URLRequest;
import flash.external.ExternalInterface;
import flash.Lib;

class LocationUtil
{
    
/** Firefox */
public static var BROWSER_FIREFOX:String = "browserFirefox";

/** Safari */
public static var BROWSER_SAFARI:String = "browserSafari";

/** Internet Explorer */
public static var BROWSER_IE:String = "browserIE";

/** Opera */
public static var BROWSER_OPERA:String = "browserOpera";

/** Undefined browser */
public static var BROWSER_UNDEFINED:String = "browserUndefined";

/** Standalone player */
public static var STANDALONE_PLAYER:String = "standalonePlayer";

public static var WINDOW_SELF:String = "_self";
public static var WINDOW_BLANK:String = "_blank";
public static var WINDOW_PARENT:String = "_parent";
public static var WINDOW_TOP:String = "_top";



/**
 * Detects MovieClip domain location.
 * Function does not return folder path or file name. The method also treats "www" and sans "www" as the same;if "www" is present method does not return it.
 * Example code:
 *    <pre>
 *          trace(getDomain(_root));
 *    </pre>
 * @param location MovieClip to get location of
 * @return Full domain(including sub-domains)of MovieClip location
 * @author Aaron Clinger
 * @author Shane McCartney
 * @author David Nelson
 * @author Vaclav Vancura(http://vancura.org, http://twitter.com/vancura)
 */
public static function getDomain(location:DisplayObject):String {
    var baseUrl:String=location.loaderInfo.url.split("://")[1].split("/")[0];
    return(baseUrl.substr(0, 4)=="www.")? baseUrl.substr(4):baseUrl;
}



/**
 * Return current location name.
 * @return Current location name
 * @author Aaron Clinger
 * @author Shane McCartney
 * @author David Nelson
 * @author Vaclav Vancura(http://vancura.org, http://twitter.com/vancura)
 */
public static function getLocationName():String {
    var out:String;
    var browserAgent:String;

    if(CapabilitiesUtil.isStandAlone()){
        out=STANDALONE_PLAYER;
    }

    else {
        if(ExternalInterface.available){
            // uses external Interface to reach out to browser and grab browser useragent info.
            browserAgent=ExternalInterface.call("function getBrowser(){return navigator.userAgent;}");

            // determines brand of browser using a find index. If not found indexOf returns(-1).
            // noinspection IfStatementWithTooManyBranchesJS
            if(browserAgent !=null && browserAgent.indexOf("Firefox")>=0){
                out=BROWSER_FIREFOX;
            } else if(browserAgent !=null && browserAgent.indexOf("Safari")>=0){
                out=BROWSER_SAFARI;
            } else if(browserAgent !=null && browserAgent.indexOf("MSIE")>=0){
                out=BROWSER_IE;
            } else if(browserAgent !=null && browserAgent.indexOf("Opera")>=0){
                out=BROWSER_OPERA;
            }
            else {
                out=BROWSER_UNDEFINED;
            }
        }

        else {
            // standalone player
            out=BROWSER_UNDEFINED;
        }
    }

    return out;
}



/**
 * Detects if MovieClip embed location matches passed domain.
 * Check for domain:
 *    <pre>
 *          trace(isDomain(_root, "google.com"));
 *          trace(isDomain(_root, "bbc.co.uk"));
 *    </pre>
 * You can even check for subdomains:
 *    <pre>
 *          trace(isDomain(_root, "subdomain.aaronclinger.com"))
 *    </pre>
 * @param location MovieClip to compare location of
 * @param domain Web domain
 * @return true if file's embed location matched passed domain
 * @author Aaron Clinger
 * @author Shane McCartney
 * @author David Nelson
 */
public static function isDomain(location:DisplayObject, domain:String):Bool {
    return getDomain(location).substr(-domain.length)==domain;
}


/**
 * Simlifies navigateToURL by allowing you to either use a String or an URLRequest
 * reference to the URL. This method also helps prevent pop-up blocking by trying to use
 * openWindow()before calling navigateToURL.
 * @param request A String or an URLRequest reference to the URL you wish to open/navigate to
 * @param window Browser window or HTML frame in which to display the URL indicated by the request parameter
 * @throws Dynamic if you pass a value type other than a String or URLRequest to parameter request.
 * @author Aaron Clinger
 * @author Shane McCartney
 * @author David Nelson
 */
public static function openURL(request:Dynamic, window:String="_self" /* WINDOW_SELF */):Void {
    var r:Dynamic=request;

    if(Std.is(r, String)){
        r=new URLRequest(r);
    } else if(!(Std.is(r, URLRequest))){
        trace("not an urlrequest");
    }

    if(window==WINDOW_BLANK && ExternalInterface.available && !CapabilitiesUtil.isIDE()&& request._data==null){
        openWindow(r.url, window);
        return;
    }

    Lib.getURL(r, window);
}



/**
 * Open a new browser window and prevent browser from blocking it.
 * Based on script by Sergey Kovalyov(http://skovalyov.blogspot.com/2007/01/how-to-prevent-pop-up-blocking-in.html)
 * Based on script by Jason the Saj(http://thesaj.wordpress.com/2008/02/12/the-nightmare-that-is-_blank-part-ii-help)
 * Original:http://apdevblog.com/problems-using-navigatetourl
 * You also have to set the wmode inside your containing html file to "opaque" and the allowScriptAccess to "always".
 * @param url url to be opened
 * @param window Window target
 * @param features Additional features for window.open function
 * @author Sergey Kovalyov
 * @author Jason the Saj
 * @author Aron Woost(<a href="http://apdevblog.com">apdevblog.com</a>)
 * @author Philipp Kyeck(<a href="http://apdevblog.com">apdevblog.com</a>)
 */
public static function openWindow(url:String, window:String="_blank", features:String=""):Void {
    switch(getLocationName()){
        case BROWSER_FIREFOX:
            ExternalInterface.call("window.open", url, window, features);
        case BROWSER_IE:
            ExternalInterface.call("function setWMWindow(){window.open('" + url + "');}");
        default:
            // otherwise, use Flash's native 'navigateToURL()' function to pop-window.
            // this is necessary because Safari 3 no longer works with the above ExternalInterface work-a-round.
            Lib.getURL(new URLRequest(url), window);
    }
}

}
class WindowNames {


    public static inline var WINDOW_SELF:String="_self";
    public static inline var WINDOW_BLANK:String="_blank";
    public static inline var WINDOW_PARENT:String="_parent";
    public static inline var WINDOW_TOP:String="_top";


}

class LocationNames {


    /** Firefox */
    public static inline var BROWSER_FIREFOX:String="browserFirefox";

    /** Safari */
    public static inline var BROWSER_SAFARI:String="browserSafari";

    /** Internet Explorer */
    public static inline var BROWSER_IE:String="browserIE";

    /** Opera */
    public static inline var BROWSER_OPERA:String="browserOpera";

    /** Undefined browser */
    public static inline var BROWSER_UNDEFINED:String="browserUndefined";

    /** Standalone player */
    public static inline var STANDALONE_PLAYER:String="standalonePlayer";


}

