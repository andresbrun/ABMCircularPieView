//
//  ViewController.swift
//  ABMCircularPieView
//
//  Created by AndresBrun on 19/09/14.
//  Copyright (c) 2014 Brun's Software. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var circularView: CircularPieProgressView!
    @IBOutlet weak var survivalPieView: SurvivalCircularView!
    @IBOutlet weak var scoresPieView: ScoreCircularView!
    
    @IBOutlet weak var animatorSlider: UISlider!
    
    @IBAction func interactorSlider(sender: UISlider) {
        circularView.currentProgress = CGFloat(sender.value)
        survivalPieView.currentProgress = CGFloat(sender.value)
        scoresPieView.currentProgress = CGFloat(sender.value)
        
    }
    
    @IBAction func animateViews(sender: AnyObject) {
        circularView.animateProgress(CGFloat(animatorSlider.value))
        survivalPieView.animateProgress(CGFloat(animatorSlider.value))
        scoresPieView.animateProgress(CGFloat(animatorSlider.value))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

