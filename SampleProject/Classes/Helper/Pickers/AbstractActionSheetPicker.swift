//
//Copyright (c) 2011, Tim Cinel
//All rights reserved.
//
//Redistribution and use in source and binary forms, with or without
//modification, are permitted provided that the following conditions are met:
//* Redistributions of source code must retain the above copyright
//notice, this list of conditions and the following disclaimer.
//* Redistributions in binary form must reproduce the above copyright
//notice, this list of conditions and the following disclaimer in the
//documentation and/or other materials provided with the distribution.
//* Neither the name of the <organization> nor the
//names of its contributors may be used to endorse or promote products
//derived from this software without specific prior written permission.
//
//THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
//ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
//WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
//DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT HOLDER> BE LIABLE FOR ANY
//DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
//(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
//LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
//ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
//(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
//SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
import Foundation
import UIKit
//#define SuppressPerformSelectorLeakWarning(Stuff) \
func () {
    ("clang diagnostic push")\
    Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"")\
    Pragma("clang diagnostic pop")\
}

func () {
    (0)
enum ActionType : Int {
        case Value
        case Selector
        case Block
}
enum TapAction : Int {
        case None
        case Success
        case Cancel
}
    var ActionBlock
    let kButtonValue: String = "buttonValue"
    let kButtonTitle: String = "buttonTitle"
    let kActionType: String = "buttonAction"
    let kActionTarget: String = "buttonActionTarget"
}

class AbstractActionSheetPicker: NSObject, UIPopoverControllerDelegate {
    var actionSheet: SWActionSheet
    var tag: Int
    var borderWidth: Int
    var toolbar: UIToolbar
    var title: String
    var pickerView: UIView
    var viewSize: CGSize {
        get {
            return self.viewSize
        }
    }

    var customButtons: [AnyObject] {
        get {
            if !customButtons {
                self.customButtons = [AnyObject]()
            }
            return customButtons
        }
    }

    var hideCancel: Bool
    // show or hide cancel button.
    var presentFromRect: CGRect
    var titleTextAttributes: [NSObject : AnyObject]
    // default is nil. Used to specify Title Label attributes.
    var attributedTitle: NSAttributedString
    // default is nil. If titleTextAttributes not nil this value ignored.
    var popoverBackgroundViewClass: AnyClass
    //allow popover customization on iPad
    var supportedInterfaceOrientations: UIInterfaceOrientationMask
    // You can set your own supportedInterfaceOrientations value to prevent dismissing picker in some special cases.
    var tapDismissAction: TapAction
    // Specify, which action should be fired in case of tapping outside of the picker (on top darkened side)
    // For subclasses.

    convenience override init(target: AnyObject, successAction: Selector, cancelAction cancelActionOrNil: Selector, origin: AnyObject) {
        self = self()
        if self != nil {
            self.target = target
            self.successAction = successAction
            self.cancelAction = cancelActionOrNil
            if (origin is UIBarButtonItem.self) {
                self.barButtonItem = origin
            }
            else if (origin is UIView.self) {
                self.containerView = origin
            }
            else {
                assert(false, "Invalid origin provided to ActionSheetPicker ( %@ )", origin)
            }
        }
    }
    // Present the ActionSheetPicker

