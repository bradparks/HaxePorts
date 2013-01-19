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


class N {
public static inline var NAN:String="not a number";
public static inline var decimal:String="point ";
public static inline var negative:String="negative ";

public static inline var _0:String="zero";
public static inline var _1:String="one ";
public static inline var _2:String="two ";
public static inline var _3:String="three ";
public static inline var _4:String="four ";
public static inline var _5:String="five ";
public static inline var _6:String="six ";
public static inline var _7:String="seven ";
public static inline var _8:String="eight ";
public static inline var _9:String="nine ";
public static inline var _10:String="ten ";
public static inline var _11:String="eleven ";
public static inline var _12:String="twelve ";
public static inline var _13:String="thirteen ";
public static inline var _14:String="fourteen ";
public static inline var _15:String="fifteen ";
public static inline var _16:String="sixteen ";
public static inline var _17:String="seventeen ";
public static inline var _18:String="eighteen ";
public static inline var _19:String="nineteen ";
public static inline var _20:String="twenty ";
public static inline var _30:String="thirty ";
public static inline var _40:String="fourty ";
public static inline var _50:String="fifty ";
public static inline var _60:String="sixty ";
public static inline var _70:String="seventy ";
public static inline var _80:String="eighty ";
public static inline var _90:String="ninety ";
public static inline var _100:String="hundred ";
public static inline var _1000:String="thousand ";
public static inline var _1000000:String="million ";
public static inline var _1000000000:String="billion ";
public static inline var _1000000000000:String="trillion ";
public static inline var _1000000000000000:String="quadrillion ";
public static inline var _1000000000000000000:String="quintillion ";
public static inline var _1000000000000000000000:String="sextillion ";
public static inline var _1000000000000000000000000:String="septillion ";
public static inline var _1000000000000000000000000000:String="octillion ";


public static var _1to9:Array<String>=["",_1,_2,_3,_4,_5,_6,_7,_8,_9];
public static var _10to19:Array<String>=[_10,_11,_12,_13,_14,_15,_16,_17,_18,_19];
public static var _10to90:Array<String>=["",_10,_20,_30,_40,_50,_60,_70,_80,_90];
public static var _100to900:Array<String>=["",_1 + _100, _2 + _100, _3 + _100, _4 + _100, _5 + _100, _6 + _100, _7 + _100, _8 + _100, _9 + _100];

public static var periods:Array<String>=
    ["",
    _1000, 
    _1000000, 
    _1000000000,
    _1000000000000,
    _1000000000000000,
    _1000000000000000000,
    _1000000000000000000000,
    _1000000000000000000000000,
    _1000000000000000000000000000
];
} 

class StringUtil
{
    public static var REGEX_UNSAFE_CHARS:String="\\-^[]";

