//
//  MWPlayerUtil.swift
//  meijuplay
//
//  Created by Horizon on 16/12/2021.
//

import Foundation
import EZPlayer
import CoreMedia

class MWPlayerUtil {
    // MARK: - properties
    var playerEndCallback: ((TimeInterval?) -> Void)?
    
    var player: EZPlayer?
    var mediaItem: MeiJuMediaItem?
    var embeddedContentView: UIView?
    var currentTime: Double = 0.0
    
    static let sharedInstance = MWPlayerUtil()
    
    // MARK: - init
    private init() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.applicationWillEnterForeground(_:)), name: UIApplication.willEnterForegroundNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.applicationDidBecomeActive(_:)), name: UIApplication.didBecomeActiveNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.applicationWillResignActive(_:)), name: UIApplication.willResignActiveNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.applicationDidEnterBackground(_:)), name: UIApplication.didEnterBackgroundNotification, object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(playerDidPlayToEnd(_:)),
                                               name: .EZPlayerPlaybackDidFinish,
                                               object: nil)
    }
    
    // MARK: - utils
    
    func playEmbeddedVideo(url: URL, embeddedContentView contentView: UIView? = nil, userInfo: [AnyHashable: Any]? = nil) {
        var mediaItem = MeiJuMediaItem()
        mediaItem.url = url
        playEmbeddedVideo(mediaItem: mediaItem, embeddedContentView: contentView, userInfo: userInfo)
    }
    
    func playEmbeddedVideo(mediaItem: MeiJuMediaItem, embeddedContentView contentView: UIView? = nil, userInfo: [AnyHashable: Any]? = nil) {
        // stop
        releasePlayer()
        
        if let skinView = userInfo?["skin"] as? UIView {
            player = EZPlayer(controlView: skinView)
        }
        else {
            player = EZPlayer()
        }

        if let autoPlay = userInfo?["autoPlay"] as? Bool {
            player?.autoPlay = autoPlay
        }

        if let floatMode = userInfo?["floatMode"] as? EZPlayerFloatMode {
            player?.floatMode = floatMode
        }

        if let fullScreenMode = userInfo?["fullScreenMode"] as? EZPlayerFullScreenMode {
            player?.fullScreenMode = fullScreenMode
        }

        player?.backButtonBlock = { [weak self] fromDisplayMode in
            switch fromDisplayMode {
            case .embedded:
                    self?.releasePlayer()
                break
            case .fullscreen:
                    if self?.embeddedContentView == nil && self?.player?.lastDisplayMode != .float {
                        self?.releasePlayer()
                    }
                break
            case .float:
                if self?.player?.lastDisplayMode == EZPlayerDisplayMode.none {
                        self?.releasePlayer()
                    }
                break
            default:
                break
            }
        }
        
        embeddedContentView = contentView
        
        if let url = mediaItem.url {
            player?.playWithURL(url, embeddedContentView: embeddedContentView, title: mediaItem.title)
        }
    }
    
    @objc func seekToTime(_ time: Double) {
        player?.seek(to: time, completionHandler: { finished in
            print(finished)
        })
    }
    
    @objc func playerDidPlayToEnd(_ notification: Notification) {
        playerEndCallback?(player?.currentTime)
        // 结束播放关闭播放器
        releasePlayer()
    }
    
    @objc func releasePlayer() {
        player?.stop()
        player?.view.removeFromSuperview()
        
        player = nil
        
        embeddedContentView = nil
        mediaItem = nil
    }
    
    // MARK: - action
    
    
    // MARK: - other
    
    @objc fileprivate  func applicationWillEnterForeground(_ notifiaction: Notification){
//        self.player?.play()
    }

    @objc fileprivate  func applicationDidBecomeActive(_ notifiaction: Notification){
        self.player?.play()
    }


    @objc fileprivate  func applicationWillResignActive(_ notifiaction: Notification){
        player?.pause()
        currentTime = player?.currentTime ?? 0.0
    }

    @objc fileprivate  func applicationDidEnterBackground(_ notifiaction: Notification){
//        player?.pause()
//        currentTime = player?.currentTime ?? 0.0
    }


}