    func showActionSheetPicker() {
        var masterView: UIView = UIView(frame: CGRectMake(0, 0, self.viewSize.width, 260))
        // to fix bug, appeared only on iPhone 4 Device: https://github.com/skywinder/ActionSheetPicker-3.0/issues/5
        if isIPhone4() {
            masterView.backgroundColor = UIColor(red: 0.97, green: 0.97, blue: 0.97, alpha: 1.0)
        }
        self.toolbar = self.createPickerToolbarWithTitle(self.title)
        masterView.addSubview(self.toolbar)
        //ios7 picker draws a darkened alpha-only region on the first and last 8 pixels horizontally, but blurs the rest of its background.  To make the whole popup appear to be edge-to-edge, we have to add blurring to the remaining left and right edges.
        if NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1 {
            var rect: CGRect = CGRectMake(0, self.toolbar.frame.origin.y, borderWidth, masterView.frame.size.height - self.toolbar.frame.origin.y)
            var leftEdge: UIToolbar = UIToolbar(frame: rect)
            rect.origin.x = masterView.frame.size.width - borderWidth
            var rightEdge: UIToolbar = UIToolbar(frame: rect)
            leftEdge.barTintColor = rightEdge.barTintColor = self.toolbar.barTintColor
            masterView.insertSubview(leftEdge, atIndex: 0)
            masterView.insertSubview(rightEdge, atIndex: 0)
        }
        self.pickerView = self.configuredPickerView()
        assert(pickerView != nil, "Picker view failed to instantiate, perhaps you have invalid component data.")
        // toolbar hidden remove the toolbar frame and update pickerview frame
        if self.toolbar.hidden {
            var halfWidth: Int = Int(borderWidth * 0.5)
            masterView.frame = CGRectMake(0, 0, self.viewSize.width, 220)
            self.pickerView.frame = CGRectMake(0, halfWidth, self.viewSize.width, 220 - halfWidth)
        }
        masterView.addSubview(pickerView)
        self.presentPickerForView(masterView)
        if UIViewController.instancesRespondToSelector("edgesForExtendedLayout") {
            switch self.tapDismissAction {
                case .None:
                    break
                case .Success:
                                        // add tap dismiss action
                    self.actionSheet.window.userInteractionEnabled = true
                    var tapAction: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "actionPickerDone:")
                    self.actionSheet.window.addGestureRecognizer(tapAction)

                case .Cancel:
                                        // add tap dismiss action
                    self.actionSheet.window.userInteractionEnabled = true
                    var tapAction: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "actionPickerCancel:")
                    self.actionSheet.window.addGestureRecognizer(tapAction)

            }
        }
    }
    // For subclasses.  This is used to send a message to the target upon a successful selection and dismissal of the picker (i.e. not canceled).

    func notifyTarget(target: AnyObject, didSucceedWithAction successAction: Selector, origin: AnyObject) {
        assert(false, "This is an abstract class, you must use a subclass of AbstractActionSheetPicker (like ActionSheetStringPicker)")
    }
    // For subclasses.  This is an optional message upon cancelation of the picker.

    func notifyTarget(target: AnyObject, didCancelWithAction cancelAction: Selector, origin: AnyObject) {
        if target && cancelAction && target.respondsToSelector(cancelAction) {
            target.performSelector(cancelAction, withObject: origin)
        }
    }
    // For subclasses.  This returns a configured picker view.  Subclasses should autorelease.

    func configuredPickerView() -> UIView {
        assert(false, "This is an abstract class, you must use a subclass of AbstractActionSheetPicker (like ActionSheetStringPicker)")
        return nil
    }
    // Adds custom buttons to the left of the UIToolbar that select specified values

    func addCustomButtonWithTitle(title: String, value: AnyObject) {
        if !title {
            title = ""
        }
        if !value {
            value = 0
        }
        var buttonDetails: [NSObject : AnyObject] = [kButtonTitle: title, kActionType: .Value, kButtonValue: value]
        self.customButtons.append(buttonDetails)
    }
    // Adds custom buttons to the left of the UIToolbar that implement specified block

    func addCustomButtonWithTitle(title: String, actionBlock block: ActionBlock) {
        if !title {
            title = ""
        }
        if !block {
            block = ({() -> Void in
            })
        }
        var buttonDetails: [NSObject : AnyObject] = [kButtonTitle: title, kActionType: .Block, kButtonValue: block.copy()]
        self.customButtons.append(buttonDetails)
    }
    // Adds custom buttons to the left of the UIToolbar that implement specified selector

    func addCustomButtonWithTitle(title: String, target: AnyObject, selector: Selector) {
        if !title {
            title = ""
        }
        if !target {
            target = NSNull()
        }
        var buttonDetails: [NSObject : AnyObject] = [kButtonTitle: title, kActionType: .Selector, kActionTarget: target, kButtonValue: NSValue(pointer: selector)]
        self.customButtons.append(buttonDetails)
    }
    //For subclasses. This responds to a custom button being pressed.

    @IBAction func customButtonPressed(sender: AnyObject) {
        var button: UIBarButtonItem = (sender as! UIBarButtonItem)
        var index: Int = button.tag
        assert((index >= 0 && index < self.customButtons.count), "Bad custom button tag: %ld, custom button count: %lu", Int(index), UInt(self.customButtons.count))
        var buttonDetails: [NSObject : AnyObject] = (self.customButtons)[Int(index)]
        assert(buttonDetails != nil, "Custom button dictionary is invalid")
        var actionType: ActionType = (CInteger(buttonDetails[kActionType])! as! ActionType)
        switch actionType {
            case .Value:
                                self.pickerView

        }

    }
    // Allow the user to specify a custom cancel button

    func setCancelButton(button: UIBarButtonItem) {
    }
    // Allow the user to specify a custom done button

    func setDoneButton(button: UIBarButtonItem) {
    }
    // Hide picker programmatically

    func hidePickerWithCancelAction() {
    }

    convenience override init() {
        self.init()
        if self != nil {
            self.presentFromRect = CGRectZero
            self.popoverBackgroundViewClass = nil
            if UIApplication.instancesRespondToSelector("supportedInterfaceOrientationsForWindow:") {
                self.supportedInterfaceOrientations = (UIApplication.sharedApplication().supportedInterfaceOrientationsForWindow(UIApplication.sharedApplication().keyWindow) as! UIInterfaceOrientationMask)
            }
            else {
                self.supportedInterfaceOrientations = (1 << .Portrait) | (1 << .LandscapeLeft) | (1 << .LandscapeRight)
                if IS_IPAD {
                    self.supportedInterfaceOrientations |= (1 << .PortraitUpsideDown)
                }
            }
            var sysDoneButton: UIBarButtonItem = self.createButtonWithType(.Done, target: self, action: "actionPickerDone:")
            var sysCancelButton: UIBarButtonItem = self.createButtonWithType(.Cancel, target: self, action: "actionPickerCancel:")
            self.cancelBarButtonItem = sysCancelButton
            self.doneBarButtonItem = sysDoneButton
            self.tapDismissAction = .None
            //allows us to use this without needing to store a reference in calling class
            self.selfReference = self
        }
    }

    func dealloc() {
        //need to clear picker delegates and datasources, otherwise they may call this object after it's gone
        if self.pickerView.respondsToSelector("setDelegate:") {
            self.pickerView.performSelector("setDelegate:", withObject: nil)
        }
        if self.pickerView.respondsToSelector("setDataSource:") {
            self.pickerView.performSelector("setDataSource:", withObject: nil)
        }
        if self.pickerView.respondsToSelector("removeTarget:action:forControlEvents:") {
            ((self.pickerView as! UIControl)).removeTarget(nil, action: nil, forControlEvents: .AllEvents)
        }
        self.target = nil
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }

    @IBAction func actionPickerDone(sender: AnyObject) {
        self.notifyTarget(self.target, didSucceedWithAction: self.successAction, origin: self.storedOrigin())
        self.dismissPicker()
    }

    @IBAction func actionPickerCancel(sender: AnyObject) {
        self.notifyTarget(self.target, didCancelWithAction: self.cancelAction, origin: self.storedOrigin())
        self.dismissPicker()
    }

    func dismissPicker() {
        if self.actionSheet {
            if self.actionSheet && self.actionSheet.isVisible() {
                actionSheet!.dismissWithClickedButtonIndex(0, animated: true)
            }
            else if self.popOverController && self.popOverController.popoverVisible {
                popOverController.dismissPopoverAnimated(true)
            }
        }
        self.actionSheet = nil
        self.popOverController = nil
        self.selfReference = nil
    }
    func () {
        "customButtonPressed not overridden, cannot interact with subclassed pickerView"
        var buttonValue: Int = CInteger(buttonDetails[kButtonValue])!
        var picker: UIPickerView = (self.pickerView as! UIPickerView)
        assert(picker != nil, "PickerView is invalid")
        picker.selectRow(buttonValue, inComponent: 0, animated: true)
        if self.respondsToSelector("pickerView:didSelectRow:inComponent:") {
            Void(objc_msgSendTyped)
            // sending Integers as params
            objc_msgSendTyped(self, "pickerView:didSelectRow:inComponent:", picker, buttonValue, 0)
        }
    }

    var barButtonItem: UIBarButtonItem
    var doneBarButtonItem: UIBarButtonItem
    var cancelBarButtonItem: UIBarButtonItem
    var containerView: UIView
    var target: AnyObject
    var successAction: Selector
    var cancelAction: Selector
    var popOverController: UIPopoverController
    var selfReference: NSObject

    func presentPickerForView(aView: UIView) {
    }

    func configureAndPresentPopoverForView(aView: UIView) {
    }

    func configureAndPresentActionSheetForView(aView: UIView) {
    }

    func presentActionSheet(actionSheet: SWActionSheet) {
    }

    func presentPopover(popover: UIPopoverController) {
    }

    func dismissPicker() {
    }

    func isViewPortrait() -> Bool {
    }

    func isValidOrigin(origin: AnyObject) -> Bool {
    }

    func storedOrigin() -> AnyObject {
    }

    func createPickerToolbarWithTitle(aTitle: String) -> UIToolbar {
    }

    func createButtonWithType(type: UIBarButtonSystemItem, target: AnyObject, action buttonAction: Selector) -> UIBarButtonItem {
    }

    @IBAction func actionPickerDone(sender: AnyObject) {
    }

    @IBAction func actionPickerCancel(sender: AnyObject) {
    }
}
//
//Copyright (c) 2011, Tim Cinel
//All rights reserved.
//
//Redistribution and use in source and binary forms, with or without
//modification, are permitted provided that the following conditions are met:
//* Redistributions of source code must retain the above copyright
//notice, this list of conditions and the following disclaimer.
//* Redistributions in binary form must reproduce the above copyright
//notice, this list of conditions and the following disclaimer in the
//documentation and/or other materials provided with the distribution.
//* Neither the name of the <organization> nor the
//names of its contributors may be used to endorse or promote products
//derived from this software without specific prior written permission.
//
//THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
//ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
//WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
//DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT HOLDER> BE LIABLE FOR ANY
//DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
//(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
//LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
//ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
//(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
//SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//

