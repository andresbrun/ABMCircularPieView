//
//  CircularPieView.swift
//  DrummerBoy
//
//  Created by AndresBrun on 14/09/14.
//  Copyright (c) 2014 Brun's Software. All rights reserved.
//

import UIKit

class CircularPieView: UIView {
    
    var bgColor: UIColor = UIColor.blackColor()
    var borderWidth: CGFloat = 10.0
    var startAngle: CGFloat = 0
    var endAngle: CGFloat = 0
    var clockWise: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.clearColor()
    }
    
    override func drawRect(rect: CGRect) {
        
        super.drawRect(rect)
        
        var clockWiseInt:Int32 = clockWise ? 0 : 1
        var context = UIGraphicsGetCurrentContext();
        var d = rect.size.width - borderWidth;
        
        CGContextAddArc(context, rect.size.width/2,rect.size.height/2, d/2, startAngle, endAngle, clockWiseInt);
        CGContextSetStrokeColorWithColor(context, bgColor.CGColor);
        CGContextSetLineWidth(context, borderWidth);
        CGContextStrokePath(context);
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
