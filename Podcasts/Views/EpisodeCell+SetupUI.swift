//
//  EpisodeCell+SetupUI.swift
//  Podcasts
//
//  Created by Elias Myronidis on 06/08/2019.
//  Copyright © 2019 eliamyro. All rights reserved.
//

import UIKit

extension EpisodeCell {
    
    func setupUI() {
        addViews()
        setupConstraints()
    }
    
    private func addViews() {
        addSubview(episodeImageView)
        addSubview(episodeStackView)
    }
    
    private func setupConstraints() {
        episodeImageView.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
        episodeImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        episodeImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        episodeImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        episodeStackView.leadingAnchor.constraint(equalTo: episodeImageView.trailingAnchor, constant: 12).isActive = true
        episodeStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
        episodeStackView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
}