import ObjectiveC
import sys
func isIPhone4() -> CG_INLINE BOOL {
        var systemInfo: structutsname
    uname(systemInfo)
    var modelName: String = String.stringWithCString(systemInfo.machine, encoding: NSUTF8StringEncoding)
    return (modelName.rangeOfString("iPhone3").location != NSNotFound)
}

let IS_WIDESCREEN = (fabs(Double(UIScreen.mainScreen().bounds.size.height) - Double(568)) < DBL_EPSILON)
let DEVICE_ORIENTATION = UIDevice.currentDevice().orientation
// UIInterfaceOrientationMask vs. UIInterfaceOrientation
// As far as I know, a function like this isn't available in the API. I derived this from the enum def for
// UIInterfaceOrientationMask.
//#define OrientationMaskSupportsOrientation(mask, orientation)   ((mask & (1 << orientation)) != 0)
var actionBlock: ActionBlock = buttonDetails[kButtonValue]

func () {
                var selector: Selector = buttonDetails[kButtonValue].pointerValue()
        var target: AnyObject = buttonDetails[kActionTarget]
        self.dismissPicker()
        if target && target.respondsToSelector(selector) {
            target.performSelector(selector)
        }

    assert(false, "Unknown action type")
}

func () {
    var setCancelButton
}

