//
//  PlaySound.swift
//  RecordPlayer (iOS)
//
//  Created by 김광수 on 2022/03/30.
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
            print("Can not play")
        }
    }
        
}
