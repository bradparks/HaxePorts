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
import flash.errors.IllegalOperationError;

/**

     * Tile layout is wapper of a AtomLayout with align and size control.

     * @author eidiot

     */class TileLayout implements ILayoutElement {
    public var x(getX, setX) : Float;
    public var y(getY, setY) : Float;
    public var width(getWidth, setWidth) : Float;
    public var height(getHeight, setHeight) : Float;
    public var useBounds(getUseBounds, setUseBounds) : Bool;
    public var atom(getAtom, never) : AtomLayout;
    public var align(getAlign, setAlign) : String;

    //======================================================================
        //  Constructor
        //======================================================================
        /**

         * Construct a <code>TileLayout</code>.

         * @param targetOrAtom    A <code>DisplayObject</code> or <code>AtomLayout</code>.

         * @param width           <code>width</code> value of the layout element.

         * @param height          <code>height</code> value of the layout element.

         * @param align           Align of the tile.

         * @param useBounds       If use <code>getBounds()</code> for atom.

         * @param x               <code>x</code> value of the layout element.

         * @param y               <code>y</code> value of the layout element.

         */    public function new(targetOrAtom : Dynamic, width : Float, height : Float, align : String = "TL", useBounds : Bool = false, x : Float = 0, y : Float = 0) {
        atomX = 0;
        atomY = 0;
        _x = 0;
        _y = 0;
        _width = 0;
        _height = 0;
        _align = "TL";
        if(Std.is(targetOrAtom, AtomLayout))  {
            _atom = targetOrAtom;
        }

        else if(Std.is(targetOrAtom, DisplayObject))  {
            _atom = new AtomLayout(targetOrAtom, useBounds);
        }

        else  {
            throw new IllegalOperationError("Only DisplayObject or Atom is accepted");
        }

        _width = width;
        _height = height;
        _x = x;
        _y = y;
        _align = align;
        layout();
    }

    //======================================================================
        //  Variables
        //======================================================================
        var atomX : Float;
    var atomY : Float;
    //======================================================================
        //  Properties: ILaoutElement
        //======================================================================
        //------------------------------
        //  x
        //------------------------------
        var _x : Float;
    /** @inheritDoc */    public function getX() : Float {
        return _x;
    }

    /** @private */    public function setX(value : Float) : Float {
        if(value != _x)  {
            _x = value;
            _atom.x = _x + atomX;
        }
        return value;
    }

    //------------------------------
        //  y
        //------------------------------
        var _y : Float;
    /** @inheritDoc */    public function getY() : Float {
        return _y;
    }

    /** @private */    public function setY(value : Float) : Float {
        if(value != _y)  {
            _y = value;
            _atom.y = _y + atomY;
        }
        return value;
    }

    //------------------------------
        //  width
        //------------------------------
        var _width : Float;
    /** @inheritDoc */    public function getWidth() : Float {
        return _width;
    }

    /** @private */    public function setWidth(value : Float) : Float {
        if(value != _width)  {
            _width = value;
            layout();
        }
        return value;
    }

    //------------------------------
        //  height
        //------------------------------
        var _height : Float;
    /** @inheritDoc */    public function getHeight() : Float {
        return _height;
    }

    /** @private */    public function setHeight(value : Float) : Float {
        if(value != _height)  {
            _height = value;
            layout();
        }
        return value;
    }

    //------------------------------
        //  useBounds
        //------------------------------
        /** @inheritDoc */    public function getUseBounds() : Bool {
        return _atom.useBounds;
    }

    /** @private */    public function setUseBounds(value : Bool) : Bool {
        _atom.useBounds = value;
        return value;
    }

    //======================================================================
        //  Properties
        //======================================================================
        //------------------------------
        //  atom
        //------------------------------
        var _atom : AtomLayout;
    /**

         * Atom in the tile.

         */    public function getAtom() : AtomLayout {
        return _atom;
    }

    //------------------------------
        //  align
        //------------------------------
        var _align : String;
    /**

         * Align of the atom in the tile.

         */    public function getAlign() : String {
        return _align;
    }

    /** @private */    public function setAlign(value : String) : String {
        if(value != _align)  {
            _align = value;
            layout();
        }
        return value;
    }

    //======================================================================
        //  Private methods
        //======================================================================
        function layout() : Void {
        switch(_align) {
        case LayoutAlign.TOP:
            atomX = centerX();
            atomY = topY();
        case LayoutAlign.TOP_RIGHT:
            atomX = rightX();
            atomY = topY();
        case LayoutAlign.RIGHT:
            atomX = rightX();
            atomY = centerY();
        case LayoutAlign.BOTTOM_RIGHT:
            atomX = rightX();
            atomY = bottomY();
        case LayoutAlign.BOTTOM:
            atomX = centerX();
            atomY = bottomY();
        case LayoutAlign.BOTTOM_LEFT:
            atomX = leftX();
            atomY = bottomY();
        case LayoutAlign.LEFT:
            atomX = leftX();
            atomY = centerY();
        case LayoutAlign.CENTER:
            atomX = centerX();
            atomY = centerY();
        case LayoutAlign.TOP_LEFT:
            atomX = leftX();
            atomY = topY();
        default:
            atomX = leftX();
            atomY = topY();
        }
        _atom.x = _x + atomX;
        _atom.y = _y + atomY;
    }

    function leftX() : Float {
        return 0;
    }

    function centerX() : Float {
        return (_width - _atom.width) / 2;
    }

    function rightX() : Float {
        return _width - _atom.width;
    }

    function topY() : Float {
        return 0;
    }

    function centerY() : Float {
        return (_height - _atom.height) / 2;
    }

    function bottomY() : Float {
        return _height - _atom.height;
    }

}