func button() {
    if !button {
        self.hideCancel = true
        return
    }
    if (button.customView is UIButton.self) {
        var uiButton: UIButton = (button.customView as! UIButton)
        uiButton.addTarget(self, action: "actionPickerCancel:", forControlEvents: .TouchUpInside)
    }
    else {
        button.target = self
        button.action = "actionPickerCancel:"
    }
    self.cancelBarButtonItem = button
}

func () {
    var setDoneButton
}

func button() {
    if (button.customView is UIButton.self) {
        var uiButton: UIButton = (button.customView as! UIButton)
        button.action = "actionPickerDone:"
        uiButton.addTarget(self, action: "actionPickerDone:", forControlEvents: .TouchUpInside)
    }
    else {
        button.target = self
        button.action = "actionPickerDone:"
    }
    button.target = self
    button.action = "actionPickerDone:"
    self.doneBarButtonItem = button
}

func () {
    var hidePickerWithCancelAction
}

func () {
}

func () {
}

func title() {
    var frame: CGRect = CGRectMake(0, 0, self.viewSize.width, 44)
    var pickerToolbar: UIToolbar = UIToolbar(frame: frame)
    pickerToolbar.barStyle = (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1) ? .Default : .BlackTranslucent
    var barItems: [AnyObject] = [AnyObject]()
    if !self.hideCancel {
        barItems.append(self.cancelBarButtonItem)
    }
    var index: Int = 0
    for buttonDetails: [NSObject : AnyObject] in self.customButtons {
        var buttonTitle: String = buttonDetails[kButtonTitle]
        var button: UIBarButtonItem
        if NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1 {
            button = UIBarButtonItem(title: buttonTitle, style: .Plain, target: self, action: "customButtonPressed:")
        }
        else {
            button = UIBarButtonItem(title: buttonTitle, style: .Bordered, target: self, action: "customButtonPressed:")
        }
        button.tag = index
        barItems.append(button)
        index++
    }
    var flexSpace: UIBarButtonItem = self.createButtonWithType(.FlexibleSpace, target: nil, action: nil)
    barItems.append(flexSpace)
    if title != "" {
        var labelButton: UIBarButtonItem
        labelButton = self.createToolbarLabelWithTitle(title, titleTextAttributes: self.titleTextAttributes, andAttributedTitle: self.attributedTitle)
        barItems.append(labelButton)
        barItems.append(flexSpace)
    }
    barItems.append(self.doneBarButtonItem)
    pickerToolbar.setItems(barItems, animated: false)
    return pickerToolbar
}

