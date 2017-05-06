//
//  ViewController.swift
//  PomoDoMo
//
//  Created by Winston Lan on 5/4/17.
//  Copyright © 2017 winstonlan. All rights reserved.
//

import UIKit

class TimerViewController: UIViewController {
    
    var breakTime = false
    var minutesRemaining = 2
    var secondsRemaining = 0
    
    var timer = Timer()
    
    @IBOutlet weak var minutesLabel: UILabel!
    @IBOutlet weak var secondsLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var statusLabel: UILabel!
    
    
    @IBAction func startButton(_ sender: Any) {
        if !(timer.isValid) {
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(TimerViewController.action), userInfo: nil, repeats: true)
            startButton.setTitle("RESET", for: [])
        } else {
            startButton.setTitle("START", for: [])
            minutesRemaining = 2
            secondsRemaining = 0
            updateMinuteLabel()
            updateSecondsLabel()
            timer.invalidate()
        }
    }
    
    
    func action() {
        if minutesRemaining == 0 && secondsRemaining == 0 {
            if !breakTime {
                print("START BREAK")
                breakTime = true
                minutesRemaining = 1
                secondsRemaining = 0
                statusLabel.text = "BREAK"
                
            } else {
                print("START WORK")
                breakTime = false
                minutesRemaining = 2
                secondsRemaining = 0
                statusLabel.text = "WORK"
            }
            
            updateMinuteLabel()
            updateSecondsLabel()
            
        } else if secondsRemaining == 0 {
            minutesRemaining -= 1
            secondsRemaining = 59
            
            updateMinuteLabel()
            updateSecondsLabel()
            
        } else {
            secondsRemaining -= 1
            updateSecondsLabel()
        }
    }
    
    func updateMinuteLabel() {
        if minutesRemaining < 10 {
            minutesLabel.text = "0\(minutesRemaining)"
        } else {
            minutesLabel.text = "\(minutesRemaining)"
        }
    }
    
    func updateSecondsLabel() {
        if secondsRemaining < 10 {
            secondsLabel.text = "0\(secondsRemaining)"
        } else {
            secondsLabel.text = "\(secondsRemaining)"
        }
    }
}

