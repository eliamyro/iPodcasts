//
//  PlayerDetailsController.swift
//  Podcasts
//
//  Created by Elias Myronidis on 27/03/2019.
//  Copyright © 2019 eliamyro. All rights reserved.
//

import UIKit

class PlayerDetailsView: UIView {
    
    var episode: Episode? {
        didSet {
            episodeTitleLabel.text = episode?.title
            authorLabel.text = episode?.author
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
        button.setImage(UIImage(named: "play")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        
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
        backgroundColor = .white
        
        addViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - PlayerDetailsView Methods
    
    private func addViews() {
        addSubview(playerStackView)
        setupViews()
    }
    
    private func setupViews() {
        dismissButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        episodeImageView.heightAnchor.constraint(equalTo: episodeImageView.widthAnchor, multiplier: 1).isActive = true
        episodeSlider.heightAnchor.constraint(equalToConstant: 36).isActive = true

        episodeTitleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 20).isActive = true
        episodeTitleLabel.setContentHuggingPriority(UILayoutPriority(251), for: .vertical)
        
        authorLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        authorLabel.setContentHuggingPriority(UILayoutPriority(251), for: .vertical)
        
        controlsStackView.setContentHuggingPriority(UILayoutPriority(250), for: .vertical)
        
        rewindButton.widthAnchor.constraint(equalToConstant: 48).isActive = true
        playPauseButton.widthAnchor.constraint(equalToConstant: 48).isActive = true
        forwardButton.widthAnchor.constraint(equalToConstant: 48).isActive = true
        
        playerStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        playerStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 24).isActive = true
        playerStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -24).isActive = true
        playerStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -24).isActive = true
        
        timeStackView.heightAnchor.constraint(equalToConstant: 22).isActive = true
        
        mutedVolumeImageView.widthAnchor.constraint(equalToConstant: 34).isActive = true
        mutedVolumeImageView.heightAnchor.constraint(equalToConstant: 34).isActive = true
        
        maxVolumeImageView.widthAnchor.constraint(equalToConstant: 34).isActive = true
        maxVolumeImageView.heightAnchor.constraint(equalToConstant: 34).isActive = true

    }
    
    @objc private func handleDismissButton() {
       self.removeFromSuperview()
    }
}
