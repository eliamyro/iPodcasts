//
//  PlayerDetailsController.swift
//  Podcasts
//
//  Created by Elias Myronidis on 27/03/2019.
//  Copyright © 2019 eliamyro. All rights reserved.
//

import UIKit
import AVKit
import MediaPlayer

class PlayerDetailsView: UIView {
    
    private let shrunkenTransform = CGAffineTransform(scaleX: 0.7, y: 0.7)
    var panGesture: UIPanGestureRecognizer!
    
    let player: AVPlayer = {
        let avPlayer = AVPlayer()
        avPlayer.automaticallyWaitsToMinimizeStalling = false
        
        return avPlayer
    }()
    
    var episode: Episode? {
        didSet {
            episodeTitleLabel.text = episode?.title
            miniEpisodeLabel.text = episode?.title
            authorLabel.text = episode?.author
            
            playPauseButton.setImage(UIImage(named: "play")?.withRenderingMode(.alwaysOriginal), for: .normal)
            miniPlayButton.setImage(UIImage(named: "play")?.withRenderingMode(.alwaysOriginal), for: .normal)
            
            setupNowPlayingInfo()
            playEpisode()
            
            guard let imageUrl = URL(string: episode?.imageUrl ?? "") else { return }
            episodeImageView.sd_setImage(with: imageUrl)
            miniImageView.sd_setImage(with: imageUrl) { (image, _, _, _) in
                guard let image = image else { return }
                let artwork = MPMediaItemArtwork(boundsSize: image.size, requestHandler: { (_) -> UIImage in
                    return image
                })
                
                var nowPlayingInfo = MPNowPlayingInfoCenter.default().nowPlayingInfo
                nowPlayingInfo?[MPMediaItemPropertyArtwork] = artwork
                
                MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
            }
        }
    }
    
    // MARK: - Views
    
    lazy var dismissButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Dismiss", for: .normal)
        
        button.addTarget(self, action: #selector(handleDismissButton), for: .touchUpInside)
        return button
    }()
    
