//
//  AudioManager.swift
//  Slowerr
//
//  Created by Brandon LeBlanc on 11/27/23.
//

import Foundation
import AVKit

final class Audio: ObservableObject{
    
    let file = "Instrumental"
    
    @Published var player: AVAudioPlayer?
    @Published private var totalTime: TimeInterval = 0.0
    @Published private var currentTime: TimeInterval = 0.0
    @Published var enableRate: Bool = true
    
    @Published private(set) var isPlaying: Bool = false {
        
        didSet {
            print("Is playing", isPlaying)
        }
    }
    
//     {
//            didSet {
//                if let player = player {
//                    player.enableRate = enableRate
//                    print("Enable Rate set to: \(enableRate)")
//                }
//            }
//        }

        @Published var playbackSpeed: Float = 1.0 {
            didSet {
                if let player = player {
                    player.rate = enableRate ? max(0.5, min(playbackSpeed, 2.0)) : 1.0
                    print("Rate set to: \(player.rate)")
                }
            }
        }
    
    func startPlayer(track: String, isPreview: Bool = false) {
        guard let url = Bundle.main.url(forResource: track, withExtension: "mp3") else {
            print("Couldnt find: \(track)")
            return
        }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            player = try AVAudioPlayer(contentsOf: url)
            
            player?.rate = playbackSpeed
            
            if isPreview {
                player?.prepareToPlay()
            } else {
                player?.play()
                isPlaying = true
            }
        } catch {
            print("Couldnt initialize", error)
        }
    }
    
    func play(){
        player?.play()
        isPlaying = true
    }
    
    func pause() {
        player?.pause()
        isPlaying = false
    }
    
    func update() {
        guard let player = player else { return }
        currentTime = player.currentTime
    }
    
    func seek(to time: TimeInterval) {
        player?.currentTime = time
    }
    
    func timeString(time: TimeInterval) -> String {
        let minute = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d", minute, seconds)
    }
    
}
