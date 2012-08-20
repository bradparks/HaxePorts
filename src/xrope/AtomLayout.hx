////////////////////////////////////////////////////////////////////////////////
//=BEGIN LICENSE MIT
//
// Copyright (c) 2012, Original author & contributors
// Original author : eidiot <http://eidiot.github.com/xrope/>
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
package xrope;
import flash.display.DisplayObject;
import flash.geom.Rectangle;

/**

     * Atom layout element for one DisplayObject.

     * @author eidiot

     */class AtomLayout implements ILayoutElement {
    public var x(getX, setX) : Float;
    public var y(getY, setY) : Float;
    public var width(getWidth, setWidth) : Float;
    public var height(getHeight, setHeight) : Float;
    public var useBounds(getUseBounds, setUseBounds) : Bool;
    public var target(getTarget, never) : DisplayObject;

    //======================================================================
        //  Constructor
        //======================================================================
        /**

         * Construct a <code>XAtomLayout</code>.

         * @param target        Target display object.

         * @param useBounds     If use <code>getBounds()</code> for layout.

         */    public function new(target : DisplayObject, useBounds : Bool = false) {
        _target = target;
        _useBounds = useBounds;
        if(useBounds)  {
            targetBounds = _target.getBounds(_target);
        }
    }

    //======================================================================
        //  Variables
        //======================================================================
        var targetBounds : Rectangle;
    //======================================================================
        //  Properties: IXLayoutElement
        //======================================================================
        //------------------------------
        //  x
        //------------------------------
        /** @inheritDoc */    public function getX() : Float {
        return (_useBounds) ? getXUseBounds() : _target.x;
    }

    public function setX(value : Float) : Float {
        if(_useBounds)  {
            setXUseBounds(value);
        }

        else  {
            _target.x = value;
        }

        return value;
    }

    //------------------------------
        //  y
        //------------------------------
        /** @inheritDoc */    public function getY() : Float {
        return (_useBounds) ? getYUseBounds() : _target.y;
    }

    /** @private */    public function setY(value : Float) : Float {
        if(_useBounds)  {
            setYUseBounds(value);
        }

        else  {
            _target.y = value;
        }

        return value;
    }

    //------------------------------
        //  width
        //------------------------------
        /** @inheritDoc */    public function getWidth() : Float {
        return _target.width;
    }

    /** @private */    public function setWidth(value : Float) : Float {
        _target.width = width;
        return value;
    }

    //------------------------------
        //  height
        //------------------------------
        /** @inheritDoc */    public function getHeight() : Float {
        return _target.height;
    }

    /** @private */    public function setHeight(value : Float) : Float {
        _target.height = height;
        return value;
    }

    //------------------------------
        //  useBounds
        //------------------------------
        var _useBounds : Bool;
    /** @inheritDoc */    public function getUseBounds() : Bool {
        return _useBounds;
    }

    /** @private */    public function setUseBounds(value : Bool) : Bool {
        if(value == _useBounds)  {
            return _useBounds;
        }
        if(value && targetBounds == null)  {
            targetBounds = _target.getBounds(_target);
        }
        var currentX : Float = x;
        var currentY : Float = y;
        _useBounds = value;
        x = currentX;
        y = currentY;
        return value;
    }

    //======================================================================
        //  Properties
        //======================================================================
        //------------------------------
        //  target
        //------------------------------
        var _target : DisplayObject;
    /**

         * Target of the atom layout.

         */    public function getTarget() : DisplayObject {
        return _target;
    }

    //======================================================================
        //  Private methods
        //======================================================================
        function getXUseBounds() : Float {
        return _target.x + targetBounds.x * Math.abs(_target.scaleX);
    }

    function setXUseBounds(value : Float) : Void {
        _target.x = value - targetBounds.x * Math.abs(_target.scaleX);
    }

    function getYUseBounds() : Float {
        return _target.y + targetBounds.y * Math.abs(_target.scaleY);
    }

    function setYUseBounds(value : Float) : Void {
        _target.y = value - targetBounds.y * Math.abs(_target.scaleY);
    }

}

