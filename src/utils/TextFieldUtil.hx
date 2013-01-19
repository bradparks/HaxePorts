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
import flash.display.DisplayObjectContainer;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFieldType;
import flash.text.TextFormat;
import flash.text.StyleSheet;
import flash.text.Font;

class TextFieldUtil
{

/**
 * Clear a<code>TextField</code>text or to all<code>TextField</code>'s texts in a<code>DisplayObjectContainer</code>.
 * @param o            <code>DisplayObject</code>that either<i>is</i>or contains<code>TextField</code>'s.
 */
public static function clearFields(o:DisplayObject):Void
{
    var tf:TextField;
    if(Std.is(o, TextField))
    {
        tf=cast(o, TextField);
        tf.text=tf.htmlText='';
    }
    else if(Std.is(o, DisplayObjectContainer))
    {
        var container:DisplayObjectContainer=cast(o, DisplayObjectContainer);
        for(i in 0...container.numChildren)
        {
            if(Std.is(container.getChildAt(i), TextField))
            {
                tf=cast(container.getChildAt(i), TextField);
                tf.text=tf.htmlText='';
            }
        }
    }
}


/**
 * Create a<code>TextField</code>instance and return it.
 */
public static function createField(str:String, x:Float=0, y:Float=0, width:Float=200, height:Float=20, multiline:Bool=false, font:String="Verdana", size:Float=9, color:Int=0,
                            autoSize:TextFieldAutoSize=null, embedFonts:Bool=false, selectable:Bool=false, css:StyleSheet=null):TextField
{
    if (autoSize == null)
    {
        autoSize = TextFieldAutoSize.LEFT;
    }
    var tf:TextField=new TextField();
    var fmt:TextFormat=new TextFormat(font, size, color);
    tf.x=x;
    tf.y=y;
    tf.width=width;
    tf.height=height;
    tf.autoSize=autoSize;
    tf.embedFonts=embedFonts;
    tf.selectable=selectable;
    tf.multiline=multiline;
    tf.textColor=color;
    tf.defaultTextFormat=fmt;
    tf.htmlText=str;
    tf.styleSheet=css;
    return tf;
}


/**
 * Apply a<code>TextFormat</code>to a<code>TextField</code>or to all<code>TextField</code>'s in a<code>DisplayObjectContainer</code>.
 * @param o                    <code>DisplayObject</code>that either<i>is</i>or contains<code>TextField</code>'s.
 * @param textFormat    to apply to the<code>TextField</code>'s.
 */
public static function formatFields(o:DisplayObject, textFormat:TextFormat):Void
{
    var tf:TextField;
    if(Std.is(o, TextField))
    {
        tf=cast(o, TextField);
        tf.setTextFormat(textFormat);
    }
    else if(Std.is(o, DisplayObjectContainer))
    {
        var container:DisplayObjectContainer=cast(o, DisplayObjectContainer);
        for(i in 0...container.numChildren)
        {
            if(Std.is(container.getChildAt(i), TextField))
            {
                tf=cast(container.getChildAt(i), TextField);
                tf.setTextFormat(textFormat);
            }
        }
    }
}


/**
 * Searches the client's available fonts to see if any of the Font from the<code>desiredFontList</code>are available.
 * @param desiredFontList       array of desired<code>fontName</code>'s.
 * @return                                      array of desired fonts which are available for use on the client's system.
 */
public static function getUsableFonts(desiredFontList:Array<Dynamic>):Array<Dynamic>
{
    var clientFontList:Array<Dynamic>=Font.enumerateFonts(true);
    var availableFontList:Array<Dynamic>=new Array();
    for(i in 0...desiredFontList.length)
    {
        for(j in 0...clientFontList.length)
        {
            if(desiredFontList[i]==cast(clientFontList[j],Font).fontName)
            {
                availableFontList.push(desiredFontList[i]);
            }
        }
    }
    return(availableFontList.length>=1)? availableFontList:null;
}


/**
 * Hide a<code>TextField</code>or<code>TextField</code>'s from display(visible false, alpha 0).
 * @see #reveal
 */
public static function hideFields(args:Array<Dynamic>):Void
{
    for(i in 0...args.length)
    {
        if(Std.is(args[i], TextField))
        {
            args[i].alpha=0;
            args[i].visible=false;
        }
    }
}


/**
 * Reveal a<code>TextField</code>or<code>TextField</code>'s(visible true, alpha 1)
 * @see #hide
 */
public static function revealFields(args:Array<Dynamic>):Void
{
    for(i in 0...args.length)
    {
        if(Std.is(args[i], TextField))
        {
            args[i].alpha=1;
            args[i].visible=true;
        }
    }
}



/**
 * Set the text of a<code>TextField</code>while preserving the formatting(leading, kerning, etc).
 * XXX - Warning:htmlText and styles can break the formatting:no known fix as of yet.
 */
public static function setFormattedText(tf:TextField, str:String, autoSize:Bool=true):Void
{
    var s:String=(isBlank(str))? " ":str;
    if(autoSize)
    {
        tf.autoSize=TextFieldAutoSize.LEFT;
    }
    var textFormat:TextFormat=tf.getTextFormat();
    if(tf.type==TextFieldType.INPUT)
    {
        tf.text=s;
    }
    else
    {
        tf.htmlText=s;
    }
    tf.setTextFormat(textFormat);
}

/**
 * Validate if a strings contents are blank after a safety trim is performed.
 */
public static function isBlank(s:String = null):Bool
{
    var str:String = StringUtil.trim(s);
    var i:Int = 0;
    if (str.length == 0)
    {
        return true;
    }
    while (i < str.length)
    {
        if (str.charCodeAt(0) != 32)
        {
            return false;
        }
        i++;
    }
    return true;
}


/**
 * Apply a<code>StyleSheet</code>to a<code>TextField</code>&amp;set its contents.
 *
 * @param tf<code>TextField</code>to display.
 * @param str of text to apply.
 * @param stylesheet to apply to the<code>TextField</code>'s(Default:<code>App.css</code>).
 *
 * @see sekati.core.App#css
 */
public static function setStyledText(tf:TextField, str:String, stylesheet:StyleSheet=null):Void
{
    styleFields(tf, stylesheet);
    tf.htmlText=str;
}


/**
 * Set the<code>TextField</code>color formatting.
 */
public static function setTextColor(tf:TextField, color:Int, backgroundColor:Int, borderColor:Int):Void
{
    tf.textColor=color;
    tf.background=true;
    tf.backgroundColor=backgroundColor;
    tf.border=true;
    tf.borderColor=borderColor;
}


/**
 * Set the<code>TextField</code>font formatting.
 */
public static function setTextFont(tf:TextField, fontName:String, fontSize:Float, isEmbedFont:Bool=false, isBold:Bool=false, isItalic:Bool=false, isUnderline:Bool=false):Void
{
    var fmt:TextFormat=tf.getTextFormat();
    fmt.font=fontName;
    fmt.size=fontSize;
    fmt.italic=isItalic;
    fmt.bold=isBold;
    fmt.underline=isUnderline;
    tf.embedFonts=isEmbedFont;
    tf.setTextFormat(fmt);
}


/**
 * Set the<code>TextField</code>leading formatting.
 */
public static function setTextLeading(tf:TextField, space:Float=0):Void
{
    var fmt:TextFormat=tf.getTextFormat();
    fmt.leading=space;
    tf.setTextFormat(fmt);
}


/**
 * Set the<code>TextField</code>letter spacing formatting.
 */
public static function setTextLetterSpacing(tf:TextField, spacing:Float=0):Void
{
    var fmt:TextFormat=tf.getTextFormat();
    fmt.letterSpacing=spacing;
    tf.setTextFormat(fmt);
}


/**
 * Set the<code>TextField</code>'s width for space characters.
 */
public static function setTextSpaceWidth(tf:TextField, space:Float=1):Void
{
    var fmt:TextFormat=new TextFormat();
    fmt.letterSpacing=space;
    var i:Int=0;
    while(tf.text.indexOf(" ", i)>-1)
    {
        var index:Int=tf.text.indexOf(" ", i);
        tf.setTextFormat(fmt, index, index + 1);
        i=index + 1;
    }
}


/**
 * Apply the application stylesheet to a<code>TextField</code>or to all<code>TextField</code>'s in a<code>DisplayObjectContainer</code>.
 *
 *<p><b>Warning</b>:Unlike<code>formatFields</code>you must<i>reset</i>your<code>htmlText</code>to have the style applied.</p>
 * @param o                    <code>DisplayObject</code>that either<i>is</i>or contains<code>TextField</code>'s.
 * @param stylesheet    to apply to the<code>TextField</code>'s(Default:<code>App.css</code>).
 * @see sekati.core.App#css
 */
public static function styleFields(o:DisplayObject, stylesheet:StyleSheet):Void
{
    var tf:TextField;
    var css:StyleSheet=stylesheet;
    if(Std.is(o, TextField))
    {
        tf=cast(o, TextField);
        tf.styleSheet=css;
    }
    else if(Std.is(o, DisplayObjectContainer))
    {
        var container:DisplayObjectContainer=cast(o, DisplayObjectContainer);
        for(i in 0...container.numChildren)
        {
            if(Std.is(container.getChildAt(i), TextField))
            {
                tf=cast(container.getChildAt(i), TextField);
                tf.styleSheet=css;
            }
        }
    }
}


/**
 * Truncate a multiline<code>TextField</code>after the defined number of lines of text.
 * @param tf                            <code>TextField</code>to truncate.
 * @param numAlllowedLines      before the remaining text is removed.
 * @param isEllipsed            determines whether the text is ended with "..." or not.
 */
public static function truncateMultilineText(tf:TextField, numAlllowedLines:Int, isEllipsed:Bool=true):Void
{
    if(tf.bottomScrollV>numAlllowedLines)
    {
        var len:Int=tf.text.length;
        for(i in 0...len)
        {
            tf.scrollV=tf.maxScrollV;
            if(tf.bottomScrollV>numAlllowedLines)
            {
                
                tf.text=tf.text.substr(0, -1);
            }
            else
            {
                var e:Int=(isEllipsed)? -3:tf.text.lastIndexOf(" ");
                tf.text=tf.text.substr(0, e);
                tf.appendText("...");
                break;
            }
        }
    }
}


/**
 * Truncate a single-line TextField to a specific width.
 * @param tf                    the textfield to truncate.
 * @param maxWidth              the desired text width to truncate at.
 * @param isEllipsed    denotes whether to truncate with the ellipse char "...".
 * @param isLineEllipse gives the option to "ellipse" the entire width of the field.
 */
public static function truncateText(tf:TextField, maxWidth:Float, isEllipsed:Bool=true, isLineEllipse:Bool=false):Void
{
    var ellipse:String='...';

    // save the autosize settings for renewal at the end ...
    var autoSizeSetting:TextFieldAutoSize=tf.autoSize;
    tf.autoSize=TextFieldAutoSize.NONE;

    // subtract a touch of length from the max width to insure no visual overflow ...
    //maxWidth=(!isLongEllipse)?(maxWidth - 5):(maxWidth -=10);

    // don't ellipse if we fit under the max width.
    if(tf.textWidth<=maxWidth && !isLineEllipse)
    {
        return;
    }

    // hide the field momentarily so the user doesnt see our tests ...
    //tf.visible=false;

    // save the original text string & it's length
    var str:String=tf.htmlText;
    var strLength:Int=str.length;

    // save the(stereotypical fonts)widest character's width:"W"
    tf.htmlText="W";
    var wCharWidth:Float=tf.textWidth;

    // save the(stereotypical fonts)medium character's width:"A"
    tf.text="A";
    var aCharWidth:Float=tf.textWidth;

    // the max num of(the largest)chars which our max desired width can hold.
    var ptr:Int=Math.floor(maxWidth / wCharWidth);

    // collect the portion of the string which represents the max large chars(ptr)and add it to the field.
    var checkStr:String=str.substr(0, ptr);
    tf.text=checkStr;

    // Now that we have a baseline set below our maxWidth we can start adding/testing characters:
    // in this way we optimize the number of loops which must be performed which *greatly* improves
    // performance rather than adding/testing thru the entire string(Std.is(this, especially) important
    // when using the method on many long texted TextFields:smart, huh?
    var cnt:Int;
    while(tf.textWidth<maxWidth)
    {
        // see if we can fit one or more standard characters in the space remaining:if we cant:bail.
        cnt=Math.floor((maxWidth - tf.textWidth)/ aCharWidth);
        if(cnt==0)
        {
            break;
        }
        // increase the max chars:if we accidentally went above the str length:fix er up ...
        ptr +=cnt;
        ptr=(ptr>strLength)? strLength:ptr;

        // once again set a slice of our max fitting chars to the field.
        checkStr=str.substr(0, ptr);
        tf.htmlText=checkStr;

        // if our max fitting chars is the same as the string length:bail too.
        if(strLength==ptr)
        {
            break;
        }
    }

    // if we want to ellipse apply it to the field.
    if(isEllipsed)
    {
        tf.appendText(ellipse);
    }

    // again check if we've exceeded the max desired width ...
    if(tf.textWidth>maxWidth)
    {
        // if we have remove a character and test again.
        while(tf.textWidth>maxWidth)
        {
            checkStr=checkStr.substr(0, -1);
            tf.htmlText=isEllipsed ?(checkStr + ellipse):checkStr;
        }
    }

    // alright - things fit perfectly now! However;maybe you want it to
    // "ellipse" thru the entire length of the field for visual effect?
    //
    // TODO - Warning:this functions but is not perfect:can be optimized and made more accurate.
    //
    if(isLineEllipse)
    {

        var tmpField:TextField=new TextField();
        tmpField.width=tf.width;
        tmpField.setTextFormat(tf.getTextFormat());

        // save the(stereotypical fonts)smallest character's width:"."
        tmpField.htmlText=".";
        var periodCharWidth:Float=tmpField.textWidth;

        tmpField.htmlText="";
        var whiteSpaceWidth:Float=tmpField.width - tf.textWidth;
        var i:Float=Math.floor(whiteSpaceWidth / periodCharWidth);
        while(i-->0)
        {
            tmpField.appendText(".");
        }
        if(whiteSpaceWidth<tmpField.textWidth)
        {
            while(whiteSpaceWidth<tmpField.textWidth)
            {
                tmpField.htmlText=tmpField.text.substr(0, -1);
            }
        }
        else if(whiteSpaceWidth>tmpField.textWidth)
        {
            while(tmpField.textWidth<whiteSpaceWidth)
            {
                tmpField.appendText(".");
            }
            tmpField.htmlText=tmpField.text.substr(0, -1);
        }
        tf.appendText(tmpField.text);
    }

    // restore the settings and make the text visible again...
    tf.autoSize=autoSizeSetting;
    //tf.visible=true;

    // defer rendering if the field is on stage to avoid the flickering of the char tests...
    //if(tf.stage !=null)tf.stage.invalidate();
}

}