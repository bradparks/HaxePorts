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

class RangeUtil
{
public static function center(a:Float, b:Float, c:Float):Float
{
    if((a>b)&&(a>c))
    {
        if(b>c)
            return b;
        else
            return c;
    }
    else if((b>a)&&(b>c))
    {
        if(a>c)
            return a;
        else
            return c;
    }
    else if(a>b)
    {
        return a;
    }
    else
    {
        return b;
    }
}

/**
 * Check if a number is in range.
 */
public static function isInRange(n:Float, min:Float, max:Float, blacklist:Array<Dynamic>=null):Bool
{
    if(blacklist==null)
        blacklist=new Array();
    if(blacklist.length>0)
    {
        for(i in blacklist)
            if(n==blacklist[i])
                return false;
    }
    return(n>=min && n<=max);
}/**
 * Created by IntelliJ IDEA.
 * User:Ian McLean
 * Date:Sep 26, 2010
 * Time:1:59:33 PM
 */


/**
 * Returns a random date within a given range
 */

public static function randomRangeDate(date1:Date, date2:Date):Date {

    if(date1.getTime()==date2.getTime()){

        throw trace("Dates specified are the same");

    }

    if(date2.getTime()<date1.getTime()){

        var temp:Date=date1;

        date1=date2;
        date2=temp;

    }

    var diff:Float=date2.getTime()- date1.getTime();

    var rand:Float=Math.random()* diff;

    var time:Float=date1.getTime()+ rand;

    var d:Date=Date.fromTime(time);

    return d;

}



/**
 * Returns a set of random numbers inside a specific range(unique numbers is optional)
 */
public static function randomRangeSet(min:Int, max:Int, count:Int, unique:Bool):Array<Dynamic> {
    var rnds:Array<Dynamic>=new Array();
    if(unique && count<=max - min + 1){
        //unique - create num range array
        var nums:Array<Dynamic>=new Array();
        for(i in min...max){
            nums.push(i);
        }
        for(j in 1...count){
            // random number
            var rn:Int=Math.floor(Math.random()* nums.length);
            rnds.push(nums[rn]);
            nums.splice(rn, 1);
        }
    }
    else {
        //non unique
        for(k in 1...count){
            rnds.push(NumberUtil.randomIntegerWithinRange(min, max));
        }
    }
    return rnds;
}

/**
 * Resolve the number inside the range. If outside the range the nearest boundary value will be returned.
 */
public static function resolve(val:Float, min:Float, max:Float):Float
{
    return Math.max(Math.min(val, max), min);
}
}