//
//  FirstViewController.swift
//  MyProject
//
//  Created by Nick Slobodsky on 03/10/2018.
//  Copyright © 2018 Nick Slobodsky. All rights reserved.
//

import UIKit
import AVFoundation

var songs : [String] = []

var audioPlayer = AVAudioPlayer()

var songSelected = false

var timer = Timer()

var currentTime = 0

var songLength = 0

var minutes = 0

var seconds = 0

var currentTrackIndex = 0

var previousTrackIndex = 0

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var myTableView: UITableView!
    

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
         gettingSongName()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return songs.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        do
        {
            let audioPath = Bundle.main.path(forResource: songs[indexPath.row], ofType: ".mp3")
            
            try audioPlayer = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: audioPath!) as URL)
            
            audioPlayer.play()
            
            currentTrackIndex = indexPath.row
            
            previousTrackIndex -= 1
            
            if previousTrackIndex < 0
            {
                previousTrackIndex = songs.count - 1
            }
            
           songSelected = true
            
        }
        catch
        {
            fatalError()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        
        cell.textLabel?.text = songs[indexPath.row]
        
        return cell
    }
    
    func gettingSongName()
    {
        let folderURL = URL(fileURLWithPath: Bundle.main.resourcePath!)
        
        do
        {
            let songPath = try FileManager.default.contentsOfDirectory(at: folderURL, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
            
            for song in songPath
            {
                var mySong = song.absoluteString
                
                if mySong.contains(".mp3")
                {
                    let findString = mySong.components(separatedBy: "/")
                    
                    mySong = findString[findString.count - 1]
                    
                    mySong = mySong.replacingOccurrences(of: "%20", with: " ")
                    
                    mySong = mySong.replacingOccurrences(of: ".mp3", with: "")
                    
                    songs.append(mySong)
                    
                }
            }
            
            myTableView.reloadData()
        }
        catch
        {
            fatalError()
        }


}

}

