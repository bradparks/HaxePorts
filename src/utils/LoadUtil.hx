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

import hu.vpmedia.math.Percent;
import flash.display.LoaderInfo;
import flash.display.DisplayObject;
import flash.external.ExternalInterface;
import flash.external.ExternalInterface;

class LoadUtil
{       

    /**
       Calculates the load speed in bytes per second(Bps).
    
       @param bytesLoaded:Float of bytes that have loaded between<code>startTime</code>and<code>elapsedTime</code>.
       @param startTime:Time in milliseconds when the load started.
       @param elapsedTime:Time in milliseconds since the load started or time when load completed.
       @return Bytes per second.
       @usageNote This method returns BYTES per second, not bits per second.
     */
    public static function calculateBps(bytesLoaded:Int, startTime:Int, elapsedTime:Int):Int
    {
        return Std.int(Math.max(0,(bytesLoaded / ConversionUtil.millisecondsToSeconds(elapsedTime - startTime))));
    }
    
    /**
       Calculates the percent the video has buffered.
    
       @param bytesLoaded:Float of bytes that have loaded between<code>startTime</code>and<code>elapsedTime</code>.
       @param bytesTotal:Float of bytes total to be loaded.
       @param startTime:Time in milliseconds when the load started.
       @param elapsedTime:The current time in milliseconds or time when load completed.
       @param lengthInMilliseconds:The total duration/length of the video in milliseconds.
       @return The percent buffered.
     */
    public static function calculateBufferPercent(bytesLoaded:Int, bytesTotal:Int, startTime:Int, elapsedTime:Int, lengthInMilliseconds:Int):Percent
    {
        var totalWait:Float=bytesTotal /(bytesLoaded /(elapsedTime - startTime))- lengthInMilliseconds;
        var millisecondsRemaining:Int=calculateMillisecondsUntilBuffered(bytesLoaded, bytesTotal, startTime, elapsedTime, lengthInMilliseconds);
    
        return(totalWait==NumberUtil.MAX_VALUE)? new Percent(0):new Percent(NumberUtil.clamp(1 - millisecondsRemaining / totalWait, 0, 1));
    }
    
    /**
       Calculates the load speed in kilobytes per second(kBps).
    
       @param bytesLoaded:Float of bytes that have loaded between<code>startTime</code>and<code>elapsedTime</code>.
       @param startTime:Time in milliseconds when the load started.
       @param elapsedTime:Time in milliseconds since the load started or time when load completed.
       @return Kilobytes per second.
       @usageNote This method returns kiloBYTES per second, not kilobits per second.
     */
    public static function calculateKBps(bytesLoaded:Int, startTime:Int, elapsedTime:Int):Float
    {
        return ConversionUtil.bytesToKilobytes(calculateBps(bytesLoaded, startTime, elapsedTime));
    }
    
    /**
       Calculates the remaining time until the video is buffered.
    
       @param bytesLoaded:Float of bytes that have loaded between<code>startTime</code>and<code>elapsedTime</code>.
       @param bytesTotal:Float of bytes total to be loaded.
       @param startTime:Time in milliseconds when the load started.
       @param elapsedTime:The current time in milliseconds or time when load completed.
       @param lengthInMilliseconds:The total duration/length of the video in milliseconds.
       @return The amount millisecond that remain before the video is buffered.
     */
    public static function calculateMillisecondsUntilBuffered(bytesLoaded:Int, bytesTotal:Int, startTime:Int, elapsedTime:Int, lengthInMilliseconds:Int):Int
    {
        return Std.int(Math.max(Math.ceil((bytesTotal - bytesLoaded)/(bytesLoaded /(elapsedTime - startTime)))- lengthInMilliseconds, 0));
    }
    
    /**
     * Ensures that the domain that loaded the app is from an approved list of domains.
     *
     * @example<listing version="3.0">
     * var approvedDomains:Array<Dynamic>=[".*\.example\.com", ".*\.foo\.com", ".*\.me\.mysite\.com"];
     * try {
     *     var testPassed:Bool=checkDomain(this.loaderInfo, approvedDomains);
     * } catch(e:IOError){
     *     // Domain check didn't pass. Stop the application.
     * } 
     * // If there wasn't an error, continue the application.
     *</listing>
     * 
     * @throws IOError If the domain isn't allowed.
     *  
     * @param loaderInfo The LoaderInfo object for the main app. 
     *                      This would probably be your application's main class' loaderInfo.
     * @param allowedDomains An array of approved domains as RegExp strings. e.g. ".*\.example.com"
     * @return Bool True if domain check passed.
     * 
     * @author Mims H. Wright
     */
    public static function checkDomain(loaderInfo:LoaderInfo, approvedDomains:Array<Dynamic>):Bool {
        var url:String;
        if(ExternalInterface.available){
            url=ExternalInterface.call("window.location.href.toString");
        } else {
            url=loaderInfo.loaderURL;
        }
        
        var allowedDomainsString:String=approvedDomains.join("|");
        var allowedPattern:String="(^"+allowedDomainsString+"/?)";
        
        var domainCheck:EReg = new EReg(allowedPattern, "i");
        var domainCheckResult:Bool=domainCheck.match(url);
        //var domainCheckResult:Dynamic=domainCheck.exec(url);
        if(domainCheckResult){
            // domain check failed, abort application
            trace("You are not permitted to load this file from this location " + url);
            return false;
        } else {
            // domain okay, proceed
            return true;
        }
    }
}