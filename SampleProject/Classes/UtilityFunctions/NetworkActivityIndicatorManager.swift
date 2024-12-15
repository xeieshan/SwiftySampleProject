//
//  NetworkActivityIndicatorManager.swift
//  SampleProject
//
//  Created by Asapp Studio on 05/02/2025.
//  Copyright © 2025 XYZco. All rights reserved.
//

import Foundation
import UIKit

import UIKit

class NetworkActivityIndicatorManager {
    static let shared = NetworkActivityIndicatorManager()

    private var activityIndicator: UIActivityIndicatorView!
    private var counter = 0 // To handle multiple network requests

    private init() {
        activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = .systemBlue

        if let windowScene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
            if let window = windowScene.windows.first(where: { $0.isKeyWindow }) {
                window.addSubview(activityIndicator)
                activityIndicator.center = window.center
            }
        }
    }

    // Boolean property to show/hide the indicator
    var isNetworkActivityIndicatorVisible: Bool {
        get {
            return activityIndicator.isAnimating
        }
        set {
            if newValue {
                start()
            } else {
                stop()
            }
        }
    }

    // Start the activity indicator
    private func start() {
        counter += 1
        if !activityIndicator.isAnimating {
            DispatchQueue.main.async {
                self.activityIndicator.startAnimating()
            }
        }
    }

    // Stop the activity indicator
    private func stop() {
        counter -= 1
        if counter <= 0 {
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
            }
            counter = 0 // Reset the counter
        }
    }
}
