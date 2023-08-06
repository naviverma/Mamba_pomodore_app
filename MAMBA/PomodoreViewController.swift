//
//  PomodoreViewController.swift
//  MAMBA
//
//  Created by Navdeep on 21/07/2023.
//

import UIKit
import AVFoundation

class PomodoreViewController: UIViewController {

    @IBOutlet var resetButton: UIButton!
    @IBOutlet var startButton: UIButton!
    @IBOutlet var restOrWorkMode: UISwitch!
    @IBOutlet var timerLabel: UILabel!
    @IBOutlet var timeProgress: UIProgressView!
    var audioPlayer:AVAudioPlayer?
    var timer:Timer? = nil
    var timeranimation:Timer? = nil
    var timeremaining:Int = 0
    var isWorkMode:Bool = true
    var stop:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Dont waste time"
        self.timerLabel.text = "120:00"
        self.timeremaining = 60 * 60 * 2
        self.timeProgress.progress = 0
        self.blackAndWhite()
        
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        blackAndWhite()
    }
    
    func blackAndWhite(){
        
        if #available(iOS 12.0, *) {
            if traitCollection.userInterfaceStyle == .dark {
                startButton.tintColor = UIColor.white
                resetButton.tintColor = UIColor.white
                timeProgress.tintColor = UIColor.white
                restOrWorkMode.onTintColor = UIColor.white
                restOrWorkMode.backgroundColor = UIColor.black
                restOrWorkMode.thumbTintColor = UIColor.black
                
            } else {
                startButton.tintColor = UIColor.black
                resetButton.tintColor = UIColor.black
                timeProgress.tintColor = UIColor.black
                restOrWorkMode.onTintColor = UIColor.black
                restOrWorkMode.backgroundColor = UIColor.white
                restOrWorkMode.thumbTintColor = UIColor.white
            }
        } else {
            let alert = UIAlertController(title: "ERROR", message: "Your phone doesnt support this app for dark mode. Change dark mode to light mode to use this app", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "ok", style: .default,handler:{
                action in
                self.navigationController?.popViewController(animated: true)
            }))
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        timer?.invalidate()
        self.timeProgress.progress = 0
        timeranimation?.invalidate()
    }
    
    
    @IBAction func reset(_ sender: Any) {
        timer?.invalidate()
        audioPlayer?.stop()
        if isWorkMode{
            self.timeremaining = 60 * 60 * 2
            self.timerLabel.text = timeString(from: self.timeremaining)
            animationReverse()
        }
        else{
            self.timeremaining = 60 * 10
            self.timerLabel.text = timeString(from: self.timeremaining)
            animationReverse()
        }
    }
    @IBAction func startTimer(_ sender: Any) {
        if timeremaining == 0 {
            //do nothing
        }
        else{
            timer?.invalidate()
            self.timeProgress.progress = 0
            animationForward()
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block:{ _ in
                self.timeremaining = self.timeremaining - 1
                DispatchQueue.main.async {
                    self.timerLabel.text = self.timeString(from: self.timeremaining)
                    if self.isWorkMode{
                        let progressUpdating = Float(self.timeremaining) / Float(60*60)
                        self.timeProgress.progress = Float(progressUpdating)
                    }
                    else{
                        let progressUpdating = Float(self.timeremaining) / Float(60*10)
                        self.timeProgress.progress = Float(progressUpdating)
                    }
                    if self.timeremaining == 0 {
                        self.playSound()
                        self.timer?.invalidate()
                        self.timeProgress.progress = 0
                        
                    }
                }
            })
        }
        }
        
    @IBAction func restOrWorkMode(_ sender: Any) {
        timer?.invalidate()
        isWorkMode = !isWorkMode
        if isWorkMode{
            self.timerLabel.text = "120:00"
            self.timeremaining = 60 * 60 * 2 //60 minutes
            animationReverse()
            
        }
        else{
            self.timerLabel.text = "10:00"
            self.timeremaining = 60 * 10//10 minutes
            animationReverse()
        }
    }
    
    func playSound(){
        guard let url = Bundle.main.url(forResource: "alarm", withExtension: "mp3")
        else{
            return
        }
        do{
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        }
        catch{
            print("Error")
        }
    }
    
    func animationForward(){
        timeranimation?.invalidate()
        timeranimation = Timer.scheduledTimer(withTimeInterval: 0.01,repeats: true, block:{_ in
            let progressCalculated = 0.01
            DispatchQueue.main.async {
                self.timeProgress.progress = self.timeProgress.progress + Float(progressCalculated)
                if self.timeProgress.progress == 1{
                    self.timeranimation?.invalidate()
                }
            }
            
        })
    }
    func animationReverse(){
        timeranimation?.invalidate()
        timeranimation = Timer.scheduledTimer(withTimeInterval: 0.01,repeats: true, block:{_ in
            let progressCalculated = 0.01
            DispatchQueue.main.async {
                self.timeProgress.progress = self.timeProgress.progress - Float(progressCalculated)
                if self.timeProgress.progress == 0{
                    self.timeranimation?.invalidate()
                }
            }
            
        })
    }
    func timeString(from totalSeconds:Int)->String {
        let minutes = totalSeconds / 60
        let seconds = totalSeconds % 60
        return String(format: "%02d:%02d",minutes,seconds)
    }
}
