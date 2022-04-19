//
//  Utils.swift
//  FakeCall
//
//  Created by admin on 5/10/20.
//  Copyright © 2020 com.tah. All rights reserved.
//

import Foundation
import AVFoundation

class SoundUtils {
    static let TAG = "SoundUtils"
    
    static func playAudio(url: String, volume: Float) -> AVAudioPlayer?{
        var audioPlayer: AVAudioPlayer?
        let url = Bundle.main.path(forResource: url, ofType: "mp3")
        if url != nil {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: url!))
                if let audio = audioPlayer {
                    audio.prepareToPlay()
                    audio.numberOfLoops = -1
                    audio.play()
                    audio.volume = volume
                    return audio
                }
            } catch {
                print("\(TAG) play audioPlayer error: \(error)" )
            }
        } else {
            print("\(TAG) url is nil ")
        }
        return nil
    }
    
    static func playAudio(audioPlayer: AVAudioPlayer?) {
        if let audio = audioPlayer {
            let result = audio.play()
            print("\(TAG) playing audio: \(result)")
        }
    }
    
    static func stopAudio(audioPlayer: AVAudioPlayer?) {
        if let audio = audioPlayer, audio.isPlaying {
            audio.stop()
            print("\(TAG) stopped audio ")
        }
    }
}