func () {
}

func () {
    var titleTextAttributes: aTitle
    var andAttributedTitle: titleTextAttributes
}

func attributedTitle() {
    var toolBarItemLabel: UILabel = UILabel(frame: CGRectMake(0, 0, 180, 30))
    toolBarItemLabel.textAlignment = .Center
    toolBarItemLabel.backgroundColor = UIColor.clearColor()
        var strikeWidth: CGFloat
        var textSize: CGSize
    if titleTextAttributes != nil {
        toolBarItemLabel.attributedText = NSAttributedString(string: aTitle, attributes: titleTextAttributes)
        textSize = toolBarItemLabel.attributedText.size
    }
    else if attributedTitle != nil {
        toolBarItemLabel.attributedText = attributedTitle
        textSize = toolBarItemLabel.attributedText.size
    }
    else {
        toolBarItemLabel.textColor = (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1) ? UIColor.blackColor() : UIColor.whiteColor()
        toolBarItemLabel.font = UIFont.boldSystemFontOfSize(16)
        toolBarItemLabel.text = aTitle
        if NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1 {
            textSize = toolBarItemLabel.text().sizeWithAttributes([NSFontAttributeName: toolBarItemLabel.font()])
        }
        else {
            textSize = toolBarItemLabel.text().sizeWithFont(toolBarItemLabel.font())
        }
    }

    strikeWidth = textSize.width
    if strikeWidth < 180 {
        toolBarItemLabel.sizeToFit()
    }
    var buttonLabel: UIBarButtonItem = UIBarButtonItem(customView: toolBarItemLabel)
    return buttonLabel
}

func () {
}

func () {
    var action: target
}

func buttonAction() {
    var barButton: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: type, target: target, action: buttonAction)
    return barButton
}

func () {
    if IS_IPAD {
        return CGSizeMake(320, 320)
    }
    if floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_7_1 {
        //iOS 7.1 or earlier
        if self.isViewPortrait() {
            return CGSizeMake(320, IS_WIDESCREEN ? 568 : 480)
        }
        return CGSizeMake(IS_WIDESCREEN ? 568 : 480, 320)
    }
    else {
        //iOS 8 or later
        return UIScreen.mainScreen().bounds.size
    }
    if self.isViewPortrait() {
        return CGSizeMake(320, IS_WIDESCREEN ? 568 : 480)
    }
    return CGSizeMake(IS_WIDESCREEN ? 568 : 480, 320)
}

