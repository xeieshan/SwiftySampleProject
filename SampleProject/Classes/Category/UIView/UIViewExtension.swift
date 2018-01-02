//
//  UiViewExtension.swift
//  <#Project Name#>
//
//  Created by <#Project Developer#> on 13/11/2015.
//  Copyright © 2015 <#Project Name#>. All rights reserved.
//

import UIKit

// MARK: - Other
extension UIView {
    func applyAllSubviews(_ f: (_ view: UIView) -> ()) {
        for view in subviews {
            f(view)
            view.applyAllSubviews(f)
        }
    }
    
    func applyAllViews(_ f: (_ view: UIView) -> ()) {
        f(self)
        applyAllSubviews(f)
    }
    
    //ANIMATION
    func fadeOut(_ vc:UIViewController,delay:TimeInterval,duration:TimeInterval){
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(duration)
        UIView.setAnimationDelay(delay)
        UIView.setAnimationDelegate(vc)
        self.alpha = 0
        UIView.commitAnimations()
    }
    
    func fadeOut(_ vc:UIViewController,delay:TimeInterval,duration:TimeInterval,completionHandler:(()->Void)?){
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(duration)
        UIView.setAnimationDelay(delay)
        UIView.setAnimationDelegate(vc)
        self.alpha = 0
        UIView.commitAnimations()
    }
    
    func fadeIn(_ vc:UIViewController,delay:TimeInterval,duration:TimeInterval){
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(duration)
        UIView.setAnimationDelay(delay)
        UIView.setAnimationDelegate(vc)
        self.alpha = 1
        UIView.commitAnimations()
    }
    
    func moveView(_ duration:TimeInterval,x:CGFloat,y:CGFloat){
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(duration)
        UIView.setAnimationCurve(UIViewAnimationCurve.easeOut)
        UIView.setAnimationBeginsFromCurrentState(true)
        let transform = CGAffineTransform(translationX: x, y: y)
        self.transform = transform
        self.transform = transform
        self.transform = transform
        UIView.commitAnimations()
    }
    
    //UI
    func addGradientSublayer(topColor:UIColor,bottomColor:UIColor,width:CGFloat,height:CGFloat){
        let gl = CAGradientLayer()
        gl.colors = [topColor.cgColor, bottomColor.cgColor] as [AnyObject]
        gl.frame = CGRect(x: 0, y: 0, width: width, height: height)
        self.layer.insertSublayer(gl, at: 0)
    }
    
    func roundLeftCorners(_ frame:CGRect,radius:CGSize){
        let headerMaskPath = UIBezierPath(roundedRect: frame, byRoundingCorners: [.topLeft, .bottomLeft],
                                          cornerRadii: radius)
        let headerMaskLayer = CAShapeLayer()
        headerMaskLayer.path = headerMaskPath.cgPath
        self.layer.mask = headerMaskLayer
    }
    
    func roundRightCorners(_ frame:CGRect,radius:CGSize){
        let headerMaskPath = UIBezierPath(roundedRect: frame, byRoundingCorners: [.topRight, .bottomRight], cornerRadii: radius)
        let headerMaskLayer = CAShapeLayer()
        headerMaskLayer.path = headerMaskPath.cgPath
        self.layer.mask = headerMaskLayer
    }
    
    func roundAllCorners(_ frame:CGRect,radius:CGSize){
        let headerMaskPath = UIBezierPath(roundedRect: frame, byRoundingCorners: [.topLeft, .bottomLeft, .topRight, .bottomRight],
                                          cornerRadii: radius)
        let headerMaskLayer = CAShapeLayer()
        headerMaskLayer.path = headerMaskPath.cgPath
        self.layer.mask = headerMaskLayer
    }
    
    func roundBotomLeftCorner(_ frame:CGRect,radius:CGSize){
        let headerMaskPath = UIBezierPath(roundedRect: frame, byRoundingCorners: .bottomLeft, cornerRadii: radius)
        let headerMaskLayer = CAShapeLayer()
        headerMaskLayer.path = headerMaskPath.cgPath
        self.layer.mask = headerMaskLayer
    }
    
    func roundBotomRightCorner(_ frame:CGRect,radius:CGSize){
        let headerMaskPath = UIBezierPath(roundedRect: frame, byRoundingCorners: .bottomRight, cornerRadii: radius)
        let headerMaskLayer = CAShapeLayer()
        headerMaskLayer.path = headerMaskPath.cgPath
        self.layer.mask = headerMaskLayer
    }
    
    func roundTopCorners(_ frame:CGRect,radius:CGSize){
        let headerMaskPath = UIBezierPath(roundedRect: frame, byRoundingCorners: [.topLeft, .topRight], cornerRadii: radius)
        let headerMaskLayer = CAShapeLayer()
        headerMaskLayer.path = headerMaskPath.cgPath
        self.layer.mask = headerMaskLayer
    }
    
    func roundSpecifiedCorners(_ frame:CGRect,radius:CGSize, corners:UIRectCorner){
        let headerMaskPath = UIBezierPath(roundedRect: frame, byRoundingCorners: corners, cornerRadii: radius)
        let headerMaskLayer = CAShapeLayer()
        headerMaskLayer.path = headerMaskPath.cgPath
        self.layer.mask = headerMaskLayer
    }
    
}

// MARK: - Animations
/**
 A preset animation behavior.
 */
enum AnimationType {
    case slideLeft, slideRight, slideDown, slideUp, squeezeLeft, squeezeRight, squeezeDown, squeezeUp, fadeIn, fadeOut, fadeOutIn, fadeInLeft, fadeInRight, fadeInDown, fadeInUp, zoomIn, zoomOut, fall, shake, pop, flipX, flipY, morph, squeeze, flash, wobble, swing
    static let allValues = [shake, pop, morph, squeeze, wobble, swing, flipX, flipY, fall, squeezeLeft, squeezeRight, squeezeDown, squeezeUp, slideLeft, slideRight, slideDown, slideUp,  fadeIn, fadeOut, fadeOutIn, fadeInLeft, fadeInRight, fadeInDown, fadeInUp, zoomIn, zoomOut, flash]
}

/**
 Easing curve to be used in animation.
 */