    public static var TRIM_RIGHT_REGEX:EReg =~/[\s]+$/g;
    
/**
 * Returns the string with slashes prepended to all characters specified in the<code>chars</code>parameter
 * @param str the string to return slashed
 * @param chars the string of chars to slash
 * @return
 */
public static function addSlashes(str:String, chars:String="\""):String
{
    // return the unaltered string if str or chars are null or empty
    if(str==null || chars==null)
        return str;

    // slash unsafe characters
    chars=slashUnsafeChars(chars);

    // build the regular expression that handles the slashing
    var regex:EReg=new EReg("([" + chars + "])", "g");

    // add the slashes to the specified characters
    return str.replace(regex, "\\$1");
}



/**
 * Returns everything after the first occurrence of the provided character in the String.
 * @param value Input String
 * @param ch Character or sub-string
 * @returns Output String
 * @author Aaron Clinger
 * @author Shane McCartney
 * @author David Nelson
 */
public static function afterFirst(value:String, ch:String):String {
    var out:String="";

    if(value!=null){
        var idx:Int=value.indexOf(ch);

        if(idx !=-1){
            idx +=ch.length;
            out=value.substr(idx);
        }
    }

    return out;
}



/**
 * Returns everything after the last occurrence of the provided character in value.
 * @param value Input String
 * @param ch Character or sub-string
 * @return Output String
 * @author Aaron Clinger
 * @author Shane McCartney
 * @author David Nelson
 */
public static function afterLast(value:String, ch:String):String {
    var out:String="";

    if(value!=null){
        var idx:Int=value.lastIndexOf(ch);

        if(idx !=-1){
            idx +=ch.length;
            out=value.substr(idx);
        }
    }

    return out;
}



/**
 * Convert an Array to a list.
 * @param a Input Array
 * @return List as "item1, item2, item3"
 * @author Aaron Clinger
 * @author Shane McCartney
 * @author David Nelson
 */
public static function arrayList(a:Array<Dynamic>):String {
    var out:String="";

    for(i in a){
        out +=i + ", ";
    }

    return out.substr(0, out.length - 2);
}



/**
 * Returns everything before the first occurrence of the provided character in the String.
 * @param value Input String
 * @param ch Character or sub-string
 * @returns Everything before the first occurence of the provided character in the String
 * @author Aaron Clinger
 * @author Shane McCartney
 * @author David Nelson
 */
public static function beforeFirst(value:String, ch:String):String {
    var out:String="";

    if(value!=null){
        var idx:Int=value.indexOf(ch);

        if(idx !=-1){
            out=value.substr(0, idx);
        }
    }

    return out;
}



/**
 * Returns everything before the last occurrence of the provided character in the String.
 * @param value Input String
 * @param ch Character or sub-string
 * @returns Everything before the last occurrence of the provided character in the String
 * @author Aaron Clinger
 * @author Shane McCartney
 * @author David Nelson
 */
public static function beforeLast(value:String, ch:String):String {
    var out:String="";

    if(value!=null){
        var idx:Int=value.lastIndexOf(ch);

        if(idx !=-1){
            out=value.substr(0, idx);
        }
    }

    return out;
}



/**
 *       Determines whether the specified string begins with the specified prefix.
 *       @param input The string that the prefix will be checked against.
 *       @param prefix The prefix that will be tested against the string.
 *       @returns True if the string starts with the prefix, false if it does not.
 *       @langversion ActionScript 3.0
 *       @playerversion Flash 9.0
 *       @tiptext
 */
public static function beginsWith(input:String, prefix:String):Bool {
    return(prefix==input.substring(0, prefix.length));
}



/**
 * Returns everything after the first occurrence of begin and before the first occurrence of end in String.
 * @param value Input String
 * @param start Character or sub-string to use as the start index
 * @param end Character or sub-string to use as the end index
 * @returns Everything after the first occurrence of begin and before the first occurrence of end in String.
 * @author Aaron Clinger
 * @author Shane McCartney
 * @author David Nelson
 */
public static function between(value:String, start:String, end:String):String {
    var out:String="";

    if(value!=null){
        var startIdx:Int=value.indexOf(start);

        if(startIdx !=-1){
            startIdx +=start.length;// RM:should we support multiple chars?(or ++startIdx);

            var endIdx:Int=value.indexOf(end, startIdx);

            if(endIdx !=-1){
                out=value.substr(startIdx, endIdx - startIdx);
            }
        }
    }

    return out;
}


/**
 * Convert bytes to a Std.string("X B" or "X kB")
 * @param value Bytes count
 * @return Result String
 * @author Vaclav Vancura(http://vancura.org, http://twitter.com/vancura)
 */
public static function convertBytesString(value:Int):String {
    return(value<=8192 ?(Std.string(value)+ " B"):(Std.string(bytesToKilobytes(value))+ " kB"));
}

/**
 * Detect HTML line breaks.
 */
public static function detectBr(str:String):Bool
{
    return str.split("<br").length>1;
}



/**
 *       Determines whether the specified string ends with the specified suffix.
 *       @param input The string that the suffix will be checked against.
 *       @param suffix The suffix that will be tested against the string.
 *       @returns True if the string ends with the suffix, false if it does not.
 *       @langversion ActionScript 3.0
 *       @playerversion Flash 9.0
 *       @tiptext
 */
public static function endsWith(input:String, suffix:String):Bool {
    return(suffix==input.substring(input.length - suffix.length));
}

/**
 * Does a case insensitive compare or two strings and returns true if they are equal.
 */
public static function equals(s1:String, s2:String, caseSensitive:Bool=false):Bool
{
    return(caseSensitive)?(s1==s2):(s1.toUpperCase()==s2.toUpperCase());
}

/**
 * Capitalize the first character in the string.
 */
public static function firstToUpper(str:String):String
{
    return str.charAt(0).toUpperCase()+ str.substr(1);
}

public static function getLettersFromString(source:String):String
{
    var pattern:EReg=~/[^A-Z^a-z]/g;
    return source.replace(pattern, '');
}

/**
 * Decode HTML.
 */
public static function htmlDecode(s:String):String
{
    s=replace(s, "&nbsp;", " ");
    s=replace(s, "&amp;", "&");
    s=replace(s, "&lt;", "<");
    s=replace(s, "&gt;", ">");
    s=replace(s, "&trade;", '™');
    s=replace(s, "&reg;", "®");
    s=replace(s, "&copy;", "©");
    s=replace(s, "&euro;", "€");
    s=replace(s, "&pound;", "£");
    s=replace(s, "&mdash;", "—");
    s=replace(s, "&ndash;", "–");
    s=replace(s, "&hellip;", '…');
    s=replace(s, "&dagger;", "†");
    s=replace(s, "&middot;", '·');
    s=replace(s, "&micro;", "µ");
    s=replace(s, "&laquo;", "«");
    s=replace(s, "&raquo;", "»");
    s=replace(s, "&bull;", "•");
    s=replace(s, "&deg;", "°");
    s=replace(s, "&ldquo", '"');
    s=replace(s, "&rsquo;", "'");
    s=replace(s, "&rdquo;", '"');
    s=replace(s, "&quot;", '"');
    return s;
}

/**
 * Encode HTML.
 */
public static function htmlEncode(s:String):String
{
    s=replace(s, "&", "&amp;");
    
    s=replace(s, " ", "&nbsp;");
    s=replace(s, "<", "&lt;");
    s=replace(s, ">", "&gt;");
    s=replace(s, "™", '&trade;');
    s=replace(s, "®", '&reg;');
    s=replace(s, "©", '&copy;');
    s=replace(s, "€", "&euro;");
    s=replace(s, "£", "&pound;");
    s=replace(s, "—", "&mdash;");
    s=replace(s, "–", "&ndash;");
    s=replace(s, "…", "&hellip;");
    s=replace(s, "†", "&dagger;");
    s=replace(s, "·", "&middot;");
    s=replace(s, "µ", "&micro;");
    s=replace(s, "«", "&laquo;");
    s=replace(s, "»", "&raquo;");
    s=replace(s, "•", "&bull;");
    s=replace(s, "°", "&deg;");
    s=replace(s, '"', "&quot;");
    return s;
}



/**
 *       Removes whitespace from the front of the specified string.
 *
 *       @param value The String whose beginning whitespace will will be removed.
 *
 *       @returns A String with whitespace removed from the begining
 *
 *       @langversion ActionScript 3.0
 *       @playerversion Flash 9.0
 *       @tiptext
 */
public static function ltrim(value:String):String {
    var out:String="";

    if(value!=null){
        out=value.replace(~/^\s+/, "");
    }

    return out;
}

/**
 * Converts a number to its text equivelant
 * 
 * @params n The number to convert
 * @returns String equivelant of the number
 * @playerversion Flash 10.0
 * @author Mims H. Wright
 */
public static function numberToString(n:Float):String {
    var output:Array<String>=new Array<String>();    // output will temporarily hold the strings that make up str
    var isNegative:Bool=false;                         // used for removing minus sign.
    var Integers:Float;
    var decimals:Float;
    
    // check for NaN 
    if(Math.isNaN(n)){ return N.NAN;}
    // check for zero
    if(n==0){ return N._0;}
    // check for negatives
    if(n<0){ 
        isNegative=true;
        n *=-1;
    }
    
    
    // solve for decimals
    var decimalPointIndex:Int=Std.string(n).indexOf(".");
    if(decimalPointIndex>-1){
        digits=Std.string(n).substr(decimalPointIndex + 1).split("");
        digits.reverse();
        
        var digit:Int;
        for(i in 0...digits.length){
            digit=Std.int(digits[i]);
            if(digit==0){
                output.push(N._0 + " ");
            } else {
                output.push(N._1to9[digit]);
            }
        }
        output.push(N.decimal);
    }

    // solve for Integers
    integers=Math.floor(n);
    var period:Int=0;
    var digits:Array<String>=Array<String>(integers.toString().split("")).reverse();
    var hundreds:Int;
    var tens:Int;
    var ones:Int;
    var next3:String;
    while(digits.length>0){
        // grab the next three digits and analyze them.
        next3=digits.slice(0,3).join("");
        
        if(next3 !="000"){
            output.push(N.periods[period]);
        }
        
        ones=Std.int(digits[0]);
        
        try { tens=Std.int(digits[1]);}
        catch(e:Dynamic){ tens=NaN;}
        
        try { hundreds=Std.int(digits[2]);}
        catch(e:Dynamic){ hundreds=NaN;}
        
        if(!Math.isNaN(tens)){
            if(tens==1){
                output.push(N._10to19[ones]);
            } else {
                output.push(N._1to9[ones]);
                output.push(N._10to90[tens]);
            }
        } else {
            output.push(N._1to9[ones]);
        }
        if(!Math.isNaN(hundreds)){
            output.push(N._100to900[hundreds]);
        }
        
        // advance the period counter
        period++;
        // remove those three digits from the array of digits
        digits.splice(0, 3);
    }
    
    
    if(isNegative==true){ 
        output.push(N.negative);
        n *=-1;
    }
    
    // reverse the output so that it will look correct
    output.reverse();
    // save the output to the string
    var str:String=output.join("");
    // remove any trailing spaces.
    if(str.charAt(str.length-1)==" "){ 
        str=str.substr(0, str.length-1);
    }
    return str;
}

/**
 * Pads value with specified padChar character to a specified length from the left.
 * @param value Input String
 * @param padChar Character for pad
 * @param length Length to pad to
 * @returns Padded String
 * @author Aaron Clinger
 * @author Shane McCartney
 * @author David Nelson
 */
public static function padLeft(value:String, padChar:String, length:Int):String {
    var s:String=value;

    while(s.length<length){
        s=padChar + s;
    }

    return s;
}



/**
 * Pads value with specified padChar character to a specified length from the right.
 * @param value Input String
 * @param padChar Character for pad
 * @param length Length to pad to
 * @returns Padded String
 * @author Aaron Clinger
 * @author Shane McCartney
 * @author David Nelson
 */
public static function padRight(value:String, padChar:String, length:Int):String {
    var s:String=value;

    while(s.length<length){
        s +=padChar;
    }

    return s;
}



/**
 * Generate a random String.
 * @param amount String length(default 10)
 * @param charSet Chars used(default "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789")
 * @return Random String
 */
public static function randomCharacters(amount:Float, charSet:String="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"):String {
    var alphabet:Array<Dynamic>=charSet.split("");
    var alphabetLength:Int=alphabet.length;
    var randomLetters:String="";

    for(j in 0...amount){
        var r:Float=Math.random()* alphabetLength;
        var s:Int=Math.floor(r);
        randomLetters +=alphabet[s];
    }

    return randomLetters;
}

/**
 * Generate a set of random LowerCase characters.
 */
public static function randomLowercaseCharacters(amount:Float):String
{
    var str:String="";
    for(i in 0...amount)
        str +=String.fromCharCode(Math.round(Math.random()*(122 - 97))+ 97);
    return str;
}

/**
 * Generate a set of random Float characters.
 */
public static function randomNumberString(amount:Float):String
{
    var str:String="";
    for(i in 0...amount)
        str +=String.fromCharCode(Math.round(Math.random()*(57 - 48))+ 48);
    return str;
}


/**
 * Get random sentence.
 * @param maxLength Max chars
 * @param minLength Min chars
 * @return Random sentence
 * @author Vaclav Vancura(http://vancura.org, http://twitter.com/vancura)
 */
public static function randomSequence(maxLength:Int=50, minLength:Int=10):String {
    return randomCharacters(NumberUtil.randomIntegerWithinRange(minLength, maxLength), "            abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789");
}

/**
 * Generate a set of random Special and Float characters.
 */
public static function randomSpecialCharacters(amount:Int):String
{
    var str:String="";
    for(i in 0...amount)
        str +=String.fromCharCode(Math.round(Math.random()*(64 - 33))+ 33);
    return str;
}

/**
 *       Removes all instances of the remove string in the input string.
 *
 *       @param input The string that will be checked for instances of remove
 *       string
 *
 *       @param remove The string that will be removed from the input string.
 *
 *       @returns A String with the remove string removed.
 *
 *       @langversion ActionScript 3.0
 *       @playerversion Flash 9.0
 *       @tiptext
 */
public static function remove(input:String, remove:String):String
{
    return replace(input, remove, "");
}



/**
 * Removes extraneous whitespace(extra spaces, tabs, line breaks, etc)from the specified String.
 * @param value String whose extraneous whitespace will be removed
 * @returns Output String
 */
public static function removeExtraWhitespace(value:String):String {
    var out:String="";

    if(value){
        var str:String=trim(value);

        out=str.replace(~/\s+/g, " ");
    }

    return out;
}

/**
 * Remove spaces from string.
 * @param str(String)
 * @return String
 */
public static function removeSpaces(str:String):String
{
    return replace(str, " ", "");
}

/**
 * Remove tabs from string.
 */
public static function removeTabs(str:String):String
{
    return replace(str, "  ", "");
}



public static function repeat(n:Int, str:String=" "):String {
    return new Array(n + 1).join(str);
}

/**
 *       Replaces all instances of the replace string in the input string
 *       with the replaceWith string.
 *
 *       @param input The string that instances of replace string will be
 *       replaces with removeWith string.
 *
 *       @param replace The string that will be replaced by instances of
 *       the replaceWith string.
 *
 *       @param replaceWith The string that will replace instances of replace
 *       string.
 *
 *       @returns A new String with the replace string replaced with the
 *       replaceWith string.
 *
 *       @langversion ActionScript 3.0
 *       @playerversion Flash 9.0
 *       @tiptext
 */
public static function replace(input:String, replace:String, replaceWith:String):String
{
    return input.split(replace).join(replaceWith);
}



/**
 * Returns the specified String in reverse character order.
 * @param value String that will be reversed
 * @returns Output String
 * @author Aaron Clinger
 * @author Shane McCartney
 * @author David Nelson
 */
public static function reverse(value:String):String {
    var out:String="";

    if(value){
        out=value.split("").reverse().join("");
    }

    return out;
}



/**
 * Returns the specified String in reverse word order.
 * @param value String that will be reversed
 * @returns Output String
 * @author Aaron Clinger
 * @author Shane McCartney
 * @author David Nelson
 */
public static function reverseWords(value:String):String {
    var out:String="";

    if(value){
        out=value.split(~/\s+/).reverse().join("");
    }

    return out;
}



/**
 *       Removes whitespace from the end of the specified string.
 *
 *       @param value The String whose ending whitespace will will be removed.
 *
 *       @returns A String with whitespace removed from the end
 *
 *       @langversion ActionScript 3.0
 *       @playerversion Flash 9.0
 *       @tiptext
 */
public static function rtrim(value:String):String {
    var out:String="";

    if(value){
        out=value.replace(~/\s+$/, "");
    }

    return out;
}

/**
 * Sanitize<code>null</code>strings for display purposes.
 */
public static function sanitizeNull(str:String):String
{
    return(str==null || str=="null")? "":str;
}

/**
 * Search for key in string.
 */
public static function search(str:String, key:String, caseSensitive:Bool=true):Bool
{
    if(!caseSensitive)
    {
        str=str.toUpperCase();
        key=key.toUpperCase();
    }
    return(str.indexOf(key)<=-1)? false:true;
}

/**
 * @private
 * @param chars
 * @return
 */
public static function slashUnsafeChars(chars:String):String
{
    var unsafeChar:String;
    var m:Int=REGEX_UNSAFE_CHARS.length;

    for(i in 0...mi)
    {
        unsafeChar=REGEX_UNSAFE_CHARS.substr(i, 1);

        if(chars.indexOf(unsafeChar)!=-1)
            chars=chars.replace(unsafeChar, "\\" + unsafeChar);
    }

    return chars;
}

/**
 *       Specifies whether the specified string is either non-null, or contains
 *       characters(i.e. length is greater that 0)
 *
 *       @param s The string which is being checked for a value
 *
 *       @langversion ActionScript 3.0
 *       @playerversion Flash 9.0
 *       @tiptext
 */
public static function stringHasValue(s:String):Bool
{
    return(s !=null && s.length>0);
}

/**
 *       Does a case insensitive compare or two strings and returns true if
 *       they are equal.
 *
 *       @param s1 The first string to compare.
 *
 *       @param s2 The second string to compare.
 *
 *       @returns A boolean value indicating whether the strings' values are
 *       equal in a case sensitive compare.
 *
 *       @langversion ActionScript 3.0
 *       @playerversion Flash 9.0
 *       @tiptext
 */
public static function stringsAreEqual(s1:String, s2:String,
    caseSensitive:Bool):Bool
{
    if(caseSensitive)
    {
        return(s1==s2);
    }
    else
    {
        return(s1.toUpperCase()==s2.toUpperCase());
    }
}

/**
 * Returns the string with slashes removed from all characters specified in the<code>chars</code>parameter
 * @param str the string to return stripped of slashes
 * @param chars the string of chars to remove slashes from
 * @return
 */
public static function stripSlashes(str:String, chars:String="\""):String
{
    // return the unaltered string if str or chars are null or empty
    if(str==null || chars==null)
        return str;

    // slash unsafe characters
    chars=slashUnsafeChars(chars);

    // build the regular expression that removes the slashes
    var regex:EReg=new EReg("\\\\([" + chars + "])", "g");

    // strip the slashes from the specified characters
    return str.replace(regex, "$1");
}

/**
 * Strip HTML markup tags.
 */
public static function stripTags(str:String):String
{
    var s:Array<Dynamic>=new Array();
    var c:Array<Dynamic>=new Array();
    for(i in 0...str.length)
    {
        if(str.charAt(i)=="<")
        {
            s.push(i);
        }
        else if(str.charAt(i)==">")
        {
            c.push(i);
        }
    }
    var o:String=str.substring(0, s[0]);
    for(j in 0...c.length)
    {
        o +=str.substring(c[j] + 1, s[j + 1]);
    }
    return o;
}

/**
 * Convert single quotes to double quotes.
 */
public static function toDoubleQuote(str:String):String
{
    var sq:String="'";
    var dq:String=String.fromCharCode(34);
    return str.split(sq).join(dq);
}

/**
 * Remove all formatting and return cleaned numbers from string.
 * @example<listing version="3.0">
 *      StringUtils.toNumeric("123-123-1234");// returns 1221231234
 *</listing>
 */
public static function toNumeric(str:String):String
{
    var len:Float=str.length;
    var result:String="";
    for(i in 0...len)
    {
        var code:Float=str.charCodeAt(i);
        if(code>=48 && code<=57)
        {
            result +=str.substr(i, 1);
        }
    }
    return result;
}

/**
 * Convert double quotes to single quotes.
 */
public static function toSingleQuote(str:String):String
{
    var sq:String="'";
    var dq:String=String.fromCharCode(34);
    return str.split(dq).join(sq);
}

/**
 * Transforms source String to per word capitalization.
 */
public static function toTitleCase(str:String):String
{
    var lstr:String=str.toLowerCase();
    return lstr.replace(~/\b([a-z])/g, function(d:Dynamic):Dynamic
        {
            return d.toUpperCase();
        });
}



/**
 *       Removes whitespace from the front and the end of the specified
 *       string.
 *
 *       @param value The String whose beginning and ending whitespace will
 *       will be removed.
 *
 *       @returns A String with whitespace removed from the begining and end
 *
 *       @langversion ActionScript 3.0
 *       @playerversion Flash 9.0
 *       @tiptext
 */
public static function trim(value:String):String {
    var out:String="";
    var regexp:EReg = ~/^\s+|\s+$/g;
    if (value != null) {
        out=regexp.replace(value, "");
    }
    return out;
}

/**
 * Trim spaces and camel notate String.
 */
public static function trimCamel(str:String=null):String
{
    str=(str==null)? "":str;
    var o:String="";
    for(i in 0...str.length)
    {
        if(str.charAt(i)!=" ")
        {
            if(justPassedSpace)
            {
                o +=str.charAt(i).toUpperCase();
                justPassedSpace=false;
            }
            else
            {
                o +=str.charAt(i).toLowerCase();
            }
        }
        else
        {
            var justPassedSpace:Bool=true;
        }
    }
    return o;
}

/**
 * Returns the truncated string with an appended ellipsis(...)if the length of<code>str</code>is greater than<code>len</code>.
 * If the length of<code>str</code>is less than or equal to<code>len</code>, the method returns<code>str</code>unaltered.
 * @param str the string to truncate
 * @param len the length to limit the string to
 * @return
 */
public static function truncate(str:String, len:Int):String
{
    // return the string if str is null, empty, or the length of str is less than or equal to len
    if(str==null || str.length<=len)
        return str;

    // short str to len
    str=str.substr(0, len);

    // trim the right side of whitespace
    str=str.replace(TRIM_RIGHT_REGEX, "");

    // append the ellipsis
    return str + "...";
}



/**
 * Returns a String truncated to a specified length with optional suffix.
 * @param value Input String
 * @param length Length the String should be shortened to
 * @param suffix(optional, default="...")String to append to the end of the truncated String
 * @returns String String truncated to a specified length with optional suffix
 */
public static function truncate2(value:String, length:Int, suffix:String="..."):String {
    var out:String="";
    var l:Int=length;

    var regexp:EReg = new EReg(~/\w+$|\s+$/);
    if(value){
        l -=suffix.length;

        var trunc:String=value;

        if(trunc.length>l){
            trunc=trunc.substr(0, l);

            if(~/[^\s]/.test(value.charAt(l))){
                trunc=rtrim(regexp.replace(trunc, ""));
            }

            trunc +=suffix;
        }

        out=trunc;
    }

    return out;
}



/**
 * Determines the number of words in a String.
 * @param value Input String
 * @returns Float of words in a String
 * @author Aaron Clinger
 * @author Shane McCartney
 * @author David Nelson
 */
public static function wordCount(value:String):Int {
    var out:Int=0;

    if(value){
        out=value.match(~/\b\w+\b/g).length;
    }

    return out;
}



/**
 * Extreme Trim:remove whitespace, line feeds, carriage returns from string
 */
public static function xtrim(str:String=null):String {
    str=(str==null)? "":str;

    var o:String="";
    var TAB:Float=9;
    var LINEFEED:Float=10;
    var CARRIAGE:Float=13;
    var SPACE:Float=32;

    for(i in 0...str.length){
        if(str.charCodeAt(i)!=SPACE && str.charCodeAt(i)!=CARRIAGE && str.charCodeAt(i)!=LINEFEED && str.charCodeAt(i)!=TAB){
            o +=str.charAt(i);
        }
    }

    return o;
}

}