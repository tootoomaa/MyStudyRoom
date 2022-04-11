//
//  PlaySound.swift
//  Lift Elevator
//
//  Created by 김광수 on 2022/04/05.
//

import Foundation
import AVFoundation

var audioPlayer: AVAudioPlayer?

func playSound(sound: String, type: String) {
    if let path = Bundle.main.path(forResource: sound, ofType: type) {
        do {
            let url = URL(fileURLWithPath: path)
            try audioPlayer = AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        } catch {
            print("Play Sound Error")
        }
    }
}
