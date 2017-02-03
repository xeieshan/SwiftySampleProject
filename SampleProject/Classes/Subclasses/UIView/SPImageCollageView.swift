//
//  SPImageCollageView.swift
//  SampleProject
//
//  Created by Waris on 24/1/17.
//  Copyright © 2016 Creatrixe. All rights reserved.
//

import UIKit

protocol SPImageCollageViewDelegate {
    func viewAll(images:[Any], fromView : SPImageCollageView)
    func imageSelected(fromImages images: [UIImageView], image:UIImageView)
}

class SPImageCollageView: UIView {
    
    var cellImagesURLs:[URL]?
    var cellImages:[UIImage]?
    var cellImageViews = [UIImageView]()
    
    var delegate: SPImageCollageViewDelegate?
    
    init(frame : CGRect, imagesURLs : [URL]){
        super.init(frame: frame)
        
        if imagesURLs.count <= 0 {
            return;
        }
        self.frame = frame;
        self.cellImagesURLs = imagesURLs;
        
        if imagesURLs.count == 1 {
            // add only one image
            for image in imagesURLs {
                let gesture = UITapGestureRecognizer(target: self, action: #selector(self.imageViewTapped(_:)))
                var rect = frame
                rect.origin.x = 0
                rect.origin.y = 0
                let imageView1 = UIImageView(frame: rect);
                imageView1.isUserInteractionEnabled = true
                print(image)
                //User SDWebimage or KingFisher or what ever you like to download image from url and set to imageview
//                imageView1.pin_setImage(from: image, placeholderImage:  UIImage(named:"image logo")) // = image;
                imageView1.contentMode = .scaleAspectFill;
                imageView1.clipsToBounds = true;
                imageView1.addGestureRecognizer(gesture);
                imageView1.tag = 1;
                self.cellImageViews.append(imageView1);
                self.addSubview(imageView1);
                imageView1.center = self.center;
            }
        }
            
        else if imagesURLs.count == 2 {
            // add two images side by side
            let imageView1 = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.width/2, height: frame.height));
            let imageView2 = UIImageView(frame: CGRect(x: imageView1.frame.width, y: 0, width: imageView1.frame.width, height: frame.size.height));
            
            let gesture1 = UITapGestureRecognizer(target: self, action: #selector(self.imageViewTapped(_:)))
            let gesture2 = UITapGestureRecognizer(target: self, action: #selector(self.imageViewTapped(_:)))
                //User SDWebimage or KingFisher or what ever you like to download image from url and set to imageview
//            imageView1.pin_setImage(from: imagesURLs[0], placeholderImage:  UIImage(named:"image logo"))
//            imageView2.pin_setImage(from: imagesURLs[1], placeholderImage:  UIImage(named:"image logo"))
            
            imageView1.isUserInteractionEnabled = true
            imageView2.isUserInteractionEnabled = true
            
            imageView2.contentMode = .scaleAspectFill;
            imageView1.contentMode = .scaleAspectFill;
            
            imageView1.clipsToBounds = true;
            imageView2.clipsToBounds = true;
            
            imageView1.addGestureRecognizer(gesture1);
            imageView2.addGestureRecognizer(gesture2);
            
            imageView1.tag = 1;
            imageView2.tag = 2;
            
            self.cellImageViews.append(imageView1)
            self.cellImageViews.append(imageView2)
            
            self.addSubview(imageView1);
            self.addSubview(imageView2);
        }
        else if imagesURLs.count == 3 {
            let imageView1 = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.width/2, height: frame.height));
            let imageView2 = UIImageView(frame: CGRect(x: imageView1.frame.width, y: 0, width: imageView1.frame.size.width, height: imageView1.frame.size.height/2));
            let imageView3 = UIImageView(frame: CGRect(x: imageView1.frame.width, y: imageView1.frame.size.height/2, width: imageView2.frame.size.width, height: imageView2.frame.size.height));
            
            let gesture1 = UITapGestureRecognizer(target: self, action: #selector(self.imageViewTapped(_:)))
            let gesture2 = UITapGestureRecognizer(target: self, action: #selector(self.imageViewTapped(_:)))
            let gesture3 = UITapGestureRecognizer(target: self, action: #selector(self.imageViewTapped(_:)))
            //User SDWebimage or KingFisher or what ever you like to download image from url and set to imageview
//            imageView1.pin_setImage(from: imagesURLs[0], placeholderImage:  UIImage(named:"image logo"))
//            imageView2.pin_setImage(from: imagesURLs[1], placeholderImage:  UIImage(named:"image logo"))
//            imageView3.pin_setImage(from: imagesURLs[2], placeholderImage:  UIImage(named:"image logo"))
            
            imageView1.isUserInteractionEnabled = true
            imageView2.isUserInteractionEnabled = true
            imageView3.isUserInteractionEnabled = true
            
            imageView1.clipsToBounds = true;
            imageView2.clipsToBounds = true;
            imageView3.clipsToBounds = true;
            
            imageView3.contentMode = .scaleAspectFill;
            imageView2.contentMode = .scaleAspectFill;
            imageView1.contentMode = .scaleAspectFill;
            
            imageView1.addGestureRecognizer(gesture1);
            imageView2.addGestureRecognizer(gesture2);
            imageView3.addGestureRecognizer(gesture3);
            
            imageView1.tag = 1;
            imageView2.tag = 2;
            imageView3.tag = 3;
            
            self.cellImageViews.append(imageView1);
            self.cellImageViews.append(imageView2);
            self.cellImageViews.append(imageView3);
            
            self.addSubview(imageView1);
            self.addSubview(imageView2);
            self.addSubview(imageView3);
        }
        else if imagesURLs.count == 4 {
            var x:CGFloat = 0;
            var y:CGFloat = 0;
            
            for i in 0..<4 {
                if i == 0 {
                    x = 0;
                    y = 0.0;
                }
                else if i == 1 {
                    x = 0;
                    y = frame.size.height/2
                }
                else if i == 2 {
                    y = 0.0;
                    x = frame.size.width/2
                }
                else if i == 3 {
                    x = frame.size.width/2
                    y = frame.size.height/2
                }
                
                let gesture = UITapGestureRecognizer(target: self, action: #selector(self.imageViewTapped(_:)))
                
                let imageView = UIImageView(frame: CGRect(x: x, y: y, width: frame.size.width/2, height: frame.size.height/2))
                //User SDWebimage or KingFisher or what ever you like to download image from url and set to imageview
//                imageView.pin_setImage(from: imagesURLs[i], placeholderImage:  UIImage(named:"image logo"))
                imageView.contentMode = .scaleAspectFill;
                imageView.clipsToBounds = true
                
                imageView.isUserInteractionEnabled = true
                
                imageView.tag = i+1;
                
                self.cellImageViews.append(imageView);
                
                imageView.addGestureRecognizer(gesture);
                self.addSubview(imageView);
            }
        }
            
        else if imagesURLs.count >= 5 {
            var x:CGFloat = 0;
            var y:CGFloat = 0;
            
            for i in 0..<5 {
                if i == 0 {
                    x = 0;
                    y = 0;
                }
                else if i == 1 {
                    x = 0
                    y = frame.size.height/2;
                }
                else if i == 2 {
                    x = frame.size.width/2
                    y = 0;
                }
                else if i == 3 {
                    x = frame.size.width/2
                    y = frame.size.height/3;
                }
                else if i == 4 {
                    x = frame.size.width/2;
                    y = 2 * (frame.size.height/3);
                }
                
                let gesture = UITapGestureRecognizer(target: self, action: #selector(self.imageViewTapped(_:)))
                let imageView = UIImageView(frame: CGRect(x: x, y: y, width: frame.size.width/2, height: frame.size.height / (i == 0 || i == 1 ? 2 : 3) ));
                //User SDWebimage or KingFisher or what ever you like to download image from url and set to imageview
//                imageView.pin_setImage(from: imagesURLs[i], placeholderImage:  UIImage(named:"image logo"))
                imageView.contentMode = .scaleAspectFill;
                imageView.clipsToBounds = true
                imageView.isUserInteractionEnabled = true
                imageView.addGestureRecognizer(gesture);
                
                imageView.tag = i+1;
                
                self.cellImageViews.append(imageView);
                self.addSubview(imageView);
                
                if imagesURLs.count > 5 {
                    let button = UIButton(frame: CGRect(x: frame.size.width/2,y: 2 * frame.size.height/3,width: frame.size.width/2,height: frame.size.height/3));
                    button.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7);
                    button.setTitle("View All (\(String(imagesURLs.count)))", for: UIControlState());
                    button.addTarget(self, action: #selector(self.viewAll(_:)), for: .touchUpInside)
                    self.addSubview(button);
                }
            }
        }
    }

    
    init(frame:CGRect, images:[UIImage]) {
        super.init(frame: frame)
        if images.count <= 0 {
            return;
        }
        self.frame = frame;
        self.cellImages = images;
        
        if images.count == 1 {
            // add only one image
            for image in images {
                let gesture = UITapGestureRecognizer(target: self, action: #selector(self.imageViewTapped(_:)))
                let imageView1 = UIImageView(frame: self.bounds);
                imageView1.isUserInteractionEnabled = true
                imageView1.image = image
                imageView1.contentMode = .scaleAspectFill;
                imageView1.clipsToBounds = true;
                imageView1.addGestureRecognizer(gesture);
                imageView1.tag = 1;
                self.cellImageViews.append(imageView1);
                self.addSubview(imageView1);
                imageView1.center = self.center;
            }
        }
        else if images.count == 2 {
            // add two images side by side
            let imageView1 = UIImageView(frame: CGRect(x: frame.origin.x, y: 0, width: frame.width/2, height: frame.height));
            let imageView2 = UIImageView(frame: CGRect(x: imageView1.frame.width + frame.origin.x, y: 0, width: imageView1.frame.width, height: frame.size.height));
            
            let gesture1 = UITapGestureRecognizer(target: self, action: #selector(self.imageViewTapped(_:)))
            let gesture2 = UITapGestureRecognizer(target: self, action: #selector(self.imageViewTapped(_:)))
            
            imageView1.image = images[0]
            imageView2.image = images[1]
            
            imageView1.isUserInteractionEnabled = true
            imageView2.isUserInteractionEnabled = true
            
            imageView2.contentMode = .scaleAspectFill;
            imageView1.contentMode = .scaleAspectFill;
            
            imageView1.clipsToBounds = true;
            imageView2.clipsToBounds = true;
            
            imageView1.addGestureRecognizer(gesture1);
            imageView2.addGestureRecognizer(gesture2);
            
            imageView1.tag = 1;
            imageView2.tag = 2;
            
            self.cellImageViews.append(imageView1)
            self.cellImageViews.append(imageView2)
            
            self.addSubview(imageView1);
            self.addSubview(imageView2);
        }
        else if images.count == 3 {
            let imageView1 = UIImageView(frame: CGRect(x: frame.origin.x, y: 0, width: frame.width/2, height: frame.height));
            let imageView2 = UIImageView(frame: CGRect(x: imageView1.frame.width + frame.origin.x, y: 0, width: imageView1.frame.size.width, height: imageView1.frame.size.height/2));
            let imageView3 = UIImageView(frame: CGRect(x: imageView1.frame.width + frame.origin.x, y: imageView1.frame.size.height/2, width: imageView2.frame.size.width, height: imageView2.frame.size.height));
            
            let gesture1 = UITapGestureRecognizer(target: self, action: #selector(self.imageViewTapped(_:)))
            let gesture2 = UITapGestureRecognizer(target: self, action: #selector(self.imageViewTapped(_:)))
            let gesture3 = UITapGestureRecognizer(target: self, action: #selector(self.imageViewTapped(_:)))
            
            imageView1.image = images[0]
            imageView2.image =  images[1]
            imageView3.image =  images[2]
            
            imageView1.isUserInteractionEnabled = true
            imageView2.isUserInteractionEnabled = true
            imageView3.isUserInteractionEnabled = true
            
            imageView1.clipsToBounds = true;
            imageView2.clipsToBounds = true;
            imageView3.clipsToBounds = true;
            
            imageView3.contentMode = .scaleAspectFill;
            imageView2.contentMode = .scaleAspectFill;
            imageView1.contentMode = .scaleAspectFill;
            
            imageView1.addGestureRecognizer(gesture1);
            imageView2.addGestureRecognizer(gesture2);
            imageView3.addGestureRecognizer(gesture3);
            
            imageView1.tag = 1;
            imageView2.tag = 2;
            imageView3.tag = 3;
            
            self.cellImageViews.append(imageView1);
            self.cellImageViews.append(imageView2);
            self.cellImageViews.append(imageView3);
            
            self.addSubview(imageView1);
            self.addSubview(imageView2);
            self.addSubview(imageView3);
        }
        else if images.count == 4 {
            var x:CGFloat = 0;
            var y:CGFloat = 0;
            
            for i in 0..<4 {
                if i == 0 {
                    x = frame.origin.x;
                    y = 0.0;
                }
                else if i == 1 {
                    x = frame.origin.x;
                    y = frame.size.height/2
                }
                else if i == 2 {
                    y = 0.0;
                    x = frame.origin.x + frame.size.width/2
                }
                else if i == 3 {
                    x = frame.origin.x + frame.size.width/2
                    y = frame.size.height/2
                }
                
                let gesture = UITapGestureRecognizer(target: self, action: #selector(self.imageViewTapped(_:)))
                
                let imageView = UIImageView(frame: CGRect(x: x, y: y, width: frame.size.width/2, height: frame.size.height/2))
                imageView.image =  images[i]
                imageView.contentMode = .scaleAspectFill;
                imageView.clipsToBounds = true
                
                imageView.isUserInteractionEnabled = true
                
                imageView.tag = i+1;
                
                self.cellImageViews.append(imageView);
                
                imageView.addGestureRecognizer(gesture);
                self.addSubview(imageView);
            }
        }
            
        else if images.count >= 5 {
            var x:CGFloat = 0;
            var y:CGFloat = 0;
            
            for i in 0..<5 {
                if i == 0 {
                    x = frame.origin.x;
                    y = 0;
                }
                else if i == 1 {
                    x = frame.origin.x
                    y = frame.size.height/2;
                }
                else if i == 2 {
                    x = frame.origin.x + frame.size.width/2
                    y = 0;
                }
                else if i == 3 {
                    x = frame.origin.x + frame.size.width/2
                    y = frame.size.height/3;
                }
                else if i == 4 {
                    x = frame.origin.x + frame.size.width/2;
                    y = 2 * (frame.size.height/3);
                }
                
                let gesture = UITapGestureRecognizer(target: self, action: #selector(self.imageViewTapped(_:)))
                let imageView = UIImageView(frame: CGRect(x: x, y: y, width: frame.size.width/2, height: frame.size.height / (i == 0 || i == 1 ? 2 : 3) ));
                imageView.image =  images[i]
                imageView.contentMode = .scaleAspectFill;
                imageView.clipsToBounds = true
                imageView.isUserInteractionEnabled = true
                imageView.addGestureRecognizer(gesture);
                
                imageView.tag = i+1;
                
                self.cellImageViews.append(imageView);
                self.addSubview(imageView);
                
                if images.count > 5 {
                    let button = UIButton(frame: CGRect(x: frame.size.width/2,y: 2 * frame.size.height/3,width: frame.size.width/2,height: frame.size.height/3));
                    button.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7);
                    button.setTitle("View All (\(String(images.count)))", for: UIControlState());
                    button.addTarget(self, action: #selector(self.viewAll(_:)), for: .touchUpInside)
                    self.addSubview(button);
                }
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func imageViewTapped(_ sender:UITapGestureRecognizer) {
        print("\(#file) : \(#function)");
        if delegate != nil{
            delegate?.imageSelected(fromImages: self.cellImageViews, image: (sender.view as! UIImageView))
        }
    }
    
    func viewAll(_ sender: UIButton) {
        print("\(#file) : \(#function)");
        self.delegate?.viewAll(images: self.cellImagesURLs!, fromView: self)
    }
    
}
