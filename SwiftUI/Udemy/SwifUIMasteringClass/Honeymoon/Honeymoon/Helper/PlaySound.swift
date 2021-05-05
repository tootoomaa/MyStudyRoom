//
//  PlaySound.swift
//  Honeymoon
//
//  Created by 김광수 on 2021/05/05.
//

import AVFoundation

var audioPlayer: AVAudioPlayer?

func playSound(sound: String, type: String) {
    if let path = Bundle.main.path(forResource: sound, ofType: type) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer?.play()
            
        } catch {
            print("Error: Cannot found and play the sound file!")
        }
    }
}
