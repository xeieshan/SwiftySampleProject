////
////  SPButton.swift
////  <#Project Name#>
////
////  Created by <#Project Developer#> on 19/01/2017.
////  Copyright © 2017 <#Project Name#>. All rights reserved.
////
//
//import Foundation
//enum SPIconPosition : Int {
//    case top = 0
//    case left
//    case bottom
//    case right
//}
//
//class SPButton: UIButton {
//    @IBInspectable var iconMargin : CGFloat
//    @IBInspectable var iconPosition : NSInteger
//    @IBInspectable var iconSize : CGSize
//    
//    func commonInit() {
//        self.iconSize = CGSize(width: 0, height: 0)
//    }
//    
//    override init(frame: CGRect) {
//        self.commonInit()
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        self.commonInit()
//    }
//    
//    func titleRectForContentRect(contentRect: CGRect) -> CGRect {
//        var textRect: CGRect = self.title(for: self.state)!.boundingRectWithSize(size, options: NSStringDrawingUsesLineFragmentOrigin, attributes: [NSFontAttributeName:self.font], context: nil)
//        var size: CGSize = textRect.size
//        
//        var size: CGSize = .sizeWithFont(self.font, constrainedToSize: contentRect.size)
//        // clang diagnostic pop
//        var iconSize: CGSize = CGSizeEqualToSize(self.iconSize, CGSizeZero) ? super.imageRectForContentRect(contentRect).size : self.iconSize
//        var totalWidth: CGFloat = size.width+iconSize.width+self.iconMargin
//        var totalHeight: CGFloat = size.height+iconSize.height+self.iconMargin
//        var rect: CGRect = {
//            switch self.contentHorizontalAlignment {
//            case UIControlContentHorizontalAlignmentLeft:
//                
//                switch _iconPosition {
//                case SPIconPositionRight:
//                    
//                    rect.origin.x = CGRectGetMinX(contentRect)
//                    break
//                case SPIconPositionLeft:
//                    
//                    rect.origin.x = CGRectGetMinX(contentRect)+totalWidth-size.width
//                    break
//                default:
//                    
//                    rect.origin.x = CGRectGetMinX(contentRect)
//                    break
//                }
//                break
//            case UIControlContentHorizontalAlignmentRight:
//                
//                switch _iconPosition {
//                case SPIconPositionRight:
//                    
//                    rect.origin.x = CGRectGetMaxX(contentRect)-totalWidth
//                    break
//                case SPIconPositionLeft:
//                    
//                    rect.origin.x = CGRectGetMaxX(contentRect)-size.width
//                    break
//                default:
//                    
//                    rect.origin.x = CGRectGetMaxX(contentRect)-size.width
//                    break
//                }
//                break
//            case UIControlContentHorizontalAlignmentFill:
//                
//                switch _iconPosition {
//                case SPIconPositionRight:
//                    
//                    rect.origin.x = CGRectGetMinX(contentRect)
//                    break
//                case SPIconPositionLeft:
//                    
//                    rect.origin.x = CGRectGetMaxX(contentRect)-size.width
//                    break
//                default:
//                    
//                    rect.origin.x = CGRectGetMinX(contentRect)+(CGRectGetWidth(contentRect)-size.width)/2
//                    break
//                }
//                break
//            default:
//                
//                switch _iconPosition {
//                case SPIconPositionRight:
//                    
//                    rect.origin.x = CGRectGetMinX(contentRect)+(CGRectGetWidth(contentRect)-totalWidth)/2
//                    break
//                case SPIconPositionLeft:
//                    
//                    rect.origin.x = CGRectGetMinX(contentRect)+CGRectGetWidth(contentRect)-(CGRectGetWidth(contentRect)-totalWidth)/2-size.width
//                    break
//                default:
//                    
//                    rect.origin.x = CGRectGetMinX(contentRect)+(CGRectGetWidth(contentRect)-size.width)/2
//                    break
//                }
//                break
//            }
//            switch self.contentVerticalAlignment {
//            case UIControlContentVerticalAlignmentTop:
//                
//                switch _iconPosition {
//                case SPIconPositionTop:
//                    
//                    rect.origin.y = CGRectGetMinY(contentRect)+totalHeight-size.height
//                    break
//                case SPIconPositionBottom:
//                    
//                    rect.origin.y = CGRectGetMinY(contentRect)
//                    break
//                default:
//                    
//                    rect.origin.y = CGRectGetMinY(contentRect)
//                    break
//                }
//                break
//            case UIControlContentVerticalAlignmentBottom:
//                
//                switch _iconPosition {
//                case SPIconPositionTop:
//                    
//                    rect.origin.y = CGRectGetMaxY(contentRect)-size.height
//                    break
//                case SPIconPositionBottom:
//                    
//                    rect.origin.y = CGRectGetMaxY(contentRect)-totalHeight
//                    break
//                default:
//                    
//                    rect.origin.y = CGRectGetMaxY(contentRect)-size.height
//                    break
//                }
//                break
//            case UIControlContentVerticalAlignmentFill:
//                
//                switch _iconPosition {
//                case SPIconPositionTop:
//                    
//                    rect.origin.y = CGRectGetMaxY(contentRect)-size.height
//                    break
//                case SPIconPositionBottom:
//                    
//                    rect.origin.y = CGRectGetMinY(contentRect)
//                    break
//                default:
//                    
//                    rect.origin.y = CGRectGetMinY(contentRect)+(CGRectGetHeight(contentRect)-size.height)/2
//                    break
//                }
//                break
//            default:
//                
//                switch _iconPosition {
//                case SPIconPositionTop:
//                    
//                    rect.origin.y = CGRectGetMaxY(contentRect)-(CGRectGetHeight(contentRect)-totalHeight)/2-size.height
//                    break
//                case SPIconPositionBottom:
//                    
//                    rect.origin.y = CGRectGetMinY(contentRect)+(CGRectGetHeight(contentRect)-totalHeight)/2
//                    break
//                default:
//                    
//                    rect.origin.y = CGRectGetMinY(contentRect)+(CGRectGetHeight(contentRect)-size.height)/2
//                    break
//                }
//                break
//            }
//            return rect
//        }
//        
//        func imageRectForContentRect(contentRect: CGRect) -> CGRect {
//            var size: CGSize = CGSizeEqualToSize(self.iconSize, CGSizeZero) ? super.imageRectForContentRect(contentRect).size : self.iconSize
//            var titleSize: CGSize = self.titleRectForContentRect(contentRect).size
//            switch _iconPosition {
//            case SPIconPositionTop:
//                
//            case SPIconPositionBottom:
//                
//                size.height = MAX(MIN(CGRectGetHeight(contentRect)-self.iconMargin-titleSize.height, size.height), self.iconSize.height)
//                break
//            default:
//                
//                size.width = MAX(MIN(CGRectGetWidth(contentRect)-self.iconMargin-titleSize.width, size.width), self.iconSize.width)
//                break
//            }
//            var totalWidth: CGFloat = size.width+titleSize.width+self.iconMargin
//            var totalHeight: CGFloat = size.height+titleSize.height+self.iconMargin
//            var rect: CGRect = {
//                switch self.contentHorizontalAlignment {
//                case UIControlContentHorizontalAlignmentLeft:
//                    
//                    switch _iconPosition {
//                    case SPIconPositionRight:
//                        
//                        rect.origin.x = CGRectGetMinX(contentRect)+totalWidth-size.width
//                        break
//                    case SPIconPositionLeft:
//                        
//                        rect.origin.x = CGRectGetMinX(contentRect)
//                        break
//                    default:
//                        
//                        rect.origin.x = CGRectGetMinX(contentRect)
//                        break
//                    }
//                    break
//                case UIControlContentHorizontalAlignmentRight:
//                    
//                    switch _iconPosition {
//                    case SPIconPositionRight:
//                        
//                        rect.origin.x = CGRectGetMaxX(contentRect)-size.width
//                        break
//                    case SPIconPositionLeft:
//                        
//                        rect.origin.x = CGRectGetMaxX(contentRect)-totalWidth
//                        break
//                    default:
//                        
//                        rect.origin.x = CGRectGetMaxX(contentRect)-size.width
//                        break
//                    }
//                    break
//                case UIControlContentHorizontalAlignmentFill:
//                    
//                    switch _iconPosition {
//                    case SPIconPositionRight:
//                        
//                        rect.origin.x = CGRectGetMaxX(contentRect)-size.width
//                        break
//                    case SPIconPositionLeft:
//                        
//                        rect.origin.x = CGRectGetMinX(contentRect)
//                        break
//                    default:
//                        
//                        rect.origin.x = CGRectGetMinX(contentRect)+(CGRectGetWidth(contentRect)-size.width)/2
//                        break
//                    }
//                    break
//                default:
//                    
//                    switch _iconPosition {
//                    case SPIconPositionRight:
//                        
//                        rect.origin.x = CGRectGetMinX(contentRect)+CGRectGetWidth(contentRect)-(CGRectGetWidth(contentRect)-totalWidth)/2-size.width
//                        break
//                    case SPIconPositionLeft:
//                        
//                        rect.origin.x = CGRectGetMinX(contentRect)+(CGRectGetWidth(contentRect)-totalWidth)/2
//                        break
//                    default:
//                        
//                        rect.origin.x = CGRectGetMinX(contentRect)+(CGRectGetWidth(contentRect)-size.width)/2
//                        break
//                    }
//                    break
//                }
//                switch self.contentVerticalAlignment {
//                case UIControlContentVerticalAlignmentTop:
//                    
//                    switch _iconPosition {
//                    case SPIconPositionTop:
//                        
//                        rect.origin.y = CGRectGetMinY(contentRect)
//                        break
//                    case SPIconPositionBottom:
//                        
//                        rect.origin.y = CGRectGetMinY(contentRect)+totalHeight-size.height
//                        break
//                    default:
//                        
//                        rect.origin.y = CGRectGetMinY(contentRect)
//                        break
//                    }
//                    break
//                case UIControlContentVerticalAlignmentBottom:
//                    
//                    switch _iconPosition {
//                    case SPIconPositionTop:
//                        
//                        rect.origin.y = CGRectGetMaxY(contentRect)-totalHeight
//                        break
//                    case SPIconPositionBottom:
//                        
//                        rect.origin.y = CGRectGetMaxY(contentRect)-size.height
//                        break
//                    default:
//                        
//                        rect.origin.y = CGRectGetMaxY(contentRect)-size.height
//                        break
//                    }
//                    break
//                case UIControlContentVerticalAlignmentFill:
//                    
//                    switch _iconPosition {
//                    case SPIconPositionTop:
//                        
//                        rect.origin.y = CGRectGetMinY(contentRect)
//                        break
//                    case SPIconPositionBottom:
//                        
//                        rect.origin.y = CGRectGetMaxY(contentRect)-size.height
//                        break
//                    default:
//                        
//                        rect.origin.y = CGRectGetMinY(contentRect)+(CGRectGetHeight(contentRect)-size.height)/2
//                        break
//                    }
//                    break
//                default:
//                    
//                    switch _iconPosition {
//                    case SPIconPositionTop:
//                        
//                        rect.origin.y = CGRectGetMinY(contentRect)+(CGRectGetHeight(contentRect)-totalHeight)/2
//                        break
//                    case SPIconPositionBottom:
//                        
//                        rect.origin.y = CGRectGetMaxY(contentRect)-(CGRectGetHeight(contentRect)-totalHeight)/2-size.height
//                        break
//                    default:
//                        
//                        rect.origin.y = CGRectGetMinY(contentRect)+(CGRectGetHeight(contentRect)-size.height)/2
//                        break
//                    }
//                    break
//                }
//                return rect
//            }
//            
//            func intrinsicContentSize() -> CGSize {
//                var contentRect: CGRect = self.contentRectForBounds(self.bounds)
//                // clang diagnostic push
//                // clang diagnostic ignored "-Wdeprecated"
//                var titleSize: CGSize = self.titleForState(self.state).sizeWithFont(self.font)
//                // clang diagnostic pop
//                var imageSize: CGSize = CGSizeEqualToSize(self.iconSize, CGSizeZero) ? super.imageRectForContentRect(contentRect).size : self.iconSize
//                switch _iconPosition {
//                case SPIconPositionTop:
//                    
//                case SPIconPositionBottom:
//                    
//                    return CGSizeMake(MAX(titleSize.width, imageSize.width), titleSize.height+imageSize.height+self.iconMargin)
//                    break
//                default:
//                    
//                    return CGSizeMake(titleSize.width+imageSize.width+self.iconMargin, MAX(titleSize.height, imageSize.height))
//                    break
//                }
//            }
//            
//            func sizeThatFits(size: CGSize) -> CGSize {
//                return self.intrinsicContentSize()
//            }
//    
//}
