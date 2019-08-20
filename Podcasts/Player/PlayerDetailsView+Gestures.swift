//
//  PlayerDetailsView+Gestures.swift
//  Podcasts
//
//  Created by Elias Myronidis on 18/08/2019.
//  Copyright © 2019 eliamyro. All rights reserved.
//

import UIKit

extension PlayerDetailsView {
    @objc func handleTapMaximize() {
        UIApplication.mainTabBarController()?.maximizePlayerDetailsView(episode: nil)
    }
    
    @objc func handlePan(gesture: UIPanGestureRecognizer) {
        if gesture.state == .changed {
            handlePanChanged(gesture: gesture)
        } else if gesture.state == .ended {
            handlePanEnded(gesture: gesture)
        }
    }
    
    @objc func handleDismissalPan(gesture: UIPanGestureRecognizer) {
        if gesture.state == .changed {
            let translation = gesture.translation(in: self.superview)
            
            self.transform = CGAffineTransform(translationX: 0, y: translation.y)
        } else if gesture.state == .ended {
            let translation = gesture.translation(in: self.superview)
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.transform = .identity
                if translation.y > 100{
                    UIApplication.mainTabBarController()?.minimizePlayerDetailsView()
                }
            })
        }
    }
    
    func handlePanChanged(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: self.superview)
        
        self.transform = CGAffineTransform(translationX: 0, y: translation.y)
        self.miniPlayerView.alpha = 1 + translation.y / 200
        self.playerStackView.alpha = 0 - translation.y / 200
    }
    
    func handlePanEnded(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: self.superview)
        let velocity = gesture.velocity(in: self.superview)
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.transform = .identity
            
            if translation.y < -200 || velocity.y < -500{
                UIApplication.mainTabBarController()?.maximizePlayerDetailsView(episode: nil)
            } else {
                self.miniPlayerView.alpha = 1
                self.playerStackView.alpha = 0
            }
        })
    }
}
