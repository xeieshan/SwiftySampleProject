//
//  SPButton.swift
//  <#Project Name#>
//
//  Created by <#Project Developer#> on 19/01/2017.
//  Copyright © 2017 <#Project Name#>. All rights reserved.
//

import Foundation
import UIKit

enum SPIconPosition: Int {
    case top = 0
    case left
    case bottom
    case right
}

@IBDesignable
class SPButton: UIButton {
    @IBInspectable var iconMargin: CGFloat = 0
    @IBInspectable var iconPositionRaw: Int {
        get { return iconPosition.rawValue }
        set { iconPosition = SPIconPosition(rawValue: newValue) ?? .left }
    }
    var iconPosition: SPIconPosition = .left
    @IBInspectable var iconSize: CGSize = .zero
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        iconSize = .zero
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        guard let imageView = imageView, let titleLabel = titleLabel else { return }
        
        let titleSize = titleLabel.intrinsicContentSize
        let imageSize = iconSize == .zero ? imageView.intrinsicContentSize : iconSize
        
        let totalWidth = titleSize.width + imageSize.width + iconMargin
        let totalHeight = titleSize.height + imageSize.height + iconMargin
        
        // Position the image and title based on the iconPosition
        switch iconPosition {
        case .top:
            imageView.frame = CGRect(
                x: (bounds.width - imageSize.width) / 2,
                y: (bounds.height - totalHeight) / 2,
                width: imageSize.width,
                height: imageSize.height
            )
            titleLabel.frame = CGRect(
                x: (bounds.width - titleSize.width) / 2,
                y: imageView.frame.maxY + iconMargin,
                width: titleSize.width,
                height: titleSize.height
            )
        case .bottom:
            titleLabel.frame = CGRect(
                x: (bounds.width - titleSize.width) / 2,
                y: (bounds.height - totalHeight) / 2,
                width: titleSize.width,
                height: titleSize.height
            )
            imageView.frame = CGRect(
                x: (bounds.width - imageSize.width) / 2,
                y: titleLabel.frame.maxY + iconMargin,
                width: imageSize.width,
                height: imageSize.height
            )
        case .left:
            imageView.frame = CGRect(
                x: (bounds.width - totalWidth) / 2,
                y: (bounds.height - imageSize.height) / 2,
                width: imageSize.width,
                height: imageSize.height
            )
            titleLabel.frame = CGRect(
                x: imageView.frame.maxX + iconMargin,
                y: (bounds.height - titleSize.height) / 2,
                width: titleSize.width,
                height: titleSize.height
            )
        case .right:
            titleLabel.frame = CGRect(
                x: (bounds.width - totalWidth) / 2,
                y: (bounds.height - titleSize.height) / 2,
                width: titleSize.width,
                height: titleSize.height
            )
            imageView.frame = CGRect(
                x: titleLabel.frame.maxX + iconMargin,
                y: (bounds.height - imageSize.height) / 2,
                width: imageSize.width,
                height: imageSize.height
            )
        }
    }
    
    override var intrinsicContentSize: CGSize {
        guard let imageView = imageView, let titleLabel = titleLabel else { return super.intrinsicContentSize }
        
        let titleSize = titleLabel.intrinsicContentSize
        let imageSize = iconSize == .zero ? imageView.intrinsicContentSize : iconSize
        
        switch iconPosition {
        case .top, .bottom:
            return CGSize(
                width: max(titleSize.width, imageSize.width),
                height: titleSize.height + imageSize.height + iconMargin
            )
        case .left, .right:
            return CGSize(
                width: titleSize.width + imageSize.width + iconMargin,
                height: max(titleSize.height, imageSize.height)
            )
        }
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        return intrinsicContentSize
    }
}