enum AnimationEasingCurve {
    case easeIn, easeOut, easeInOut, linear, easeInSine, easeOutSine, easeInOutSine, easeInQuad, easeOutQuad, easeInOutQuad, easeInCubic, easeOutCubic, easeInOutCubic, easeInQuart, easeOutQuart, easeInOutQuart, easeInQuint, easeOutQuint, easeInOutQuint, easeInExpo, easeOutExpo, easeInOutExpo, easeInCirc, easeOutCirc, easeInOutCirc, easeInBack, easeOutBack, easeInOutBack, spring
    static let allValues = [easeIn, easeOut, easeInOut, linear, easeInSine, easeOutSine, easeInOutSine, easeInQuad, easeOutQuad, easeInOutQuad, easeInCubic, easeOutCubic, easeInOutCubic, easeInQuart, easeOutQuart, easeInOutQuart, easeInQuint, easeOutQuint, easeInOutQuint, easeInExpo, easeOutExpo, easeInOutExpo, easeInCirc, easeOutCirc, easeInOutCirc, easeInBack, easeOutBack, easeInOutBack, spring]
    var timingFunction:CAMediaTimingFunction {
        switch self {
        case .easeIn: return CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        case .easeOut: return CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        case .easeInOut: return CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        case .linear: return CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        case .easeInSine: return CAMediaTimingFunction(controlPoints: 0.47, 0, 0.745, 0.715)
        case .easeOutSine: return CAMediaTimingFunction(controlPoints: 0.39, 0.575, 0.565, 1)
        case .easeInOutSine: return CAMediaTimingFunction(controlPoints: 0.445, 0.05, 0.55, 0.95)
        case .easeInQuad: return CAMediaTimingFunction(controlPoints: 0.55, 0.085, 0.68, 0.53)
        case .easeOutQuad: return CAMediaTimingFunction(controlPoints: 0.25, 0.46, 0.45, 0.94)
        case .easeInOutQuad: return CAMediaTimingFunction(controlPoints: 0.455, 0.03, 0.515, 0.955)
        case .easeInCubic: return CAMediaTimingFunction(controlPoints: 0.55, 0.055, 0.675, 0.19)
        case .easeOutCubic: return CAMediaTimingFunction(controlPoints: 0.215, 0.61, 0.355, 1)
        case .easeInOutCubic: return CAMediaTimingFunction(controlPoints: 0.645, 0.045, 0.355, 1)
        case .easeInQuart: return CAMediaTimingFunction(controlPoints: 0.895, 0.03, 0.685, 0.22)
        case .easeOutQuart: return CAMediaTimingFunction(controlPoints: 0.165, 0.84, 0.44, 1)
        case .easeInOutQuart: return CAMediaTimingFunction(controlPoints: 0.77, 0, 0.175, 1)
        case .easeInQuint: return CAMediaTimingFunction(controlPoints: 0.755, 0.05, 0.855, 0.06)
        case .easeOutQuint: return CAMediaTimingFunction(controlPoints: 0.23, 1, 0.32, 1)
        case .easeInOutQuint: return CAMediaTimingFunction(controlPoints: 0.86, 0, 0.07, 1)
        case .easeInExpo: return CAMediaTimingFunction(controlPoints: 0.95, 0.05, 0.795, 0.035)
        case .easeOutExpo: return CAMediaTimingFunction(controlPoints: 0.19, 1, 0.22, 1)
        case .easeInOutExpo: return CAMediaTimingFunction(controlPoints: 1, 0, 0, 1)
        case .easeInCirc: return CAMediaTimingFunction(controlPoints: 0.6, 0.04, 0.98, 0.335)
        case .easeOutCirc: return CAMediaTimingFunction(controlPoints: 0.075, 0.82, 0.165, 1)
        case .easeInOutCirc: return CAMediaTimingFunction(controlPoints: 0.785, 0.135, 0.15, 0.86)
        case .easeInBack: return CAMediaTimingFunction(controlPoints: 0.6, -0.28, 0.735, 0.045)
        case .easeOutBack: return CAMediaTimingFunction(controlPoints: 0.175, 0.885, 0.32, 1.275)
        case .easeInOutBack: return CAMediaTimingFunction(controlPoints: 0.68, -0.55, 0.265, 1.55)
        case .spring: return CAMediaTimingFunction(controlPoints: 0.5, 1.1+Float(1/3), 1, 1)
        }
    }
    var animationOption:UIViewAnimationOptions {
        switch self {
        case .easeIn: return UIViewAnimationOptions.curveEaseIn
        case .easeOut: return UIViewAnimationOptions.curveEaseOut
        case .easeInOut: return UIViewAnimationOptions()
        default: return UIViewAnimationOptions.curveLinear
        }
    }
}

extension UIView {
    
    typealias AnimationCompletionHandler = () -> Void
    
    /**
     Animates using a predermined animation type and provides optional properties for customization.
     
     - Parameter animationType: The Animation type to use.
     - Parameter curve: The animation easing curve.
     - Parameter duration: The duration of the animation.
     - Parameter delay: The delay before animation begins.
     - Parameter force: The force of the movement.
     - Parameter damping: The damping of the force.
     - Parameter velocity: The velocity of the movement.
     - Parameter distance: The distance that it travels, like in the case of SlideLeft
     - Parameter fromRotation: The starting rotation.
     - Parameter fromScale: The starting scale.
     - Parameter fromX: The starting x offset.
     - Parameter fromY: The starting y offset.
     - Parameter completion: The completion handler that runs after animation is complete.
     */
    
