//
//  UIApplication.swift
//  Podcasts
//
//  Created by Elias Myronidis on 20/08/2019.
//  Copyright © 2019 eliamyro. All rights reserved.
//

import UIKit

extension UIApplication {
    
    static func mainTabBarController() -> MainTabController? {
        return shared.keyWindow?.rootViewController as? MainTabController
    }
}
