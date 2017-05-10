//
//  ViewController.swift
//  PomoDoMo
//
//  Created by Winston Lan on 5/4/17.
//  Copyright © 2017 winstonlan. All rights reserved.
//

import UIKit

class TimerViewController: UIViewController {
    
    var timer = Timer()
    var pomo = Pomodoro()
    
    @IBOutlet weak var minutesLabel: UILabel!
    @IBOutlet weak var secondsLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var pomoCountLabel: UILabel!
    
    
    @IBAction func startButton(_ sender: Any) {
        if !(timer.isValid) {
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(TimerViewController.action), userInfo: nil, repeats: true)
            startButton.setTitle("RESET", for: [])
        } else {
            startButton.setTitle("START", for: [])
            pomo.minutesRemaining = pomo.workTime
            pomo.secondsRemaining = 0
            
            timer.invalidate()
            pomo.isWorking = false
            
            updateMinuteLabel()
            updateSecondsLabel()
        }
    }
    
    
    func action() {
        if pomo.minutesRemaining == 0 && pomo.secondsRemaining == 0 {
            if pomo.isWorking {
                let newPomoCount = UserDefaults.standard.integer(forKey: "pomoCount") + 1
                UserDefaults.standard.set(newPomoCount, forKey:"pomoCount")
                pomo.isWorking = false
                
                if newPomoCount % 3 == 0 {
                    pomo.minutesRemaining = 15
                } else {
                    pomo.minutesRemaining = pomo.breakTime
                }
                
                pomo.secondsRemaining = 0
                statusLabel.text = "BREAK"
                pomoCountLabel.text = "\(UserDefaults.standard.integer(forKey: "pomoCount"))"
            } else {
                pomo.isWorking = true
                pomo.minutesRemaining = pomo.workTime
                pomo.secondsRemaining = 0
                statusLabel.text = "WORK"
            }
            
            updateMinuteLabel()
            updateSecondsLabel()
            
        } else if pomo.secondsRemaining == 0 {
            pomo.minutesRemaining -= 1
            pomo.secondsRemaining = 59
            
            updateMinuteLabel()
            updateSecondsLabel()
            
        } else {
            pomo.secondsRemaining -= 1
            updateSecondsLabel()
        }
    }
    
    func updateMinuteLabel() {
        if pomo.minutesRemaining < 10 {
            minutesLabel.text = "0\(pomo.minutesRemaining)"
        } else {
            minutesLabel.text = "\(pomo.minutesRemaining)"
        }
    }
    
    func updateSecondsLabel() {
        if pomo.secondsRemaining < 10 {
            secondsLabel.text = "0\(pomo.secondsRemaining)"
        } else {
            secondsLabel.text = "\(pomo.secondsRemaining)"
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let date = Date()
        let calendar = Calendar.current
        let newDate = calendar.startOfDay(for: date)
        if date == newDate {
            UserDefaults.standard.set(0, forKey: "pomoCount")
        }
        pomoCountLabel.text = "\(UserDefaults.standard.integer(forKey: "pomoCount"))"
    }
    
}