    func animate(_ animationType:AnimationType, curve:AnimationEasingCurve, duration:CGFloat = 1, delay:CGFloat = 0, force:CGFloat = 1, damping:CGFloat = 0.7, velocity:CGFloat = 0.7, distance:CGFloat = 300.0, fromRotation rotate:CGFloat = 0, fromScale scale:CGFloat = 1, fromX x:CGFloat = 0, fromY y:CGFloat = 0, completion: AnimationCompletionHandler? = nil)
    {
        var rotate = rotate, x = x, y = y
        var scaleX:CGFloat = scale
        var scaleY:CGFloat = scale
        var opacity:CGFloat = 0
        let repeatCount:Float = 1
        
        var animateFromInitialState = true
        
        alpha = 0.99
        
        switch animationType {
        case .slideLeft:
            x = distance*force
        case .slideRight:
            x = -distance*force
        case .slideDown:
            y = -distance*force
        case .slideUp:
            y = distance*force
        case .squeezeLeft:
            x = distance
            scaleX = 3*force
        case .squeezeRight:
            x = -distance
            scaleX = 3*force
        case .squeezeDown:
            y = -distance
            scaleY = 3*force
        case .squeezeUp:
            y = distance
            scaleY = 3*force
        case .fadeIn:
            opacity = 0
        case .fadeOut:
            animateFromInitialState = false
            opacity = 0
        case .fadeOutIn:
            let animation = CABasicAnimation()
            animation.keyPath = "opacity"
            animation.fromValue = 1
            animation.toValue = 0
            animation.timingFunction = curve.timingFunction
            animation.duration = CFTimeInterval(duration)
            animation.beginTime = CACurrentMediaTime() + CFTimeInterval(delay)
            animation.autoreverses = true
            layer.add(animation, forKey: "fade")
        case .fadeInLeft:
            opacity = 0
            x = distance*force
        case .fadeInRight:
            x = -distance*force
            opacity = 0
        case .fadeInDown:
            y = -distance*force
            opacity = 0
        case .fadeInUp:
            y = distance*force
            opacity = 0
        case .zoomIn:
            opacity = 0
            scaleX = 2*force
            scaleY = 2*force
        case .zoomOut:
            animateFromInitialState = false
            opacity = 0
            scaleX = 2*force
            scaleY = 2*force
        case .fall:
            animateFromInitialState = false
            rotate = 15 * CGFloat(Double.pi/180)
            y = distance*force
        case .shake:
            let animation = CAKeyframeAnimation()
            animation.keyPath = "position.x"
            animation.values = [0, 30*force, -30*force, 30*force, 0]
            animation.keyTimes = [0, 0.2, 0.4, 0.6, 0.8, 1]
            animation.timingFunction = curve.timingFunction
            animation.duration = CFTimeInterval(duration)
            animation.isAdditive = true
            animation.repeatCount = repeatCount
            animation.beginTime = CACurrentMediaTime() + CFTimeInterval(delay)
            layer.add(animation, forKey: "shake")
        case .pop:
            let animation = CAKeyframeAnimation()
            animation.keyPath = "transform.scale"
            animation.values = [0, 0.2*force, -0.2*force, 0.2*force, 0]
            animation.keyTimes = [0, 0.2, 0.4, 0.6, 0.8, 1]
            animation.timingFunction = curve.timingFunction
            animation.duration = CFTimeInterval(duration)
            animation.isAdditive = true
            animation.repeatCount = repeatCount
            animation.beginTime = CACurrentMediaTime() + CFTimeInterval(delay)
            layer.add(animation, forKey: "pop")
        case .flipX:
            rotate = 0
            scaleX = 1
            scaleY = 1
            var perspective = CATransform3DIdentity
            perspective.m34 = -1.0 / layer.frame.size.width/2
            
            let animation = CABasicAnimation()
            animation.keyPath = "transform"
            animation.fromValue = NSValue(caTransform3D:
                CATransform3DMakeRotation(0, 0, 0, 0))
            animation.toValue = NSValue(caTransform3D:
                CATransform3DConcat(perspective, CATransform3DMakeRotation(CGFloat(Double.pi), 0, 1, 0)))
            animation.duration = CFTimeInterval(duration)
            animation.beginTime = CACurrentMediaTime() + CFTimeInterval(delay)
            animation.timingFunction = curve.timingFunction
            layer.add(animation, forKey: "3d")
        case .flipY:
            var perspective = CATransform3DIdentity
            perspective.m34 = -1.0 / layer.frame.size.width/2
            
            let animation = CABasicAnimation()
            animation.keyPath = "transform"
            animation.fromValue = NSValue(caTransform3D:
                CATransform3DMakeRotation(0, 0, 0, 0))
            animation.toValue = NSValue(caTransform3D:
                CATransform3DConcat(perspective,CATransform3DMakeRotation(CGFloat(Double.pi), 1, 0, 0)))
            animation.duration = CFTimeInterval(duration)
            animation.beginTime = CACurrentMediaTime() + CFTimeInterval(delay)
            animation.timingFunction = curve.timingFunction
            layer.add(animation, forKey: "3d")
        case .morph:
            let morphX = CAKeyframeAnimation()
            morphX.keyPath = "transform.scale.x"
            morphX.values = [1, 1.3*force, 0.7, 1.3*force, 1]
            morphX.keyTimes = [0, 0.2, 0.4, 0.6, 0.8, 1]
            morphX.timingFunction = curve.timingFunction
            morphX.duration = CFTimeInterval(duration)
            morphX.repeatCount = repeatCount
            morphX.beginTime = CACurrentMediaTime() + CFTimeInterval(delay)
            layer.add(morphX, forKey: "morphX")
            
            let morphY = CAKeyframeAnimation()
            morphY.keyPath = "transform.scale.y"
            morphY.values = [1, 0.7, 1.3*force, 0.7, 1]
            morphY.keyTimes = [0, 0.2, 0.4, 0.6, 0.8, 1]
            morphY.timingFunction = curve.timingFunction
            morphY.duration = CFTimeInterval(duration)
            morphY.repeatCount = repeatCount
            morphY.beginTime = CACurrentMediaTime() + CFTimeInterval(delay)
            layer.add(morphY, forKey: "morphY")
        case .squeeze:
            let morphX = CAKeyframeAnimation()
            morphX.keyPath = "transform.scale.x"
            morphX.values = [1, 1.5*force, 0.5, 1.5*force, 1]
            morphX.keyTimes = [0, 0.2, 0.4, 0.6, 0.8, 1]
            morphX.timingFunction = curve.timingFunction
            morphX.duration = CFTimeInterval(duration)
            morphX.repeatCount = repeatCount
            morphX.beginTime = CACurrentMediaTime() + CFTimeInterval(delay)
            layer.add(morphX, forKey: "morphX")
            
            let morphY = CAKeyframeAnimation()
            morphY.keyPath = "transform.scale.y"
            morphY.values = [1, 0.5, 1, 0.5, 1]
            morphY.keyTimes = [0, 0.2, 0.4, 0.6, 0.8, 1]
            morphY.timingFunction = curve.timingFunction
            morphY.duration = CFTimeInterval(duration)
            morphY.repeatCount = repeatCount
            morphY.beginTime = CACurrentMediaTime() + CFTimeInterval(delay)
            layer.add(morphY, forKey: "morphY")
        case .flash:
            let animation = CABasicAnimation()
            animation.keyPath = "opacity"
            animation.fromValue = 1
            animation.toValue = 0
            animation.duration = CFTimeInterval(duration)
            animation.repeatCount = repeatCount * 2.0
            animation.autoreverses = true
            animation.beginTime = CACurrentMediaTime() + CFTimeInterval(delay)
            layer.add(animation, forKey: "flash")
        case .wobble:
            let animation = CAKeyframeAnimation()
            animation.keyPath = "transform.rotation"
            animation.values = [0, 0.3*force, -0.3*force, 0.3*force, 0]
            animation.keyTimes = [0, 0.2, 0.4, 0.6, 0.8, 1]
            animation.duration = CFTimeInterval(duration)
            animation.isAdditive = true
            animation.beginTime = CACurrentMediaTime() + CFTimeInterval(delay)
            layer.add(animation, forKey: "wobble")
            
            let x = CAKeyframeAnimation()
            x.keyPath = "position.x"
            x.values = [0, 30*force, -30*force, 30*force, 0]
            x.keyTimes = [0, 0.2, 0.4, 0.6, 0.8, 1]
            x.timingFunction = curve.timingFunction
            x.duration = CFTimeInterval(duration)
            x.isAdditive = true
            x.repeatCount = repeatCount
            x.beginTime = CACurrentMediaTime() + CFTimeInterval(delay)
            layer.add(x, forKey: "x")
        case .swing:
            let animation = CAKeyframeAnimation()
            animation.keyPath = "transform.rotation"
            animation.values = [0, 0.3*force, -0.3*force, 0.3*force, 0]
            animation.keyTimes = [0, 0.2, 0.4, 0.6, 0.8, 1]
            animation.duration = CFTimeInterval(duration)
            animation.isAdditive = true
            animation.beginTime = CACurrentMediaTime() + CFTimeInterval(delay)
            layer.add(animation, forKey: "swing")
        }
        
        if animateFromInitialState {
            let translate = CGAffineTransform(translationX: x, y: y)
            let scale = CGAffineTransform(scaleX: scaleX, y: scaleY)
            let rotate = CGAffineTransform(rotationAngle: rotate)
            let translateAndScale = translate.concatenating(scale)
            self.transform = rotate.concatenating(translateAndScale)
            alpha = opacity
        }
        
        UIView.animate( withDuration: TimeInterval(duration),
                        delay: TimeInterval(delay),
                        usingSpringWithDamping: damping,
                        initialSpringVelocity: velocity,
                        options: [curve.animationOption, UIViewAnimationOptions.allowUserInteraction],
                        animations: { [weak self] in
                            if let _self = self {
                                if animateFromInitialState {
                                    _self.transform = CGAffineTransform.identity
                                    _self.alpha = 1
                                } else {
                                    let translate = CGAffineTransform(translationX: x, y: y)
                                    let scale = CGAffineTransform(scaleX: scaleX, y: scaleY)
                                    let rotate = CGAffineTransform(rotationAngle: rotate)
                                    let translateAndScale = translate.concatenating(scale)
                                    _self.transform = rotate.concatenating(translateAndScale)
                                    _self.alpha = opacity
                                }
                            }
            }, completion: { finished in
                completion?()
        })
    }
}

// MARK: - UIView IBInspectable
extension UIView {
    
