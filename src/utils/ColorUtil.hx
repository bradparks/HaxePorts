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
import flash.geom.Rectangle;
import flash.geom.ColorTransform;
import hu.vpmedia.math.Percent;

class ColorUtil
{
/**
 * Sample &amp;average the<i>Blue</i>(RGB)value from a display object or one of its region.
 *
 * @param src The DisplayObject
 * @param accuracy Percentage of pixels to sample when averaging.
 * @param region to sample from [Default:null=entire src object].
 * @return the sampled average<i>blue</i>value on a scale of 0-255.
 */
public static function averageBlue(src:DisplayObject, accuracy:Float=0.01, region:Rectangle=null):Int
{
    return averageColorProperty(src, region, accuracy, 'b');
}


/**
 * @private
 *
 * Sample & average a colorspace value(RGB or HSL)value from a display object or one of its region.
 * @param src                   of the display object.
 * @param region                to sample from [Default:null=entire src object].
 * @param accuracy              percentage of pixels to sample when averaging.
 * @colorspace                  to be sampled. Valid arguments are<code>'r', 'g', 'b', 'h', 's', 'l', 'v'</code>.
 * @return                              the sampled average value requested from the colorspace.
 */
public static function averageColorProperty(src:DisplayObject, region:Rectangle=null, accuracy:Float=0.01, colorspace:String='l'):Float
{
    if(!region)
    {
        region=new Rectangle(0, 0, src.width, src.height);
    }
    var offset:Int=1 / accuracy;
    var total:Int;
    var count:Int;
    // loop thru x/y pixels by offset
    var i:Int = region.x;
    while (i<(region.x + region.width))
    {
        var j:Int = region.y;
        while (j<(region.y + region.height))
        {
            var hex:Int=getColorFromDisplayObject(src, i, j);
            var obj:Dynamic=getRGB(hex);
            if(colorspace=="h" || colorspace=="s" || colorspace=="l")
            {
                var hsl:Dynamic=RGBtoHSL(obj.r, obj.g, obj.b);
                obj=hsl;
            }
            if(colorspace=="v")
            {
                var hsv:Dynamic=RGBtoHSV(obj.r, obj.g, obj.b);
                obj=hsv;
            }
            total +=obj[colorspace];
            count++;
                //trace("colorspace:'" + colorspace + "'=" + obj[colorspace]);
                j += offset;
        }
        i += offset;
    }
    // return the average value
    return total / count;
}


/**
 * Sample &amp;average the<i>Green</i>(RGB)value from a display object or one of its region.
 *
 * @param src The DisplayObject
 * @param accuracy Percentage of pixels to sample when averaging.
 * @param region to sample from [Default:null=entire src object].
 * @return the sampled average<i>green</i>value on a scale of 0-255.
 */
public static function averageGreen(src:DisplayObject, accuracy:Float=0.01, region:Rectangle=null):Int
{
    return averageColorProperty(src, region, accuracy, 'g');
}


/**
 * Sample &amp;average the<i>Hue</i>(HSL)value from a display object or one of its region.
 *
 * @param src The DisplayObject
 * @param accuracy percentage of pixels to sample when averaging.
 * @param region to sample from [Default:null=entire src object].
 * @return the sampled average<i>hue</i>value on a scale of 0-360.
 */
public static function averageHue(src:DisplayObject, accuracy:Float=0.01, region:Rectangle=null):Int
{
    return averageColorProperty(src, region, accuracy, 'h');
}


/**
 * Sample &amp;average the<i>Lightness</i>(HSL)value from a display object or one of its region.
 *
 * @param src The DisplayObject
 * @param accuracy percentage of pixels to sample when averaging.
 * @param region to sample from [Default:null=entire src object].
 * @return the sampled average<i>lightness</i>value on a scale of 0-255.
 */
public static function averageLightness(src:DisplayObject, accuracy:Float=0.01, region:Rectangle=null):Int
{
    return averageColorProperty(src, region, accuracy, 'l');
}


/**
 * Sample &amp;average the<i>Red</i>(RGB)value from a display object or one of its region.
 *
 * @param src The DisplayObject.
 * @param accuracy Percentage of pixels to sample when averaging.
 * @param region to sample from [Default:null=entire src object].
 * @return the sampled average<i>red</i>value on a scale of 0-255.
 */
public static function averageRed(src:DisplayObject, accuracy:Float=0.01, region:Rectangle=null):Int
{
    return averageColorProperty(src, region, accuracy, 'r');
}


/**
 * Sample &amp;average the<i>Saturation</i>(HSL)value from a display object or one of its region.
 *
 * @param src The DisplayObject.
 * @param accuracy percentage of pixels to sample when averaging.
 * @param region to sample from [Default:null=entire src object].
 * @return the sampled average<i>saturation</i>value on a scale of 0-1.
 */
public static function averageSaturation(src:DisplayObject, accuracy:Float=0.01, region:Rectangle=null):Float
{
    return averageColorProperty(src, region, accuracy, 's');
}


/**
 * Sample &amp;average the<i>Value</i>(HSV)value from a display object or one of its region.
 *
 * @param src The DisplayObject
 * @param accuracy percentage of pixels to sample when averaging.
 * @param region to sample from [Default:null=entire src object].
 * @return the sampled average<i>lightness</i>value on a scale of 0-1.
 */
public static function averageValue(src:DisplayObject, accuracy:Float=0.01, region:Rectangle=null):Float
{
    return averageColorProperty(src, region, accuracy, 'v');
}



/**
 * Change the contrast of a hexadecimal Float by a certain increment
 * @param hex           color value to shift contrast on
 * @param inc           increment value to shift
 * @return new hex color value
 */
public static function changeContrast(hex:Float, inc:Float):Float {
    var o:Dynamic=getRGB(hex);
    o.r=clamp(o.r + inc, 0, 255);
    o.g=clamp(o.g + inc, 0, 255);
    o.b=clamp(o.b + inc, 0, 255);
    return toRGBComponents(o.r, o.g, o.b);
}

/**
   Converts a 32-bit ARGB color value Into an ARGB object.

   @param color:The 32-bit ARGB color value.
   @return Returns an object with the properties a, r, g, and b defined.
   @example
<listing version="3.0">
   var myRGB:Dynamic=ColorUtil.getARGB(0xCCFF00FF);
   trace("Alpha=" + myRGB.a);
   trace("Red=" + myRGB.r);
   trace("Green=" + myRGB.g);
   trace("Blue=" + myRGB.b);
</listing>
 */
public static function getARGB(color:Int):Dynamic
{
    var c:Dynamic={};
    c.a=color>>24 & 0xFF;
    c.r=color>>16 & 0xFF;
    c.g=color>>8 & 0xFF;
    c.b=color & 0xFF;
    return c;
}

/**
   Converts a series of individual RGB(A)values to a 32-bit ARGB color value.

   @param r A Int from 0 to 255 representing the red color value.
   @param g A Int from 0 to 255 representing the green color value.
   @param b A Int from 0 to 255 representing the blue color value.
   @param a A Int from 0 to 255 representing the alpha value. Default is<code>255</code>.
   @return Returns a hexidecimal color as a String.
   @example
<listing version="3.0">
   var hexColor:String=ColorUtil.getHexStringFromARGB(128, 255, 0, 255);
   trace(hexColor);// Traces 80FF00FF
</listing>
 */
public static function getColor(r:Int, g:Int, b:Int, a:Int=255):Int
{
    return(a<<24)|(r<<16)|(g<<8)| b;
}



/**
 * Return the(A)RGB<i>hexadecimal</i>color value of a DisplayObject.
 * @param src           of the display object.
 * @param x             position to sample.
 * @param y             position to sample.
 * @param getAlpha      if true return is RGBA, else RGB.
 */
public static function getColorFromDisplayObject(src:DisplayObject, x:Int=0, y:Int=0, getAlpha:Bool=false):Int
{
    var MAX_SIZE_SAFE:Int=2880;

    var w:Float=clamp(src.width, 1, MAX_SIZE_SAFE);
    var h:Float=clamp(src.height, 1, MAX_SIZE_SAFE);
    var bmp:BitmapData=new BitmapData(w, h);
    bmp.lock();
    bmp.draw(src);
    var color:Int=(!getAlpha)? bmp.getPixel(int(x), Std.int(y)):bmp.getPixel32(int(x), Std.int(y));
    bmp.unlock();
    bmp.dispose();
    return color;
}



/**
 Converts a 32-bit ARGB color value Into a hexadecimal String representation.
 @param a A Int from 0 to 255 representing the alpha value.
 @param r A Int from 0 to 255 representing the red color value.
 @param g A Int from 0 to 255 representing the green color value.
 @param b A Int from 0 to 255 representing the blue color value.
 @return Returns a hexadecimal color as a String.
 @example
<code>
 var hexColor:String=ColorUtil.getHexStringFromARGB(128, 255, 0, 255);
 trace(hexColor);// Traces 80FF00FF
</code>
 */
public static function getHexStringFromARGB(a:Int, r:Int, g:Int, b:Int):String {
    var aa:String=a.toString(16);
    var rr:String=r.toString(16);
    var gg:String=g.toString(16);
    var bb:String=b.toString(16);
    aa=(aa.length==1)? '0' + aa:aa;
    rr=(rr.length==1)? '0' + rr:rr;
    gg=(gg.length==1)? '0' + gg:gg;
    bb=(bb.length==1)? '0' + bb:bb;
    return(aa + rr + gg + bb).toUpperCase();
}



/**
 Converts an RGB color value Into a hexadecimal String representation.
 @param r A Int from 0 to 255 representing the red color value.
 @param g A Int from 0 to 255 representing the green color value.
 @param b A Int from 0 to 255 representing the blue color value.
 @return Returns a hexadecimal color as a String.
 @example
<code>
 var hexColor:String=ColorUtil.getHexStringFromRGB(255, 0, 255);
 trace(hexColor);// Traces FF00FF
</code>
 */
public static function getHexStringFromRGB(r:Int, g:Int, b:Int):String {
    var rr:String=r.toString(16);
    var gg:String=g.toString(16);
    var bb:String=b.toString(16);
    rr=(rr.length==1)? '0' + rr:rr;
    gg=(gg.length==1)? '0' + gg:gg;
    bb=(bb.length==1)? '0' + bb:bb;
    return(rr + gg + bb).toUpperCase();
}

/**
   Converts a 24-bit RGB color value Into an RGB object.

   @param color:The 24-bit RGB color value.
   @return Returns an object with the properties r, g, and b defined.
   @example
<code>
   var myRGB:Dynamic=ColorUtil.getRGB(0xFF00FF);
   trace("Red=" + myRGB.r);
   trace("Green=" + myRGB.g);
   trace("Blue=" + myRGB.b);
</code>
 */
public static function getRGB(color:Int):Dynamic
{
    var c:Dynamic={};
    c.r=color>>16 & 0xFF;
    c.g=color>>8 & 0xFF;
    c.b=color & 0xFF;
    return c;
}


/**
 * Returns the transform value set by the last setTransform()call.
 * @return An object containing the current offset and percentage values for the color.
 */
public static function getTransform(src:DisplayObject):Dynamic
{
    var ct:ColorTransform=src.transform.colorTransform;
    return { ra:ct.redMultiplier * 100, rb:ct.redOffset, ga:ct.greenMultiplier * 100, gb:ct.greenOffset, ba:ct.blueMultiplier * 100, bb:ct.blueOffset, aa:ct.alphaMultiplier * 100,
            ab:ct.alphaOffset };
}

/**
 * Convert HSL to HSV using RGB conversions:color preservation may be dubious.
 */
public static function HSLtoHSV(hue:Float, luminance:Float, saturation:Float):Dynamic
{
    var rgbVal:Dynamic=HSLtoRGB(hue, luminance, saturation);
    return RGBtoHSV(rgbVal.r, rgbVal.g, rgbVal.b);
}

/**
 * Convert HSL values to RGB values.
 * @param hue                   0 to 360.
 * @param luminance     0 to 1.
 * @param saturation    0 to 1.
 * @return                              Dynamic with R,G,B values on 0 to 1 scale.
 */
public static function HSLtoRGB(hue:Float, luminance:Float, saturation:Float):Dynamic
{
    var delta:Float;
    if(luminance<0.5)
    {
        delta=saturation * luminance;
    }
    else
    {
        delta=saturation *(1 - luminance);
    }
    return HueToRGB(luminance - delta, luminance + delta, hue);
}

/**
 * Convert HSV to HLS using RGB conversions:color preservation may be dubious.
 */
public static function HSVtoHSL(hue:Float, saturation:Float, value:Float):Dynamic
{
    var rgbVal:Dynamic=HSVtoRGB(hue, saturation, value);
    return RGBtoHSL(rgbVal.r, rgbVal.g, rgbVal.b);
}

/**
 * Convert HSV values to RGB values.
 * @param hue                   on 0 to 360 scale.
 * @param saturation    on 0 to 1 scale.
 * @param value                 on 0 to 1 scale.
 * @return                              Dynamic with R,G,B values on 0 to 1 scale.
 */
public static function HSVtoRGB(hue:Float, saturation:Float, value:Float):Dynamic
{
    var min:Float=(1 - saturation)* value;

    return HueToRGB(min, value, hue);
}

/**
 * Convert hue to RGB values using a linear transformation.
 * @param min   of R,G,B.
 * @param max   of R,G,B.
 * @param hue   value angle hue.
 * @return              Dynamic with R,G,B properties on 0-1 scale.
 */
public static function HueToRGB(min:Float, max:Float, hue:Float):Dynamic
{
    var HUE_MAX:Int=360;

    var mu:Float, md:Float, F:Float, n:Float;
    while(hue<0)
    {
        hue +=HUE_MAX;
    }
    n=Math.floor(hue / 60);
    F=(hue - n * 60)/ 60;
    n %=6;

    mu=min +((max - min)* F);
    md=max -((max - min)* F);

    switch(n)
    {
        case 0:
            return { r:max, g:mu, b:min };
        case 1:
            return { r:md, g:max, b:min };
        case 2:
            return { r:min, g:max, b:mu };
        case 3:
            return { r:min, g:md, b:max };
        case 4:
            return { r:mu, g:min, b:max };
        case 5:
            return { r:max, g:min, b:md };
    }
    return null;
}



/**
   Interpolates(tints)between two colors.

   @param begin:The start color.
   @param end:The finish color.
   @param amount:The level of Interpolation between the two colors.
   @return The new Interpolated color.
   @usage
<code>
   var myColor:ColorTransform=new ColorTransform();
   myColor.color            =0xFF0000;

   var box:Sprite=new Sprite();
   box.graphics.beginFill(0x0000FF);
   box.graphics.drawRect(10, 10, 250, 250);
   box.graphics.endFill();

   box.transform.colorTransform=ColorUtil.interpolateColor(new ColorTransform(), myColor, new Percent(0.5));

   this.addChild(box);
</code>
 */
public static function InterpolateColor(begin:ColorTransform, end:ColorTransform, amount:Percent):ColorTransform
{
    var Interpolation:ColorTransform=new ColorTransform();

    interpolation.redMultiplier=interpolate(amount, begin.redMultiplier, end.redMultiplier);
    interpolation.greenMultiplier=interpolate(amount, begin.greenMultiplier, end.greenMultiplier);
    interpolation.blueMultiplier=interpolate(amount, begin.blueMultiplier, end.blueMultiplier);
    interpolation.alphaMultiplier=interpolate(amount, begin.alphaMultiplier, end.alphaMultiplier);
    interpolation.redOffset=interpolate(amount, begin.redOffset, end.redOffset);
    interpolation.greenOffset=interpolate(amount, begin.greenOffset, end.greenOffset);
    interpolation.blueOffset=interpolate(amount, begin.blueOffset, end.blueOffset);
    interpolation.alphaOffset=interpolate(amount, begin.alphaOffset, end.alphaOffset);

    return Interpolation;
}


/**
 * Inverts the color of the DisplayObject.
 */
public static function invertColor(src:DisplayObject):Void
{
    var t:Dynamic=getTransform(src);
    setTransform(src, {
            ra:-t['ra'], ga:-t['ga'], ba:-t['ba'], rb:255 - t['rb'], gb:255 - t['gb'], bb:255 - t['bb']
        });
}

/**
 * Returns a random color between 0x000000 and 0xFFFFFF
 * 
 * @author Mims Wright
 */
public static function randomColor():Int {
    return Int(Math.random()* 0xFFFFFF);
}


/**
 * Reset the color of the DisplayObject to its original view(pre-ColorTransformed).
 */
public static function resetColor(src:DisplayObject):Void
{
    setTransform(src, { ra:100, ga:100, ba:100, rb:0, gb:0, bb:0 });
}



/**
 * Convert an RGB Hexadecimal value to HSL values
 * @param red           0 - 1 scale.
 * @param green         0 - 1 scale.
 * @param blue          0 - 1 scale.
 * @return Dynamic with h(hue), l(lightness), s(saturation)values:<ul>
 *<li><code>h</code>on 0 - 360 scale.</li>
 *<li><code>l</code>on 0 - 255 scale.</li>
 *<li><code>s</code>on 0 - 1 scale.</li></ul>
 */
public static function RGBtoHSL(red:Float, green:Float, blue:Float):Dynamic {
    var min:Float, max:Float, delta:Float, l:Float, s:Float, h:Float=0;

    max=Math.max(red, Math.max(green, blue));
    min=Math.min(red, Math.min(green, blue));

    //l=(min + max)/ 2;
    l=(min + max)* 0.5;
    // L
    if(l==0){
        return { h:h, l:0, s:1 };
    }

    //delta=(max - min)/ 2;
    delta=(max - min)* 0.5;

    if(l<0.5){
        // S
        s=delta / l;
    }
    else {
        s=delta /(1 - l);
    }
    // H
    h=RGBToHue(red, green, blue);

    return { h:h, l:l, s:s };
}

/**
 * Convert RGB values to HSV values.
 * @param red           0 to 1 scale.
 * @param green         0 to 1 scale.
 * @param blue          0 to 1 scale.
 * @return                      Dynamic with H,S,V values:<ul>
 *                                            <li>h - on 0 to 360 scale</li>
 *                                            <li>s - on 0 to 1 scale</li>
 *                                            <li>v - on 0 to 1 scale</li></ul>
 */
public static function RGBtoHSV(red:Float, green:Float, blue:Float):Dynamic
{
    var min:Float, max:Float, s:Float, v:Float, h:Float=0;

    max=Math.max(red, Math.max(green, blue));
    min=Math.min(red, Math.min(green, blue));

    if(max==0)
    {
        return { h:0, s:0, v:0 };
    }

    v=max;
    s=(max - min)/ max;

    h=RGBToHue(red, green, blue);

    return { h:h, s:s, v:v };
}


/**
 * Convert RGB values to a hue using a linear transformation.
 * @param red           value on 0 to 1 scale.
 * @param green         value on 0 to 1 scale.
 * @param blue          value on 0 to 1 scale.
 * @return                      hue degree between 0 and 360.
 */
public static function RGBToHue(red:Float, green:Float, blue:Float):Int
{
    var f:Float, min:Float, mid:Float, max:Float, n:Float;

    max=Math.max(red, Math.max(green, blue));
    min=Math.min(red, Math.min(green, blue));

    // achromatic case
    if(max - min==0)
    {
        return 0;
    }

    mid=center(red, green, blue);

    // using this loop to avoid super-ugly nested ifs
    while(true)
    {
        if(red==max)
        {
            if(blue==min)
                n=0;
            else
                n=5;
            break;
        }

        if(green==max)
        {
            if(blue==min)
                n=1;
            else
                n=2;
            break;
        }

        if(red==min)
            n=3;
        else
            n=4;
        break;
    }

    if((n % 2)==0)
    {
        f=mid - min;
    }
    else
    {
        f=max - mid;
    }
    f=f /(max - min);

    return 60 *(n + f);
}

public static function setARGB(a:Float, r:Float, g:Float, b:Float):Int
{
    var argb:Int=0;
    argb +=(a<<24);
    argb +=(r<<16);
    argb +=(g<<8);
    argb +=(b);
    return argb;
}


/**
 * Set the(A)RGB<i>hexadecimal</i>color value of a DisplayObject using ColorTransform.
 */
public static function setColor(src:DisplayObject, hex:Int):Void
{
    var ct:ColorTransform=src.transform.colorTransform;
    ct.color=hex;
    src.transform.colorTransform=ct;
}


/**
 * Set ColorTransform information for a DisplayObject.
 *
 *<p>The colorTransformObject parameter is a generic object that you create from the new Dynamic constructor. It has parameters specifying the percentage and
 * offset values for the red, green, blue, and alpha(transparency)components of a color, entered in the format 0xRRGGBBAA.</p>
 *
 * @param transformObject An object created with the new Dynamic constructor. This instance of the Dynamic class must have the following properties
 * that specify color transform values:ra, rb, ga, gb, ba, bb, aa, ab. These properties are explained in the above summary for the setTransform()method.
 */
public static function setTransform(src:DisplayObject, transformObject:Dynamic):Void
{
    var t:Dynamic={ ra:100, rb:0, ga:100, gb:0, ba:100, bb:0, aa:100, ab:0 };
    for(p in transformObject)
    {
        t[p]=transformObject[p];
    }
    var ct:ColorTransform=new ColorTransform(t['ra'] * 0.01, t['ga'] * 0.01, t['ba'] * 0.01, t['aa'] * 0.01, t['rb'], t['gb'], t['bb'], t['ab']);
    src.transform.colorTransform=ct;
}

/**
 * Parse a String representation of a color(hex or html)to Int.
 */
public static function toColor(str:String):Int
{
    if(str.substr(0, 2)=='0x')
    {
        str=str.substr(2);
    }
    else if(str.substr(0, 1)=='#')
    {
        str=str.substr(1);
    }
    return parseInt(str, 16);
}

public static function toGrayscale(hex:Int):Int
{
    var color:Dynamic=getARGB(hex);
    var c:Float=0;
    c +=color.r * .3;
    c +=color.g * .59;
    c +=color.b * .11;
    color.r=color.g=color.b=c;
    return setARGB(color.a, color.r, color.g, color.b);
}



/**
 * Convert a hexadecimal number to a string representation with ECMAScript notation:<code>0xrrggbb</code>.
 */
public static function toHexString(hex:Int):String {
    return "0x" +(hex.toString(16)).toUpperCase();
}



/**
 * Convert a hexadecimal number to a string representation with HTML notation:<code>#rrggbb</code>.
 */
public static function toHTML(hex:Int):String {
    return "#" +(hex.toString(16)).toUpperCase();
}



/**
 * Convert individual R,G,B values to a hexadecimal value.
 */
public static function toRGBComponents(r:Int, g:Int, b:Int):Int {
    var hex:Int=0;
    hex +=(r<<16);
    hex +=(g<<8);
    hex +=(b);
    return hex;
}

}