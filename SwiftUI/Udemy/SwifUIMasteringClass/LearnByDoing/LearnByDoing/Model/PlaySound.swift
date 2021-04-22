//
//  PlaySound.swift
//  LearnByDoing
//
//  Created by 김광수 on 2021/04/22.
//

import Foundation
import AVFoundation


var audioPlayer: AVAudioPlayer?

func playSound(sound: String, type: String) {
    
    if let path = Bundle.main.path(forResource: sound, ofType: type) {
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer?.play()
        } catch {
            print("Cound not find and play the sound file")
        }
        
    }
}
