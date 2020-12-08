//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

var player: AVAudioPlayer?

func playSound() {
    guard let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3") else { return }

    do {
        try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
        try AVAudioSession.sharedInstance().setActive(true)

        
        player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)

    

        guard let player = player else { return }

        player.play()

    } catch let error {
        print(error.localizedDescription)
    }
}

class ViewController: UIViewController {
    
    @IBOutlet weak var progressbar: UIProgressView!
    
    let eggTimes = ["Soft": 300, "Medium": 420, "Hard": 720] //dictionary for all egg times
    var timer = Timer() //set the Swift Timer to a local Variable
    
    @IBOutlet weak var titleLabel: UILabel!
    
    var totaltime =  0
    var secondspast = 0
    
    
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        
        
        timer.invalidate() //invalidate the timer to get the 1 second
        
        
        let hardness = sender.currentTitle! //set hardness for which the user selected
        
        totaltime = eggTimes[hardness]! //set the total time which the user selected
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    
       
        
    }
    
    
    @objc func updateTimer() {
        if secondspast <= totaltime { //if the timer is less than the total hardness
            
            
            progressbar.progress = Float(secondspast)/Float(totaltime) //set the progress bar in percent
         
            
            secondspast += 1
        }else{
            timer.invalidate() //Stop Timer
            titleLabel.text = "DONE"
            playSound()
        }
    }
    
    
}
