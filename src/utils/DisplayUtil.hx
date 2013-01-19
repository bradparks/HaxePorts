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
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.geom.Rectangle;
import flash.geom.Matrix;
import flash.geom.Point;

class DisplayUtil
{

/**
 * Allows you to add a child without first checking that the child or parent exist.
 * Allows you to add a child at an index higher than the number of children without error.
 * Allows you to use the same function for addChild and addChildAt.
 * 
 * @param child The child DisplayObject to add.
 * @param parent The container to add the child to.
 * @param atIndex The index to add the child at. Default is to add to the top(-1)
 * @return Bool True if the child was added, false if something prevented it from being added.
 * 
 * @author Mims Wright 
 */
public static function addChild(child:DisplayObject, parent:DisplayObjectContainer, atIndex:Int=-1):Bool
{
    if(child && parent){
        if(atIndex<0 || atIndex>parent.numChildren){
            atIndex=parent.numChildren;
        }
        parent.addChildAt(child, atIndex);
        return true;
    }
    return false;
}


/**
 *   Apply a scroll rect from(0,0)to(width,height)
 *   @param dispObj Display object to apply on
 *   @author Jackson Dunstan
 */
public static function applyNaturalScrollRect(dispObj:DisplayObject):Void
{
    dispObj.scrollRect=new Rectangle(0, 0, dispObj.width, dispObj.height);
}



/**
 * Brings the DisplayObject forward in the display list. The<code>steps</code>parameter can be used to jump more than one level.
 * @param object the DisplayObject to reorder
 * @param steps the number of levels bring the DisplayObject forward
 * @return the new index of the DisplayObject
 */
public static function bringForward(object:DisplayObject, steps:Int=1):Int
{
    if(!object.parent)
        return -1;

    var index:Int=object.parent.getChildIndex(object)+ steps;
    index=clamp(index, 0, object.parent.numChildren - 1);

    object.parent.setChildIndex(object, index);

    return index;
}



/**
 * Brings the DisplayObject to the front of the display list. The<code>back</code>parameter can be used to pull the DisplayObject back a few levels from the front.
 * @param object the DisplayObject to reorder
 * @param back the number of levels from the front of the display list
 * @return the new index of the DisplayObject
 */
public static function bringToFront(object:DisplayObject, back:Int=0):Int
{
    if(!object.parent)
        return -1;

    var index:Int=object.parent.numChildren -(back + 1);
    index=clamp(index, 0, object.parent.numChildren - 1);

    object.parent.setChildIndex(object, index);

    return index;
}


/**
 * Returns a Bitmap instance of the supplied DisplayObject.
 */
public static function createBitmap(source:DisplayObject, useSmoothing:Bool=true):Bitmap
{
    var bitmapData:BitmapData=new BitmapData(source.width, source.height, true, 0xffffff);
    bitmapData.draw(source);

    var bitmap:Bitmap=new Bitmap(bitmapData);
    bitmap.smoothing=useSmoothing;

    return bitmap;
}


/**
 * Creates a thumbnail of a BitmapData. The thumbnail can be any size as
 * the copied image will be scaled proportionally and cropped if necessary
 * to fit Into the thumbnail area. If the image needs to be cropped in order
 * to fit the thumbnail area, the alignment of the crop can be specified
 *
 * @param image
 *
 * The source image for which a thumbnail should be created. The source
 * will not be modified
 *
 * @param width
 *
 * The width of the thumbnail
 *
 * @param height
 *
 * The height of the thumbnail
 *
 * @param align
 *
 * If the thumbnail has a different aspect ratio to the source image, although
 * the image will be scaled to fit along one axis it will be necessary to crop
 * the image. Use this parameter to specify how the copied and scaled image should
 * be aligned within the thumbnail boundaries. Use a constant from the Alignment
 * enumeration clazz
 *
 * @param smooth
 *
 * Whether to apply bitmap smoothing to the thumbnail
 */

public static function createThumb(image:BitmapData, width:Int, height:Int, align:String="C", smooth:Bool=true):Bitmap
{
    var source:Bitmap=new Bitmap(image);
    var thumbnail:BitmapData=new BitmapData(width, height, false, 0x0);

    thumbnail.draw(image, fitIntoRect(source, thumbnail.rect, true, align, false), null, null, null, smooth);
    source=null;

    return new Bitmap(thumbnail, PixelSnapping.AUTO, smooth);
}


/**
 * Crop the BitmapData source and return a new BitmapData.
 * @param source Source BitmapData
 * @param dest Crop area as Rectangle
 * @return Cropped source as BitmapData
 * @author Vaclav Vancura(http://vancura.org, http://twitter.com/vancura)
 */
public static function cropBitmapData(source:BitmapData, dest:Rectangle):BitmapData {
    var o:BitmapData=new BitmapData(dest.width, dest.height);
    var point:Point=new Point(0, 0);

    o.copyPixels(source, dest, point);

    return o;
}



/**
 * duplicateDisplayObject
 * creates a duplicate of the DisplayObject passed.
 * similar to duplicateMovieClip in AVM1. If using Flash 9, make sure
 * you export for ActionScript the symbol you are duplicating
 *
 * @param source the display object to duplicate
 * @param autoAdd if true, adds the duplicate to the display list
 * in which source was located
 * @return a duplicate instance of source
 *
 * @author Trevor McCauley - www.senocular.com
 * @author cleaned up by Mims Wright
 */
public static function duplicateDisplayObject(source:DisplayObject, autoAdd:Bool=false):DisplayObject {
    var sourceClass:Class=Class(Object(source).constructor);
    var duplicate:DisplayObject=cast(Type.createInstance(sourceClass), DisplayObject);

    // duplicate properties
    duplicate.transform=source.transform;
    duplicate.filters=source.filters;
    duplicate.cacheAsBitmap=source.cacheAsBitmap;
    duplicate.opaqueBackground=source.opaqueBackground;
    if(source.scale9Grid){
        var rect:Rectangle=source.scale9Grid;

        // version check for scale9Grid bug
        if(Capabilities.version.split(" ")[1]=="9,0,16,0"){
            // Flash 9 bug where returned scale9Grid as twips
            rect.x /= 20;
            rect.y /= 20;
            rect.width /= 20;
            rect.height /= 20;
        }

        duplicate.scale9Grid=rect;
    }

    // todo:needs test
    if("graphics" in source){
        var graphics:Graphics=Graphics(source["graphics"]);
        Graphics(duplicate["graphics"]).copyFrom(graphics);
    }

    // add to target parent's display list
    // if autoAdd was provided as true
    if(autoAdd && source.parent){
        source.parent.addChild(duplicate);
    }
    return duplicate;
}


public static function filterChildrenByProps(container:DisplayObjectContainer, props:Dynamic):Array<Dynamic>
{
    var filteredChildren:Array<Dynamic>=[];
    var child:DisplayObject;

    for(i in 0...container.numChildren)
    {
        child=container.getChildAt(i);
        var isOK:Bool=true;
        for(prop in props)
        {
            if(child[prop] !=props[prop])
            {
                isOK=false;
                break;
            }
        }
        if(isOK)
            filteredChildren.push(child);
    }
    return filteredChildren;
}


/**
 * Fits a DisplayObject Into a rectangular area with several options for scale
 * and alignment. This method will return the Matrix required to duplicate the
 * transformation and can optionally apply this matrix to the DisplayObject.
 *
 * @param displayObject
 *
 * The DisplayObject that needs to be fitted Into the Rectangle.
 *
 * @param rectangle
 *
 * A Rectangle object representing the space which the DisplayObject should fit Into.
 *
 * @param fillRect
 *
 * Whether the DisplayObject should fill the entire Rectangle or just fit within it.
 * If true, the DisplayObject will be cropped if its aspect ratio differs to that of
 * the target Rectangle.
 *
 * @param align
 *
 * The alignment of the DisplayObject within the target Rectangle. Use a constant from
 * the DisplayUtils clazz.
 *
 * @param applyTransform
 *
 * Whether to apply the generated transformation matrix to the DisplayObject. By setting this
 * to false you can leave the DisplayObject as it is but store the returned Matrix for to use
 * either with a DisplayObject's transform property or with, for example, BitmapData.draw()
 */

public static function fitIntoRect(displayObject:DisplayObject, rectangle:Rectangle, fillRect:Bool=true, align:String="C", applyTransform:Bool=true):Matrix
{
    var matrix:Matrix=new Matrix();

    var wD:Float=displayObject.width / displayObject.scaleX;
    var hD:Float=displayObject.height / displayObject.scaleY;

    var wR:Float=rectangle.width;
    var hR:Float=rectangle.height;

    var sX:Float=wR / wD;
    var sY:Float=hR / hD;

    var rD:Float=wD / hD;
    var rR:Float=wR / hR;

    var sH:Float=fillRect ? sY:sX;
    var sV:Float=fillRect ? sX:sY;

    var s:Float=rD>=rR ? sH:sV;
    var w:Float=wD * s;
    var h:Float=hD * s;

    var tX:Float=0.0;
    var tY:Float=0.0;

    switch(align)
    {
        case Alignment.LEFT:
        case Alignment.TOP_LEFT:
        case Alignment.BOTTOM_LEFT:
            tX=0.0;
            break;

        case Alignment.RIGHT:
        case Alignment.TOP_RIGHT:
        case Alignment.BOTTOM_RIGHT:
            tX=w - wR;
            break;

        default:
            tX=0.5 *(w - wR);
    }

    switch(align)
    {
        case Alignment.TOP:
        case Alignment.TOP_LEFT:
        case Alignment.TOP_RIGHT:
            tY=0.0;
            break;

        case Alignment.BOTTOM:
        case Alignment.BOTTOM_LEFT:
        case Alignment.BOTTOM_RIGHT:
            tY=h - hR;
            break;

        default:
            tY=0.5 *(h - hR);
    }

    matrix.scale(s, s);
    matrix.translate(rectangle.left - tX, rectangle.top - tY);

    if(applyTransform)
    {
        displayObject.transform.matrix=matrix;
    }

    return matrix;
}


/**
 *   Get the children of a container as an array
 *   @param container Container to get the children of
 *   @return The children of the given container as an array
 *   @author Jackson Dunstan
 */
public static function getChildren(container:DisplayObjectContainer):Array<Dynamic>
{
    var ret:Array<Dynamic>=[];

    var numChildren:Int=container.numChildren;
    for(i in 0...numChildreni)
    {
        ret.push(container.getChildAt(i));
    }

    return ret;
}


/**
 * Determines the full bounds of the display object regardless of masking elements.
 * @param    displayObject    The display object to analyze.
 * @return    the display object dimensions.
 */
public static function getFullBounds(displayObject:DisplayObject):Rectangle
{
    var bounds:Rectangle, transform:Transform, toGlobalMatrix:Matrix, currentMatrix:Matrix;

    transform=displayObject.transform;
    currentMatrix=transform.matrix;
    toGlobalMatrix=transform.concatenatedMatrix;
    toGlobalMatrix.invert();
    transform.matrix=toGlobalMatrix;

    bounds=transform.pixelBounds.clone();

    transform.matrix=currentMatrix;

    return bounds;
}


/**
 *   Get the parents of a display object as an array
 *   @param obj Dynamic whose parents should be retrieved
 *   @param includeSelf If obj should be included in the returned array
 *   @param stopAt Display object to stop getting parents at. Passing
 *                 null indicates that all parents should be included.
 *   @return An array of the parents of the given display object. This
 *           includes all parents unless stopAt is non-null. If stopAt is
 *           non-null, it and its parents will not be included in the
 *           returned array.
 *   @author Jackson Dunstan
 */
public static function getParents(obj:DisplayObject, includeSelf:Bool=true, stopAt:DisplayObject=null):Array<Dynamic>
{
    var ret:Array<Dynamic>=[];

    var cur:DisplayObject = includeSelf ? obj:obj.parent;    
    while (cur !=stopAt && cur !=null)
    {
        ret.push(cur);
        cur = cur.parent;
    }

    return ret;
}


/**
 *   Check if a display object is visible. This checks all of its
 *   parents' visibilities.
 *   @param obj Display object to check
 *   @author Jackson Dunstan
 */
public static function isVisible(obj:DisplayObject):Bool
{
    var cur:DisplayObject = obj;
    while(cur !=null)
    {
        if(!cur.visible)
        {
            return false;
        }
        cur = cur.parent;
    }
    return true;
}


/**
 * Translate<code>DisplayObject</code>container position in a new container.
 */
public static function localToLocal(from:DisplayObject, to:DisplayObject):Point
{
    var point:Point=new Point();
    point=from.localToGlobal(point);
    point=to.globalToLocal(point);
    return point;
}


public static function originalHeight(obj:DisplayObject):Float
{
    return obj.height / obj.scaleY;
}


public static function originalWidth(obj:DisplayObject):Float
{
    return obj.width / obj.scaleX;
}


public static function relativePos(dO1:DisplayObject, dO2:DisplayObject):Point
{
    var pos:Point=new Point(0, 0);
    pos=dO1.localToGlobal(pos);
    pos=dO2.globalToLocal(pos);
    return pos;
}


/**
 *   Remove all children from a container and leave the bottom few
 *   @param container Container to remove from
 *   @param leave(optional)Number of bottom children to leave
 *   @author Jackson Dunstan
 */
public static function removeAllChildren(container:DisplayObjectContainer, leave:Int=0):Void
{
    while(container.numChildren>leave)
    {
        container.removeChildAt(leave);
    }
}


/**
 *  Remove all children of a specific type from a container.
 * 
 * @example<listing version="3.0">
 * var s:Sprite=new Sprite();
 * s.addChild(new Shape());
 * s.addChild(new Shape());
 * s.addChild(new MovieClip());
 * s.addChild(new Sprite());
 * trace(s.numChildren);// 4
 * removeAllChildrenByType(s, Shape);
 * trace(s.numChildren);// 2
 *</listing>
 *   
 *     @param container Container to remove from
 *  @param the type of children to remove
 *  @author John Lindquist
 */
public static function removeAllChildrenByType(container:DisplayObjectContainer, type:Class<Dynamic>):Void
{
    for(child in container)
    {
        if(Std.is(child, type))
        {
            container.removeChild(child);
        }
    }
}


/**
 * Removes a child from the parent without throwing errors if the child or parent is null
 * or if the child isn't a child of the specified parent.
 * 
 * @param child The child DisplayObject to remove.
 * @param parent The parent to remove the child from. If none is specified, the function
 *                  attempts to get the parent from the child's<code>parent</code>property.
 * @returns Bool True if the child was removed from the parent. False if something prevented it.
 * 
 * @author Mims Wright
 */
public static function removeChild(child:DisplayObject, parent:DisplayObjectContainer=null):Bool
{
    if(child){
        if(!parent){
            if(!child.parent){ // if parent and child.parent are null
                return false;
            }
            parent=child.parent;
        }
        if(parent==child.parent){
            parent.removeChild(child);
            return true;
        }
    }
    return false;
}


/**
 * Removes the child at the index specified in a container and returns it.
 * Automatically handles cases that could potentially throw errors such as the index
 * being out of bounds or the parent being null.
 * 
 * @param parent The container to remove the child from.
 * @param index The index to remove. If left blank or if out of bounds, defaults to the top child.
 * @return DisplayObject The child that was removed.
 * 
 * @author Mims Wright
 */
public static function removeChildAt(parent:DisplayObjectContainer, index:Int=-1):DisplayObject
{
    if(parent && parent.numChildren>0){
        if(index<0 || index>parent.numChildren){ index=parent.numChildren;}
        var child:DisplayObject=parent.removeChildAt(index);
    }
    return null;
}


/**
 * Wait for a next frame.
 * Prevents high CPU state, when AVM doesn't send ENTER_FRAMES. It just simply waits until it gets one.
 * @param callback Function to call once when next frame is displayed
 * @author Vaclav Vancura(http://vancura.org, http://twitter.com/vancura)
 */
public static function scheduleForNextFrame(cb:Void->Void):Void {
    var obj:Shape=new Shape();

    obj.addEventListener(Event.ENTER_FRAME, function(ev:Event):Void {
        obj.removeEventListener(Event.ENTER_FRAME, arguments.callee);
        cb();
    });
}




/**
 * Sends the DisplayObject back in the display list. The<code>steps</code>parameter can be used to jump more than one level.
 * @param object the DisplayObject to reorder
 * @param steps the number of levels send the DisplayObject backward
 * @return the new index of the DisplayObject
 */
public static function sendBackward(object:DisplayObject, steps:Int=1):Int
{
    if(!object.parent)
        return -1;

    var index:Int=object.parent.getChildIndex(object)- steps;
    index=clamp(index, 0, object.parent.numChildren - 1);

    object.parent.setChildIndex(object, index);

    return index;
}




/**
 * Sends the DisplayObject to the back of the display list. The<code>forward</code>parameter can be used to bring the DisplayObject forward a few levels from the back.
 * @param object the DisplayObject to reorder
 * @param forward the number of levels from the back of the display list
 * @return the new index of the DisplayObject
 */
public static function sendToBack(object:DisplayObject, forward:Int=0):Int
{
    if(!object.parent)
        return -1;

    var index:Int=clamp(forward, 0, object.parent.numChildren - 1);

    object.parent.setChildIndex(object, index);

    return index;
}


public static function setProperties(children:Array<Dynamic>, props:Dynamic):Void
{
    var child:DisplayObject;
    for(i in 0...children.length)
    {
        child=children[i];
        for(prop in props)
        {
            child[prop]=props[prop];
        }
    }
}/**
 * Created by ${PRODUCT_NAME}.
 * User:jlindqui
 * Date:3/9/11
 * Time:10:21 AM
 * To change this template use File | Settings | File Templates.
 */



/**
 * 
 * @param displayObjectContainer - the DisplayObjectContainer that you want to see all the children of
 * This is useful for visual debugging of hidden objects.
 */
public static function showChildren(displayObjectContainer:DisplayObjectContainer):Void
{
    var i:Int=0;
    while(i<displayObjectContainer.numChildren)
    {
        var childAt:DisplayObject=displayObjectContainer.getChildAt(i);
        childAt.visible=true;
        if(Std.is(childAt, DisplayObjectContainer))
        {
            showChildren(DisplayObjectContainer(childAt));
        }
        i++;
    }
}


/**
 * Stops all timelines of the specified display object and its children.
 * @param    displayObject    The display object to loop through.
 */
public static function stopAllTimelines(displayObject:DisplayObjectContainer):Void
{
    var numChildren:Int=displayObject.numChildren;

    for(i in 0...numChildren)
    {
        var child:DisplayObject=displayObject.getChildAt(i);

        if(Std.is(child, DisplayObjectContainer))
        {
            if(Std.is(child, MovieClip))
            {
                MovieClip(child).stop();
            }

        stopAllTimelines(cast(child, DisplayObjectContainer));
        }
    }
}

public static function sumProps(children:Array<Dynamic>, prop:String):Float
{
    var sum:Float=0;
    for(i in 0...children.length)
    {
        sum +=children[i][prop];
    }
    return sum;
}


/**
 * trace()children of the DisplayObjectContainer.
 * @param container DisplayObjectContainer to get children of
 * @param indentLevel Indentation level(default 0)
 * @author Vaclav Vancura(http://vancura.org, http://twitter.com/vancura)
 */
public static function traceChildren(container:DisplayObjectContainer, indentLevel:Int=0):Void {
    for(i in 0...container.numChildren){
        var thisChild:DisplayObject=container.getChildAt(i);
        var output:String="";

        for(j in 0...indentLevel){ 
            output +="   ";
        }

        output +="+  " + thisChild.name + "=" + Std.string(thisChild);

        trace(output);

        if(Std.is(thisChild, DisplayObjectContainer)){ 
            traceChildren(DisplayObjectContainer(thisChild), indentLevel + 1);
        }
    }
}


/**
 *   Wait a given number of frames then call a callback
 *   @param numFrames Float of frames to wait before calling the callback
 *   @param callback Function to call once the given number of frames have passed
 *   @author Jackson Dunstan
 */
public static function wait(numFrames:Int, cb:Void->Void):Void
{
    var obj:Shape=new Shape();
    obj.addEventListener(
        Event.ENTER_FRAME,
        function(ev:Event):Void
        {
            numFrames--;
            if(numFrames==0)
            {
                obj.removeEventListener(Event.ENTER_FRAME, arguments.callee);
                cb();
            }
        }
        );
}

}