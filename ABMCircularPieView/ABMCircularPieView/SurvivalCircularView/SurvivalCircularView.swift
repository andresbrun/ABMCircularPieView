//
//  SurvivalCircularView.swift
//  DrummerBoy
//
//  Created by AndresBrun on 13/09/14.
//  Copyright (c) 2014 Brun's Software. All rights reserved.
//

import UIKit

@IBDesignable class SurvivalCircularView: CircularPieProgressView {

    @IBInspectable var bgColorSafe: UIColor = UIColor.greenColor().colorWithAlphaComponent(0.5) {
        didSet{
            setupView()
        }
    }
    
    @IBInspectable var trackColorSafe: UIColor = UIColor.greenColor() {
        didSet{
            setupView()
        }
    }
    
    @IBInspectable var bgColorDanger: UIColor = UIColor.redColor().colorWithAlphaComponent(0.5) {
        didSet{
            setupView()
        }
    }
    
    @IBInspectable var trackColorDanger: UIColor = UIColor.redColor() {
        didSet{
            setupView()
        }
    }
    
    @IBInspectable var safeZone:CGFloat = 0.5 {
        didSet{
            setupView()
        }
    }
    
    override func getPieAngles() -> NSArray
    {
        return [startAngle, getRelativeAngle(safeZone), endAngle]
    }
    
    override func getPieColors() -> NSArray
    {
        return [trackColorDanger, trackColorSafe]
    }
    
    override func getBgPieColors() -> NSArray
    {
        return [bgColorDanger, bgColorSafe]
    }
    
    override func startAngleForProgress (progress: CGFloat) -> CGFloat
    {
        var minMaskAngle = min(getRelativeAngle(progress),getRelativeAngle(safeZone))
        var maxMaskAngle = max(getRelativeAngle(progress),getRelativeAngle(safeZone))
        
        return clockWise ? maxMaskAngle : minMaskAngle
    }
    
    override func endAngleForProgress (progress: CGFloat) -> CGFloat
    {
        var minMaskAngle = min(getRelativeAngle(progress),getRelativeAngle(safeZone))
        var maxMaskAngle = max(getRelativeAngle(progress),getRelativeAngle(safeZone))
        
        return clockWise ? minMaskAngle : maxMaskAngle
    }
    
    override func createPathWithProgress (progress: CGFloat) -> CGPath
    {
        var minMaskAngle = min(getRelativeAngle(progress),getRelativeAngle(safeZone))
        var maxMaskAngle = max(getRelativeAngle(progress),getRelativeAngle(safeZone))
        
         var path = CGPathCreateMutable()
         CGPathMoveToPoint(path, nil, CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds))
         CGPathAddArc(path,
             nil,
             CGRectGetMidX(self.bounds),
             CGRectGetMidY(self.bounds),
             CGRectGetMidX(self.bounds),
             clockWise ? maxMaskAngle : minMaskAngle,
             clockWise ? minMaskAngle : maxMaskAngle,
             clockWise)
         CGPathCloseSubpath(path)
        
         return path
    }

}
