//
//  UIViewController+Helper.h
//  <#Project Name#>
//
//  Created by <#Project Developer#> on 25/03/2015.
//  Copyright (c) 2015 <#Project Name#>. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

typedef enum : NSUInteger {
    VCTypeImagePicker,
    VCTypeVideoPicker,
    VCTypeNone,
} VCType;


typedef void(^MediaSelectionHandler)(NSURL *mediaURL, NSData *data, VCType type, BOOL success);

typedef void (^AlertViewDismissHandler)(void);
typedef void (^AlertViewButtonClickedAtIndexHandler)(UIImagePickerControllerSourceType selectedOption);
//typedef void (^AlertViewConfirmedButtonClickedHandler)(void);
typedef void (^AlertViewCurrentPasswordConfirmedHandler)(NSString *currentPassword);

@interface UIViewController (Helper)<MFMessageComposeViewControllerDelegate, MFMailComposeViewControllerDelegate, UIActionSheetDelegate>

@property (nonatomic, strong) UIImagePickerController           *imagePickerVC;
@property (nonatomic, strong) MFMailComposeViewController       *mailVC;
@property (nonatomic, strong) MFMessageComposeViewController    *messageVC;

@property (nonatomic, strong) MediaSelectionHandler handler;


- (void)sendEmailTo:(NSArray *)to forSubject:(NSString *)subject body:(NSString *)body ccRecipients:(NSArray *)cc bccRecipients:(NSArray *)bcc;
- (void)sendMessageTo:(NSArray *)recipents body:(NSString *)body;

- (void)addChildViewControllerInContainer:(UIView *)containerView childViewController:(UIViewController *)controller;

- (void)addChildViewControllerInContainer:(UIView *)containerView childViewController:(UIViewController *)controller preserverViewController:(UIViewController *)dontDeleteVC;

- (void)removeAllChildViewControllers;

- (void)removeAllChildViewControllersExcept:(UIViewController *)vc;


#pragma mark - UIAlertController Methods

//- (void)showAlertViewWithTitle:(NSString *)title message:(NSString *)message;
//
//- (void)showAlertViewWithTitle:(NSString *)title message:(NSString *)message withDismissCompletion:(AlertViewDismissHandler)dismissHandler;

//- (void)showConfirmationAlertViewWithTitle:(NSString *)title message:(NSString *)message withDismissCompletion:(AlertViewConfirmedButtonClickedHandler)dismissHandler;

- (void)showCurrentPasswordConfirmationAlertViewWithTitle:(NSString *)title message:(NSString *)message withDismissCompletion:(AlertViewCurrentPasswordConfirmedHandler)dismissHandler;

- (void)showPINConfirmationAlertViewWithDismissCompletion:(AlertViewCurrentPasswordConfirmedHandler)dismissHandler;


- (void)showActionSheetForImageInputWithTitle:(NSString *)title withCompletionHandler:(AlertViewButtonClickedAtIndexHandler)completionHandler;

- (void)showActionSheetWithPickerView:(UIPickerView *)pickerView titleMessage:(NSString *)title completionHandler:(AlertViewDismissHandler)completionHandler;

//- (void)showImagePickerWithType:(UIImagePickerControllerSourceType)type withCompletionBlock:(MediaSelectionHandler)block;
//- (void)showVideoPickerWithType:(UIImagePickerControllerSourceType)type withCompletionBlock:(MediaSelectionHandler)block;
//- (void)pickMediaWithType:(VCType)vcType withCompletion:(MediaSelectionHandler)block;

@end
