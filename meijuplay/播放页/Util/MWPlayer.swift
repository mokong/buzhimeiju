//
//  MWPlayer.swift
//  meijuplay
//
//  Created by Horizon on 4/1/2022.
//

import Foundation
import AVFoundation
import AVKit

class MWPlayer: NSObject {
    // MARK: - properties
    var progressCallback: ((Double) -> Void)?
    var hideLoadingViewCallback: ((Bool) -> Void)?
    
    fileprivate var player: AVPlayer?
    fileprivate var playerLayer: AVPlayerLayer?
    
    // MARK: - init
    static let shared = MWPlayer()
    
    private override init() {
        super.init()
        
        NotificationCenter.default.addObserver(self, selector: #selector(playerEndedPlaying), name: NSNotification.Name("AVPlayerItemDidPlayToEndTimeNotification"), object: nil)
    }

    
    func play(with urlStr: String?, in view: UIView) {
        guard let str = urlStr,
              let url = URL(string: str) else {
                  return
              }
        
        // Create AVPlayer Object
        let assert = AVAsset(url: url)
        let playerItem = AVPlayerItem(asset: assert)
        player = AVPlayer(playerItem: playerItem)
        
        guard let tempPlayer = player else {
            return
        }
        
        // Create AVPlayerLayer object
        playerLayer = AVPlayerLayer(player: tempPlayer)
        playerLayer?.frame = view.bounds
        playerLayer?.videoGravity = .resizeAspect
        
        // Play Video
        player?.play()
        
        player?.addPeriodicTimeObserver(forInterval: CMTime(seconds: 1, preferredTimescale: 2), queue: DispatchQueue.main, using: { [weak self] progressTime in
            if let duration = self?.player?.currentItem?.duration {
                let durationSeconds = CMTimeGetSeconds(duration)
                let seconds = CMTimeGetSeconds(progressTime)
                var progress = Double(seconds/durationSeconds)
                if progress > 1.0 {
                    progress = 0.0
                }
                self?.progressCallback?(progress)
            }
        })
        
        player?.addObserver(self, forKeyPath: "timeControlStatus", options: [.old, .new], context: nil)
    }
    
    // MARK: - utils
    
    public func playVideo() {
        player?.play()
    }
    
    public func pauseVideo() {
        player?.pause()
    }
    
    public func rewindVideo(by seconds: Float64) {
        if let currentTime = player?.currentTime() {
            var newTime = CMTimeGetSeconds(currentTime) - seconds
            if newTime <= 0 {
                newTime = 0
            }
            player?.seek(to: CMTime(value: CMTimeValue(newTime * 1000), timescale: 1000))
        }
    }
    
    public func forwardVideo(by seconds: Float64) {
        if let currentTime = player?.currentTime(),
           let duration = player?.currentItem?.duration {
            var newTime = CMTimeGetSeconds(currentTime) + seconds
            if newTime >= CMTimeGetSeconds(duration) {
                newTime = CMTimeGetSeconds(duration)
            }
            player?.seek(to: CMTime(value: CMTimeValue(newTime * 1000), timescale: 1000))
        }
    }
    
    // MARK: - action
    @objc func playerEndedPlaying(_ notification: Notification) {
        DispatchQueue.main.async { [weak self] in
            self?.player?.seek(to: CMTime.zero)
        }
    }
    
    // MARK: - other
    override public func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "timeControlStatus",
            let change = change,
           let newValue = change[NSKeyValueChangeKey.newKey] as? Int,
           let oldValue = change[NSKeyValueChangeKey.oldKey] as? Int {
            let oldStatus = AVPlayer.TimeControlStatus(rawValue: oldValue)
            let newStatus = AVPlayer.TimeControlStatus(rawValue: newValue)
            if newStatus != oldStatus {
                DispatchQueue.main.async { [weak self] in
                    if newStatus == .playing || newStatus == .paused {
                        self?.hideLoadingViewCallback?(true)
                    }
                    else {
                        self?.hideLoadingViewCallback?(false)
                    }
                }
            }
        }
    }

}
