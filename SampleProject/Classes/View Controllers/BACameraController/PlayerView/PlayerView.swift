//
//  PlayerView.swift
//  CustomCamera
//
//  Created by <#Project Developer#> on 19/01/2011.
//  Copyright © 2016 <#Project Developer#> All rights reserved.

import UIKit
import AVFoundation
import AVKit

class PlayerView: UIView {
    
    @IBOutlet weak var playerView: UIView!
    
    fileprivate var videoLayer:AVPlayerLayer?
    private var URL:URL?
    var sendButtonCompletionHandler:((_ videoUrl: URL) -> Void)?;
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor(red: 0,green: 0,blue: 0,alpha: 0.5);
    }
    
    func playVideoWithURL(_ url:URL) {
        self.URL = url;
        let videoPlayer = AVPlayer(url: url)
        videoPlayer.actionAtItemEnd = .none
        
        
        self.videoLayer = AVPlayerLayer(player: videoPlayer)
//        self.videoLayer!.frame = playerView!.bounds;
        
        
        playerView.layer.addSublayer(videoLayer!);
        
        videoPlayer.play()
    }
    
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        videoLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill;
        videoLayer?.frame = self.playerView.bounds
    }
    
    @IBAction func discardVideo(_ sender: AnyObject) {
        self.removeFromSuperview();
    }
    
    @IBAction func sendVideo(_ sender: AnyObject) {
        // call delegate with url
        // send url to delegate
        if (sendButtonCompletionHandler != nil) {
            sendButtonCompletionHandler!(self.URL!);
        }
        self.removeFromSuperview();
    }
}