    @IBInspectable var shadowColor: UIColor {
        get {
            return UIColor(cgColor: layer.shadowColor!)
        }
        set {
            layer.shadowColor = shadowColor.cgColor
        }
    }
    
    @IBInspectable var shouldRasterize: Bool {
        get {
            return layer.shouldRasterize
        }
        set {
            layer.shouldRasterize = shouldRasterize;
            if shouldRasterize{
                layer.rasterizationScale = UIScreen.main.scale
            }
        }
    }
    
    @IBInspectable var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = shadowOpacity
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = shadowRadius
        }
    }
    
    @IBInspectable var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = shadowOffset
        }
    }
    
    @IBInspectable var masksToBounds: Bool {
        get {
            return layer.masksToBounds
        }
        set {
            layer.masksToBounds = masksToBounds;
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    @IBInspectable var leftBorderWidth: CGFloat {
        get {
            return 0.0   // Just to satisfy property
        }
        set {
            let line = UIView(frame: CGRect(x: 0.0, y: 0.0, width: newValue, height: bounds.height))
            line.translatesAutoresizingMaskIntoConstraints = false
            line.backgroundColor = UIColor(cgColor: layer.borderColor!)
            self.addSubview(line)
            
            let views = ["line": line]
            let metrics = ["lineWidth": newValue]
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "|[line(==lineWidth)]", options: [], metrics: metrics, views: views))
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[line]|", options: [], metrics: nil, views: views))
        }
    }
    
    @IBInspectable var topBorderWidth: CGFloat {
        get {
            return 0.0   // Just to satisfy property
        }
        set {
            let line = UIView(frame: CGRect(x: 0.0, y: 0.0, width: bounds.width, height: newValue))
            line.translatesAutoresizingMaskIntoConstraints = false
            line.backgroundColor = borderColor
            self.addSubview(line)
            
            let views = ["line": line]
            let metrics = ["lineWidth": newValue]
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "|[line]|", options: [], metrics: nil, views: views))
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[line(==lineWidth)]", options: [], metrics: metrics, views: views))
        }
    }
    
    @IBInspectable var rightBorderWidth: CGFloat {
        get {
            return 0.0   // Just to satisfy property
        }
        set {
            let line = UIView(frame: CGRect(x: bounds.width, y: 0.0, width: newValue, height: bounds.height))
            line.translatesAutoresizingMaskIntoConstraints = false
            line.backgroundColor = borderColor
            self.addSubview(line)
            
            let views = ["line": line]
            let metrics = ["lineWidth": newValue]
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "[line(==lineWidth)]|", options: [], metrics: metrics, views: views))
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[line]|", options: [], metrics: nil, views: views))
        }
    }
    @IBInspectable var bottomBorderWidth: CGFloat {
        get {
            return 0.0   // Just to satisfy property
        }
        set {
            let line = UIView(frame: CGRect(x: 0.0, y: bounds.height, width: bounds.width, height: newValue))
            line.translatesAutoresizingMaskIntoConstraints = false
            line.backgroundColor = borderColor
            self.addSubview(line)
            
            let views = ["line": line]
            let metrics = ["lineWidth": newValue]
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "|[line]|", options: [], metrics: nil, views: views))
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[line(==lineWidth)]|", options: [], metrics: metrics, views: views))
        }
    }
    
}

/*
 // Top Left Square
 let topLeftSquare = UIView(autoLayout:true)
 bigCircle.addSubview(topLeftSquare)
 topLeftSquare.backgroundColor = UIColor(white: 0.1, alpha: 1)
 topLeftSquare
 .left(to: bigCircle)
 .top(to: bigCircle)
 .width(to: bigCircle, attribute: .Width, constant: 0, multiplier: 0.48)
 .height(to: topLeftSquare, attribute: .Width)
 .layoutIfNeeded()
 
 // Top Right Square
 let topRightSquare = UIView(autoLayout:true)
 bigCircle.addSubview(topRightSquare)
 topRightSquare.backgroundColor = UIColor(white: 0.1, alpha: 1)
 topRightSquare
 .right(to: bigCircle)
 .top(to: bigCircle)
 .size(to: topLeftSquare)
 .layoutIfNeeded()
 
 // Bottom Left Square
 let bottomLeftSquare = UIView(autoLayout:true)
 bigCircle.addSubview(bottomLeftSquare)
 bottomLeftSquare.backgroundColor = UIColor(white: 0.1, alpha: 1)
 bottomLeftSquare
 .left(to: bigCircle)
 .bottom(to: bigCircle)
 .size(to: topLeftSquare)
 .layoutIfNeeded()
 
 
 // Bottom Right Square
 let bottomRightSquare = UIView(autoLayout:true)
 bigCircle.addSubview(bottomRightSquare)
 bottomRightSquare.backgroundColor = UIColor(white:0.1, alpha: 1)
 bottomRightSquare
 .right(to: bigCircle)
 .bottom(to: bigCircle)
 .size(to: topLeftSquare)
 .layoutIfNeeded()
 */

import Foundation
import UIKit

extension UIView {
    
    // MARK: Init
    
    /**
     Instantiates a new UIView with Auto Layout
     
     - Parameter autoLayout Enables Auto Layout.
     - Returns: self
     */
    convenience init(autoLayout: Bool = true)
    {
        self.init(frame:CGRect.zero)
        self.translatesAutoresizingMaskIntoConstraints = !(autoLayout)
    }
    
    // MARK: Position
    
    /**
     Returns the frame's origin
     */
    
    func origin() -> CGPoint { return frame.origin }
    
    /**
     Sets the frame's top and left sides using Auto Layout or frames
     
     - Parameter constant: The CGPoint to ise as the origin
     - Returns: self
     */
    func origin(_ constant: CGPoint) -> UIView {
        if translatesAutoresizingMaskIntoConstraints {
            frame.origin = constant
            return self
        } else {
            return origin(to: superview!, constant: constant)
        }
    }
    /**
     Pins left and top sides to another view using Auto Layout
     
     - Parameter to: The view to pin to
     - Parameter constant: The offset to use after multiplication is done.
     - Parameter multiplier: The multiplier to use, i.e. 0.5 is half.
     - Returns: self UIView
     */
    func origin(to:AnyObject, constant: CGPoint = CGPoint(x: 0, y: 0), multiplier:CGFloat = 1) -> UIView {
        var constraints = [NSLayoutConstraint]()
        if let left = pin(.left, to: to, attribute: .left, constant: constant.x, multiplier: multiplier) {
            constraints.append(left)
        }
        if let top = pin(.top, to: to, attribute: .top, constant: constant.y, multiplier: multiplier) {
            constraints.append(top)
        }
        return self
    }
    
    /**
     Returns the frame minimum x point
     */
    func left() -> CGFloat { return frame.origin.x }
    
    /**
     Sets the frame left side using Auto Layout or frames
     
     - Parameter constant: The value to use.
     - Returns: self
     */
    func left(_ constant: CGFloat) -> UIView {
        if translatesAutoresizingMaskIntoConstraints {
            frame.origin.x = constant
            return self
        } else {
            return left(to: superview!, attribute: .left, constant: constant)
        }
    }
    
    /**
     Pins left side to another view using Auto Layout
     
     - Parameter to: The view to pin to
     - Parameter attribute: The attribute to pin to
     - Parameter constant: The offset to use after multiplication is done.
     - Parameter multiplier: The multiplier to use, i.e. 0.5 is half.
     - Returns: self
     */
    func left(to:AnyObject, attribute: NSLayoutAttribute = .left, constant: CGFloat = 0, multiplier:CGFloat = 1) -> UIView {
        _ = pin(.left, to: to, attribute: attribute, constant: constant, multiplier: multiplier)
        return self
    }
    
