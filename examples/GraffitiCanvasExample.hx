////////////////////////////////////////////////////////////////////////////////
//=BEGIN LICENSE MIT
//
// Copyright (c) 2012, Original author & contributors
// Original author : www.nocircleno.com/graffiti/
// Contributors: Andras Csizmadia <andras@vpmedia.eu>
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
package;   

import flash.display.Sprite; 
import flash.Lib;

import com.nocircleno.graffiti.GraffitiCanvas;    
import com.nocircleno.graffiti.tools.BitmapTool;     
import com.nocircleno.graffiti.tools.BrushTool;       
import com.nocircleno.graffiti.tools.BrushType;  
import com.nocircleno.graffiti.tools.FillBucketTool;     
import com.nocircleno.graffiti.tools.LineTool;       
import com.nocircleno.graffiti.tools.LineType;      
import com.nocircleno.graffiti.tools.ShapeTool;          
import com.nocircleno.graffiti.tools.ShapeType; 
import com.nocircleno.graffiti.tools.TextTool;     
import com.nocircleno.graffiti.tools.LineTool;      
import com.nocircleno.graffiti.tools.ToolRenderType;     

class GraffitiCanvasExample extends Sprite {

  var canvas:GraffitiCanvas;
  
    public function new()  
  {
    super();
    Lib.current.addChild(this);  
    
    var canvas:GraffitiCanvas = new GraffitiCanvas(400, 400, 10);
    addChild(canvas);
    var angledBrush:BrushTool = new BrushTool(8, 0xFF0000, 1, 0, BrushType.BACKWARD_LINE);
    canvas.activeTool = angledBrush;    
    } 

}