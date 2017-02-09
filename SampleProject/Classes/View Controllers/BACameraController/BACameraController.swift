//
//  ViewController.swift
//  CustomCamera
//
//  Created by <#Project Developer#> on 19/01/2011.
//  Copyright © 2016 <#Project Developer#> All rights reserved.

import UIKit
import AVFoundation
import MobileCoreServices
import AssetsLibrary
import Photos

protocol BACameraControllerDelegate {
    func controllerCancelled();
    
    func mediaSelected(_ mediaArray:[BAMedia])
}

struct BATime {
    var hour:Int = 0
    var minute:Int = 0
    var seconds:Int = 0
}

class BACameraController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate, OverlayViewDelegate {
    
    fileprivate var cameraView:UIImagePickerController?;
    
    var totalTime:BATime = BATime(hour: 0, minute: 0, seconds: 0);
    
    var delegate:BACameraControllerDelegate?
    var overlayView:OverlayView?
    var availableCameraDevices:[UIImagePickerControllerCameraDevice] = [UIImagePickerControllerCameraDevice]()
    
    var videoTimer:Timer = Timer()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil);
        print("\(#function)");
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
        print("\(#function)");
    }
    
    override var prefersStatusBarHidden : Bool{
        return false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("\(#function)");
        
        self.view.backgroundColor = UIColor.black
        let _ = self.prefersStatusBarHidden
        let _ = cameraView?.prefersStatusBarHidden
        
        let video = AVMediaTypeVideo;
        let audio = AVMediaTypeAudio;
        
        let authStatus = AVCaptureDevice.authorizationStatus(forMediaType: video);
        let authStatus2 = AVCaptureDevice.authorizationStatus(forMediaType: audio);
        
        
        if (authStatus == .authorized && authStatus2 == .authorized) {
            // do your logic
            self.showCameraView()
        } else if (authStatus == .denied || authStatus2 == .denied ){
            // denied
        } else if (authStatus == .restricted || authStatus2 == .restricted){
            // restricted, normally won't happen
        } else if (authStatus == .notDetermined || authStatus2 == .notDetermined){
            // not determined?!
            
            AVCaptureDevice.requestAccess(forMediaType: video, completionHandler: { (granted:Bool) in
                if(granted){
                    
                    AVCaptureDevice.requestAccess(forMediaType: audio, completionHandler: { (granted:Bool) in
                        if(granted){
                            
                            DispatchQueue.main.async(execute: {
                                self.showCameraView()
                            })
                            
                            
                            NSLog("Granted access to %@", video);
                        } else {
                            NSLog("Not granted access to %@", video);
                            self.dismiss(animated: true, completion: nil);
                            
                        }
                        
                    });
                    
                    NSLog("Granted access to %@", video);
                } else {
                    NSLog("Not granted access to %@", video);
                }
                
            });
            
        } else {
            // impossible, unknown authorization status
            self.dismiss(animated: true, completion: nil);
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        print("viewWillLayoutSubviews");
    }
    
    func showCameraView() {
        
        print("\(#function)");
        
        if let nibs = Bundle.main.loadNibNamed("OverlayView", owner: self, options: nil) {
            overlayView = nibs.first as? OverlayView
            
            
            if (!UIImagePickerController.isSourceTypeAvailable(.camera)) {
                // no camera found
                print("no camera found");
                
                overlayView?.frame = self.view.frame;
                overlayView?.center = self.view.center;
                overlayView?.cameraViewController = self;
                overlayView?.delegate = self;
                overlayView?.backgroundColor = UIColor.darkGray;
                overlayView?.noCameraTextField.isHidden = false;
                // hide camera controls
                
                let objectsArray = overlayView?.controlsArray;
                
                for x in 0..<objectsArray!.count {
                    (objectsArray![x] as! UIView).isHidden = true;
                }
                
                self.view .addSubview(overlayView!);
                
            }
                
            else {
                
                print("\(#function): camera found");
                if (UIImagePickerController.isCameraDeviceAvailable(.rear)){
                    availableCameraDevices.append(.rear);
                }
                
                if (UIImagePickerController.isCameraDeviceAvailable(.front)){
                    availableCameraDevices.append(.front);
                }
                
                if availableCameraDevices.count > 0 {
                    
                    cameraView = UIImagePickerController.init();
                    
                    cameraView?.mediaTypes = [kUTTypeMovie as String,kUTTypeImage as String];
                    cameraView?.sourceType = .camera;
                    cameraView?.delegate = self;
                    cameraView?.cameraDevice = availableCameraDevices.count > 0 ? availableCameraDevices[0] : .front
                    cameraView?.cameraOverlayView = overlayView
                    cameraView?.showsCameraControls = false;
                    cameraView?.cameraFlashMode = .on;
                    //                    cameraView?.cameraViewTransform = CGAffineTransformMakeScale(1.6, 1.6);
                    overlayView?.cameraViewController = self;
                    overlayView?.delegate = self;
                    overlayView?.backgroundColor = UIColor.clear;
                    overlayView?.frame = (cameraView?.view.frame)!;
                    
                    self.view.addSubview((cameraView?.view)!);
                    
                }
                else {
                    //no camera found
                    print("no camera found");
                    self.dismiss(animated: true, completion: nil);
                }
                
            }
        }
        else {
            print("found nil in nibs");
        }
    }
    
    func hideCameraView() {
        cameraView?.removeFromParentViewController()
    }
    
    //MARK: - ImagePickerController Delegate
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        print("\(#function)");
        
        let mediaType = info[UIImagePickerControllerMediaType] as! NSString
        
        if mediaType.isEqual(to: kUTTypeImage as NSString as String) {
            let image = info[UIImagePickerControllerOriginalImage] as! UIImage
            
            //            UIImageWriteToSavedPhotosAlbum(image, self, nil, nil);
            
            //            delegate?.imageSelected(image);
            
            UIImageWriteToSavedPhotosAlbum(image, self, #selector(self.image(image:didFinishSavingWithError:contextInfo:)), nil);
            
        }
            
        else {
            let recordedVideoURL = (info[UIImagePickerControllerMediaURL] as! URL)
            
            if let nibs = Bundle.main.loadNibNamed("PlayerView", owner: self, options: nil) {
                if let playerView = nibs.first as? PlayerView {
                    
                    playerView.frame = self.view.frame;
                    
                    playerView.center = self.view.center;
                    self.view.addSubview(playerView);
                    self.view.bringSubview(toFront: playerView);
                    playerView.playVideoWithURL(recordedVideoURL)
                    playerView.sendButtonCompletionHandler = {url in
                        self.delegate?.mediaSelected([BAMedia(media: url as AnyObject, mediaType: BAMediaType.video, mediaURL: url)]);
                        self.dismiss(animated: true, completion: nil);
                    };
                    
                }
                
            }
            
            
            
        }
        
        
    }
    
    func discardVideo(_ view:UIView) {
        
    }
    
    func sendVideo(_ view:UIView) {
        
    }
    
    func image(image Image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: UnsafeRawPointer) {
        print("\(#function)");
        
        if error == nil {
            print("reloading collection view");
            self.overlayView?.updateCollectionViewWithItems(newItems: [Image], isReload: false);
        }
        
    }
    
    //MARK: - OverlayView Delegate
    func takePicture() {
        cameraView?.cameraCaptureMode = .photo
        self.cameraView?.takePicture();
    }
    
    func backButtonPressed() {
        print("\(#function)");
        self.dismiss(animated: true, completion: nil);
    }
    
    func mediaSelected(_ mediaArray: [BAMedia]) {
        self.delegate?.mediaSelected(mediaArray);
        self.dismiss(animated: true, completion: nil);
        
    }
    
    func toggleFlashLight() -> (String) {
        
        print("\(#function)");
        
        let flashModes:[UIImagePickerControllerCameraFlashMode] = [UIImagePickerControllerCameraFlashMode.auto,UIImagePickerControllerCameraFlashMode.on,UIImagePickerControllerCameraFlashMode.off];
        let strings = ["Auto","On","Off"];
        
        var index = flashModes.index(of: (cameraView?.cameraFlashMode)!)!
        index += 1;
        
        if index >= flashModes.count {
            index = 0;
        }
        
        print(flashModes[index]);
        cameraView?.cameraFlashMode = flashModes[index];
        
        return strings[index];
        
    }
    
    func changeCamera() {
        print("\(#function)");
        if cameraView?.cameraDevice == .rear && availableCameraDevices.contains(.front) {
            cameraView?.cameraDevice = .front;
        }
            
        else if cameraView?.cameraDevice == .front && availableCameraDevices.contains(.rear) {
            cameraView?.cameraDevice = .rear;
        }
        
    }
    
    @objc func updateTimeOfVideo (_ isClear:Bool){
        
        print("\(#function)");
        print("isClear: \(isClear)");
        
        if isClear == false {
            self.overlayView?.updateVideoTime("");
        }
        else {
            overlayView?.updateVideoTime(self.tickTimer());
        }
    }
    
    func startVideoCapture() {
        self.videoTimer.invalidate()
        self.videoTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimeOfVideo), userInfo: nil, repeats: true);
        cameraView?.cameraCaptureMode = .video
        cameraView?.startVideoCapture()
    }
    
    func stopVideoCapture() {
        self.videoTimer.invalidate()
        self.totalTime = BATime(hour: 0, minute: 0, seconds: 0);
        cameraView?.stopVideoCapture()
        updateTimeOfVideo(false);
    }
    
    func tickTimer() -> (String) {
        if totalTime.seconds == 59 {
            if totalTime.minute == 59 {
                if totalTime.hour == 23 {
                    totalTime.hour = 0
                }
                else {
                    totalTime.hour += 1;
                }
                
            }
            else {
                totalTime.minute += 1;
            }
        }
        else {
            totalTime.seconds += 1;
        }
        
        return String(format: "%02d:%02d:%02d", totalTime.hour,totalTime.minute,totalTime.seconds);
        
    }
    
    
    override var shouldAutorotate : Bool {
        return false;
    }
}

