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

import flash.utils.Endian;
import hu.vpmedia.math.Percent;

class NumberUtil
{

#if flash
public static var MAX_VALUE:Float = untyped __global__["Number"].MAX_VALUE;
public static var MIN_VALUE:Float = untyped __global__["Number"].MIN_VALUE;
#else        
public static var MAX_VALUE:Float = 179 * Math.pow(10, 306);//1.79769313486231e + 308 
public static var MIN_VALUE:Float = -494 * Math.pow(10, 322);//4.9406564584124654e-324
#end

        
/**
 * Formats a number to include one or more leading zeroes if needed. 
 * @example<listing version="3.0">
 * addLeadingZeroes(4);// "04"
 * addLeadingZeroes(5, 3);// "0005"
 * addLeadingZeroes(10, 1);// "10"
 * addLeadingZeroes(10, 2);// "010"
 *</listing>
 * 
 * @param n The number that will be formatted. Ignores negative numbers.
 * @return A string of the number with leading zeroes.
 *
 * @langversion ActionScript 3.0
 * @playerversion Flash 9.0
 * 
 * @author updated by Mims Wright - original contributor unknown
 */
public static function addLeadingZeroes(n:Float, zeroes:Int=1):String
{
    var out:String=Std.string(n);
    
    if(n<0 || zeroes<1){
        return out;
    }

    while(out.length<zeroes + 1){
        out="0" + out;
    }

    return out;
}

/**
 * Constrains a value to the defined numeric boundaries.
 * 
 * @example<listing version="3.0">
 * clamp(3, 2, 5);// this will give back 3 since it's within the range
 * clamp(20, 2, 5);// this will give back 5 since 5 is the upper boundary
 * clamp(-5, 2, 5);// this will give back 2 since 2 is the lower boundary
 *</listing>
 * 
 * @author Mims Wright
 */
public static function clamp(val:Float, min:Float, max:Float):Float
{
    return Math.max(Math.min(val, max), min);
}

/**
   Creates evenly spaced numerical increments between two numbers.

   @param begin:The starting value.
   @param end:The ending value.
   @param steps:The number of increments between the starting and ending values.
   @return Returns an Array composed of the increments between the two values.
   @example
<code>
   trace(NumberUtil.createStepsBetween(0, 5, 4));// Traces 1,2,3,4
   trace(NumberUtil.createStepsBetween(1, 3, 3));// Traces 1.5,2,2.5
</code>
 */
public static function createStepsBetween(begin:Float, end:Float, steps:Float):Array<Dynamic>
{
    steps++;

    var i:Int=0;
    var stepsBetween:Array<Dynamic>=new Array();
    var increment:Float=(end - begin)/ steps;

    while(++i<steps)
        stepsBetween.push((i * increment)+ begin);

    return stepsBetween;
}



/**
 * Get fast max for two numbers.
 * @param val1 Float A
 * @param val2 Float B
 * @return Max
 * @author Jackson Dunstan(http://jacksondunstan.com/articles/445)
 */
public static function fastMax2(val1:Float, val2:Float):Float {
    if((!(val1<=0)&& !(val1>0))||(!(val2<=0)&& !(val2>0)))return Math.NaN;
    return val1>val2 ? val1:val2;
}



/**
 * Get fast min for two numbers.
 * @param val1 Float A
 * @param val2 Float B
 * @return Min
 * @author Jackson Dunstan(http://jacksondunstan.com/articles/445)
 */
public static function fastMin2(val1:Float, val2:Float):Float {
    if((!(val1<=0)&& !(val1>0))||(!(val2<=0)&& !(val2>0)))return Math.NaN;
    return val1<val2 ? val1:val2;
}



/**
 Formats a number.
 @param value The number you wish to format.
 @param minLength The minimum length of the number.
 @param thouDelim The character used to separate thousands.
 @param fillChar The leading character used to make the number the minimum length.
 @return Returns the formatted number as a String.
 @example
<code>
 trace(NumberUtil.format(1234567, 8, ","));// Traces 01,234,567
</code>
 */
public static function format(value:Float, minLength:Int, thouDelim:String=null, fillChar:String=null):String {
    var num:String=Std.string(value);
    var len:Int=num.length;

    if(thouDelim !=null){
        var numSplit:Array<Dynamic>=num.split('');
        var counter:Int=3;
        var i:Int=numSplit.length;

        while(--i>0){
            counter--;
            if(counter==0){
                counter=3;
                numSplit.splice(i, 0, thouDelim);
            }
        }

        num=numSplit.join('');
    }

    if(minLength !=0){
        if(len<minLength){
            minLength -=len;

            var addChar:String=(fillChar==null)? '0':fillChar;

            while(minLength--)
                num=addChar + num;
        }
    }

    return num;
}

/**
   Finds the English ordinal suffix for the number given.

   @param value:Float to find the ordinal suffix of.
   @return Returns the suffix for the number, 2 characters.
   @example
<code>
   trace(32 + FloatUtil.getOrdinalSuffix(32));// Traces 32nd
</code>
 */
public static function getOrdinalSuffix(value:Int):String
{
    if(value>=10 && value<=20)
        return 'th';

    switch(value % 10)
    {
        case 0,4,5,6,7,8,9:
            return 'th';
        case 3:
            return 'rd';
        case 2:
            return 'nd';
        case 1:
            return 'st';
        default:
            return '';
    }
}



/**
 * Low pass filter algorithm for easing a value toward a destination value.
 * Works best for tweening values when no definite time duration exists and
 * when the destination value changes.
 * When<code>(0.5 &lt;n &lt;1)</code>, then the resulting values will
 * overshoot(ping-pong)until they reach the destination value.
 * When<code>n</code>is greater than 1, as its value increases, the time
 * it takes to reach the destination also increases. A pleasing value for
 *<code>n</code>is 5.
 * @param value The current value.
 * @param dest The destination value.
 * @param n The slowdown factor.
 * @return The weighted average.
 */
public static function getWeightedAverage(value:Float, dest:Float, n:Float):Float {
    return value +(dest - value)/ n;
}

/** String for quick lookup of a hex character based on index */
public static inline var hexChars:String="0123456789abcdef";

/**
 * Inserts commas every three digits in the Integer of<code>value</code>
 * @param value the number to insert commas Into
 * @return<code>value</code>as a<code>String</code>formatted with commas
 */
public static function insertCommas(value:Float):String
{
    // convert the value to a string
    var valueString:String=Std.string(value);

    // determine the location of the point
    var commaIndex:Int=valueString.indexOf(".");

    // if a point doesn't exist, consider it to be at the end of the value
    if(commaIndex==-1)
        commaIndex=valueString.length;

    do
    {
        // move to the left three digits
        commaIndex -=3;

        // if index is beyond the beginning of the value, end the loop
        if(commaIndex<=0)
            break;

        // insert the comma
        valueString=valueString.substring(0, commaIndex)+ "," + valueString.substr(commaIndex);
    }
    while(true);

    // remove "0" if value is a decimal
    if(valueString.substr(0, 2)=="0.")
        valueString=valueString.substr(1);

    return valueString;
}


/**
   Determines a value between two specified values.

   @param amount:The level of interpolation between the two values. If<code>0%</code>,<code>begin</code>value is returned;if<code>100%</code>,<code>end</code>value is returned.
   @param minimum:The lower value.
   @param maximum:The upper value.
   @example
<code>
   trace(NumberUtil.interpolate(new Percent(0.5), 0, 10));// Traces 5
</code>
 */
public static function interpolate(amount:Percent, minimum:Float, maximum:Float):Float
{
    return minimum +(maximum - minimum)* amount.decimalPercentage;
}

/**
   Determines if the value is included within a range.

   @param value:Float to determine if it is included in the range.
   @param firstValue:First value of the range.
   @param secondValue:Second value of the range.
   @return Returns<code>true</code>if the number falls within the range;otherwise<code>false</code>.
   @usageNote The range values do not need to be in order.
   @example
<code>
   trace(NumberUtil.isBetween(3, 0, 5));// Traces true
   trace(NumberUtil.isBetween(7, 0, 5));// Traces false
</code>
 */
public static function isBetween(value:Float, firstValue:Float, secondValue:Float):Bool
{
    return !(value<Math.min(firstValue, secondValue)|| value>Math.max(firstValue, secondValue));
}

/**
   Determines if the two values are equal, with the option to define the precision.

   @param val1:A value to compare.
   @param val2:A value to compare.
   @param precision:The maximum amount the two values can differ and still be considered equal.
   @return Returns<code>true</code>the values are equal;otherwise<code>false</code>.
   @example
<code>
   trace(NumberUtil.isEqual(3.042, 3, 0));// Traces false
   trace(NumberUtil.isEqual(3.042, 3, 0.5));// Traces true
</code>
 */
public static function isEqual(val1:Float, val2:Float, precision:Float=0):Bool
{
    return Math.abs(val1 - val2)<=Math.abs(precision);
}

/**
   Determines if the number is even.

   @param value:A number to determine if it is divisible by<code>2</code>.
   @return Returns<code>true</code>if the number is even;otherwise<code>false</code>.
   @example
<code>
   trace(NumberUtil.isEven(7));// Traces false
   trace(NumberUtil.isEven(12));// Traces true
</code>
 */
public static function isEven(value:Float):Bool
{
    return(value & 1)==0;
}

/**
   Determines if the number is an Integer.

   @param value:A number to determine if it contains no decimal values.
   @return Returns<code>true</code>if the number is an Integer;otherwise<code>false</code>.
   @example
<code>
   trace(NumberUtil.isInteger(13));// Traces true
   trace(NumberUtil.isInteger(1.2345));// Traces false
</code>
 */
public static function isInteger(value:Float):Bool
{
    return(value % 1)==0;
}



/**
 * Determines whether or not the supplied Float is negative.
 * @param value Float to evaluate
 * @return Whether or not the supplied Float is negative
 * @author Aaron Clinger
 * @author Shane McCartney
 * @author David Nelson
 */
public static function isNegative(value:Float):Bool {
    return !isPositive(value);
}

/**
   Determines if the number is odd.

   @param value:A number to determine if it is not divisible by<code>2</code>.
   @return Returns<code>true</code>if the number is odd;otherwise<code>false</code>.
   @example
<code>
   trace(NumberUtil.isOdd(7));// Traces true
   trace(NumberUtil.isOdd(12));// Traces false
</code>
 */
public static function isOdd(value:Float):Bool
{
    return !isEven(value);
}



/**
 * Determines whether or not the supplied Float is positive.
 * @param value Float to evaluate
 * @return Whether or not the supplied Float is positive
 * @author Aaron Clinger
 * @author Shane McCartney
 * @author David Nelson
 */
public static function isPositive(value:Float):Bool {
    return value >= 0;
}

/**
   Determines if the number is prime.

   @param value:A number to determine if it is only divisible by<code>1</code>and itself.
   @return Returns<code>true</code>if the number is prime;otherwise<code>false</code>.
   @example
<code>
   trace(NumberUtil.isPrime(13));// Traces true
   trace(NumberUtil.isPrime(4));// Traces false
</code>
 */
public static function isPrime(value:Float):Bool
{
    if(value==1 || value==2)
        return true;

    if(isEven(value))
        return false;

    var s:Float=Math.sqrt(value);
    for(i in 3...s)
        if(value % i==0)
            return false;

    return true;
}

/**
 * Returns true if the two numbers are within "maxPercentDifferent" percent of each other. 
 * 
 * @example<listing version='3.0'>
 * isRoughlyEqual(0.7, 0.69);// true
 * isRoughlyEqual(0.7, 0.5);// false
 * 
 * isRoughlyEqual(123456789, 123450000);// true
 * isRoughlyEqual(123456789, 100000000);// false
 * isRoughlyEqual(123456789, 100000000, 0.25);// true
 * 
 *</listing>
 */
public static function isRoughlyEqual(a:Float, b:Float, maxPercentDifferent:Float=0.10):Bool {
    return Math.abs((a/b)- 1.0)<maxPercentDifferent;
}

/**
   Determines if index is included within the collection length otherwise the index loops to the beginning or end of the range and continues.

   @param index:Index to loop if needed.
   @param length:The total elements in the collection.
   @return A valid zero-based index.
   @example
<code>
   var colors:Array<Dynamic>=new Array("Red", "Green", "Blue");

   trace(colors[NumberUtil.loopIndex(2, colors.length)]);// Traces Blue
   trace(colors[NumberUtil.loopIndex(4, colors.length)]);// Traces Green
   trace(colors[NumberUtil.loopIndex(-6, colors.length)]);// Traces Red
</code>
 */
public static function loopIndex(index:Int, length:Int):Int
{
    if(index<0)
        index=length + index % length;

    if(index>=length)
        return index % length;

    return index;
}

/**
   Maps a value from one coordinate space to another.

   @param value:Value from the input coordinate space to map to the output coordinate space.
   @param min1:Starting value of the input coordinate space.
   @param max1:Ending value of the input coordinate space.
   @param min2:Starting value of the output coordinate space.
   @param max2:Ending value of the output coordinate space.
   @example
<code>
   trace(NumberUtil.map(0.75, 0, 1, 0, 100));// Traces 75
</code>
 */
public static function map(value:Float, min1:Float, max1:Float, min2:Float, max2:Float):Float
{
    return min2 +(max2 - min2)*((value - min1)/(max1 - min1));
}

/**
   Evaluates<code>val1</code>and<code>val2</code>and returns the larger value. Unlike<code>Math.max</code>this method will return the defined value if the other value is<code>null</code>or not a number.

   @param val1:A value to compare.
   @param val2:A value to compare.
   @return Returns the largest value, or the value out of the two that is defined and valid.
   @example
<code>
   trace(max(-5, null));// Traces -5
   trace(max(-5, "CASA"));// Traces -5
   trace(max(-5, -13));// Traces -5
</code>
 */
public static function max(val1:Dynamic, val2:Dynamic):Float
{
    if(Math.isNaN(val1)&& Math.isNaN(val2)|| val1==null && val2==null)
        return Math.NaN;

    if(val1==null || val2==null)
        return(val2==null)? val1:val2;

    if(Math.isNaN(val1)|| Math.isNaN(val2))
        return(Math.isNaN(val2))? val1:val2;

    return Math.max(val1, val2);
}

/**
   Evaluates<code>val1</code>and<code>val2</code>and returns the smaller value. Unlike<code>Math.min</code>this method will return the defined value if the other value is<code>null</code>or not a number.

   @param val1:A value to compare.
   @param val2:A value to compare.
   @return Returns the smallest value, or the value out of the two that is defined and valid.
   @example
<code>
   trace(min(5, null));// Traces 5
   trace(min(5, "CASA"));// Traces 5
   trace(min(5, 13));// Traces 5
</code>
 */
public static function min(val1:Dynamic, val2:Dynamic):Float
{
    if(Math.isNaN(val1)&& Math.isNaN(val2)|| val1==null && val2==null)
        return Math.NaN;

    if(val1==null || val2==null)
        return(val2==null)? val1:val2;

    if(Math.isNaN(val1)|| Math.isNaN(val2))
        return Math.isNaN(val2)? val1:val2;

    return Math.min(val1, val2);
}


/**
   Determines a percentage of a value in a given range.

   @param value:The value to be converted.
   @param minimum:The lower value of the range.
   @param maximum:The upper value of the range.
   @example
<code>
   trace(NumberUtil.normalize(8, 4, 20).decimalPercentage);// Traces 0.25
</code>
 */
public static function normalize(value:Float, minimum:Float, maximum:Float):Percent
{
    return new Percent((value - minimum)/(maximum - minimum));
}



/**
 * Pads the<code>value</code>with the set number of digits before and after the point.
 * If the number of digits in the Integer of<code>value</code>is less than<code>beforePoint</code>, the remaining digits are filled with zeros.
 * If the number of digits in the decimal of<code>value</code>is less than<code>afterPoint</code>, the remaining digits are filled with zeros.
 * @param value the number to pad
 * @param beforePoint the number of digits to pad before the point
 * @param afterPoint the number of digits to pad after the point
 * @return<code>value</code>padded as a<code>String</code>
 * @example
 *<listing version="3.0">
 * FloatUtil.pad(.824, 0, 5);// returns ".82400"
 * FloatUtil.pad(9, 3, 2);// returns "009.00"
 * FloatUtil.pad(2835.3, 4, 2);// returns "2835.30"
 *</listing>
 */
public static function pad(value:Float, beforePoint:Int, afterPoint:Int=0):String {
    // separate the Integer from the decimal
    var valueArray:Array<Dynamic>=Std.string(value).split(".");

    var integer:String=valueArray[0];

    // determine the sign of the value
    var negative:Bool=integer.substr(0, 1)=="-";

    // remove the "-" if it exists
    if(negative)
        integer=integer.substr(1);

    // treat zeros as empty, so Integer.length doesn't return 1 when Integer is 0
    if(integer=="0"){
        integer="";
    }

    var len:Int=integer.length;

    // determine how many times "0" needs to be prepended
    var zeros:Int=Math.max(0, beforePoint - len);

    // prepend "0" until zeros==0
    while(zeros--)
        integer="0" + integer;

    var decimal:String;

    // if a point didn't exist or the decimal is 0, empty the decimal
    if(valueArray.length==1 || valueArray[1]=="0"){
        decimal="";
    }
    else {
        decimal=valueArray[1];
    }

    len=decimal.length;

    // determine how many times "0" needs to be appended
    zeros=Math.max(0, afterPoint - len);

    // append "0" until zeros==0
    while(zeros--)
        decimal +="0";

    // set sign if negative
    var sign:String=negative ? "-":"";

    // set point if a decimal exists(or afterPoint>0, determined earlier)
    var point:String=decimal ? ".":"";

    return sign + integer + point + decimal;
}

/**
   Creates a random Integer within the defined range.

   @param min:The minimum value the random Integer can be.
   @param min:The maximum value the random Integer can be.
   @return Returns a random Integer within the range.
 */
public static function randomIntegerWithinRange(min:Int, max:Int):Int
{
    return Math.round(randomWithinRange(min, max));
}



/**
 * Returns an Int:-1 or 1.
 * Example code:
 *    <pre>
 *          RandomUtils.sign();// returns 1 or -1(50% chance of 1)
 *    </pre>
 * Another example code:
 *    <pre>
 *          RandomUtils.sign(0.8);// returns 1 or -1(80% chance of 1)
 *    </pre>
 * @param chance Chance Std.parseFloat(0-1)
 * @return Int:-1 or 1.
 * @author Aaron Clinger
 * @author Shane McCartney
 * @author David Nelson
 */
public static function randomSign(chance:Float=0.5):Int {
    return(Math.random()<chance)? 1:-1;
}

/**
 *  Randomly generates a number in a range between min and max inclusively.
 *  Automatically swaps max and min if min is higher than max.
 *
 *  @param min The minimum value the random number can be.
 *  @param min The maximum value the random number can be.
 *  @return Returns a random number within the range.
 * 
 * @author Mims Wright
 */
public static function randomWithinRange(min:Float, max:Float):Float
{
    if(min>max){
        var temp:Float=max;
        max=min;
        min=temp;
    }
    return min +(Math.random()*(max - min));
}

/**
 * Rotates x left n bits
 *
 * @langversion ActionScript 3.0
 * @playerversion Flash 9.0
 * @tiptext
 */
public static function rol(x:Int, n:Int):Int
{
    return(x<<n)|(x>>>(32 - n));
}

/**
 * Rotates x right n bits
 *
 * @langversion ActionScript 3.0
 * @playerversion Flash 9.0
 * @tiptext
 */
public static function ror(x:Int, n:Int):Int
{
    var nn:Int=32 - n;
    return(x<<nn)|(x>>>(32 - nn));
}

/**
 * Rounds a number to the nearest nth, where<code>digits</code>is n / 10.
 * @param value the number to round
 * @param digits the number of digits to show after the point
 * @return
 */
public static function round(value:Float, digits:Int):Float
{
    digits=Math.pow(10, digits);

    return Math.round(value * digits)/ digits;
}

/**
   Rounds a number's decimal value to a specific place.

   @param value:The number to round.
   @param place:The decimal place to round.
   @return Returns the value rounded to the defined place.
   @example
<code>
   trace(NumberUtil.roundToPlace(3.14159, 2));// Traces 3.14
   trace(NumberUtil.roundToPlace(3.14159, 3));// Traces 3.142
</code>
 */
public static function roundDecimalToPlace(value:Float, place:Int):Float
{
    var p:Float=Math.pow(10, place);

    return Math.round(value * p)/ p;
}

/**
 * Converts a Int Into a string in the format “0x123456789ABCDEF”.
 * This function is quite useful for displaying hex colors as text.
 *
 * @example 
 *<listing version="3.0">
 * getNumberAsHexString(255);// 0xFF
 * getNumberAsHexString(0xABCDEF);// 0xABCDEF
 * getNumberAsHexString(0x00FFCC);// 0xFFCC
 * getNumberAsHexString(0x00FFCC, 6);// 0x00FFCC
 * getNumberAsHexString(0x00FFCC, 6, false);// 00FFCC
 * getNumberAsHexString(0x12345, 1, false, Endian.BIG_ENDIAN);// 452301(note 0 added to 1 to make a byte)
 *</listing>
 *
 *
 * @param number The number to convert to hex. Note, numbers larger than 0xFFFFFFFF may produce unexpected results.
 * @param minimumLength The smallest number of hexits to include in the output.
 *                        Missing places will be filled in with 0’s.
 *                        e.g. getNumberAsHexString(0xFF33, 6);// results in "0x00FF33"
 * @param showHexDenotation If true, will append "0x" to the front of the string.
 * @param endianness Flag to output the Int as big or little endian. 
 *                      Can be Endian.BIG_INDIAN/Endian.LITTLE_ENDIAN or true/false. 
 *                      Default is BIG.
 * @return String representation of the number as a string starting with "0x"
 * 
 * @langversion ActionScript 3.0
 * @playerversion Flash 9.0
 * @see flash.utils.Endian
 * 
 * @author Mims H. Wright(modified by Pimm Hogeling)
 */
public static function toHex(n:Int, minimumLength:Int=1, showHexDenotation:Bool=true, endianness:Dynamic=null):String {
    var bigEndian:Bool;
    if(endianness==null){ endianness=Endian.BIG_ENDIAN;}
    if(Std.is(endianness, Bool)){ 
        bigEndian=Bool(endianness);
    } else {
        bigEndian=endianness==Endian.BIG_ENDIAN;
    }

    
    // The string that will be output at the end of the function.
    var string:String=n.toString(16).toUpperCase();
    
    // While the minimumLength argument is higher than the length of the string, add a leading zero.
    while(minimumLength>string.length){
        string="0" + string;
    }
    
    if(!bigEndian){
        // reverse string.
        if(string.length %2==1){ string="0" + string;}
        var i:Int=0;
        var reversed:Array<Dynamic>=[];
        while(i<string.length){
            var byte:String=string.charAt(i++)+ string.charAt(i++);
            reversed.unshift(byte);
        }
        string=reversed.join("");
        
    }
    
    // Return the result with a "0x" in front of the result.
    if(showHexDenotation){ string="0x" + string;}
    
    return string;
}

}