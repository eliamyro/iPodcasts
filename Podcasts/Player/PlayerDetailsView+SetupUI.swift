//
//  PlayerDetailsView+SetupUI.swift
//  Podcasts
//
//  Created by Elias Myronidis on 06/08/2019.
//  Copyright © 2019 eliamyro. All rights reserved.
//

import UIKit

extension PlayerDetailsView {
    
    func setupUI() {
        backgroundColor = .white
        
        addViews()
        setupConstraints()
    }
    
    private func addViews() {
        addSubview(miniPlayerView)
        miniPlayerView.addSubview(miniPlayerStackView)
        miniPlayerView.addSubview(miniPlayerDividerView)
        addSubview(playerStackView)
        
    }
    
    private func setupConstraints() {
        dismissButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        miniPlayerView.heightAnchor.constraint(equalToConstant: 64).isActive = true
        miniPlayerView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        miniPlayerView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        miniPlayerStackView.topAnchor.constraint(equalTo: miniPlayerView.topAnchor, constant: 8).isActive = true
        miniPlayerStackView.leadingAnchor.constraint(equalTo: miniPlayerView.leadingAnchor, constant: 8).isActive = true
        miniPlayerStackView.bottomAnchor.constraint(equalTo: miniPlayerView.bottomAnchor, constant: -8).isActive = true
        miniPlayerStackView.trailingAnchor.constraint(equalTo: miniPlayerView.trailingAnchor, constant: -8).isActive = true
        
        miniPlayerDividerView.bottomAnchor.constraint(equalTo: miniPlayerView.topAnchor).isActive = true
        miniPlayerDividerView.leadingAnchor.constraint(equalTo: miniPlayerView.leadingAnchor).isActive = true
        miniPlayerDividerView.trailingAnchor.constraint(equalTo: miniPlayerView.trailingAnchor).isActive = true
        miniPlayerDividerView.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        
        miniImageView.widthAnchor.constraint(equalToConstant: 48).isActive = true
        miniPlayButton.widthAnchor.constraint(equalToConstant: 48).isActive = true
        miniForwardButton.widthAnchor.constraint(equalToConstant: 48).isActive = true
        
        episodeImageView.heightAnchor.constraint(equalTo: episodeImageView.widthAnchor, multiplier: 1).isActive = true
        currentTimeSlider.heightAnchor.constraint(equalToConstant: 36).isActive = true
        
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
}
