//
//  ViewController.swift
//  Clock_M4
//
//  Created by Elif Dede on 2/5/24.
//

import UIKit


class ViewController: UIViewController {
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var countdownLabel: UILabel!
    @IBOutlet weak var startStopButton: UIButton!
    
    var clockTimer: Timer?
    var countdownTimer: Timer?
    var remainingTime: TimeInterval = 0
    var timer: Timer?
    var targetTime: Date?
 
    override func viewDidLoad() {
        super.viewDidLoad()

        setImageView()
      
        startClock()
       
        datePicker.datePickerMode = .countDownTimer
 
        countdownLabel.text = "00:00:00"
        
       
        
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)

        setImageView()
    }
  
    
    func setImageView() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "a"
        let currentTime = Date()
        let timeString = dateFormatter.string(from: currentTime)
        
        if timeString == "AM" {
            backgroundImageView.image = UIImage(named: "dayImage")
        } else {
            backgroundImageView.image = UIImage(named: "nightImage")
        }
    }
    
    func startClock() {
        clockTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateClock), userInfo: nil, repeats: true)
    }
    
    @objc func updateClock() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE, dd MMM yyyy HH:mm:ss"
        let currentTime = Date()
        let timeString = dateFormatter.string(from: currentTime)
        timeLabel.text = timeString
    }
    
   
 
        
        
      
    @IBAction func startStopButtonAction(_ sender: UIButton) {
            if timer == nil {
                startTimer()
            } else {
                stopTimer()
                resetTimer()
            }
        }
   
    
    func startTimer() {
        targetTime = datePicker.countDownDuration > 0 ? Date().addingTimeInterval(datePicker.countDownDuration) : nil
            
        if let targetTime = targetTime {
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] timer in
                let timeRemaining = max(targetTime.timeIntervalSinceNow, 0)
                let hours = Int(timeRemaining) / 3600
                let minutes = (Int(timeRemaining) % 3600) / 60
                let seconds = Int(timeRemaining) % 60
                    
                self?.countdownLabel.text = String(format: "%02d:%02d:%02d", hours, minutes, seconds)
                if timeRemaining <= 0 {
                        self?.stopTimer()
                        self?.startStopButton.setTitle("Start Timer", for: .normal)
                    }
                }
                
                startStopButton.setTitle("Stop Timer", for: .normal)
            }
        }
        
        func stopTimer() {
            timer?.invalidate()
            timer = nil
        }
        
        func resetTimer() {
            datePicker.countDownDuration = 0
            countdownLabel.text = "00:00:00"
            startStopButton.setTitle("Start Timer", for: .normal)
        }
}




