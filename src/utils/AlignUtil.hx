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
import flash.display.DisplayObject;
import flash.text.TextField;

class AlignUtil
{
/**
 * Center align object to target.
 */
public static function alignCenter(item:DisplayObject, target:DisplayObject):Void {
    xAlignCenter(item, target);
    yAlignCenter(item, target);
}

/**
 * Aligns all the target DisplayObjects by their left edge to the left-most target. 
 *
 * Similar to the Flash IDE Alignment panel.
 * 
 * Given the following arrangement of targets:
 *<code>
 *  t1 
 *       t2
 *    t3
 *</code>
 * 
 * After calling<code>alignLeft([ t1, t2, t3 ])</code>the arrangment will be:
 *<code>
 *  t1
 *  t2
 *  t3
 *</code>
 * 
 * @param targets Array of DisplayObject(or Dynamic with an<code>x</code>property like<code>Point</code>).
 * @return targets Array. 
 * 
 * @example
 *<listing version="3.0">
 *     var t1:Sprite=new Sprite();
 *     t1.x=5;
 * 
 *     var t2:Sprite=new Sprite();
 *     t2.x=30;
 * 
 *     var t3:Sprite=new Sprite();
 *     t3.x=15;
 * 
 *     var targets:Array<Dynamic>=[t1, t2, t3];
 *     alignLeft(targets);
 * 
 *     trace(t1.x, t2.x t3.x);
 *     // 5 5 5
 *</listing>
 * 
 * @author drewbourne
 */
public static function alignLeft(targets:Array<Dynamic>):Array<Dynamic>
{
    var minX:Float=NumberUtil.MAX_VALUE;
    var targetX:Float;
    var target:Dynamic;
    
    for(target in targets)
    {
        targetX=target.x;
        
        if(targetX<minX)
            minX=targetX;
    }
    
    for(target in targets)
    {
        target.x=minX;
    }
    
    return targets;
}

/**
 * Aligns all the target DisplayObjects by their left edge to the left-most target. 
 *
 * Similar to the Flash IDE Alignment panel.
 * 
 * Given the following arrangement of targets:
 *<code>
 *  t1 
 *       t2
 *    t3
 *</code>
 * 
 * After calling<code>alignRight([ t1, t2, t3 ])</code>the arrangment will be:
 *<code>
 *       t1
 *       t2
 *       t3
 *</code>
 * 
 * @param targets Array of DisplayObject 
 *                   or Dynamic with an<code>x</code>property like<code>Point</code>
 *                   or Dynamic with an<code>x</code>and<code>width</code>properties like<code>Rectangle</code>.
 * 
 * @return targets Array. 
 * 
 * @example
 *<listing version="3.0">
 *     
 *</listing>
 * 
 * @author drewbourne
 */
public static function alignRight(targets:Array<Dynamic>):Array<Dynamic>
{
    var maxX:Float=NumberUtil.MIN_VALUE;
    var targetW:Float;
    var targetX:Float;
    var target:Dynamic;
    
    for(target in targets)
    {
        targetW=Reflect.hasField(target, "width") ? Reflect.getProperty(target, "width"):0;
        targetX=target.x + targetW;
        
        if(targetX>maxX)
            maxX=targetX;
    }
    
    for(target in targets)
    {
        targetW=Reflect.hasField(target, "width") ? Reflect.getProperty(target, "width"):0;
        target.x=maxX - targetW;
    }
    
    return targets;
}


/**
   Aligns a DisplayObject to the bottom of the bounding Rectangle.

   @param displayObject The DisplayObject to align.
   @param bounds The area in which to align the DisplayObject.
   @param snapToPixel Force the position to whole pixels<code>true</code>, or to let the DisplayObject be positioned on sub-pixels<code>false</code>.
   @param outside Align the DisplayObject to the outside of the bounds<code>true</code>, or the inside<code>false</code>.
 */
public static function alignToRectangleBottom(displayObject:DisplayObject, bounds:Rectangle, snapToPixel:Bool=true, outside:Bool=false):Void
{
    var y:Float=outside ? bounds.bottom:bounds.bottom - displayObject.height;
    displayObject.y=snapToPixel ? Math.round(y):y;
}


/**
   Aligns a DisplayObject to the horizontal center of the bounding Rectangle.

   @param displayObject:The DisplayObject to align.
   @param bounds:The area in which to align the DisplayObject.
   @param snapToPixel:Force the position to whole pixels<code>true</code>, or to let the DisplayObject be positioned on sub-pixels<code>false</code>.
 */
public static function alignToRectangleCenter(displayObject:DisplayObject, bounds:Rectangle, snapToPixel:Bool=true):Void
{
    var centerX:Float=bounds.width * 0.5 - displayObject.width * 0.5 + bounds.x;
    displayObject.x=snapToPixel ? Math.round(centerX):centerX;
}


/**
   Aligns a DisplayObject to the horizontal center and vertical middle of the bounding Rectangle.

   @param displayObject:The DisplayObject to align.
   @param bounds:The area in which to align the DisplayObject.
   @param snapToPixel:Force the position to whole pixels<code>true</code>, or to let the DisplayObject be positioned on sub-pixels<code>false</code>.
 */
public static function alignToRectangleCenterMiddle(displayObject:DisplayObject, bounds:Rectangle, snapToPixel:Bool=true):Void
{
    alignToRectangleCenter(displayObject, bounds, snapToPixel);
    alignToRectangleMiddle(displayObject, bounds, snapToPixel);
}


/**
   Aligns a DisplayObject to the left side of the bounding Rectangle.

   @param displayObject:The DisplayObject to align.
   @param bounds:The area in which to align the DisplayObject.
   @param snapToPixel:Force the position to whole pixels<code>true</code>, or to let the DisplayObject be positioned on sub-pixels<code>false</code>.
   @param outside:Align the DisplayObject to the outside of the bounds<code>true</code>, or the inside<code>false</code>.
 */
public static function alignToRectangleLeft(displayObject:DisplayObject, bounds:Rectangle, snapToPixel:Bool=true, outside:Bool=false):Void
{
    var x:Float=outside ? bounds.left - displayObject.width:bounds.left;
    displayObject.x=snapToPixel ? Math.round(x):x;
}


/**
   Aligns a DisplayObject to the vertical middle of the bounding Rectangle.

   @param displayObject:The DisplayObject to align.
   @param bounds:The area in which to align the DisplayObject.
   @param snapToPixel:Force the position to whole pixels<code>true</code>, or to let the DisplayObject be positioned on sub-pixels<code>false</code>.
 */
public static function alignToRectangleMiddle(displayObject:DisplayObject, bounds:Rectangle, snapToPixel:Bool=true):Void
{
    var centerY:Float=bounds.height * 0.5 - displayObject.height * 0.5 + bounds.y;
    displayObject.y=snapToPixel ? Math.round(centerY):centerY;
}


/**
   Aligns a DisplayObject to the right side of the bounding Rectangle.

   @param displayObject:The DisplayObject to align.
   @param bounds:The area in which to align the DisplayObject.
   @param snapToPixel:Force the position to whole pixels<code>true</code>, or to let the DisplayObject be positioned on sub-pixels<code>false</code>.
   @param outside:Align the DisplayObject to the outside of the bounds<code>true</code>, or the inside<code>false</code>.
 */
public static function alignToRectangleRight(displayObject:DisplayObject, bounds:Rectangle, snapToPixel:Bool=true, outside:Bool=false):Void
{
    var x:Float=outside ? bounds.right:bounds.right - displayObject.width;
    displayObject.x=snapToPixel ? Math.round(x):x;
}


/**
   Aligns a DisplayObject to the top of the bounding Rectangle.

   @param displayObject:The DisplayObject to align.
   @param bounds:The area in which to align the DisplayObject.
   @param snapToPixel:Force the position to whole pixels<code>true</code>, or to let the DisplayObject be positioned on sub-pixels<code>false</code>.
   @param outside:Align the DisplayObject to the outside of the bounds<code>true</code>, or the inside<code>false</code>.
 */
public static function alignToRectangleTop(displayObject:DisplayObject, bounds:Rectangle, snapToPixel:Bool=true, outside:Bool=false):Void
{
    var y:Float=outside ? bounds.top - displayObject.height:bounds.top;
    displayObject.y=snapToPixel ? Math.round(y):y;
}

/**
 * Aligns the items in the array in a grid based on the number of rows and columns.
 * Uses the same spacing for all.
 *
 * @example<listing version="3.0">Alignment.hAlignSpaceNum([ clip0, clip1, clip2], 10);</listing>
 *
 * @param items An array of items
 * @param rows The number of rows
 * @param cols The number of columns
 * @param spacing The spacing between items in pixels
 */
public static function gridAlignSpaceNumber(items:Array<Dynamic>, rows:Float, cols:Float, spacing:Float=0):Void
{
    var col:Float=0;
    var row:Float=1;
    var yPos:Float=0;
    var xPos:Float=0;
    var maxHeightCurrentRow:Float=0;
    var maxHeightPreviousRow:Float=0;
    var n:Int=items.length;

    for(i in 0...n)
    {
        if(row<=rows)
        {
            items[i].x=xPos;

            if(col==(cols - 1))
            {
                xPos=0;
                row++;
            }
            else
            {
                xPos +=items[(i)].width + spacing;
            }

            if(col==cols)
            {
                col=0;

                /*
                 * Get the max item height from previous row
                 */
                maxHeightPreviousRow=maxHeightCurrentRow;
                maxHeightCurrentRow=items[(i)].height;

                yPos +=maxHeightPreviousRow + spacing;
            }
            else
            {
                /*
                 * Calculate the max item height from previous row
                 */
                maxHeightCurrentRow=Math.max(maxHeightCurrentRow, items[(i)].height);
            }
            items[i].y=yPos;

            col++;
        }
        else
        {
            break;
        }
    }
}

/**
 * Aligns the items in the array in a grid based on the number of rows and columns.
 * Uses the same spacing for all
 *
 * @example<listing version="3.0">Alignment.hAlignSpaceNum([ clip0, clip1, clip2], 10);</listing>
 *
 * @param items An array of items
 * @param rows The number of rows
 * @param cols The number of columns
 * @param hGap The column width
 * @param vGap The row height
 * @param spacing The spacing between items in pixels
 */
public static function gridAlignSpaceNumberGap(items:Array<Dynamic>, rows:Float, cols:Float, hGap:Float, vGap:Float, spacing:Float=0):Void
{
    var col:Float=0;
    var row:Float=1;
    var yPos:Float=0;
    var xPos:Float=0;

    var n:Int=items.length;
    for(i in 0...n)
    {
        if(row<=rows)
        {
            items[i].x=xPos;

            if(col==(cols - 1))
            {
                xPos=0;
                row++;
            }
            else
            {
                xPos +=hGap + spacing;
            }

            if(col==cols)
            {
                col=0;
                yPos +=vGap + spacing;
            }

            items[i].y=yPos;

            col++;
        }
        else
            break;
    }
}



/**
 * Convenient horizontal align method with optional alignment argument
 * @example<listing version="3.0">Alignment.hAlign([ clip0, clip1, clip2], 10);</listing>
 * @param items An array of items
 * @param args spacing The spacing between items in pixels as either a number or array or blank
 */
public static function horizontalAlign(items:Array<Dynamic>, args:Array<Dynamic>):Void {
    if(args.length>0){
        if(Std.is(args[0], Array))
            horizontalAlignSpaceArray(items, args[0]);
        if(Std.is(args[0], Float))
            horizontalAlignSpaceNumber(items, args[0]);
    }
    else
        horizontalAlignNoSpace(items);
}

/**
 * Aligns each item horizontally to the one above it.
 * Uses no spacing.
 *
 * @example<listing version="3.0">Alignment.hAlignNoSpace([ clip0, clip1, clip2]);</listing>
 *
 * @param items An array of items
 */
public static function horizontalAlignNoSpace(items:Array<Dynamic>):Void
{
    var n:Int=items.length;
    for(i in 1...n)
    {
        items[i].x=items[(i - 1)].y + items[(i - 1)].width;
    }
}



/**
 * Aligns each item in the array to the one preceding it.
 * Uses the correlating position in the spacing arr for the spacing.
 * @example<listing version="3.0">Alignment.hAlignSpaceArr([ clip0, clip1, clip2], [ 0, 5, 30 ]);</listing>
 * @param items An array of items
 * @param spacing The array for spacing between items in pixels
 */

public static function horizontalAlignSpaceArray(items:Array<Dynamic>, spacing:Array<Dynamic>):Void {
    var n:Int=items.length;
    for(i in 1...n){
        items[i].x=items[(i - 1)].x + items[(i - 1)].width + spacing[i];
    }
}

/**
 * Aligns the items in the array horizontally to each the one preceding it in the array.
 * Uses the same spacing for all.
 *
 * @example<listing version="3.0">Alignment.hAlignSpaceNum([ clip0, clip1, clip2], 10);</listing>
 *
 * @param items An array of items
 * @param spacing The spacing between items in pixels
 */
public static function horizontalAlignSpaceNumber(items:Array<Dynamic>, spacing:Float):Void
{
    var n:Int=items.length;
    for(i in 1...n)
    {
        items[i].x=items[(i - 1)].x + items[(i - 1)].width + spacing;
    }
}


/**
 * Interpolate the DisplayObject at weight t==(0 &lt;=t &lt;=1). a position 1 would position the object to the
 * right-most bounds, and tx=0 would position to the left
 *
 * @param object DisplayObject to position
 * @param tx weight of horizontal position from 0 to 1
 * @param ty weight of verticle position from 0 to 1
 * @param width width of horizontal constraint
 * @param height height of the verticle constraint
 * @offsetX the left offset of the horizontal constraint(default=0)
 * @offsetY the topmost offset of verticle constraint(default=0)
 */
public static function Interpolate(object:DisplayObject, tx:Float, ty:Float, width:Float, height:Float, offsetX:Int=0, offsetY:Int=0):Void
{
    object.x=(width * tx)+ offsetX -(tx * object.width);
    object.y=(height * ty)+ offsetY -(ty * object.height);
}

/**
 * Interpolate multiple DisplayObjects at multiple weights at t==(0 less or equal t less or equal 1).  at tx=1, the position of the object would be aligned to the right-most bounds, and tx=0 would position to the left
 *
 * @param DisplayObject DisplayObject to position
 * @param positionArray weight array of horizontal position from 0 to 1
 * @param width width of horizontal constraint
 * @offsetX the left offset of the horizontal constraint(default=0)
 */
public static function InterpolateMultiX(objectArray:Array<Dynamic>, positionArray:Array<Dynamic>, width:Float, offsetX:Int=0):Void
{
    var j:Int=objectArray.length;
    for(i in 0...j)
    {
        interpolateX(objectArray[i], positionArray[i], width, offsetX);
    }
}

/**
 * Interpolate multiple DisplayObjects at multiple weights at t==(0 less or equal t less or equal 1).  at tx=1, the position of the object would be aligned to the right-most bounds, and ty=0 would position to the left
 *
 * @param DisplayObject DisplayObject to position
 * @param positionArray weight array of vertical position from 0 to 1
 * @param height width of horizontal constraint
 * @param offsetY the left offset of the horizontal constraint(default=0)
 */
public static function InterpolateMultiY(objectArray:Array<Dynamic>, positionArray:Array<Dynamic>, height:Float, offsetY:Int=0):Void
{
    var j:Int=objectArray.length;
    for(i in 0...j)
    {
        interpolateX(objectArray[i], positionArray[i], height, offsetY);
    }
}


/**
 * Interpolate the DisplayObject at weight t to the rectangle, ie, a weight of 1 would position the object to the right-most bounds
 *
 * @param DisplayObject DisplayObject to position
 * @param tx
 * @param width width of horizontal constraint
 * @param offsetX the left offset of the horizontal constraint(default=0)
 */
public static function interpolateX(object:DisplayObject, tx:Float, width:Float, offsetX:Int=0):Void
{
    object.x=(width * tx)+ offsetX -(tx * object.width);
}


/**
 * Interpolate the DisplayObject at weight t==(0 less or equal t less or equal 1).  a position 1 would position the object to the right-most bounds, and tx=0 would position to the left
 *
 * @param DisplayObject DisplayObject to position
 * @param ty weight of verticle position from 0 to 1
 * @param height height of the verticle constraint
 * @offsetY the left offset of the horizontal constraint(default=0)
 */
public static function interpolateY(object:DisplayObject, ty:Float, height:Float, offsetY:Int=0):Void
{
    object.y=(height * ty)+ offsetY -(ty * object.height);
}



/**
 * Convenient vertical align method with optional alignment argument
 * @example<listing version="3.0">Alignment.vAlign([ clip0, clip1, clip2], 10);</listing>
 * @param items An array of items
 * @param spacingValues spacing The spacing between items in pixels as either a number or array or blank
 */
public static function verticalAlign(items:Array<Dynamic>, spacingValues:Array<Dynamic>):Void {
    if(spacingValues.length>0){
        if(Std.is(spacingValues[0], Array))
            verticalAlignSpaceArray(items, spacingValues[0]);
        if(Std.is(spacingValues[0], Float))
            verticalAlignSpaceNumber(items, spacingValues[0]);
    }
    else
        verticalAlignNoSpace(items);
}

/**
 * Aligns each item vertically to the one above it.
 * Uses no spacing.
 *
 * @example<listing version="3.0">Alignment.valignNoSpace([ clip0, clip1, clip2]);</listing>
 *
 * @param items An array of items
 */
public static function verticalAlignNoSpace(items:Array<Dynamic>):Void
{
    var n:Int=items.length;
    for(i in 1...n)
    {
        items[i].y=Std.int(items[(i - 1)].y + items[(i - 1)].height);
    }
}



/**
 * Aligns each item in the array to the one preceding it.
 * Uses the correlating position in the spacing arr for the spacing.
 * @example<listing version="3.0">Alignment.valignSpaceArr([ clip0, clip1, clip2], [ 0, 5, 30 ]);</listing>
 * @param items An array of items
 * @param spacing The array for spacing between items in pixels
 */
public static function verticalAlignSpaceArray(items:Array<Dynamic>, spacing:Array<Dynamic>):Void {
    var n:Int=items.length;
    for(i in 1...n){
        items[i].y=Std.int(items[(i - 1)].y + items[(i - 1)].height + spacing[i]);
    }
}


/**
 * Aligns the items in the array vertically to each the one preceding it in the array.
 * Uses the same spacing for all.
 *
 * @example<listing version="3.0">Alignment.valignSpaceNum([ clip0, clip1, clip2], 10);</listing>
 *
 * @param items An array of items
 * @param spacing The spacing between items in pixels
 */
public static function verticalAlignSpaceNumber(items:Array<Dynamic>, spacing:Float):Void
{
    var n:Int=items.length;
    for(i in 1...n)
    {
        if(Std.is(items[i - 1], TextField))
        {
            items[i].y=Std.int(items[(i - 1)].y + items[(i - 1)].textHeight + spacing);
        }
        else
        {
            items[i].y=Std.int(items[(i - 1)].y + items[(i - 1)].height + spacing);
        }
    }
}


/**
 * Horizontal center align object to target.
 * Alignment algorithm taken from:
 * http://chargedweb.com/labs/2010/07/27/alignutil_align_objects_easily/
 * Copyright 2010 Julius Loa | jloa@chargedweb.com
 * license:    MIT {http://www.opensource.org/licenses/mit-license.php}
 *
 * This algorith takes the objects rotation and scale Into account.
 */
public static function xAlignCenter(item:DisplayObject, target:DisplayObject):Void
{
    //item.x=Std.int(target.width / 2 - item.width / 2);

    var b:Rectangle=item.transform.pixelBounds;
    var bp:Point=target.globalToLocal(new Point(b.x, b.y));
    b.x=bp.x;b.y=bp.y;
    item.x=Std.int((target.width - b.width)/2 + item.x - b.x);
}


/**
 * Horizontal left align object to target.
 */
public static function xAlignLeft(item:DisplayObject, target:DisplayObject):Void
{
    item.x=Std.int(target.x);
}


/**
 * Horizontal right align object to target.
 */
public static function xAlignRight(item:DisplayObject, target:DisplayObject):Void
{
    item.x=Std.int(target.width - item.width);
}


/**
 * Vertical center align object to target.
 *
 * Alignment algorithm taken from:
 * http://chargedweb.com/labs/2010/07/27/alignutil_align_objects_easily/
 * Copyright 2010 Julius Loa | jloa@chargedweb.com
 * license:    MIT {http://www.opensource.org/licenses/mit-license.php}
 *
 * This algorith takes the objects rotation and scale Into account.
 */
public static function yAlignCenter(item:DisplayObject, target:DisplayObject):Void
{
    var b:Rectangle=item.transform.pixelBounds;
    var bp:Point=target.globalToLocal(new Point(b.x, b.y));
    b.x=bp.x;b.y=bp.y;
    item.y=Std.int((target.height - b.height)/2 + item.y - b.y);
}


/**
 * Vertical left  align object to target.
 */
public static function yAlignLeft(item:DisplayObject, target:DisplayObject):Void
{
    item.y=Std.int(target.y);
}


/**
 * Vertical right align object to target.
 */
public static function yAlignRight(item:DisplayObject, target:DisplayObject):Void
{
    item.y=Std.int(target.height - item.height);
}

}