func () {
    return .IsPortrait(UIApplication.sharedApplication().statusBarOrientation)
}

func () {
}

func origin() {
    if !origin {
        return false
    }
    var isButton: Bool = (origin is UIBarButtonItem.self)
    var isView: Bool = (origin is UIView.self)
    return (isButton || isView)
}

func () {
    if self.barButtonItem {
        return self.barButtonItem
    }
    return self.containerView
}

func () {
    var presentPickerForView
}

func aView() {
    self.presentFromRect = aView.frame
    if IS_IPAD {
        self.configureAndPresentPopoverForView(aView)
    }
    else {
        self.configureAndPresentActionSheetForView(aView)
    }
}

func () {
    var configureAndPresentActionSheetForView
}

func aView() {
    NSNotificationCenter.defaultCenter().addObserver(self, selector: "didRotate:", name: UIApplicationWillChangeStatusBarOrientationNotification, object: nil)
    self.actionSheet = SWActionSheet(view: aView)
    self.presentActionSheet(actionSheet!)
    // Use beginAnimations for a smoother popup animation, otherwise the UIActionSheet pops into view
    UIView.beginAnimations(nil, context: nil)
    //    _actionSheet.bounds = CGRectMake(0, 0, self.viewSize.width, sheetHeight);
    UIView.commitAnimations()
}

func () {
    var didRotate
}

func notification() {
    if OrientationMaskSupportsOrientation(self.supportedInterfaceOrientations, DEVICE_ORIENTATION) {
        self.dismissPicker()
    }
}

func () {
    var presentActionSheet
}

func actionSheet() {
    NSParameterAssert(actionSheet != nil)
    if self.barButtonItem {
        actionSheet!.showFromBarButtonItem(barButtonItem, animated: true)
    }
    else {
        actionSheet!.showInContainerView()
    }
}

func () {
    var configureAndPresentPopoverForView
}

func aView() {
    var viewController: UIViewController = UIViewController(nibName: nil, bundle: nil)
    viewController.view = aView
    if NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1 {
        viewController.preferredContentSize = aView.frame.size
    }
    else {
        viewController.contentSizeForViewInPopover = viewController.view.frame.size
    }
    self.popOverController = UIPopoverController(contentViewController: viewController)
    self.popOverController.delegate = self
    if self.popoverBackgroundViewClass {
        self.popOverController.popoverBackgroundViewClass = self.popoverBackgroundViewClass
    }
    self.presentPopover(popOverController)
}

func () {
    var presentPopover
}

func popover() {
    NSParameterAssert(popover != nil)
    if self.barButtonItem {
        popover.presentPopoverFromBarButtonItem(barButtonItem, permittedArrowDirections: .Any, animated: true)
        return
    }
    else if (self.containerView) {
        dispatch_async(dispatch_get_main_queue(), {() -> Void in
            popover.presentPopoverFromRect(containerView.bounds, inView: containerView, permittedArrowDirections: .Any, animated: true)
        })
        return
    }

        // Unfortunately, things go to hell whenever you try to present a popover from a table view cell.  These are failsafes.
    var origin: UIView? = nil
    var presentRect: CGRect = CGRectZero
            origin = UIApplication.sharedApplication().keyWindow.rootViewController().view!
        presentRect = CGRectMake(origin.center.x, origin.center.y, 1, 1)
        dispatch_async(dispatch_get_main_queue(), {() -> Void in
            popover.presentPopoverFromRect(presentRect, inView: origin!, permittedArrowDirections: .Any, animated: true)
        })

}

func () {
    var popoverControllerDidDismissPopover
}

func popoverController() {
    switch self.tapDismissAction {
        case .Success:
                        self.notifyTarget(self.target, didSucceedWithAction: self.successAction, origin: self.storedOrigin)

        case .None, .Cancel:
                        self.notifyTarget(self.target, didCancelWithAction: self.cancelAction, origin: self.storedOrigin)

    }

}