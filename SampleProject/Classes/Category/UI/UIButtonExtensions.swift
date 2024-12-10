//
//  UIButtonExtensions.swift
//  <#Project Name#>
//
//  Created by <#Project Developer#> on 8/22/16.
//  Copyright © 2017 <#Project Name#> All rights reserved.
//

#if os(iOS) || os(tvOS)

import UIKit


// MARK: - Properties
public extension UIButton {
	
	@IBInspectable
	/// Image of disabled state for button; also inspectable from Storyboard.
	var imageForDisabled: UIImage? {
		get {
			return image(for: .disabled)
		}
		set {
			setImage(newValue, for: .disabled)
		}
	}
	
	@IBInspectable
	/// Image of highlighted state for button; also inspectable from Storyboard.
	var imageForHighlighted: UIImage? {
		get {
			return image(for: .highlighted)
		}
		set {
			setImage(newValue, for: .highlighted)
		}
	}
	
	@IBInspectable
	/// Image of normal state for button; also inspectable from Storyboard.
	var imageForNormal: UIImage? {
		get {
			return image(for: .normal)
		}
		set {
			setImage(newValue, for: .normal)
		}
	}
	
	@IBInspectable
	/// Image of selected state for button; also inspectable from Storyboard.
	var imageForSelected: UIImage? {
		get {
			return image(for: .selected)
		}
		set {
			setImage(newValue, for: .selected)
		}
	}
	
	@IBInspectable
	/// Title color of disabled state for button; also inspectable from Storyboard.
	var titleColorForDisabled: UIColor? {
		get {
			return titleColor(for: .highlighted)
		}
		set {
			setTitleColor(newValue, for: .highlighted)
		}
	}
	
	@IBInspectable
	/// Title color of highlighted state for button; also inspectable from Storyboard.
	var titleColorForHighlighted: UIColor? {
		get {
			return titleColor(for: .highlighted)
		}
		set {
			setTitleColor(newValue, for: .highlighted)
		}
	}
	
	@IBInspectable
	/// Title color of normal state for button; also inspectable from Storyboard.
	var titleColorForNormal: UIColor? {
		get {
			return titleColor(for: .normal)
		}
		set {
			setTitleColor(newValue, for: .normal)
		}
	}
	
	@IBInspectable
	/// Title color of selected state for button; also inspectable from Storyboard.
	var titleColorForSelected: UIColor? {
		get {
			return titleColor(for: .selected)
		}
		set {
			setTitleColor(newValue, for: .selected)
		}
	}
	
	@IBInspectable
	/// Title of disabled state for button; also inspectable from Storyboard.
	var titleForDisabled: String? {
		get {
			return title(for: .disabled)
		}
		set {
			setTitle(newValue, for: .disabled)
		}
	}
	
	@IBInspectable
	/// Title of highlighted state for button; also inspectable from Storyboard.
	var titleForHighlighted: String? {
		get {
			return title(for: .highlighted)
		}
		set {
			setTitle(newValue, for: .highlighted)
		}
	}
	
	@IBInspectable
	/// Title of normal state for button; also inspectable from Storyboard.
	var titleForNormal: String? {
		get {
			return title(for: .normal)
		}
		set {
			setTitle(newValue, for: .normal)
		}
	}
	
	@IBInspectable
	/// Title of selected state for button; also inspectable from Storyboard.
	var titleForSelected: String? {
		get {
			return title(for: .selected)
		}
		set {
			setTitle(newValue, for: .selected)
		}
	}
	
}


// MARK: - Methods
public extension UIButton {
    
    private var states: [UIControl.State] {
        return [.normal, .selected, .highlighted, .disabled]
    }
	
	/// Set image for all states.
	///
	/// - Parameter image: UIImage.
	func setImageForAllStates(_ image: UIImage) {
		states.forEach { self.setImage(image, for:  $0) }
	}
	
	/// Set title color for all states.
	///
	/// - Parameter color: UIColor.
	func setTitleColorForAllStates(_ color: UIColor) {
		states.forEach { self.setTitleColor(color, for: $0) }
	}
	
	/// Set title for all states.
	///
	/// - Parameter title: title string.
	func setTitleForAllStates(_ title: String) {
		states.forEach { self.setTitle(title, for: $0) }
	}
    
    
    //    This method sets an image and title for a UIButton and
    //    repositions the titlePosition with respect to the button image.
    //    Add additionalSpacing between the button image & title as required
    //    For titlePosition, the function only respects UIViewContentModeTop, UIViewContentModeBottom, UIViewContentModeLeft and UIViewContentModeRight
    //    All other titlePositions are ignored
    @objc func set(image anImage: UIImage?, title: NSString!, titlePosition: UIView.ContentMode, additionalSpacing: CGFloat, state: UIControl.State){
        self.imageView?.contentMode = .center
        self.setImage(anImage, for: state)
        
        positionLabelRespectToImage(title: title!, position: titlePosition, spacing: additionalSpacing)
        
        self.titleLabel?.contentMode = .center
        self.setTitle(title! as String, for: state)
    }
    
    private func positionLabelRespectToImage(title: NSString, position: UIView.ContentMode, spacing: CGFloat) {
        // 1. Configuration setup
        var configuration = self.configuration ?? UIButton.Configuration.plain()
        
        // 2. Safe image handling
        let currentImage = self.image(for: .normal)
        
        // 3. Position mapping
        switch position {
        case .top:
            configuration.imagePlacement = .top
        case .bottom:
            configuration.imagePlacement = .bottom
        case .left:
            configuration.imagePlacement = .leading
        case .right:
            configuration.imagePlacement = .trailing
        default:
            configuration.imagePlacement = .leading  // Better default for most cases
        }
        
        // 4. Consistent spacing
        configuration.imagePadding = spacing
        
        self.setTitle(title as String, for: .normal)
        
        // 5. Safe title preservation
        let currentTitle = self.title(for: .normal) ?? ""
        
        // 6. Proper configuration update
        configuration.title = currentTitle
        configuration.image = currentImage
        
        // 7. Apply configuration
        self.configuration = configuration
        
        // 8. Layout handling
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
}

#endif
