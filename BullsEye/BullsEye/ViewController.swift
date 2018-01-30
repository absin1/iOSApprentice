//
//  ViewController.swift
//  BullsEye
//
//  Created by absin on 1/29/18.
//  Copyright © 2018 absin.io. All rights reserved.
//

import UIKit
import QuartzCore

class ViewController: UIViewController {
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetValueLabel: UILabel!
    @IBOutlet weak var roundIdLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    var sliderValue: Int = 0
    var targetValue: Int = 50
    var roundId: Int = 1
    var score: Int = 0
    var point: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let thumbImageNormal = UIImage(named: "SliderThumb-Normal")
        slider.setThumbImage(thumbImageNormal, for: .normal)
        let thumbImageaHighlighted = #imageLiteral(resourceName: "SliderThumb-Highlighted")
        slider.setThumbImage(thumbImageaHighlighted, for: .highlighted)
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        let trackLeftImage = UIImage(named: "SliderTrackLeft")!
        let trackLeftResizable = trackLeftImage.resizableImage(withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
        let trackRightImage = UIImage(named: "SliderTrackRight")!
        let trackRightResizable = trackRightImage.resizableImage(withCapInsets: insets)
        slider.setMaximumTrackImage(trackRightResizable, for: .normal)
        
        sliderValue = lroundf(slider.value)
        runSingleRound()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func showAlert(_ sender: UIButton) {
        evaluateScore()
        var popupTitle = "Hello"
        switch point {
        case _ where point == 0:
            popupTitle = "Perfect!"
        case _ where point < 5:
            popupTitle = "You almost had it!"
        case _ where point < 10:
            popupTitle = "Pretty good!"
        default:
            popupTitle = "Not even close.."
        }
        let alert = UIAlertController(title: popupTitle, message: "You entered: \(sliderValue) against target \(targetValue) and scored \(100-abs(lroundf(slider.value)-targetValue)) points bringing your total to \(score) points", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: {action in self.runSingleRound()})
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func sliderMoved(_ sender: UISlider) {
        sliderValue = lroundf(sender.value)
        print("The value of the slider is \(sliderValue)")
    }
    
    @IBAction func restartGame(_ sender: UIButton) {
        restartGame() 
    }
    
    private func runSingleRound() {
        targetValue = 1 + Int(arc4random_uniform(100))
        targetValueLabel.text = String(targetValue)
        roundIdLabel.text = "\(roundId)"
        roundId+=1
        slider.value = 50.0
        scoreLabel.text="\(score)"
   }
    private func evaluateScore() {
        point = abs(lroundf(slider.value)-targetValue)
        score+=100-point
    }
    private func restartGame() {
        score = 0
        scoreLabel.text="\(score)"
        roundId = 1
        runSingleRound()
        let transition = CATransition()
        transition.type = kCATransitionFade
        transition.duration = 1
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        view.layer.add(transition, forKey: nil)
    }
}

