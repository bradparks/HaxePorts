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
import flash.geom.Point;

class GeomUtil
{
/**
   Determines the angle/degree between the first and second point.

   @param first:The first Point.
   @param second:The second Point.
   @return The degree between the two points.
 */
public static function angle(first:Point, second:Point):Float
{
    return Math.atan2(second.y - first.y, second.x - first.x)/(Math.PI / 180);
}/**
 * Created by IntelliJ IDEA.
 * User:Ian McLean
 * Date:Sep 30, 2010
 * Time:11:56:07 AM
 */


/**
    Converts cartesian coordinates to polar coordinates.

   @param x:The x value of the cartesian point.
   @param y:The y value of the cartesian point.
   @return Returns an array containing polar coordinates r and q.
 */

public static function cartesianToPolarCoordinates(x:Float,  y:Float):Array<Dynamic> {

    var r:Float=Math.sqrt(Math.pow(x,2)+ Math.pow(y,2));
    var q:Float=Math.atan(y/x)*(180/Math.PI);

    return [r, q];
}

//TODO:Author?

/**
 * Calculates center Point of a Rectangle.
 * 
 * @param value Rectangle to determine center Point of
 */
public static function getRectangleCenter(value:Rectangle):Point {
    return new Point(value.x +(value.width / 2), value.y +(value.height / 2));
}


/**
   Calculates the perimeter of a rectangle.

   @param rect:Rectangle to determine the perimeter of.
 */
public static function getRectanglePerimeter(rect:Rectangle):Float
{
    return rect.width * 2 + rect.height * 2;
}/**
 * Created by IntelliJ IDEA.
 * User:Ian McLean
 * Date:Sep 30, 2010
 * Time:1:00:51 PM
 */


/**
* Converts polar coordinates to cartesian coordinates.
* @param r The r value of the polar coordinate.
* @param q The q value of the polar coordinate in degrees.
*/

public static function polarToCartesianCoordinates(r:Float, q:Float):Point {

    var asRadian:Float=q * Math.PI/180;

    var x:Float=r * Math.cos(asRadian);
    var y:Float=r * Math.sin(asRadian);
    return new Point(x,y);
}

/**
 * Returns a randomly generated point(containing Int values)
 * 
 * @author Mims H. Wright
 */
public static function randomPoint(xLow:Int, xHigh:Int, yLow:Int, yHigh:Int):Point {
    return new Point(
        NumberUtil.randomIntegerWithinRange(xLow, xHigh),
        NumberUtil.randomIntegerWithinRange(yLow, yHigh)
    );
}


// TODO:What's the point of this? Does this even work? Can a rect have a negative width or height?
// TODO:Author?

/**
 * Reverse a rectangle.
 * 
 * @param value Source rectangle
 * @return Reversed rectangle
 */
public static function reverseRectangle(value:Rectangle):Rectangle {
    return new Rectangle(value.left, value.top, -value.width, -value.height);
}



/**
   Rotates a Point around another Point by the specified angle.

   @param point:The Point to rotate.
   @param centerPoint:The Point to rotate this Point around.
   @param angle:The angle(in degrees)to rotate this point.
 */
public static function rotatePoint(point:Point, centerPoint:Point, angle:Float):Void
{
    var radians:Float=ConversionUtil.degreesToRadians(angle);
    var baseX:Float=point.x - centerPoint.x;
    var baseY:Float=point.y - centerPoint.y;

    point.x=(Math.cos(radians)* baseX)-(Math.sin(radians)* baseY)+ centerPoint.x;
    point.y=(Math.sin(radians)* baseX)+(Math.cos(radians)* baseY)+ centerPoint.y;
}

// todo:author?

/**
 * Returns a new point with x and y values rounded down to the nearest Int.
 * 
 * @param value Source Point to be rounded.
 * @return Point A new point with x and y rounded down to an Int.
 */
public static function roundPoint(point:Point):Point {
    return new Point(Std.int(point.x), Std.int(point.y));
}

/**
 * Simplifies the supplied angle to its simplest representation.
 * Example code:
 *    <pre>
 *          var simpAngle:Float=simplifyAngle(725);// returns 5
 *          var simpAngle2:Float=simplifyAngle(-725);// returns -5
 *    </pre>
 * @param angle Angle to simplify in degrees
 * @return Supplied angle simplified
 * @author Vaclav Vancura(http://vancura.org, http://twitter.com/vancura)
 */
public static function simplifyAngle(angle:Float):Float {
    var _rotations:Float=Math.floor(angle / 360);

    return(angle>=0)? angle -(360 * _rotations):angle +(360 * _rotations);
}

/**
 * Trims the supplied angle to its 0..360 representation.
 * Example code:
 *    <pre>
 *          var simpAngle:Float=trimAngle(725);// returns 5
 *    </pre>
 * @param value Angle to trim
 * @return Supplied angle trimmed
 * @author Vaclav Vancura(http://vancura.org, http://twitter.com/vancura)
 */
public static function trimAngle(value:Float):Float {
    var a:Float=value;

    while(a<0)a +=360;
    while(a>360)a -=360;

    return a;
}

}