    /**
     Returns the frame leading value
     */
    func leading() -> CGFloat { return layoutDirectionIsLeftToRight() ? left() : right() }
    
    /**
     Sets the frame leading side using Auto Layout or frames
     
     - Parameter constant: The value to use.
     - Returns: self
     */
    func leading(_ constant: CGFloat) -> UIView {
        if translatesAutoresizingMaskIntoConstraints {
            return layoutDirectionIsLeftToRight() ? left(constant) : right(constant)
        } else {
            return leading(to: superview!, attribute: .leading, constant: constant)
        }
    }
    
    /**
     Pins the frame leading side to another view using Auto Layout
     
     - Parameter to: The view to pin to
     - Parameter attribute: The attribute to pin to
     - Parameter constant: The offset to use after multiplication is done.
     - Parameter multiplier: The multiplier to use, i.e. 0.5 is half.
     - Returns: self
     */
    func leading(to:AnyObject, attribute: NSLayoutAttribute = .leading, constant: CGFloat = 0, multiplier:CGFloat = 1) -> UIView {
        _ = pin(.leading, to: to, attribute: attribute, constant: constant, multiplier: multiplier)
        return self
    }
    
    /**
     Returns the frame max x point
     */
    func right() -> CGFloat { return frame.origin.x + frame.size.width }
    
    /**
     Sets the frame right side using Auto Layout or frames
     
     - Parameter constant: The value to use.
     - Returns: self
     */
    func right(_ constant: CGFloat) -> UIView  {
        if translatesAutoresizingMaskIntoConstraints {
            return left(constant - width)
        } else {
            return right(to: superview!, attribute: .right, constant: constant)
        }
    }
    /**
     Pins the frame right side to another view using Auto Layout
     
     - Parameter to: The view to pin to
     - Parameter attribute: The attribute to pin to
     - Parameter constant: The offset to use after multiplication is done.
     - Parameter multiplier: The multiplier to use, i.e. 0.5 is half.
     - Returns: self
     */
    func right(to:AnyObject, attribute: NSLayoutAttribute = .right, constant: CGFloat = 0, multiplier:CGFloat = 1) -> UIView {
        _ = pin(.right, to: to, attribute: attribute, constant: constant, multiplier: multiplier)
        return self
    }
    
    /**
     Returns the frame trailing value
     */
    func trailing() -> CGFloat { return layoutDirectionIsLeftToRight() ? right() : left() }
    
    /**
     Sets the frame trailing side using Auto Layout or frames
     
     - Parameter constant: The value to use
     - Returns: self UIView
     */
    func trailing(_ constant: CGFloat) -> UIView {
        if translatesAutoresizingMaskIntoConstraints {
            return layoutDirectionIsLeftToRight() ? right(constant) : left(constant)
        } else {
            return trailing(to: superview!, attribute: .trailing, constant: constant)
        }
    }
    
    /**
     Pins the frame trailing side to another view using Auto Layout
     
     - Parameter to: The view to pin to
     - Parameter attribute: The attribute to pin to
     - Parameter constant: The offset to use after multiplication is done.
     - Parameter multiplier: The multiplier to use, i.e. 0.5 is half.
     - Returns: self
     */
    func trailing(to:AnyObject, attribute: NSLayoutAttribute = .trailing, constant: CGFloat = 0, multiplier:CGFloat = 1) -> UIView {
        _ = pin(.trailing, to: to, attribute: attribute, constant: constant, multiplier: multiplier)
        return self
    }
    
    /**
     Returns the frame top value
     */
    func top() -> CGFloat { return frame.origin.y }
    
    /**
     Sets the frame top side using Auto Layout or frames
     
     - Parameter constant: The value to use.
     - Returns: self
     */
    func top(_ constant: CGFloat) -> UIView {
        if translatesAutoresizingMaskIntoConstraints {
            frame.origin.y = constant
            return self
        } else {
            return top(to: superview!, attribute: .top, constant: constant)
        }
    }
    
    /**
     Pins the frame trailing side to another view using Auto Layout
     
     - Parameter to: The view to pin to
     - Parameter attribute: The attribute to pin to
     - Parameter constant: The offset to use after multiplication is done.
     - Parameter multiplier: The multiplier to use, i.e. 0.5 is half.
     - Returns: self
     */
    func top(to:AnyObject, attribute: NSLayoutAttribute = .top, constant: CGFloat = 0, multiplier:CGFloat = 1) -> UIView {
        _ = pin(.top, to: to, attribute: attribute, constant: constant, multiplier: multiplier)
        return self
    }
    
    /**
     Returns the frame bottom value
     */
    func bottomY() -> CGFloat { return top() + height }
    
    /**
     Sets the frame bottom side using Auto Layout or frames
     
     - Parameter constant: The value to use.
     - Returns: self
     */
    func bottom(_ constant: CGFloat) -> UIView {
        if translatesAutoresizingMaskIntoConstraints {
            return top(constant - height)
        } else {
            return bottom(to: superview!, attribute: .bottom, constant: constant)
        }
    }
    /**
     Pins the frame bottom side to another view using Auto Layout
     
     - Parameter to: The view to pin to
     - Parameter attribute: The attribute to pin to
     - Parameter constant: The offset to use after multiplication is done.
     - Parameter multiplier: The multiplier to use, i.e. 0.5 is half.
     - Returns: self
     */
    func bottom(to:AnyObject, attribute: NSLayoutAttribute = .bottom, constant: CGFloat = 0, multiplier:CGFloat = 1) -> UIView {
        _ = pin(.bottom, to: to, attribute: attribute, constant: constant, multiplier: multiplier)
        return self
    }
    
    /**
     Sets the center to it's superview using Auto Layout or frames
     
     - Parameter constant: The value to use.
     - Returns: self
     */
    func center(_ constant: CGPoint = CGPoint(x: 0, y: 0)) -> UIView {
        if translatesAutoresizingMaskIntoConstraints {
            center = constant
        } else {
            _ = centerX(constant.x)
            _ = centerY(constant.y)
        }
        return self
    }
    
    /**
     Pins the center point to another view using Auto Layout
     
     - Parameter to: The view to pin to
     - Parameter constant: The offset to use after multiplication is done.
     - Parameter multiplier: The multiplier to use, i.e. 0.5 is half.
     - Returns: self
     */
    func center(to:AnyObject, constant:CGSize = CGSize(width: 0, height: 0), multiplier:CGFloat = 1) -> UIView  {
        var constraints = [NSLayoutConstraint]()
        if let centerX = pin(.centerX, to: superview!, attribute: .centerX, constant: constant.width, multiplier: multiplier) {
            constraints.append(centerX)
        }
        if let centerY = pin(.centerY, to: superview!, attribute: .centerY, constant: constant.height, multiplier: multiplier) {
            constraints.append(centerY)
        }
        return self
    }
    
    /**
     Returns the center X
     */
    func centerX() -> CGFloat { return center.x }
    
    /**
     Sets the center X using Auto Layout or frames
     
     - Parameter constant: The value to use.
     - Returns: self
     */
    func centerX(_ constant: CGFloat = 0) -> UIView {
        if translatesAutoresizingMaskIntoConstraints {
            center = CGPoint(x: superview!.width/2 + constant , y: center.y)
        } else {
            _ = pin(.centerX, to: superview!, attribute: .centerX, constant: constant)
        }
        return self
    }
    
