//
//  BaseViewController.swift
//  <#Project Name#>
//
//  Created by <#Project Developer#> on 29/02/2016.
//  Copyright © 2016 <#Project Name#>. All rights reserved.
//
import Foundation
import UIKit
import MessageUI

enum UINavigationBarRightButtonType : Int {
    case none
    case search
    case tick
    case done
    case add
    case addfriends
    case share
}

enum UINavigationBarLeftButtonType : Int {
    case none
    case back
    case menu
    case cross
}

protocol BaseViewControllerDelegate {
    func rightNavigationBarButtonClicked()
    func leftNavigationBarButtonClicked()
}
class BaseViewController: UIViewController {
    var baseDelegate: BaseViewControllerDelegate?
    var leftButton: UIButton?
    var rightButton: UIButton?
    var rightbtnItem: UIBarButtonItem?
    var leftbtnItem:  UIBarButtonItem?
    var leftbtnType:  UINavigationBarLeftButtonType?
    var rightbtnType: UINavigationBarRightButtonType?
    //    var mySearchBar  : UISearchBar?
    
    
    
    func backViewController() -> UIViewController {
        let numberOfViewControllers: Int = self.navigationController!.viewControllers.count
        if numberOfViewControllers >= 2 {
            return self.navigationController!.viewControllers[numberOfViewControllers - 2]
        }
        return self.navigationController!.viewControllers[numberOfViewControllers-1]
    }
    
    func setupNavigationBarTitle(_ title: String, showRightButton: Bool, leftButtonType: UINavigationBarLeftButtonType, rightButtonType: UINavigationBarRightButtonType) {
        self.hideNavigationBar(false)
        self.leftbtnType = leftButtonType
        self.rightbtnType = rightButtonType
        if showRightButton {
            self.rightButton = UIButton.init(type: UIButton.ButtonType.custom)
            if rightButtonType == .addfriends {
                self.rightButton!.frame = CGRect(x: 0, y: 0, width: 100, height: 24)
                UtilityHelper.setViewBorder(self.rightButton!, withWidth: 5, andColor: UIColor.white)
                self.rightButton?.cornerRadius =  3.0
                self.rightButton!.setTitle(rightButtonType == .addfriends ? "ADD FRIENDS" : "", for: UIControl.State())
                self.rightButton!.titleLabel!.font = UIConfiguration.getUIFONTBOLD(sizeFont: 12)
            }
            else if rightButtonType == .none {
                self.navigationItem.rightBarButtonItem = nil
            }
            else
            {
                let optionsImage: UIImage! = ((rightButtonType == .tick) ? UIImage(named: "tick_thin"): (rightButtonType == .add) ? UIImage(named: "add-icon") :(rightButtonType == .search) ? UIImage(named: "search-white") : (rightButtonType == .share) ? UIImage(named: "share-white-icon") : nil )
                self.rightButton = UIButton(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
                self.rightButton?.setImage(optionsImage, for: UIControl.State())
            }
            self.rightButton!.addTarget(self, action: #selector(BaseViewController.rightNavigationButtonClicked(_:)), for: .touchUpInside)
            self.rightButton?.contentMode = .scaleAspectFit
            self.rightbtnItem = UIBarButtonItem(customView: rightButton!)
            
            let negativeSpacer: UIBarButtonItem? = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
            negativeSpacer?.width = ConstantDevices.IS_IOS_6 ? -6 : -8
            
            self.navigationItem.setRightBarButtonItems([negativeSpacer!, rightbtnItem!], animated: false)
        }
            
        else {
            self.rightButton?.isHidden = true
        }
        if leftButtonType == .none {
            self.navigationItem.leftBarButtonItem = nil
            //            self.navigationItem.setLeftBarButtonItems([], animated: false)
        }else{
            self.leftButton = UIButton.init(type: UIButton.ButtonType.custom)
            let menuImage: UIImage? = ((leftButtonType == .menu) ? UIImage(named: "check-sign") : (leftButtonType == .back) ? UIImage(named: "back-icon") : (leftButtonType == .cross) ? UIImage(named: "cross_thin"): nil)
            //Get Images from UIConfiguration
            self.leftButton!.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
            self.leftButton!.addTarget(self, action: #selector(BaseViewController.leftNavigationButtonClicked(_:)), for: .touchUpInside)
            self.leftButton!.setImage(menuImage, for: UIControl.State())
            self.leftbtnItem = UIBarButtonItem(customView: self.leftButton!)
            let negativeSpacer: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
            negativeSpacer.width = ConstantDevices.IS_IOS_6 ? -6 : -16
            self.navigationItem.setLeftBarButtonItems([negativeSpacer, self.leftbtnItem!], animated: false)
        }
        //        if title != NSNull() {
        //            self.navigationItem.title = title
        //        }
        if title.length > 0 {
            self.navigationItem.title = title
        }
    }
    
    func setupNavigationBarWithTitleImage(_ imageName: String, showBackButtonIfNeeded show: Bool) {
        self.hideNavigationBar(false)
        let barImageView: UIImageView = UIImageView(image: UIImage(named: "check-sign"))
        self.navigationItem.titleView = barImageView
        self.showBackButtonIfNeeded(show)
    }
    
    func changeButtonColor(_ color: UIColor) {
        self.leftButton!.backgroundColor = color
    }
    @available(iOS, deprecated: 9.0)
    func hideStatusBar(_ hide: Bool) {
        
        UIApplication.shared.setStatusBarHidden(hide, with: .none)
        
    }
    
    func hideNavigationBar(_ hide: Bool) {
        self.navigationController!.isNavigationBarHidden = hide
    }
    
    func goBackToIndex(_ backIndex: Int) {
        self.goBackToIndex(backIndex, animated: true)
    }
    
    func goBackToIndex(_ backIndex: Int, animated animate: Bool) {
        if (self.navigationController!.viewControllers.count - backIndex) > 0 {
            let controller: BaseViewController = (self.navigationController!.viewControllers[(self.navigationController!.viewControllers.count - 1 - backIndex)] as! BaseViewController)
            self.navigationController!.popToViewController(controller, animated: animate)
        }
    }
    
    func logoutToLoginViewController() {
        self.navigationController!.popToRootViewController(animated: true)
        //    [UtilityFunctions setValueInUserDefaults:@(NO) forKey:@"user"];
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.interactivePopGestureRecognizer!.delegate = nil
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.baseDelegate = nil
    }
    //
    
    @objc func rightNavigationButtonClicked(_ sender: AnyObject) {
        NSLog("Right Navigation Button Clicked")
        self.baseDelegate?.rightNavigationBarButtonClicked()
    }
    
    @objc func leftNavigationButtonClicked(_ sender: AnyObject) {
        NSLog("Left Navigation Button Clicked")
        self.baseDelegate?.leftNavigationBarButtonClicked()
    }
    
    func btnMenuClicked() {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func showBackButtonIfNeeded(_ show: Bool) {
        if show {
            let backBarImage: UIImage = (self.navigationController!.viewControllers.count > 1 ? UIConfiguration.NavBarBackImage : UIConfiguration.NavBarMenuImage)!
            self.leftButton = UIButton(frame: CGRect(x: 0, y: 0, width: backBarImage.size.width, height: backBarImage.size.height))
            self.leftButton!.addTarget(self, action: #selector(BaseViewController.leftNavigationButtonClicked(_:)), for: .touchUpInside)
            self.leftButton!.setImage(backBarImage, for: UIControl.State())
            let backbtnItem: UIBarButtonItem = UIBarButtonItem(customView: self.leftButton!)
            self.navigationItem.leftBarButtonItem = backbtnItem
        }
    }
    
}
