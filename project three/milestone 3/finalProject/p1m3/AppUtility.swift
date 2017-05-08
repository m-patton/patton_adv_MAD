//
//  AppUtility.swift
//  p1m3
//
//  Created by Mae Patton on 5/7/17.
//  Copyright © 2017 Mae Patton. All rights reserved.
//

import Foundation
import UIKit

struct AppUtility {
    //This will prevent any views I want to stay in portrait from rotating
    //http://stackoverflow.com/questions/28938660/how-to-lock-orientation-of-one-view-controller-to-portrait-mode-only-in-swift
    static func lockOrientation(_ orientation: UIInterfaceOrientationMask) {
        
        if let delegate = UIApplication.shared.delegate as? AppDelegate {
            delegate.orientationLock = orientation
        }
    }
    
    static func lockOrientation(_ orientation: UIInterfaceOrientationMask, andRotateTo rotateOrientation:UIInterfaceOrientation) {
        
        self.lockOrientation(orientation)
        
        UIDevice.current.setValue(rotateOrientation.rawValue, forKey: "orientation")
    }
    
}
