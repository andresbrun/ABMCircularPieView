//
//  CircularPieProgressView.swift
//  DrummerBoy
//
//  Created by AndresBrun on 12/09/14.
//  Copyright (c) 2014 Brun's Software. All rights reserved.
//

import UIKit
import QuartzCore

@IBDesignable class CircularPieProgressView: UIView {
    
    
    @IBInspectable var bgColor: UIColor = UIColor.whiteColor() {
        didSet{
            setupView()
        }
    }
    
    @IBInspectable var trackColor: UIColor = UIColor.blackColor() {
        didSet{
            setupView()
        }
    }
    
    @IBInspectable var clockWise: Bool = false {
        didSet{
            setupView()
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 20.0 {
        didSet{
            setupView()
        }
    }
    
    @IBInspectable var startAngle: CGFloat = 0 {
        didSet{
            setupView()
        }
    }
    
    @IBInspectable var endAngle: CGFloat = 3.14 {
        didSet{
            setupView()
        }
    }
    
    @IBInspectable var currentProgress: CGFloat = 0.5 {
        didSet{
            currentProgress = min(max(currentProgress, 0), 1)
            updateTrackView()
        }
    }

    var trackView: UIView!
    var maskLayer: CAShapeLayer!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.setupView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    override func drawRect(rect: CGRect) {
        
        super.drawRect(rect)
        
        var clockWiseInt:Int32 = clockWise ? 0 : 1
        var context = UIGraphicsGetCurrentContext();
        var d = rect.size.width - borderWidth;
        
        var pies = getPieAngles().count-2
        for i in 0...pies {
            
            CGContextAddArc(context,
                rect.size.width/2,
                rect.size.height/2,
                d/2,
                (getPieAngles()[i] as CGFloat),
                (getPieAngles()[i+1] as CGFloat),
                clockWiseInt);
            CGContextSetStrokeColorWithColor(context, (getBgPieColors()[i] as UIColor).CGColor);
            CGContextSetLineWidth(context, borderWidth);
            CGContextStrokePath(context);
        }
    }

    func startAngleForProgress (progress: CGFloat) -> CGFloat
    {
        return startAngle
    }
    
    func endAngleForProgress (progress: CGFloat) -> CGFloat
    {
        return getRelativeAngle(progress)
    }
    
    func setupView(){
        
        if (trackView != nil)
        {
            for view in trackView.subviews
            {
                view.removeFromSuperview()
            }
        } else
        {
            trackView = UIView(frame: self.bounds)
        }
        
        var pies = getPieAngles().count-2
        for i in 0...pies {
            
            var pieView = CircularPieView(frame: self.bounds)
            pieView.bgColor = (getPieColors()[i] as UIColor)
            pieView.startAngle = (getPieAngles()[i] as CGFloat)
            pieView.endAngle = (getPieAngles()[i+1] as CGFloat)
            pieView.borderWidth = borderWidth
            pieView.clockWise = clockWise
            pieView.setNeedsDisplay()
            
            trackView.addSubview(pieView)
        }
        
        self.addSubview(trackView)
        
        self.updateTrackView()
    }
    
    func updateTrackView()
    {
        if (maskLayer == nil)
        {
            maskLayer = CAShapeLayer()
            trackView.layer.mask = maskLayer
        }
        
        maskLayer.path = createPathWithProgress(currentProgress);
    }
    
    func createPathWithProgress (progress: CGFloat) -> CGPath
    {
        var path = CGPathCreateMutable()
        CGPathMoveToPoint(path, nil, CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
        CGPathAddArc(path,
            nil,
            CGRectGetMidX(self.bounds),
            CGRectGetMidY(self.bounds),
            CGRectGetMidX(self.bounds),
            startAngleForProgress(progress),
            endAngleForProgress(progress),
            !clockWise)
        CGPathCloseSubpath(path);
        
        return path
    }
    
    func animateProgress (progress: CGFloat)
    {
        var path = createPathWithProgress(progress)
        
        var animation = CABasicAnimation()
        animation.keyPath = "path"
        animation.duration = 0.5
        animation.fromValue = maskLayer.path
        animation.toValue = path
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        self.maskLayer.path = path;
        
        maskLayer.addAnimation(animation, forKey: "path")
    }
    
    func getRelativeAngle (progress: CGFloat) -> CGFloat
    {
        var rangeDegress = endAngle - startAngle
        
        if rangeDegress > 0 && !clockWise
        {
            rangeDegress = CGFloat(2 * M_PI) - rangeDegress
        }
        
        if rangeDegress < 0 && clockWise
        {
            rangeDegress = CGFloat(2 * M_PI) + rangeDegress
        }
        
        var endTrackAngle = startAngle + (clockWise ? 1 : -1) * fabs(rangeDegress) * progress
        
        return endTrackAngle
    }
    
    func getPieAngles() -> NSArray
    {
        return [startAngle, endAngle]
    }
    
    func getPieColors() -> NSArray
    {
        return [trackColor]
    }
    
    func getBgPieColors() -> NSArray
    {
        return [bgColor]
    }
    
}