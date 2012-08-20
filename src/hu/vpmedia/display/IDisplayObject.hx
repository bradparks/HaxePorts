////////////////////////////////////////////////////////////////////////////////
//=BEGIN LICENSE MIT
//
// Copyright (c) 2012, Original author & contributors
// Original author: Matthew Tretter (matthew@exanimo.com)
// Contributors: Andras Csizmadia <andras@vpmedia.eu>
// 
// Permission is hereby granted, free of charge, to any person obtaining
// a copy of this software and associated documentation files(the
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
package hu.vpmedia.display;

import flash.accessibility.AccessibilityProperties;
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.LoaderInfo;
import flash.display.Stage;
import flash.events.IEventDispatcher;
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.geom.Transform;
/**
 *
 *  An interface that represents a DisplayObject.
 *
 *    IMPORTANT: This interface should NEVER appear in any API!! It only
 *    exists to be extended by other interfaces so that when you try to
 *    access (for example) ScrollPane.x, you won't get an error.
 *
 *     @langversion ActionScript 3
 *    @playerversion Flash 9.0.0
 *
 *    @author     Matthew Tretter (matthew@exanimo.com)
 *    @version    2008.01.17
 *
 */
interface IDisplayObject implements IEventDispatcher
{
//
// accessors
//
/**
 * @copy flash.display.DisplayObject#accessibilityProperties
 */
function get accessibilityProperties():AccessibilityProperties;
/**
 * @private
 */
function set accessibilityProperties(accessibilityProperties:AccessibilityProperties):Void;
/**
 * @copy flash.display.DisplayObject#alpha
 */
function get alpha():Float;
/**
 * @private
 */
function set alpha(alpha:Float):Void;
/**
 * @copy flash.display.DisplayObject#blendMode
 */
function get blendMode():String;
/**
 * @private
 */
function set blendMode(blendMode:String):Void;
/**
 * @copy flash.display.DisplayObject#cacheAsBitmap
 */
function get cacheAsBitmap():Bool;
/**
 * @private
 */
function set cacheAsBitmap(cacheAsBitmap:Bool):Void;
/**
 * @copy flash.display.DisplayObject#filters
 */
function get filters():Array;
/**
 * @private
 */
function set filters(filters:Array):Void;
/**
 * @copy flash.display.DisplayObject#height
 */
function get height():Float;
/**
 * @private
 */
function set height(height:Float):Void;
/**
 * @copy flash.display.DisplayObject#loaderInfo
 */
function get loaderInfo():LoaderInfo;
/**
 * @copy flash.display.DisplayObject#mask
 */
function get mask():DisplayObject;
/**
 * @private
 */
function set mask(mask:DisplayObject):Void;
/**
 * @copy flash.display.DisplayObject#mouseX
 */
function get mouseX():Float;
/**
 * @copy flash.display.DisplayObject#mouseY
 */
function get mouseY():Float;
/**
 * @copy flash.display.DisplayObject#name
 */
function get name():String;
/**
 * @private
 */
function set name(name:String):Void;
/**
 * @copy flash.display.DisplayObject#opaqueBackground
 */
function get opaqueBackground():Object;
/**
 * @private
 */
function set opaqueBackground(opaqueBackground:Object):Void;
/**
 * @copy flash.display.DisplayObject#parent
 */
function get parent():DisplayObjectContainer;
/**
 * @copy flash.display.DisplayObject#root
 */
function get root():DisplayObject;
/**
 * @copy flash.display.DisplayObject#rotation
 */
function get rotation():Float;
/**
 * @private
 */
function set rotation(rotation:Float):Void;
/**
 * @copy flash.display.DisplayObject#scale9Grid
 */
function get scale9Grid():Rectangle;
/**
 * @private
 */
function set scale9Grid(scale9Grid:Rectangle):Void;
/**
 * @copy flash.display.DisplayObject#scaleX
 */
function get scaleX():Float;
/**
 * @private
 */
function set scaleX(scaleX:Float):Void;
/**
 * @copy flash.display.DisplayObject#scaleY
 */
function get scaleY():Float;
/**
 * @private
 */
function set scaleY(scaleY:Float):Void;
/**
 * @copy flash.display.DisplayObject#scrollRect
 */
function get scrollRect():Rectangle;
/**
 * @private
 */
function set scrollRect(scrollRect:Rectangle):Void;
/**
 * @copy flash.display.DisplayObject#stage
 */
function get stage():Stage;
/**
 * @copy flash.display.DisplayObject#transform
 */
function get transform():Transform;
/**
 * @private
 */
function set transform(transform:Transform):Void;
/**
 * @copy flash.display.DisplayObject#visible
 */
function get visible():Bool;
/**
 * @private
 */
function set visible(visible:Bool):Void;
/**
 * @copy flash.display.DisplayObject#width
 */
function get width():Float;
/**
 * @private
 */
function set width(width:Float):Void;
/**
 * @copy flash.display.DisplayObject#x
 */
function get x():Float;
/**
 * @private
 */
function set x(x:Float):Void;
/**
 * @copy flash.display.DisplayObject#y
 */
function get y():Float;
/**
 * @private
 */
function set y(y:Float):Void;
//
// methods
//
/**
 * @copy flash.display.DisplayObject#getBounds()
 */
function getBounds(targetCoordinateSpace:DisplayObject):Rectangle;
/**
 * @copy flash.display.DisplayObject#getRect()
 */
function getRect(targetCoordinateSpace:DisplayObject):Rectangle;
/**
 * @copy flash.display.DisplayObject#globalToLocal()
 */
function globalToLocal(point:Point):Point;
/**
 * @copy flash.display.DisplayObject#hitTestObject()
 */
function hitTestObject(obj:DisplayObject):Bool;
/**
 * @copy flash.display.DisplayObject#hitTestPoint()
 */
function hitTestPoint(x:Float, y:Float, shapeFlag:Bool=false):Bool;
/**
 * @copy flash.display.DisplayObject#localToGlobal()
 */
function localToGlobal(point:Point):Point;
}