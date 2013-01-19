////////////////////////////////////////////////////////////////////////////////
//=BEGIN MIT LICENSE
//
// The MIT License
// 
// Copyright (c) 2012-2013 Andras Csizmadia
// http://www.vpmedia.eu
// 
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
// 
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//
//=END MIT LICENSE
////////////////////////////////////////////////////////////////////////////////
package;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Loader;  
import flash.display.LoaderInfo;
import flash.display.Sprite;
import flash.events.Event;  
import flash.events.IOErrorEvent;
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.net.URLRequest;

import nme.Assets;
 
import org.bytearray.display.ScaleBitmap;

class ScaleBitmapExample extends Sprite {
    private var url:String;

    public function new()
    {
        url="bitmap.png";  
        super();               
        flash.Lib.current.addChild(this);
        configureAssets();
    }

    private function configureAssets():Void 
    {
        var loader:Loader=new Loader();
        var info:LoaderInfo = loader.contentLoaderInfo;
        info.addEventListener(Event.COMPLETE, completeHandler);
        info.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);

        var request:URLRequest=new URLRequest(url);
        loader.load(request);
        addChild(loader);
    }

    private function completeHandler(event:Event):Void 
    {          
        var loader:Loader=cast(event.target.loader,Loader);
            
        var image:Bitmap=cast(loader.content,Bitmap); 
        
        var bitmapData:BitmapData=image.bitmapData;
        initBitmapData(bitmapData);        
    }
    
    private function ioErrorHandler(event:IOErrorEvent):Void
    {
        trace("Unable to load image:" + url);
        
        var image:BitmapData = Assets.getBitmapData("images/bitmap.png"); 
        initBitmapData(image);
    }
    
    private function initBitmapData(bitmapData:BitmapData):Void
    {
        var b:ScaleBitmap = new ScaleBitmap(bitmapData.clone());
        addChild(b);
        b.x = b.y = 200;
        b.bitmapScale9Grid = new Rectangle(20, 20, 80, 80);
        b.bitmapWidth = 400;
        b.bitmapHeight = 200;
    }
}