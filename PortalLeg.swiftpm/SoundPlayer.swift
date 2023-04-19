import Foundation
import AVKit

class SoundPlayer {
    static let shared = SoundPlayer()
    
    private init() { }
    
    private var player: AVAudioPlayer? = nil
    
    func playSound(named: String, withExtension: String) -> Bool {
        
        if player?.isPlaying ?? false {
            return false
        }
        if let url = Bundle.main.url(forResource: named, withExtension: withExtension) {
            do {
                player = try AVAudioPlayer(contentsOf: url)
            } catch {
                print(error)
            }
        } else {
            print("[SoundPlayer::playSound] Cannot find a file named \(named)\(withExtension)")
        }
        player?.play()
        return true
    }
    func stop() {
        player?.stop()
    }
}
