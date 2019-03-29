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
    
    lazy var episodeTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Episode Title"
        label.textAlignment = .center
        
        return label
    }()
    
    lazy var playerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [dismissButton, episodeImageView, episodeSlider, episodeTitleLabel])
        stackView.axis = .vertical
        stackView.backgroundColor = .blue
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    
    // MARK: - UIView Methods

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - PlayerDetailsView Methods
    
    private func setupViews() {
        addSubview(playerStackView)
        setupDismissButton()
        setupPlayerStackView()
        setupEpisodeImageView()
        setupEpisodeSlider()
    }
    
    private func setupDismissButton() {
        dismissButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
    
    private func setupPlayerStackView() {
        playerStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        playerStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 24).isActive = true
        playerStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -24).isActive = true
        playerStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -24).isActive = true
    }
    
    private func setupEpisodeImageView() {
        episodeImageView.heightAnchor.constraint(equalTo: episodeImageView.widthAnchor, multiplier: 1).isActive = true
    }
    
    private func setupEpisodeSlider() {
        episodeSlider.heightAnchor.constraint(equalToConstant: 36).isActive = true
    }
    
    @objc private func handleDismissButton() {
       self.removeFromSuperview()
    }
}