    /**
     Pins the center X to another view using Auto Layout
     
     - Parameter to: The view to pin to
     - Parameter attribute: The attribute to pin to
     - Parameter constant: The offset to use after multiplication is done.
     - Parameter multiplier: The multiplier to use, i.e. 0.5 is half.
     - Returns: self
     */
    func centerX(to:AnyObject, attribute: NSLayoutAttribute = .centerX, constant: CGFloat = 0, multiplier:CGFloat = 1) -> UIView {
        _ = pin(.centerX, to: to, attribute: attribute, constant: constant, multiplier: multiplier)
        return self
    }
    
    /**
     Returns the center Y
     */
    func centerY() -> CGFloat { return center.y }
    
    /**
     Sets the center Y using Auto Layout or frames
     
     - Parameter constant: The value to use.
     - Returns: self
     */
    func centerY(_ constant: CGFloat = 0) -> UIView {
        if translatesAutoresizingMaskIntoConstraints {
            center = CGPoint(x: superview!.center.x, y: CGFloat(superview!.height/2) + constant)
        } else {
            _ = pin(.centerY, to: superview!, attribute: .centerY, constant: constant)
        }
        return self
    }
    
    /**
     Pins the center Y to another view using Auto Layout
     
     - Parameter to: The view to pin to
     - Parameter attribute: The attribute to pin to
     - Parameter constant: The offset to use after multiplication is done.
     - Parameter multiplier: The multiplier to use, i.e. 0.5 is half.
     - Returns: self
     */
    func centerY(to:AnyObject, attribute: NSLayoutAttribute = .centerY, constant: CGFloat = 0, multiplier:CGFloat = 1) -> UIView {
        _ = pin(.centerY, to: superview!, attribute: attribute, constant: constant)
        return self
    }
    
    // MARK: Compression and Hugging Priority
    
    /**
     Returns the Compression Resistance Priority for Horizontal Axis using Auto Layout
     */
    func horizontalCompressionPriority() -> UILayoutPriority { return contentCompressionResistancePriority(for: .horizontal) }
    
    /**
     Sets the Compression Resistance Priority for Horizontal Axis using Auto Layout
     
     - Returns: self
     */
    func horizontalCompressionPriority(_ priority: UILayoutPriority) -> UIView {
        if !translatesAutoresizingMaskIntoConstraints {
            setContentCompressionResistancePriority(priority, for: .horizontal)
        }
        return self
    }
    
    /**
     Returns the Compression Resistance Priority for Vertical Axis using Auto Layout
     */
    func verticalCompressionPriority() -> UILayoutPriority { return contentCompressionResistancePriority(for: .vertical) }
    
    /**
     Sets the Compression Resistance Priority for Vertical Axis using Auto Layout
     
     - Returns: self
     */
    func verticalCompressionPriority(_ priority: UILayoutPriority) -> UIView {
        if !translatesAutoresizingMaskIntoConstraints {
            setContentCompressionResistancePriority(priority, for: .vertical)
        }
        return self
    }
    
    /**
     Returns the Content Hugging Priority for Horizontal Axis using Auto Layout
     */
    func horizontalHuggingPriority() -> UILayoutPriority { return contentHuggingPriority(for: .horizontal) }
    
    /**
     Sets the Content Hugging Priority for Horizontal Axis using Auto Layout
     
     - Returns: self
     */
    func horizontalHuggingPriority(_ priority: UILayoutPriority) -> UIView {
        if !translatesAutoresizingMaskIntoConstraints {
            setContentHuggingPriority(priority, for: .horizontal)
        }
        return self
    }
    
    /**
     Returns the Content Hugging Priority for Vertical Axis using Auto Layout
     */
    func verticalHuggingPriority() -> UILayoutPriority { return contentHuggingPriority(for: .vertical) }
    
    /**
     Sets the Content Hugging Priority for Vertical Axis using Auto Layout
     
     - Returns: self
     */
    func verticalHuggingPriority(_ priority: UILayoutPriority) -> UIView {
        if !translatesAutoresizingMaskIntoConstraints {
            setContentHuggingPriority(priority, for: .vertical)
        }
        return self
    }
    
    
    // MARK: Size
    
    
    /**
     Sets the frame size using Auto Layout or frames
     
     - Parameter constant: The value to use.
     - Returns: self UIView
     */
    func size(_ constant: CGSize) -> UIView {
        if translatesAutoresizingMaskIntoConstraints {
            frame.size = constant
        } else {
            _ = applyAttribute(.width, constant: constant.width)
            _ = applyAttribute(.height, constant: constant.height)
        }
        return self
    }
    
    /**
     Pins the size to another view using Auto Layout
     
     - Parameter to: The view to pin to
     - Parameter constant: The offset to use after multiplication is done.
     - Parameter multiplier: The multiplier to use, i.e. 0.5 is half.
     - Returns: self
     */
    func size(to:AnyObject, constant: CGSize = CGSize(width: 0, height: 0), multiplier:CGFloat = 1) -> UIView {
        if !translatesAutoresizingMaskIntoConstraints {
            var constraints = [NSLayoutConstraint]()
            if let width = pin(.width, to: to, attribute: .width, constant: constant.width, multiplier: multiplier) {
                constraints.append(width)
            }
            if let height = pin(.height, to: to, attribute: .height, constant: constant.height, multiplier: multiplier) {
                constraints.append(height)
            }
        }
        return self
    }
    
    
    /**
     Sets the frame width using Auto Layout or frames
     
     - Parameter constant: The value to use.
     - Returns: self
     */
    func width(_ constant: CGFloat) -> UIView {
        if translatesAutoresizingMaskIntoConstraints {
            frame.size.width = constant
        } else {
            _ = applyAttribute(.width, constant: constant)
        }
        return self
    }
    
    /**
     Pins the width to another view using Auto Layout
     
     - Parameter to: The view to pin to
     - Parameter attribute: The attribute to pin to
     - Parameter constant: The offset to use after multiplication is done.
     - Parameter multiplier: The multiplier to use, i.e. 0.5 is half.
     - Returns: self
     */
    func width(to:AnyObject, attribute: NSLayoutAttribute = .width, constant: CGFloat = 0, multiplier:CGFloat = 1) -> UIView {
        if !translatesAutoresizingMaskIntoConstraints {
            _ = pin(.width, to: to, attribute: attribute, constant: constant, multiplier: multiplier)
        }
        return self
    }
    
    
    /**
     Sets the frame height using Auto Layout or frames
     
     - Parameter constant: The value to use.
     - Returns: self UIView
     */
    func height(_ constant: CGFloat) -> UIView {
        if translatesAutoresizingMaskIntoConstraints {
            frame.size.height = constant
        } else {
            _ = applyAttribute(.height, constant: constant)
        }
        return self
    }
    
    /**
     Pins the height to another view using Auto Layout
     
     - Parameter to: The view to pin to
     - Parameter attribute: The attribute to pin to
     - Parameter constant: The offset to use after multiplication is done.
     - Parameter multiplier: The multiplier to use, i.e. 0.5 is half.
     - Returns: self
     */
    func height(to:AnyObject, attribute: NSLayoutAttribute = .height, constant: CGFloat = 0, multiplier:CGFloat = 1) -> UIView {
        if !translatesAutoresizingMaskIntoConstraints {
            _ = pin(.height, to: to, attribute: attribute, constant: constant, multiplier: multiplier)
        }
        return self
    }
    