    lazy var miniImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "appicon")
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    lazy var miniEpisodeLabel: UILabel = {
        let label = UILabel()
        label.text = "Episode Title"
        
        return label
    }()
    
    lazy var miniPlayButton: UIButton = {
        let button = UIButton(type: .system)
        button.imageView?.contentMode = .scaleAspectFit
        button.imageEdgeInsets = UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6)
        
        button.addTarget(self, action: #selector(handlePlayPauseButton), for: .touchUpInside)
        return button
    }()
    
    lazy var miniForwardButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "fastforward15")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.imageEdgeInsets = UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6)
        
        button.addTarget(self, action: #selector(handleFastForward), for: .touchUpInside)
        return button
    }()
    
    lazy var miniPlayerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [miniImageView, miniEpisodeLabel, miniPlayButton, miniForwardButton])
        stackView.axis = .horizontal
        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    lazy var miniPlayerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var miniPlayerDividerView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.alpha = 0.3
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var episodeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "appicon")
        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    lazy var currentTimeSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0
        
        slider.addTarget(self, action: #selector(handleCurrentTimeSlideChange), for: .valueChanged)
        return slider
    }()
    
    lazy var currentTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "00:00:00"
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .lightGray
        
        return label
    }()
    
    lazy var durationLabel: UILabel = {
        let label = UILabel()
        label.text = "00:00:00"
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .lightGray
        
        return label
    }()
    
    lazy var timeStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [currentTimeLabel, durationLabel])
        stackView.axis = .horizontal
        stackView.distribution = UIStackView.Distribution.fillEqually
        
        return stackView
    }()
    
    lazy var episodeTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Episode Title"
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textAlignment = .center
        label.numberOfLines = 2
        
        return label
    }()
    
    lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.text = "Author"
        label.textColor = UIColor.purple
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18)
        
        return label
    }()
    
    let spaceView1 = UIView()
    let spaceView2 = UIView()
    
    lazy var rewindButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "rewind15")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.addTarget(self, action: #selector(handleRewind), for: .touchUpInside)
        return button
    }()
    
    lazy var playPauseButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "pause")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.addTarget(self, action: #selector(handlePlayPauseButton), for: .touchUpInside)
        return button
    }()
    
    lazy var forwardButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "fastforward15")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.addTarget(self, action: #selector(handleFastForward), for: .touchUpInside)
        return button
    }()
    
    lazy var controlsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [spaceView1, rewindButton, playPauseButton, forwardButton, spaceView2])
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        
        return stackView
    }()
    
    lazy var mutedVolumeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "muted_volume")
        
        return imageView
    }()
    
    lazy var volumeSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 1
        slider.value = 1
        
        slider.addTarget(self, action: #selector(handleVolumeChange), for: .valueChanged)
        return slider
    }()
    
    lazy var maxVolumeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "max_volume")
        
        return imageView
    }()
    
    lazy var volumeStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [mutedVolumeImageView, volumeSlider, maxVolumeImageView])
        stackView.axis = .horizontal
        
        return stackView
    }()
    
    lazy var playerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [dismissButton, episodeImageView, currentTimeSlider, timeStackView, episodeTitleLabel, authorLabel, controlsStackView, volumeStackView])
        stackView.spacing = 5
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    // MARK: - UIView Methods
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupAudioSession()
        setupRemoteControl()
        setupGestures()
        setupUI()
        
        initialEpisodeImageView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didAddSubview(_ subview: UIView) {
        super.didAddSubview(subview)
        
        observePlayerCurrentTime()
        
        let time = CMTimeMake(value: 1, timescale: 3)
        let times = [NSValue(time: time)]
        player.addBoundaryTimeObserver(forTimes: times, queue: .main) { [weak self] in
            self?.playPauseButton.setImage(#imageLiteral(resourceName: "pause").withRenderingMode(.alwaysOriginal), for: .normal)
            self?.miniPlayButton.setImage(#imageLiteral(resourceName: "pause").withRenderingMode(.alwaysOriginal), for: .normal)
            self?.enlargeEpisodeImageView()
            self?.currentTimeSlider.maximumValue =  Float(CMTimeGetSeconds(self?.player.currentItem?.duration ?? CMTimeMake(value: 1, timescale: 1)))
            
            self?.setupLockScreenCurrentTime()
        }
    }
    
    // MARK: - PlayerDetailsView Actions
    
    @objc private func handleDismissButton() {
        UIApplication.mainTabBarController()?.minimizePlayerDetailsView()
        panGesture.isEnabled = true
    }
    
    @objc private func handlePlayPauseButton() {
        if player.timeControlStatus == .paused {
            player.play()
            playPauseButton.setImage(#imageLiteral(resourceName: "pause").withRenderingMode(.alwaysOriginal), for: .normal)
            miniPlayButton.setImage(#imageLiteral(resourceName: "pause").withRenderingMode(.alwaysOriginal), for: .normal)
            enlargeEpisodeImageView()
            setupLockScreenCurrentTime()
        } else {
            player.pause()
            playPauseButton.setImage(#imageLiteral(resourceName: "play").withRenderingMode(.alwaysOriginal), for: .normal)
            miniPlayButton.setImage(#imageLiteral(resourceName: "play").withRenderingMode(.alwaysOriginal), for: .normal)
            shrinkEpisodeImageView()
            setupLockScreenCurrentTime()
        }
    }
    
    @objc private func handleCurrentTimeSlideChange() {
        print(currentTimeSlider.value)
        let time = CMTimeMakeWithSeconds(Float64(currentTimeSlider.value), preferredTimescale: Int32(NSEC_PER_SEC))
        player.seek(to: time)
    }
    
    @objc private func handleRewind() {
        seekToCurrentTime(delta: -15)
    }
    
    @objc private func handleFastForward() {
        seekToCurrentTime(delta: 15)
    }
    
    @objc private func handleVolumeChange(_ sender: UISlider) {
        player.volume = sender.value
    }
    
    // MARK: - PlayerDetailsView Methods
    
    private func setupNowPlayingInfo() {
        var nowPlayingInfo = [String : Any]()
        nowPlayingInfo[MPMediaItemPropertyTitle] = episode?.title
        nowPlayingInfo[MPMediaItemPropertyArtist] = episode?.author
        
        MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
    }
    
    private func setupLockScreenCurrentTime() {
        guard let currentItem = player.currentItem else { return }
        let duration = CMTimeGetSeconds(currentItem.duration)
        let elapsedTime = CMTimeGetSeconds(player.currentTime())
        
        var nowPlayingInfo = MPNowPlayingInfoCenter.default().nowPlayingInfo
        nowPlayingInfo?[MPNowPlayingInfoPropertyElapsedPlaybackTime] = elapsedTime
        nowPlayingInfo?[MPMediaItemPropertyPlaybackDuration] = duration
        
        MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
    }
    
    // Enable audio background
    private func setupAudioSession() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch let sessionError {
            print("Failed to activate Audio session", sessionError)
        }
    }
    
    private func setupRemoteControl() {
        UIApplication.shared.beginReceivingRemoteControlEvents()
        
        let commandCenter = MPRemoteCommandCenter.shared()
        
        commandCenter.playCommand.isEnabled = true
        commandCenter.playCommand.addTarget { _ -> MPRemoteCommandHandlerStatus in
            self.handlePlayPauseButton()
            return .success
        }
        
        commandCenter.pauseCommand.isEnabled = true
        commandCenter.pauseCommand.addTarget(handler: { _ -> MPRemoteCommandHandlerStatus in
            self.handlePlayPauseButton()
            return .success
        })
    }
    
    private func setupGestures() {
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapMaximize)))
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        miniPlayerView.addGestureRecognizer(panGesture)
        playerStackView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handleDismissalPan)))
    }
    
    private func playEpisode() {
        guard let url = URL(string: episode?.streamUrl ?? "") else { return }
        let playerItem = AVPlayerItem(url: url)
        player.replaceCurrentItem(with: playerItem)
        player.play()
    }
    
    private func seekToCurrentTime(delta: Int64) {
        let deltaSeconds = CMTimeMake(value: delta, timescale: 1)
        let seekTime = CMTimeAdd(player.currentTime(), deltaSeconds)
        player.seek(to: seekTime)
    }
    
    private func initialEpisodeImageView() {
        episodeImageView.transform = shrunkenTransform
    }
    
    private func enlargeEpisodeImageView() {
        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.episodeImageView.transform = .identity
        })
    }
    
    private func shrinkEpisodeImageView() {
        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.episodeImageView.transform = self.shrunkenTransform
        })
    }
    
    private func observePlayerCurrentTime() {
        let interval = CMTimeMake(value: 1, timescale: 1)
        player.addPeriodicTimeObserver(forInterval: interval, queue: .main) { [weak self] time in
            self?.currentTimeLabel.text = "\(time.toDisplayString())"
            
            let durationTime = self?.player.currentItem?.duration
            self?.durationLabel.text = "\(durationTime?.toDisplayString() ?? "00:00:00")"
            
            self?.updateCurrentTimeSlider()
        }
    }
    
    private func updateCurrentTimeSlider() {
        let currentTimeSeconds = Float(CMTimeGetSeconds(player.currentTime()))
        
        currentTimeSlider.setValue(currentTimeSeconds, animated: true)
    }
}
