//
//  PlayerDetailsController.swift
//  Podcasts
//
//  Created by Elias Myronidis on 27/03/2019.
//  Copyright © 2019 eliamyro. All rights reserved.
//

import UIKit
import AVKit

class PlayerDetailsView: UIView {
    
    private let shrunkenTransform = CGAffineTransform(scaleX: 0.7, y: 0.7)
    
    let player: AVPlayer = {
        let avPlayer = AVPlayer()
        avPlayer.automaticallyWaitsToMinimizeStalling = false
        
        return avPlayer
    }()
    
    var episode: Episode? {
        didSet {
            episodeTitleLabel.text = episode?.title
            authorLabel.text = episode?.author
            
            playEpisode()
            
            guard let imageUrl = URL(string: episode?.imageUrl ?? "") else { return }
            episodeImageView.sd_setImage(with: imageUrl)
        }
    }
    
    // MARK: - Views
    
    lazy var dismissButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Dismiss", for: .normal)
        
        button.addTarget(self, action: #selector(handleDismissButton), for: .touchUpInside)
        
        return button
    }()
    
    lazy var episodeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "appicon")
        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    lazy var episodeSlider: UISlider = {
        let slider = UISlider()
        
        return slider
    }()
    
    lazy var currentTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "00:00"
        label.textAlignment = .left
        label.textColor = .darkGray
        
        return label
    }()
    
    lazy var totalTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "02:23"
        label.textAlignment = .right
        label.textColor = .darkGray
        
        return label
    }()
    
    lazy var timeStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [currentTimeLabel, totalTimeLabel])
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
        let stackView = UIStackView(arrangedSubviews: [dismissButton, episodeImageView, episodeSlider, timeStackView, episodeTitleLabel, authorLabel, controlsStackView, volumeStackView])
        stackView.spacing = 5
        stackView.axis = .vertical
        stackView.backgroundColor = .blue
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()

    // MARK: - UIView Methods

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        
        initialEpisodeImageView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didAddSubview(_ subview: UIView) {
        super.didAddSubview(subview)
        
        let time = CMTimeMake(value: 1, timescale: 3)
        let times = [NSValue(time: time)]
        player.addBoundaryTimeObserver(forTimes: times, queue: .main) {
            self.enlargeEpisodeImageView()
        }
    }
    
    // MARK: - PlayerDetailsView Actions
    
    @objc private func handleDismissButton() {
       self.removeFromSuperview()
    }
    
    @objc private func handlePlayPauseButton() {
        if player.timeControlStatus == .paused {
            player.play()
            playPauseButton.setImage(#imageLiteral(resourceName: "pause").withRenderingMode(.alwaysOriginal), for: .normal)
            enlargeEpisodeImageView()
        } else {
            player.pause()
            playPauseButton.setImage(#imageLiteral(resourceName: "play").withRenderingMode(.alwaysOriginal), for: .normal)
            shrinkEpisodeImageView()
        }
    }
    
    private func playEpisode() {
        guard let url = URL(string: episode?.streamUrl ?? "") else { return }
        let playerItem = AVPlayerItem(url: url)
        player.replaceCurrentItem(with: playerItem)
        player.play()
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
}