    /**
     Returns the minimum size using Auto Layout
     */
    func minSize() -> CGSize? {
        if !translatesAutoresizingMaskIntoConstraints {
            if let minWidth = minWidth() {
                if let minHeight = minHeight() {
                    return CGSize(width: minWidth, height: minHeight)
                }
            }
        }
        return nil
    }
    
    /**
     Sets the minimum size using Auto Layout
     
     - Parameter constant: The value to use.
     - Returns: self
     */
    func minSize(_ constant:CGSize) -> UIView {
        if !translatesAutoresizingMaskIntoConstraints {
            _ = applyAttribute(.width, constant: constant.width, multiplier: 1, relation: .greaterThanOrEqual)
            _ = applyAttribute(.height, constant: constant.height, multiplier: 1, relation: .greaterThanOrEqual)
        }
        return self
    }
    
    /**
     Pins the minimum size to another view using Auto Layout
     
     - Parameter to: The view to pin to
     - Parameter constant: The offset to use after multiplication is done.
     - Parameter multiplier: The multiplier to use, i.e. 0.5 is half.
     - Returns: self
     */
    func minSize(to:AnyObject, constant:CGSize = CGSize(width: 0, height: 0), multiplier:CGFloat = 1) -> UIView {
        if !translatesAutoresizingMaskIntoConstraints {
            var constraints = [NSLayoutConstraint]()
            if let width = pin(.width, to: to, attribute: .width, constant: constant.width, multiplier: multiplier, relation: .greaterThanOrEqual) {
                constraints.append(width)
            }
            if let height = pin(.width, to: to, attribute: .height, constant: constant.height, multiplier: multiplier, relation: .greaterThanOrEqual) {
                constraints.append(height)
            }
        }
        return self
    }
    
    /**
     Returns the minimum width using Auto Layout
     */
    func minWidth() -> CGFloat? {
        if !translatesAutoresizingMaskIntoConstraints {
            for constrain in constraints {
                if constrain.firstAttribute == .width && constrain.firstItem as! NSObject == self && constrain.secondItem == nil && constrain.relation == .greaterThanOrEqual {
                    return constrain.constant
                }
            }
        }
        return nil
    }
    
    /**
     Sets the minimum width using Auto Layout
     
     - Parameter constant: The value to use.
     - Returns: self
     */
    func minWidth(_ constant:CGFloat) -> UIView {
        if !translatesAutoresizingMaskIntoConstraints {
            _ = applyAttribute(.width, constant: constant, multiplier: 1, relation: .greaterThanOrEqual)
        }
        return self
    }
    
    /**
     Pins the minimum width to another view using Auto Layout
     
     - Parameter to: The view to pin to
     - Parameter attribute: The attribute to pin to
     - Parameter constant: The offset to use after multiplication is done.
     - Parameter multiplier: The multiplier to use, i.e. 0.5 is half.
     - Returns: self
     */
    func minWidth(to:AnyObject, attribute: NSLayoutAttribute = .width, constant:CGFloat = 0, multiplier:CGFloat = 1) -> UIView {
        if !translatesAutoresizingMaskIntoConstraints {
            _ = pin(.width, to: to, attribute: attribute, constant: constant, multiplier: multiplier, relation: .greaterThanOrEqual)
        }
        return self
    }
    
    /**
     Returns the minimum height using Auto Layout
     */
    func minHeight() -> CGFloat? {
        if !translatesAutoresizingMaskIntoConstraints {
            for constrain in constraints {
                if constrain.firstAttribute == .height && constrain.firstItem as! NSObject == self && constrain.secondItem == nil && constrain.relation == .greaterThanOrEqual {
                    return constrain.constant
                }
            }
        }
        return nil
    }
    
    /**
     Sets the minimum height using Auto Layout
     
     - Parameter constant: The value to use.
     - Returns: self
     */
    func minHeight(_ constant:CGFloat) -> UIView {
        if !translatesAutoresizingMaskIntoConstraints {
            _ = applyAttribute(.height, constant: constant, multiplier: 1, relation: .greaterThanOrEqual)
        }
        return self
    }
    
    /**
     Pins the minimum height to another view using Auto Layout
     
     - Parameter to: The view to pin to
     - Parameter attribute: The attribute to pin to
     - Parameter constant: The offset to use after multiplication is done.
     - Parameter multiplier: The multiplier to use, i.e. 0.5 is half.
     - Returns: self
     */
    func minHeight(to:AnyObject, attribute: NSLayoutAttribute = .height, constant:CGFloat = 0, multiplier:CGFloat = 1) -> UIView {
        if !translatesAutoresizingMaskIntoConstraints {
            _ = pin(.height, to: to, attribute: attribute, constant: constant, multiplier: multiplier, relation: .greaterThanOrEqual)
        }
        return self
    }
    
    /**
     Returns the maximun size using Auto Layout
     */
    func maxSize() -> CGSize? {
        if !translatesAutoresizingMaskIntoConstraints {
            if let maxWidth = maxWidth() {
                if let maxHeight = maxHeight() {
                    return CGSize(width: maxWidth, height: maxHeight)
                }
            }
        }
        return nil
    }
    
    /**
     Sets the maximun size using Auto Layout
     
     - Parameter constant: The value to use.
     - Returns: self
     */
    func maxSize(_ constant:CGSize) -> UIView {
        if !translatesAutoresizingMaskIntoConstraints {
            _ = applyAttribute(.width, constant: constant.width, multiplier: 1, relation: .lessThanOrEqual)
            _ = applyAttribute(.height, constant: constant.height, multiplier: 1, relation: .lessThanOrEqual)
        }
        return self
    }
    
    /**
     Pins the maximun size to another view using Auto Layout
     
     - Parameter to: The view to pin to
     - Parameter constant: The offset to use after multiplication is done.
     - Parameter multiplier: The multiplier to use, i.e. 0.5 is half.
     - Returns: self
     */
    func maxSize(to:AnyObject, constant:CGSize = CGSize(width: 0, height: 0), multiplier:CGFloat = 1) -> UIView {
        if !translatesAutoresizingMaskIntoConstraints {
            var constraints = [NSLayoutConstraint]()
            if let width = pin(.width, to: to, attribute: .width, constant: constant.width, multiplier: multiplier, relation: .lessThanOrEqual) {
                constraints.append(width)
            }
            if let height = pin(.width, to: to, attribute: .height, constant: constant.height, multiplier: multiplier, relation: .lessThanOrEqual) {
                constraints.append(height)
            }
        }
        return self
    }
    
    /**
     Returns the maximun width using Auto Layout
     */
    func maxWidth() -> CGFloat? {
        if !translatesAutoresizingMaskIntoConstraints {
            for constrain in constraints {
                if constrain.firstAttribute == .width && constrain.firstItem as! NSObject == self && constrain.secondItem == nil && constrain.relation == .lessThanOrEqual {
                    return constrain.constant
                }
            }
        }
        return nil
    }
    
    /**
     Sets the maximun width using Auto Layout
     
     - Parameter constant: The value to use.
     - Returns: self
     */
    func maxWidth(_ constant:CGFloat) -> UIView {
        if !translatesAutoresizingMaskIntoConstraints {
            _ = applyAttribute(.width, constant: constant, multiplier: 1, relation: .lessThanOrEqual)
        }
        return self
    }
    
