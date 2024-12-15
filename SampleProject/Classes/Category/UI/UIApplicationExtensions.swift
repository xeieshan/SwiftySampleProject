//
//  UIApplicationExtensions.swift
//  SampleProject
//
//  Created by Asapp Studio on 30/01/2025.
//  Copyright © 2025 XYZco. All rights reserved.
//

import Foundation
import UIKit

extension UIApplication {
    
    /// Retrieves the key window from the active foreground scene.
    var keyWindows: UIWindow? {
        return connectedScenes
            .filter { $0.activationState == .foregroundActive }
            .compactMap { $0 as? UIWindowScene }
            .first?.windows
            .first(where: \.isKeyWindow)
    }
    
    var windowScene: UIWindowScene? {
        return UIApplication.shared.connectedScenes
            .filter { $0.activationState == .foregroundActive }
            .first as? UIWindowScene
    }
}
