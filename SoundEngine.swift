//
//  SoundEngine.swift
//  MaestroLevel
//
//  Created by Fredrik Colldén on 2015-11-28.
//  Copyright © 2015 Marie. All rights reserved.
//

import UIKit
import AVFoundation


class SoundEngine {
    
    let qualityOfServiceClass = Int(QOS_CLASS_BACKGROUND.rawValue)
    
    init() {
        
    }
    
    func addSound(name: String) -> AVAudioPlayer {
        print(name)
        let path = NSBundle.mainBundle().pathForResource(name, ofType: "caf")
        let url = NSURL.fileURLWithPath(path!)
        var audioPlayer:AVAudioPlayer
        do {
            try audioPlayer = AVAudioPlayer(contentsOfURL: url)
            //audioPlayer.enableRate = true
            audioPlayer.prepareToPlay()
        } catch {
            audioPlayer = AVAudioPlayer()
            print("Player not available")
        }
        return audioPlayer
    }
    
    func playSound (sound: AVAudioPlayer, length: CGFloat) {
        if (sound.playing) {
            sound.pause()
            sound.currentTime = 0
        }
        
        sound.play()
    }
    
}
