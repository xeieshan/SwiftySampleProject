//
//  UIViewController.swift
//  <#Project Name#>
//
//  Created by <#Project Developer#> on 11/03/2016.
//  Copyright © 2016 <#Project Name#>. All rights reserved.
//

import Foundation

extension UIViewController {
    
    // MARK: - UIAlertController
    
    typealias AlertViewDismissHandler = () -> Void
    typealias AlertViewCurrentPasswordConfirmedHandler = (String) -> Void
    
    func showAlertViewWithTitle(title:String,message : String)
    {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    func showAlertViewWithTitle(title:String,message : String, dismissCompletion:@escaping (AlertViewDismissHandler))
    {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { action -> Void in
            //Do some other stuff
             dismissCompletion()
            }))
        present(alertController, animated: true, completion:nil)
    }
    
    func showConfirmationAlertViewWithTitle(title:String,message : String, dismissCompletion:@escaping (AlertViewDismissHandler))
    {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "YES", style: .default, handler: { action -> Void in
            //Do some other stuff
            dismissCompletion()
        }))
        
        alertController.addAction(UIAlertAction(title: "NO", style: .cancel, handler: { action -> Void in
            //Do some other stuff
            
        }))
        
        present(alertController, animated: true, completion:nil)
    }
    
    func showCurrentPasswordConfirmationAlertViewWithTitle(title:String,message : String, dismissCompletion:@escaping (AlertViewCurrentPasswordConfirmedHandler))
    {
        let alertController: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
            dismissCompletion("")
        }
        alertController.addAction(cancelAction)

        let nextAction: UIAlertAction = UIAlertAction(title: "Next", style: .default) { action -> Void in
            let textField:UITextField = (alertController.textFields?.first)!
            dismissCompletion(textField.text!)
            
        }
        alertController.addAction(nextAction)
        alertController.addTextField { textField -> Void in
            textField.placeholder = "Current Password"
            textField.isSecureTextEntry = true
            textField.textColor = UIColor.blue
            textField.addTarget(self, action: Selector(("alertTextFieldDidChange:")), for: UIControlEvents.editingChanged)
        }
        present(alertController, animated: true, completion:nil)

    }
    private func alertTextFieldDidChange(textField:UITextField) -> Void {
        let presentedAlertController:UIAlertController! = self.presentedViewController! as! UIAlertController
        let textField:UITextField! = presentedAlertController.textFields?.first
        let okAction:UIAlertAction! = presentedAlertController.actions.last
        okAction.isEnabled = (textField.text?.length)!>2
        
    }
    
    func showTextInputAlertViewWithTitle(title:String,message : String, dismissCompletion:@escaping (AlertViewCurrentPasswordConfirmedHandler))
    {
        let alertController: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
            dismissCompletion("")
        }
        alertController.addAction(cancelAction)
        
        let nextAction: UIAlertAction = UIAlertAction(title: "Next", style: .default) { action -> Void in
            let textField:UITextField = (alertController.textFields?.first)!
            dismissCompletion(textField.text!)
            
        }
        alertController.addAction(nextAction)
        alertController.addTextField { textField -> Void in
            textField.placeholder = "Enter something"
            textField.textColor = UIColor.black
        }
        present(alertController, animated: true, completion:nil)
        
    }
    
}
