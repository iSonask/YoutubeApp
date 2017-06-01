//
//  VideoLauncher.swift
//  YoutubeApp
//
//  Created by FARHAN IT SOLUTION on 10/05/17.
//
//

import UIKit
import AVFoundation
class VideoPlayerView: UIView {
    
    let controlsContainerVew: UIView = {
        let vw = UIView()
        vw.backgroundColor = UIColor(white: 0, alpha: 1)
        return vw
    }()
    
    let activityIndicatoreView: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        aiv.translatesAutoresizingMaskIntoConstraints = false
        aiv.startAnimating()
        return aiv
    }()
    
    var isplaying = false
    
    let pausePlayButton: UIButton = {
        let btn = UIButton(type: UIButtonType.system)
        
        btn.setImage(#imageLiteral(resourceName: "pause"), for: .normal)
        btn.tintColor = .white
        btn.backgroundColor = UIColor(white: 0, alpha: 1)
        btn.addTarget(self, action: #selector(pauseSelected), for: .touchUpInside)
        btn.isHidden = true
        return btn
    }()
    
    let downButton: UIButton = {
        let btn = UIButton(type: .system)
        let img = #imageLiteral(resourceName: "down").filled(withColor: .white)
        btn.setImage(img, for: .normal)
        btn.backgroundColor = UIColor(white: 0, alpha: 1)
        btn.addTarget(self, action: #selector(downSelected), for: .touchUpInside)
        return btn
    }()
    let videoLengthLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "00:00"
        lbl.textColor = .white
        lbl.font = UIFont.boldSystemFont(ofSize: 14)
        lbl.textAlignment = .right
        return lbl
    }()
    let slider: UISlider = {
        let slider = UISlider()
        slider.minimumTrackTintColor = .red
        slider.setThumbImage(#imageLiteral(resourceName: "play").filled(withColor: .red), for: .normal)
        slider.addTarget(self, action: #selector(handleSlider), for: .valueChanged)
        return slider
    }()
    func handleSlider()  {
        if let duration = player?.currentItem?.duration{
            
            let totalseconds = CMTimeGetSeconds(duration)
            
            let value = Float64(slider.value) * totalseconds
            
            let seekTIme = CMTime(value: Int64(value), timescale: 1)
            
            player?.seek(to: seekTIme, completionHandler: {(completion) in
                
            })
        }
        
    }
    func pauseSelected()  {
        print("pause")
        
        if isplaying{
            player?.pause()
            pausePlayButton.setImage(#imageLiteral(resourceName: "play"), for: .normal)
        } else{
            player?.play()
            pausePlayButton.setImage(#imageLiteral(resourceName: "pause"), for: .normal)
        }
        isplaying = !isplaying
    }
    
    func downSelected()  {
        print("down")
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupPlayer()
        controlsContainerVew.frame = frame
        addSubview(controlsContainerVew)
        
        controlsContainerVew.addSubview(activityIndicatoreView)
        activityIndicatoreView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        activityIndicatoreView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        controlsContainerVew.addSubview(pausePlayButton)
        pausePlayButton.anchorCenterSuperview()
        pausePlayButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        pausePlayButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        controlsContainerVew.addSubview(videoLengthLabel)
        videoLengthLabel.anchor(nil, left: nil, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 50, heightConstant: 20)
        
        controlsContainerVew.addSubview(slider)
        slider.anchor(nil, left: leftAnchor, bottom: bottomAnchor, right: videoLengthLabel.leftAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: frame.width - CGFloat(50), heightConstant: 20)
        backgroundColor = .black
        
        
    }
    var player: AVPlayer?
    fileprivate func setupPlayer()  {
        //http://mm2.pcslab.com/mm/7h2000.mp4
        //http://techslides.com/demos/sample-videos/small.mp4
        if let urlString = URL(string: "http://mm2.pcslab.com/mm/7h2000.mp4"){
            player = AVPlayer(url: urlString)
            
            player?.play()
            let playerLayer = AVPlayerLayer(player: player)
            self.layer.addSublayer(playerLayer)
            playerLayer.frame = self.frame
            
            player?.addObserver(self, forKeyPath: "currentItem.loadedTimeRanges", options: .new, context: nil)
            
        }
        
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "currentItem.loadedTimeRanges"{
            print("currentItem.loadedTimeRanges")
            activityIndicatoreView.stopAnimating()
            controlsContainerVew.backgroundColor = .clear
            pausePlayButton.isHidden = false
            isplaying = true
            if let duration = player?.currentItem?.duration{
                print(duration.durationText)
                videoLengthLabel.text = "\(duration.durationText)"
            }
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


class VideoLauncher: NSObject {
    
    func showVideoPlayer()  {
        print("video")
        
        if let keyWindow = UIApplication.shared.keyWindow{
            //aspect ratio of HD videos
            let height = keyWindow.frame.width * 9 / 16
            let videoplayerFrame = CGRect(x: 0, y: 0, width: keyWindow.frame.width, height: height)
            let videoPlayer = VideoPlayerView(frame: videoplayerFrame)
            let view = UIView(frame: keyWindow.frame)
            
            view.backgroundColor = .white
            view.frame = CGRect(x: keyWindow.frame.width - 10, y: keyWindow.frame.height - 10, width: 10, height: 10)
            
            view.addSubview(videoPlayer)
            keyWindow.addSubview(view)
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                view.frame = keyWindow.frame
            }, completion: { (completion) in
                UIApplication.shared.isStatusBarHidden = true
            })
        }
        
    }
    

}
extension CMTime {
    var durationText:String {
        let totalSeconds = CMTimeGetSeconds(self)
        let hours = Int(totalSeconds / 3600)
        let minutes = Int((totalSeconds.truncatingRemainder(dividingBy: 3600)) / 60)
        let seconds = Int(totalSeconds.truncatingRemainder(dividingBy: 60))
        
        if hours > 0 {
            return String(format: "%i:%02i:%02i", hours, minutes, seconds)
        } else {
            return String(format: "%02i:%02i", minutes, seconds)
        }
    }
}
