//
//  ScoreCircularView.swift
//  DrummerBoy
//
//  Created by AndresBrun on 15/09/14.
//  Copyright (c) 2014 Brun's Software. All rights reserved.
//

import UIKit

@IBDesignable class ScoreCircularView: CircularPieProgressView {

    @IBInspectable var lowColor: UIColor = UIColor.grayColor() {
        didSet{
            setupView()
        }
    }
    
    @IBInspectable var middlelColor: UIColor = UIColor.darkGrayColor() {
        didSet{
            setupView()
        }
    }
    
    @IBInspectable var hiColor: UIColor = UIColor.blackColor() {
        didSet{
            setupView()
        }
    }
   
    @IBInspectable var completePie: Bool = false {
        didSet{
            updateTrackView()
        }
    }
    
    override func updateTrackView()
    {
        if (maskLayer == nil)
        {
            maskLayer = CAShapeLayer()
            trackView.layer.mask = maskLayer
        }
        
        var path = createPathWithProgress(getRoundProgress(currentProgress))
        maskLayer.path = path
    }
    
    private func getRoundProgress(progress: CGFloat) -> CGFloat
    {
        var roundProgress:CGFloat = 0.0
        if completePie
        {
            if progress > 0.66
            {
                roundProgress = 0.66
            } else if progress > 0.33
            {
                roundProgress = 0.33
            }
        } else
        {
            roundProgress = progress
        }
        
        return roundProgress
    }
    
    override func animateProgress (progress: CGFloat)
    {
        var path = createPathWithProgress(getRoundProgress(progress))
        
        var animation = CABasicAnimation()
        animation.keyPath = "path"
        animation.duration = 0.5
        animation.fromValue = maskLayer.path
        animation.toValue = path
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        self.maskLayer.path = path;
        
        maskLayer.addAnimation(animation, forKey: "path")
    }

    override func startAngleForProgress(progress: CGFloat) -> CGFloat {
        return startAngle
    }
    
    override func endAngleForProgress(progress: CGFloat) -> CGFloat {
        return getRelativeAngle(progress)
    }
    
    override func getPieAngles() -> NSArray
    {
        return [startAngle, getRelativeAngle(0.33), getRelativeAngle(0.66), endAngle]
    }
    
    override func getPieColors() -> NSArray
    {
        return [lowColor, middlelColor, hiColor]
    }
    
    override func getBgPieColors() -> NSArray
    {
        return [lowColor.colorWithAlphaComponent(0.2),
            middlelColor.colorWithAlphaComponent(0.2),
            hiColor.colorWithAlphaComponent(0.2)]
    }
}
