//
//  PodcastCell.swift
//  Podcasts
//
//  Created by Elias Myronidis on 02/02/2019.
//  Copyright © 2019 eliamyro. All rights reserved.
//

import UIKit
import SDWebImage

class PodcastCell: UITableViewCell {
    
    var podcast: Podcast? {
        didSet {
            guard let podcast = podcast else { return }
            
            trackNameLabel.text = podcast.trackName
            artistNameLabel.text = podcast.artistName
            episodeCountLabel.text = "\(podcast.trackCount ?? 0) Episodes"
            
            guard let url = URL(string: podcast.artworkUrl600 ?? "") else { return }
            podcastImageView.sd_setImage(with: url, completed: nil)
        }
    }
    
    
    // MARK: - Views
    
    lazy var podcastImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "appicon"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var trackNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Track name"
        label.numberOfLines = 2
        label.font = UIFont.boldSystemFont(ofSize: 17)
        
        return label
    }()
    
    lazy var artistNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Artist name"
        label.font = UIFont.systemFont(ofSize: 16)
        
        return label
    }()
    
    lazy var episodeCountLabel: UILabel = {
        let label = UILabel()
        label.text = "Episode count"
        label.textColor = UIColor.darkGray
        label.font = UIFont.systemFont(ofSize: 14)
        
        return label
    }()
    
    lazy var podcastStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [trackNameLabel, artistNameLabel, episodeCountLabel])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
