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

class ConversionUtil
{
/**
   Converts bits to bytes.

   @param bits:The number of bits.
   @return Returns the number of bytes.
 */
public static function bitsToBytes(bits:Float):Float
{
    return bits / 8;
}

/**
   Converts bits to kilobits.

   @param bits:The number of bits.
   @return Returns the number of kilobits.
 */
public static function bitsToKilobits(bits:Float):Float
{
    return bits / 1024;
}

/**
   Converts bits to kilobytes.

   @param bits:The number of bits.
   @return Returns the number of kilobits.
 */
public static function bitsToKilobytes(bits:Float):Float
{
    return bits / 8192;
}

/**
   Converts bytes to bits.

   @param bytes:The number of bytes.
   @return Returns the number of bits.
 */
public static function bytesToBits(bytes:Float):Float
{
    return bytes * 8;
}

/**
   Converts bytes to kilobits.

   @param bytes:The number of bytes.
   @return Returns the number of kilobits.
 */
public static function bytesToKilobits(bytes:Float):Float
{
    return bytes / 128;
}

/**
   Converts bytes to kilobytes.

   @param bytes:The number of bytes.
   @return Returns the number of kilobytes.
 */
public static function bytesToKilobytes(bytes:Float):Float
{
    return bytes / 1024;
}

/**
   Converts days to hours.

   @param days:The number of days.
   @return Returns the number of hours.
 */
public static function daysToHours(days:Float):Float
{
    return days * 24;
}

/**
   Converts days to milliseconds.

   @param days:The number of days.
   @return Returns the number of milliseconds.
 */
public static function daysToMilliseconds(days:Float):Float
{
    return secondsToMilliseconds(daysToSeconds(days));
}

/**
   Converts days to minutes.

   @param days:The number of days.
   @return Returns the number of minutes.
 */
public static function daysToMinutes(days:Float):Float
{
    return hoursToMinutes(daysToHours(days));
}

/**
   Converts days to seconds.

   @param days:The number of days.
   @return Returns the number of seconds.
 */
public static function daysToSeconds(days:Float):Float
{
    return minutesToSeconds(daysToMinutes(days));
}

/**
   Converts degrees to radians.

   @param degrees:The number of degrees.
   @return Returns the number of radians.
 */
public static function degreesToRadians(degrees:Float):Float
{
    return degrees *(Math.PI / 180);
}

/**
   Converts hours to days.

   @param hours:The number of hours.
   @return Returns the number of days.
 */
public static function hoursToDays(hours:Float):Float
{
    return hours / 24;
}

/**
   Converts hours to milliseconds.

   @param hours:The number of hours.
   @return Returns the number of milliseconds.
 */
public static function hoursToMilliseconds(hours:Float):Float
{
    return secondsToMilliseconds(hoursToSeconds(hours));
}

/**
   Converts hours to minutes.

   @param hours:The number of hours.
   @return Returns the number of minutes.
 */
public static function hoursToMinutes(hours:Float):Float
{
    return hours * 60;
}

/**
   Converts hours to seconds.

   @param hours:The number of hours.
   @return Returns the number of seconds.
 */
public static function hoursToSeconds(hours:Float):Float
{
    return minutesToSeconds(hoursToMinutes(hours));
}

/**
   Converts kilobits to bits.

   @param kilobits:The number of kilobits.
   @return Returns the number of bits.
 */
public static function kilobitsToBits(kilobits:Float):Float
{
    return kilobits * 1024;
}

/**
   Converts kilobits to bytes.

   @param kilobits:The number of kilobits.
   @return Returns the number of bytes.
 */
public static function kilobitsToBytes(kilobits:Float):Float
{
    return kilobits * 128;
}

/**
   Converts kilobits to kilobytes.

   @param kilobytes:The number of kilobits.
   @return Returns the number of kilobytes.
 */
public static function kilobitsToKilobytes(kilobits:Float):Float
{
    return kilobits / 8;
}

/**
   Converts kilobytes to bits.

   @param kilobytes:The number of kilobytes.
   @return Returns the number of bits.
 */
public static function kilobytesToBits(kilobytes:Float):Float
{
    return kilobytes * 8192;
}

/**
   Converts kilobytes to bytes.

   @param kilobytes:The number of kilobytes.
   @return Returns the number of bytes.
 */
public static function kilobytesToBytes(kilobytes:Float):Float
{
    return kilobytes * 1024;
}

/**
   Converts kilobytes to kilobits.

   @param kilobytes:The number of kilobytes.
   @return Returns the number of kilobits.
 */
public static function kilobytesToKilobits(kilobytes:Float):Float
{
    return kilobytes * 8;
}


/**
   Converts milliseconds to days.

   @param milliseconds:The number of milliseconds.
   @return Returns the number of days.
 */
public static function millisecondsToDays(milliseconds:Float):Float
{
    return hoursToDays(millisecondsToHours(milliseconds));
}

/**
   Converts milliseconds to hours.

   @param milliseconds:The number of milliseconds.
   @return Returns the number of hours.
 */
public static function millisecondsToHours(milliseconds:Float):Float
{
    return minutesToHours(millisecondsToMinutes(milliseconds));
}

/**
   Converts milliseconds to minutes.

   @param milliseconds:The number of milliseconds.
   @return Returns the number of minutes.
 */
public static function millisecondsToMinutes(milliseconds:Float):Float
{
    return secondsToMinutes(millisecondsToSeconds(milliseconds));
}

/**
   Converts milliseconds to seconds.

   @param milliseconds:The number of milliseconds.
   @return Returns the number of seconds.
 */
public static function millisecondsToSeconds(milliseconds:Float):Float
{
    return milliseconds / 1000;
}

/**
   Converts minutes to days.

   @param minutes:The number of minutes.
   @return Returns the number of days.
 */
public static function minutesToDays(minutes:Float):Float
{
    return hoursToDays(minutesToHours(minutes));
}

/**
   Converts minutes to hours.

   @param minutes:The number of minutes.
   @return Returns the number of hours.
 */
public static function minutesToHours(minutes:Float):Float
{
    return minutes / 60;
}

/**
   Converts minutes to milliseconds.

   @param minutes:The number of minutes.
   @return Returns the number of milliseconds.
 */
public static function minutesToMilliseconds(minutes:Float):Float
{
    return secondsToMilliseconds(minutesToSeconds(minutes));
}

/**
   Converts minutes to seconds.

   @param minutes:The number of minutes.
   @return Returns the number of seconds.
 */
public static function minutesToSeconds(minutes:Float):Float
{
    return minutes * 60;
}

/**
   Converts radians to degrees.

   @param radians:The number of radians.
   @return Returns the number of degrees.
 */
public static function radiansToDegrees(radians:Float):Float
{
    return radians *(180 / Math.PI);
}

/**
   Converts seconds to days.

   @param seconds:The number of seconds.
   @return Returns the number of days.
 */
public static function secondsToDays(seconds:Float):Float
{
    return hoursToDays(secondsToHours(seconds));
}


/**
   Converts seconds to hours.

   @param seconds:The number of seconds.
   @return Returns the number of hours.
 */
public static function secondsToHours(seconds:Float):Float
{
    return minutesToHours(secondsToMinutes(seconds));
}

/**
   Converts seconds to milliseconds.

   @param seconds:The number of seconds.
   @return Returns the number of milliseconds.
 */
public static function secondsToMilliseconds(seconds:Float):Float
{
    return seconds * 1000;
}

/**
   Converts seconds to minutes.

   @param seconds:The number of seconds.
   @return Returns the number of minutes.
 */
public static function secondsToMinutes(seconds:Float):Float
{
    return seconds / 60;
}

}