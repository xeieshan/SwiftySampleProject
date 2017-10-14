//
//  ViewController.swift
//  <#Project Name#>
//
//  Created by <#Project Developer#> on 29/02/2016.
//  Copyright © 2016 <#Project Name#>. All rights reserved.
//
import UIKit
import Foundation


class ViewController: UIViewController {//,UITableViewDelegate,UITableViewDataSource
    
    @IBOutlet weak var tf1: UITextField?
    @IBOutlet weak var tf2: UITextField?
    @IBOutlet weak var tf3: UITextField?
    @IBOutlet weak var imagesView : UIView!
    
    var arrayProfiles : [MOProfile] = []
    
    weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        //Initializations
        self.initializations()
        //SetupView
        self.setUpView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }

    func setUpView() {
        
    }

    func initializations() {
//        let nibName = UINib(nibName: "ReUse", bundle:nil)
//        tableView.registerNib(nibName, forCellReuseIdentifier: "ReUse")
//        tf1.delegate = self
        
        UtilityHelper.performOn(QueueType.Main) { () -> Void in
            
        }
        UtilityHelper.delay(1) { () -> Void in
            
        }
        
        if UtilityFunctions.isValidateAlphabet("adnalsn") {
            
        }
        if UtilityHelper.isValidateAlphabet("adnalsn") {
            
        }
        
        let width:CGFloat = UtilityHelper.measureWidthForText("sjdakjshdkajhsdkjhaskjdhkajhsdkjashkjdhjkashdkjashkjdhaksd", font: UIConfiguration.getUIFONTBOLD(sizeFont: 12))
        let height:CGFloat = UtilityHelper.measureHeightForText("sjdakjshdkajhsdkjhaskjdhkajhsdkjashkjdhjkashdkjashkjdhaksd", font: UIConfiguration.getUIFONTAPPREGULAR(sizeFont: 16))
        let widthF:CGFloat = UtilityHelper.requiredHeightForLabelWith(self.view.frame.size.width, font: UIConfiguration.getUIFONTAPPREGULAR(sizeFont: 16),text: "sdjahdkashkdjhaskhdkjashdkjashdkjahskdjhaskjdhkajshdkjashdkjahskdjhaksjdhkasd")
        
        print(UtilityHelper.DictionaryForm(self))
        print(width)
        print(height)
        print(widthF)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        
    }
    
    
    @IBAction func pickImage(_ sender : UIButton){
        let cameraVC = BACameraController.init(nibName: nil, bundle: nil);
        cameraVC.delegate = self;
        self.present(cameraVC, animated: true, completion: nil);
    }
    
    func getImagesDataFromMedia(_ mediaArray : [BAMedia], completion: @escaping (_ images : [UIImage], _ videos : [URL]) -> Void) {
        var mediaDictArray = [UIImage]()
        var videoDict = [URL]()
        for media in mediaArray { //if let media = mediaArray.first
            if media.mediaType == .image {
                mediaDictArray.append(media.media as! UIImage)
            }
            else{
                videoDict.append(media.mediaURL!)
            }
        }
        completion(mediaDictArray, videoDict)
    }

    //    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    //
    //        let cell : UITableViewCell = UITableViewCell(style:UITableViewCellStyle.subtitle, reuseIdentifier: "ReUse")
    //        cell.textLabel!.text = "Zee"
    //        cell.detailTextLabel!.text = "Hai"
    //
    //        return cell
    //
    //    }
    //    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    //        return 1
    //
    //    }
    //    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String?  {
    //        return "Header"
    //    }
    //    func tableView(tableView: UITableView, titleForFooterInSection section: Int) -> String? {
    //        return "Footer"
    //    }
    //    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    //        
    //    }
}
    
extension ViewController : BACameraControllerDelegate{
    func mediaSelected(_ mediaArray:[BAMedia]){
        
        getImagesDataFromMedia(mediaArray) { (images, videos) in
            if images.count > 0{
                DispatchQueue.main.async {
                    let collageView = SPImageCollageView.init(frame: self.imagesView.bounds, images: images)
                    collageView.delegate = self
                    self.imagesView.addSubview(collageView)
                }
            }
            else if videos.count > 0 {
                
            }
        }
    }
    
    func controllerCancelled(){
        
    }
}

extension ViewController : SPImageCollageViewDelegate{
    
    func viewAll(images: [Any], fromView: SPImageCollageView) {
        
    }
    
    func imageSelected(fromImages images: [UIImageView], image:UIImageView){
        
    }
}
