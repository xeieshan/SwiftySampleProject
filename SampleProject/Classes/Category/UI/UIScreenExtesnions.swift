//
//  UIScreenExtesnions.swift
//  SampleProject
//
//  Created by Asapp Studio on 30/01/2025.
//  Copyright © 2025 XYZco. All rights reserved.
//

import Foundation
import UIKit

extension UIScreen {
    static var screenWidth: CGFloat {
        guard let windowScene = UIApplication.shared.connectedScenes
                .compactMap({ $0 as? UIWindowScene })
                .first,
              let interfaceOrientation = windowScene.windows.first?.windowScene?.interfaceOrientation else {
            return UIScreen.main.bounds.width // Default to width if no window scene
        }
        
        return (interfaceOrientation.isPortrait ? UIScreen.main.bounds.width : UIScreen.main.bounds.height)
    }
    
    static var screenHeight: CGFloat {
        guard let windowScene = UIApplication.shared.connectedScenes
                .compactMap({ $0 as? UIWindowScene })
                .first,
              let interfaceOrientation = windowScene.windows.first?.windowScene?.interfaceOrientation else {
            return UIScreen.main.bounds.height // Default to width if no window scene
        }
        
        return (interfaceOrientation.isPortrait ? UIScreen.main.bounds.height : UIScreen.main.bounds.width)
    }
    
}