    /**
     Pins the maximun width to another view using Auto Layout
     
     - Parameter to: The view to pin to
     - Parameter attribute: The attribute to pin to
     - Parameter constant: The offset to use after multiplication is done.
     - Parameter multiplier: The multiplier to use, i.e. 0.5 is half.
     - Returns: self
     */
    func maxWidth(to:AnyObject, attribute: NSLayoutAttribute = .width, constant:CGFloat = 0, multiplier:CGFloat = 1) -> UIView {
        if !translatesAutoresizingMaskIntoConstraints {
            _ = pin(.width, to: to, attribute: attribute, constant: constant, multiplier: multiplier, relation: .lessThanOrEqual)
        }
        return self
    }
    
    /**
     Returns the maximun height using Auto Layout
     */
    func maxHeight() -> CGFloat? {
        if !translatesAutoresizingMaskIntoConstraints {
            for constrain in constraints {
                if constrain.firstAttribute == .height && constrain.firstItem as! NSObject == self && constrain.secondItem == nil && constrain.relation == .lessThanOrEqual {
                    return constrain.constant
                }
            }
        }
        return nil
    }
    
    /**
     Sets the maximun height using Auto Layout
     
     - Parameter constant: The value to use.
     - Returns: self
     */
    func maxHeight(_ constant:CGFloat) -> UIView {
        if !translatesAutoresizingMaskIntoConstraints {
            _ = applyAttribute(.height, constant: constant, multiplier: 1, relation: .lessThanOrEqual)
        }
        return self
    }
    
    /**
     Pins the maximun height to another view using Auto Layout
     
     - Parameter to: The view to pin to
     - Parameter attribute: The attribute to pin to
     - Parameter constant: The offset to use after multiplication is done.
     - Parameter multiplier: The multiplier to use, i.e. 0.5 is half.
     - Returns: self
     */
    func maxHeight(to:AnyObject, attribute: NSLayoutAttribute = .height, constant:CGFloat = 0, multiplier:CGFloat = 1) -> UIView {
        if !translatesAutoresizingMaskIntoConstraints {
            _ = pin(.height, to: to, attribute: attribute, constant: constant, multiplier: multiplier, relation: .lessThanOrEqual)
        }
        return self
    }
    
    /**
     Returns the length of the smallest side
     */
    func smallestSideLength() -> CGFloat
    {
        return min(width, height)
    }
    
    /**
     Returns the length of the largest side
     */
    func largestSideLength() -> CGFloat
    {
        return max(width, height)
    }
    
    
    // MARK: AutoLayout state
    
    /**
     Prepares the view for a frame based animation by removing the view, enabling translatesAutoresizingMaskIntoConstraints and re-adding the view to it's superview
     */
    func prepForAnimation()
    {
        if superview != nil {
            let aSuperview = superview!
            removeFromSuperview()
            translatesAutoresizingMaskIntoConstraints = true
            aSuperview.addSubview(self)
        }
    }
    
    /**
     Prepares the view for Auto Layout by removing the view, disabling translatesAutoresizingMaskIntoConstraints and re-adding the view to it's superview
     */
    func prepForAutoLayout()
    {
        if superview != nil {
            let aSuperview = superview!
            removeFromSuperview()
            translatesAutoresizingMaskIntoConstraints = false
            aSuperview.addSubview(self)
        }
    }
    
    
    // MARK: Pin and Apply
    
    /**
     Pins an attribute to another view
     
     - Parameter pinAttribute: The View's attribut to pin
     - Parameter to: The view to pin to
     - Parameter attribute: The Attribute to pin to
     - Parameter constant: The offset to use after multiplication is done.
     - Parameter multiplier: The multiplier to use, i.e. 0.5 is half.
     - Parameter relation: The Relation to use
     - Returns: NSLayoutConstraint
     */
    func pin(_ pinAttribute:NSLayoutAttribute, to:AnyObject? = nil, attribute:NSLayoutAttribute, constant:CGFloat = 0, multiplier:CGFloat = 1, relation:NSLayoutRelation = .equal) -> NSLayoutConstraint? {
        if !translatesAutoresizingMaskIntoConstraints {
            if self.superview == nil {
                print("WARNING: No superview found for pinning")
                return nil
            }
            var superview: UIView!
            if (to != nil) {
                superview = to is UIView ? commonSuperviewWithView(to! as! UIView)! : self.superview
            } else {
                superview = self.superview
            }
            let constraint = NSLayoutConstraint(item: self, attribute: pinAttribute, relatedBy: relation, toItem: to, attribute: attribute, multiplier: multiplier, constant: constant)
            superview?.addConstraint(constraint)
            return constraint
        }
        return nil
    }
    
    /**
     Applies an attribute to the view
     
     - Parameter attribute:  Attribute to apply
     - Parameter constant: The offset to use after multiplication is done.
     - Parameter multiplier: The multiplier to use, i.e. 0.5 is half.
     - Parameter relation: The Relation to use
     - Returns: NSLayoutConstraint
     */
    func applyAttribute(_ attribute:NSLayoutAttribute, constant:CGFloat = 0, multiplier: CGFloat = 1, relation:NSLayoutRelation = .equal) -> NSLayoutConstraint  {
        let constraint = NSLayoutConstraint(item: self, attribute: attribute, relatedBy: relation, toItem: nil, attribute: .notAnAttribute, multiplier: multiplier, constant: constant)
        addConstraint(constraint)
        return constraint
    }
    
    // MARK: Removing Constraints
    
    /**
     Removes all attached constraints recursevely
     
     - Returns: self
     */
    func removeAttachedConstraintsRecursevely() -> UIView
    {
        for constraint in constraints {
            print("constraint \(constraint)")
            _ = removeConstraintRecursevely(constraint )
        }
        for constraint in superview!.constraints {
            let firstView = constraint.firstItem as! UIView
            if let _ = constraint.secondItem as? UIView {
                if firstView == self {
                    _ = firstView.removeConstraintRecursevely(constraint )
                }
            }
        }
        return self
    }
    
    /**
     Removes a constraint recursevely
     
     - Returns: self
     */
    func removeConstraintRecursevely(_ constraint:NSLayoutConstraint) -> UIView
    {
        let firstView = constraint.firstItem as! UIView
        if constraint.secondItem != nil {
            var commonSuperview = firstView.commonSuperviewWithView(constraint.secondItem as! UIView)
            var constraintFound = false
            while constraintFound == false {
                for _ in commonSuperview!.constraints {
                    constraintFound = true
                }
                if constraintFound == true {
                    commonSuperview!.removeConstraint(constraint)
                    return self
                }
                commonSuperview = commonSuperview?.superview
            }
        } else {
            constraint.firstItem?.removeConstraint(constraint)
        }
        return self
    }
    
    
    // MARK: Direction
    
    /**
     Returns true if layout direction is left to right
     */
    func layoutDirectionIsLeftToRight() -> Bool {
        return (UIApplication.shared.userInterfaceLayoutDirection == .leftToRight)
    }
    
    
    
    // MARK: Private
    
    /**
     Finds the nearest common superview
     
     - Returns: UIVIew?
     */
    fileprivate func commonSuperviewWithView(_ view:UIView) -> UIView?
    {
        var commonSuperview: UIView? = nil
        var checkView: UIView? = self
        repeat {
            if view.isDescendant(of: checkView!) {
                commonSuperview = checkView!
            }
            checkView = checkView!.superview
        } while (checkView) != nil
        return commonSuperview
    }
    
}
