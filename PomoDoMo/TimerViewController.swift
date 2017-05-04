//
//  ViewController.swift
//  PomoDoMo
//
//  Created by Winston Lan on 5/4/17.
//  Copyright © 2017 winstonlan. All rights reserved.
//

import UIKit

class TimerViewController: UIViewController {
    
    var minutesRemaining = 25
    var secondsRemaining = 0
    
    var timer = Timer()
    
    @IBOutlet weak var minutesLabel: UILabel!
    @IBOutlet weak var secondsLabel: UILabel!
    
    @IBAction func startButton(_ sender: Any) {
        if !(timer.isValid) {
//            minutesLabel.text = "\(minutesRemaining)"
//            secondsLabel.text = "\(secondsRemaining)"
            
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(TimerViewController.action), userInfo: nil, repeats: true)
        }
    }
    
    @IBAction func stopButton(_ sender: Any) {
        timer.invalidate()
    }
    
    func action() {
        if minutesRemaining == 0 && secondsRemaining == 0 {
            print("DONE")
            timer.invalidate()
        } else if secondsRemaining == 0 {
            minutesRemaining -= 1
            secondsRemaining = 60
            
            if minutesRemaining < 10 {
                minutesLabel.text = "0\(minutesRemaining)"
            } else {
                 minutesLabel.text = "\(minutesRemaining)"
            }
            
            secondsLabel.text = "00"
        } else {
            secondsRemaining -= 1
            
            if secondsRemaining < 10 {
                secondsLabel.text = "0\(secondsRemaining)"
            } else {
                secondsLabel.text = "\(secondsRemaining)"
            }
        }
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

