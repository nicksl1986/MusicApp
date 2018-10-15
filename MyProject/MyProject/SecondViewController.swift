//
//  SecondViewController.swift
//  MyProject
//
//  Created by Nick Slobodsky on 03/10/2018.
//  Copyright © 2018 Nick Slobodsky. All rights reserved.
//

import UIKit
import AVFoundation

class SecondViewController: UIViewController, AVAudioPlayerDelegate {
    
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var myImageView: UIImageView!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var slider: UISlider!
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
       if songSelected == true
       {
          label.text = songs[currentTrackIndex]
        
          myImageView.loadGif(name: "music")
        
          timerRunning()
        
          slider.maximumValue = Float(Int(audioPlayer.duration))
       }
        else
       {
            myImageView.loadGif(name: "music")
        
            currentTrackIndex = 0
        
            previousTrackIndex = songs.count - 1
        
            nextSong()
       }
    
    }
    
    func nextSong()
    {
        let audioPath = Bundle.main.path(forResource: songs[currentTrackIndex], ofType: ".mp3")
       
        do
        {
            try audioPlayer = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: audioPath!) as URL)
        }
        catch
        {
            fatalError()
        }
        
        audioPlayer.play()
        
        slider.maximumValue = Float(audioPlayer.duration)
        
        label.text = songs[currentTrackIndex]
        
        timerRunning()
      
    }
   
    func timeString(totalTime : Int) -> String
    {
        let minutes = (totalTime / 60) % 60
        
        let seconds = totalTime % 60
        
        return String(format: "%02d : %02d", minutes, seconds)
    }
    
    @IBAction func play(_ sender: UIButton) {
        
        audioPlayer.play()
        
        startTimer()
    }
    
    func startTimer()
    {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerRunning), userInfo: nil, repeats: true)
    }
    
    
    @IBAction func pause(_ sender: UIButton) {
        
        timer.invalidate()
        
        audioPlayer.pause()
        
    }
    
    
    @IBAction func previous(_ sender: UIButton) {
        
       timer.invalidate()
        
       slider.value = 0
        
       currentTrackIndex = previousTrackIndex
        
       previousTrackIndex -= 1
        
       if previousTrackIndex < 0
       {
            previousTrackIndex = songs.count - 1
       }
        
        nextSong()
        
    }
    
    
    @IBAction func next(_ sender: UIButton) {
        
        timer.invalidate()
        
        previousTrackIndex = currentTrackIndex
        
        currentTrackIndex += 1
        
        if currentTrackIndex > songs.count - 1
        {
            
            currentTrackIndex = 0
        }
        
        nextSong()
    }
    
    
    @IBAction func slider(_ sender: UISlider) {
        
        audioPlayer.currentTime = TimeInterval(slider.value)
    }
    
    
    @objc func timerRunning()
    {
        if audioPlayer.isPlaying == true
        {
            currentTime = Int(audioPlayer.currentTime)
            
            slider.value = Float(currentTime)
            
            timeLabel.text = timeString(totalTime: currentTime)
        }
        else
        {
            timer.invalidate()
            
            timeLabel.text = timeString(totalTime: 0)
            
            slider.value = 0
            
            previousTrackIndex = currentTrackIndex
            
            currentTrackIndex += 1
            
            if currentTrackIndex > songs.count - 1
            {
                currentTrackIndex = 0
            }
            
            nextSong()
        }
       
    }
    
    

}




