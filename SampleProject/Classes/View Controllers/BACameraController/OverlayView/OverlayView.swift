//
//  OverlayView.swift
//  CustomCamera
//
//  Created by Waris on 19/01/2011.
//  Copyright © 2016 WarisSaqi. All rights reserved.

import UIKit
import Photos
import AVKit
import AVFoundation


//MARK: Options that can be set

let kGalleryAnimationDelay = 0.25;
let kMaxNumberOfImages = 10;
let kMaxNumberOfVideos = 1;
let kViewsTransparency = 0.6;

let kTickImageName = "camera_select_multiple";
let kDownArrowName = "camera_arrowdown";
let kUpArrowName = "camera_arrowup"

enum BAMediaType {
    case image
    case video
}


struct BAMedia {
    var media:AnyObject
    var mediaType:BAMediaType
    var mediaURL : URL?
}


protocol OverlayViewDelegate {
    
    func takePicture();
    func changeCamera();
    func toggleFlashLight()->(String);
    func backButtonPressed();
    func startVideoCapture();
    func stopVideoCapture();
    
    func mediaSelected(_ mediaArray:[BAMedia]);
}

enum SelectionMode {
    case ModeImage
    case ModeVideo
}

class OverlayView: UIView , UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet var controlsArray: [AnyObject]!
    
    var tickImage:UIImage = UIImage(named:kTickImageName)!
    var downArrow:UIImage = UIImage(named: kDownArrowName)!;
    var upArrow:UIImage = UIImage(named: kUpArrowName)!;
    
    var assetArray = [PHAsset]();
    var thumbNails = [BAMedia]();
    
    var numberOfSelectedMedia:Int = 0;
    
    var selectionMode:SelectionMode = .ModeImage;
    
    var cameraViewController : UIViewController?
    
    //    var multipleImagesArray = [Int:BAMedia]()
    
    var assetCollection:PHAssetCollection?
    var flowLayout:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    var topSpaceConstraint: NSLayoutConstraint!
    var checkedIndexes = [Int:Bool]();
    var isVideoCaturing:Bool = false;
    
    var delegate:OverlayViewDelegate?
    
    @IBOutlet weak var flashOnTextField: UILabel!
    @IBOutlet weak var captureButton: UIButton!
    @IBOutlet weak var topBar: UIView!
    @IBOutlet weak var bottomBar: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var deselectAllButton: UIButton!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var expandingButton: UIButton!
    @IBOutlet weak var videoTimeLabel: UILabel!
    
    @IBOutlet weak var noCameraTextField: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.setupUI()
        
        if PHPhotoLibrary.authorizationStatus() == .authorized  {
            loadPhotosInCollectionView();
        }
        else{
            let _ = requestForPhotosAccess()
        }
    }
    
    
    func setupUI() {
        
        self.expandingButton.setImage(self.upArrow, for: UIControlState());
        self.flowLayout.scrollDirection = .horizontal;
        self.flowLayout.itemSize = CGSize(width: 90, height: 90);
        self.collectionView.collectionViewLayout = flowLayout;
        self.collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        collectionView.register(UINib.init(nibName: "OverlayViewCell", bundle: nil), forCellWithReuseIdentifier: "Cell");
        
        captureButton.layer.cornerRadius = captureButton.frame.size.width/2;
        captureButton.layer.borderWidth = 3.0;
        captureButton.alpha = 0.8;
        
        let buttonGesture = UILongPressGestureRecognizer(target: self, action: #selector(captureButtonLongPressed(_:)))
        
        captureButton.addGestureRecognizer(buttonGesture);
        
        self.captureButton.layer.borderWidth = 3.0;
        self.captureButton.layer.borderColor = UIColor.white.cgColor;
        self.captureButton.clipsToBounds = true;
        
        self.topBar.alpha = CGFloat(kViewsTransparency)
        
        bottomBar.backgroundColor = UIColor.clear.withAlphaComponent(CGFloat(kViewsTransparency))
        
        
    }
    
    func captureButtonLongPressed(_ gesture:UILongPressGestureRecognizer) {
        if gesture.state == .began && !isVideoCaturing {
            self.bottomBar.isUserInteractionEnabled = false;
            print("longPressed: Began");
            isVideoCaturing = true;
            captureButton.backgroundColor = UIColor.red
            delegate?.startVideoCapture()
        }
        
        if gesture.state == .ended {
            print("longPressed: Ended");
        }
        
    }
    
    func itemSelectedForMultiplePictures(_ index:Int) {
        
        let cell = collectionView.cellForItem(at: IndexPath(row: index, section: 0)) as! OverlayViewCell;
        //        let image = getAssetThumbnail(assetArray[index]);
        let mediaType = self.thumbNails[index].mediaType;
        
        if (numberOfSelectedMedia == 0) {
            // change selection mode to media type
            self.selectionMode = mediaType == .video ? .ModeVideo : .ModeImage;
        }
        
        if ((mediaType == .video && selectionMode == .ModeVideo) || (mediaType == .image && selectionMode == .ModeImage)) {
            
            if checkedIndexes[index] == true {
                numberOfSelectedMedia = numberOfSelectedMedia > 0 ? (numberOfSelectedMedia - 1) : 0;
                checkedIndexes.removeValue(forKey: index);
                cell.gradientView.isHidden = true;
                cell.selectedImageView.isHidden = true;
            }
            else {
                //select image and add
                if (numberOfSelectedMedia <= (mediaType == .image ? kMaxNumberOfImages : kMaxNumberOfVideos)) {
                    cell.selectedImageView.isHidden = false;
                    cell.gradientView.isHidden = false;
                    checkedIndexes[index] = true;
                    numberOfSelectedMedia += 1;
                }
            }
        }
        
        let title = String(format: "%@",checkedIndexes.count > 0 ? "Deselect All (\(checkedIndexes.count))" : "");
        self.deselectAllButton.setTitle(title, for: UIControlState());
    }
    
    
    
    func requestForPhotosAccess() -> Bool {
        var result = true;
        
        if PHPhotoLibrary.authorizationStatus() == .authorized {
            return true;
        } else {
            PHPhotoLibrary.requestAuthorization({ (status: PHAuthorizationStatus) -> Void in
                if status == .authorized {
                    self.loadPhotosInCollectionView()
                } else {
                    result = false;
                }
            })
        }
        
        return result;
    }

    func loadPhotosInCollectionView() {
        
        var tempAssets = [PHAsset]();
        var tempThumbnails = [BAMedia]();
        
        let result = PHAssetCollection.fetchMoments(with: nil);
        
        result.enumerateObjects({ (object:AnyObject, idx:Int, stop:UnsafeMutablePointer<ObjCBool>) in
            let assetsCollection = object as? PHAssetCollection;
            let assests = PHAsset.fetchAssets(in: assetsCollection!, options: nil);
            assests.enumerateObjects({ (object:AnyObject, idx:Int, stop:UnsafeMutablePointer<ObjCBool>) in
                if object.mediaType == .image {
                    let thumbnail = self.getAssetThumbnail(object as! PHAsset);
                    tempAssets.append(object as! PHAsset);
                    tempThumbnails.append(BAMedia(media: thumbnail, mediaType: .image, mediaURL: nil));
                }
                    
                else if object.mediaType == .video {
                    let thumbnail = self.getAssetThumbnail(object as! PHAsset);
                    tempAssets.append(object as! PHAsset);
                    tempThumbnails.append(BAMedia(media: thumbnail,mediaType: .video, mediaURL: nil))
                }
            });
        })
        
        print("total count: \(tempAssets.count)");
        
        self.assetArray.removeAll(keepingCapacity: false);
        
        self.assetArray = tempAssets.reversed();
        self.thumbNails = tempThumbnails.reversed();
        
        self.collectionView.reloadData();
        
    }
    
    //MARK: - CollectionView
    
    
    func reloadAssestsArray() {
        
        var tempAssets = [PHAsset]();
        
        let result = PHAssetCollection.fetchMoments(with: nil);
        
        result.enumerateObjects({ (object:AnyObject, idx:Int, stop:UnsafeMutablePointer<ObjCBool>) in
            let assetsCollection = object as? PHAssetCollection;
            let assests = PHAsset.fetchAssets(in: assetsCollection!, options: nil);
            assests.enumerateObjects({ (object:AnyObject, idx:Int, stop:UnsafeMutablePointer<ObjCBool>) in
                if object.mediaType == .image || object.mediaType == .video {
                    tempAssets.append(object as! PHAsset);
                }
            });
        })
        
        print("total count: \(tempAssets.count)");
        
        self.assetArray.removeAll(keepingCapacity: false);
        self.assetArray = tempAssets.reversed();
    }
    
    
    func updateCollectionViewWithItems(newItems items:[UIImage], isReload fullReload:Bool) {
        print("\(#function)");
        if fullReload {
            loadPhotosInCollectionView()
            
        }
        else if (!fullReload && items.count > 0){
            
            self.collectionView .performBatchUpdates({
                let resultSize = self.thumbNails.count;
                self.thumbNails.insert(BAMedia(media: items[0], mediaType:.image, mediaURL: nil), at: 0);
                var indexPaths:[IndexPath] = [IndexPath]();
                
                for i in resultSize..<resultSize + items.count {
                    indexPaths .append(IndexPath(row: i, section: 0));
                }
                self.collectionView.insertItems(at: indexPaths);
                
                self.performSelector(inBackground: #selector(self.reloadAssestsArray), with: nil);
            }, completion: { (completed) in
                if completed {
                    self.collectionView.reloadData()
                    print("updated...!")
                }
                
            });
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        itemSelectedForMultiplePictures(indexPath.row);
    }
    
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1;
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (self.thumbNails.count);
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell:OverlayViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! OverlayViewCell;
        
        //        let asset = self.assetArray[indexPath.row];
        let media = self.thumbNails[indexPath.row];
        
        let image = media.media as? UIImage;
        
        cell.imageView.image = image;
        
        if self.thumbNails[indexPath.row].mediaType == .image {
            cell.movieImageView.isHidden = true;
        }
        else {
            cell.movieImageView.isHidden = false;
        }
        
        
        //
        //        if asset.mediaType == .Video {
        //            // add extra crunch for video thumbnail
        //        }
        
        if checkedIndexes[indexPath.row] == true {
            cell.selectedImageView.isHidden = false;
            cell.gradientView.isHidden = false;
            
        }
        else {
            cell.selectedImageView.isHidden = true;
            cell.gradientView.isHidden = true;
        }
        
        return cell;
    }
    
    func updateVideoTime(_ timeText:String) {
        print("updateVideoTime: \(timeText)")
        videoTimeLabel.text = timeText;
    }
    
    //MARK: - IBActions
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        delegate?.backButtonPressed()
    }
    
    @IBAction func toggleFlash(_ sender: AnyObject) {
        flashOnTextField.text = delegate?.toggleFlashLight()
    }
    
    @IBAction func toggleCamera(_ sender: AnyObject) {
        delegate?.changeCamera()
    }
    
    
    @IBAction func takePhoto(_ sender: AnyObject) {
        print("take photo");
        if isVideoCaturing {
            captureButton.backgroundColor = UIColor.black
            delegate?.stopVideoCapture()
            isVideoCaturing = false;
            self.bottomBar.isUserInteractionEnabled = true;
        }
        else {
            self.delegate?.takePicture()
        }
    }
    
    @IBAction func deSelectAll(_ sender: UIButton) {
        if self.checkedIndexes.count > 0 {
            sender.setTitle("", for: UIControlState())
            checkedIndexes = [Int:Bool]();
            numberOfSelectedMedia = 0;
            selectionMode = .ModeImage;
            self.collectionView .reloadData()
        }
    }
    
    @IBAction func sendButton(_ sender: AnyObject) {
        if self.checkedIndexes.count > 0 {
//            SVProgressHUD.show()
            DispatchQueue.global(qos: .background).async {
                self.getFullImage(self.checkedIndexes, completion: { (result) in
                    DispatchQueue.main.async {
//                        SVProgressHUD.dismiss()
                        self.delegate?.mediaSelected(result);
                    }
                })
            }
        }
    }
    
    
    @IBAction func expandBottomView(_ sender: AnyObject) {
        
        let button = sender as! UIButton;
        
        if button.currentImage == upArrow {
            
            self.layoutIfNeeded()
            
            UIView.animate(withDuration: kGalleryAnimationDelay, animations: {
                self.videoTimeLabel.alpha = 0.0;
                self.captureButton.alpha = 0.0;
                self.noCameraTextField.alpha = 0.0;
                self.captureButton.isUserInteractionEnabled = false;
                button.setImage(self.downArrow, for: UIControlState())
                
                self.removeConstraint(self.heightConstraint);
                
                self.topSpaceConstraint = NSLayoutConstraint(item: self.topBar, attribute: .bottom, relatedBy: .equal, toItem: self.bottomBar, attribute: .top, multiplier: 1, constant: 0);
                
                NSLayoutConstraint.activate([self.topSpaceConstraint!])
                self.layoutIfNeeded()
                
                self.flowLayout.scrollDirection = .vertical;
                
            })
        }
            
        else {
            self.layoutIfNeeded()
            
            UIView.animate(withDuration: kGalleryAnimationDelay, animations: {
                self.noCameraTextField.alpha = 1.0;
                self.videoTimeLabel.alpha = 1.0;
                self.captureButton.alpha = 0.8;
                self.captureButton.isUserInteractionEnabled = true;
                button.setImage(self.upArrow, for: UIControlState());
                
                self.removeConstraint(self.topSpaceConstraint)
                
                self.heightConstraint = NSLayoutConstraint(item: self.bottomBar, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0.25, constant: 0);
                NSLayoutConstraint.activate([self.heightConstraint!])
                
                self.flowLayout.scrollDirection = .horizontal;
                self.layoutIfNeeded()
                
            })
        }
        
    }
    
    
    //MARK: - Helper Methods
    
    func getAssetThumbnail(_ asset: PHAsset) -> UIImage {
        
        let manager = PHImageManager.default()
        let option = PHImageRequestOptions()
        var thumbnail = UIImage()
        option.isSynchronous = true
        
        manager.requestImage(for: asset, targetSize: CGSize(width: 100.0, height: 100.0), contentMode: .aspectFill, options: option, resultHandler: {(result, info)->Void in
            
            thumbnail = result!
        })
        
        return thumbnail
    }
    
    
    func getFullImage(_ array:[Int:Bool], completion: @escaping (_ result: [BAMedia]) -> Void){
        let manager = PHImageManager.default()
        let option = PHImageRequestOptions()
        var data = Data()
        option.isSynchronous = true
        
        var images = [BAMedia]();
        
        for (row, _) in array {
            if array[row] == true {
                
                let asset = self.assetArray[row]
                print(asset.mediaType.rawValue)
                
                if asset.mediaType == .image{
                    manager.requestImage(for: asset, targetSize: PHImageManagerMaximumSize, contentMode: .aspectFill, options: option, resultHandler: {(result, info)->Void in
//                        let url = asset.url
                        images.append(BAMedia(media: result! as AnyObject, mediaType: .image, mediaURL: nil));
                        if images.count == array.count{
                            completion(images)
                        }
                    })
                }
                else if asset.mediaType == .video{
                    manager.requestAVAsset(forVideo: asset, options: PHVideoRequestOptions.init(), resultHandler: { (asset1, avAudioMix, info) in
                        // print(asset1)
                        let url = (asset1 as! AVURLAsset).url
                        data = try! Data.init(contentsOf: url)
                        images.append(BAMedia(media: data as AnyObject, mediaType: .video, mediaURL: url));
                        if images.count == array.count {
                            completion(images)
                        }
                    })
                }
            }
        }
    }
    
}
