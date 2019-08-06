//
//  PodcastCell+SetupUI.swift
//  Podcasts
//
//  Created by Elias Myronidis on 06/08/2019.
//  Copyright © 2019 eliamyro. All rights reserved.
//

import UIKit

extension PodcastCell {
    
    func setupUI() {
    
        addViews()
        setupConstraints()
    }
    
    private func addViews() {
        addSubview(podcastImageView)
        addSubview(podcastStackView)
    }
    
    private func setupConstraints() {
        podcastImageView.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
        podcastImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        podcastImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        podcastImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        podcastStackView.leadingAnchor.constraint(equalTo: podcastImageView.trailingAnchor, constant: 12).isActive = true
        podcastStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
        podcastStackView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
}
