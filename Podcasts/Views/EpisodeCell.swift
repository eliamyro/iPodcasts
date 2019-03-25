//
//  EpisodeCell.swift
//  Podcasts
//
//  Created by Elias Myronidis on 25/03/2019.
//  Copyright © 2019 eliamyro. All rights reserved.
//

import UIKit

class EpisodeCell: UITableViewCell {
    
    var episode: Episode? {
        didSet {
            guard let episode = episode else { return }
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM dd, yyyy"
            
            pubDateLabel.text = dateFormatter.string(from: episode.pubDate)
            titleLabel.text = episode.title
            descriptionLabel.text = episode.description
        }
    }
    
    // MARK: - Views
    
    lazy var episodeImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "appicon"))
        imageView.backgroundColor = .red
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var pubDateLabel: UILabel = {
        let label = UILabel()
        label.text = "Pub date"
        label.textColor = UIColor.purple
        label.font = UIFont.boldSystemFont(ofSize: 16)
        
        return label
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Title"
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.numberOfLines = 2
        
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Description"
        label.textColor = UIColor.lightGray
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 2
        
        return label
    }()
    
    lazy var episodeStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [pubDateLabel, titleLabel, descriptionLabel])
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(episodeImageView)
        addSubview(episodeStackView)
        
        episodeImageView.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
        episodeImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        episodeImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        episodeImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        episodeStackView.leadingAnchor.constraint(equalTo: episodeImageView.trailingAnchor, constant: 12).isActive = true
        episodeStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
        episodeStackView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

