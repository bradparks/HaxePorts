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

import flash.geom.Rectangle;
import hu.vpmedia.math.Percent;

class RatioUtil
{

public static function defineRect(size:Rectangle, width:Float, height:Float, snapToPixel:Bool):Rectangle {
    var scaled:Rectangle=size.clone();

    scaled.width=snapToPixel ? Std.int(width):width;
    scaled.height=snapToPixel ? Std.int(height):height;

    return scaled;
}



/**
 * Determines the ratio of height to width.
 * @param rect Area's width and height expressed as a Rectangle - the Rectangle's x and y values are ignored
 * @author Aaron Clinger
 * @author Shane McCartney
 * @author David Nelson
 */
public static function heightToWidth(rect:Rectangle):Float {
    return rect.height / rect.width;
}




/**
 * Scales an area's width and height while preserving aspect ratio.
 * @param rect Area's width and height expressed as a Rectangle - the Rectangle's x and y values are ignored
 * @param amount Amount you wish to scale by
 * @param snapToPixel true to force the scale to whole pixels, or false to allow sub-pixels
 * @author Aaron Clinger
 * @author Shane McCartney
 * @author David Nelson
 */
public static function scale(rect:Rectangle, amount:Percent, snapToPixel:Bool=true):Rectangle {
    return defineRect(rect, rect.width * amount.decimalPercentage, rect.height * amount.decimalPercentage, snapToPixel);
}


/**
 * Scales the height of an area while preserving aspect ratio.
 * @param rect Area's width and height expressed as a Rectangle - the Rectangle's x and y values are ignored
 * @param width Width to scale to
 * @param snapToPixel true to force the scale to whole pixels, or false to allow sub-pixels
 * @author Aaron Clinger
 * @author Shane McCartney
 * @author David Nelson
 */
public static function scaleHeight(rect:Rectangle, width:Float, snapToPixel:Bool=true):Rectangle {
    return defineRect(rect, width, width * heightToWidth(rect), snapToPixel);
}


/**
 * Resizes an area to fill the bounding area while preserving aspect ratio.
 * @param rect Area's width and height expressed as a Rectangle - the Rectangle's x and y values are ignored
 * @param bounds Area to fill - the Rectangle's x and y values are ignored
 * @param snapToPixel true to force the scale to whole pixels, or false to allow sub-pixels
 * @author Aaron Clinger
 * @author Shane McCartney
 * @author David Nelson
 */
public static function scaleToFill(rect:Rectangle, bounds:Rectangle, snapToPixel:Bool=true):Rectangle {
    var scaled:Rectangle=scaleHeight(rect, bounds.width, snapToPixel);

    if(scaled.height<bounds.height)scaled=scaleWidth(rect, bounds.height, snapToPixel);

    return scaled;
}


/**
 * Resizes an area to the maximum size of a bounding area without exceeding while preserving aspect ratio.
 * @param rect Area's width and height expressed as a Rectangle - the Rectangle's x and y values are ignored
 * @param bounds Area the rectangle needs to fit within - the Rectangle's x and y values are ignored
 * @param snapToPixel true to force the scale to whole pixels, or false to allow sub-pixels
 * @author Aaron Clinger
 * @author Shane McCartney
 * @author David Nelson
 */
public static function scaleToFit(rect:Rectangle, bounds:Rectangle, snapToPixel:Bool=true):Rectangle {
    var scaled:Rectangle=scaleHeight(rect, bounds.width, snapToPixel);

    if(scaled.height>bounds.height)scaled=scaleWidth(rect, bounds.height, snapToPixel);

    return scaled;
}

/**
 * Scales the width of an area while preserving aspect ratio.
 * @param rect Area's width and height expressed as a Rectangle - the Rectangle's x and y values are ignored
 * @param height Height to scale to
 * @param snapToPixel true to force the scale to whole pixels, or false to allow sub-pixels
 * @author Aaron Clinger
 * @author Shane McCartney
 * @author David Nelson
 */
public static function scaleWidth(rect:Rectangle, height:Float, snapToPixel:Bool=true):Rectangle {
    return defineRect(rect, height * widthToHeight(rect), height, snapToPixel);
}



/**
 * Determines the ratio of width to height.
 * @param rect Area's width and height expressed as a Rectangle - the Rectangle's x and y values are ignored
 * @author Aaron Clinger
 * @author Shane McCartney
 * @author David Nelson
 */
public static function widthToHeight(rect:Rectangle):Float {
    return rect.width / rect.height;
}

}