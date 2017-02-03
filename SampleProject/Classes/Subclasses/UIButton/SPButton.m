//
//  SPButton.m
//  <#Project Name#>
//
//  Created by <#Project Developer#> on 12/11/2015.
//  Copyright (c) 2015 <#Project Name#>. All rights reserved.
//

#import "SPButton.h"

@implementation SPButton

- (void)commonInit
{
    self.iconSize = CGSizeZero;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated"
    CGSize size = [[self titleForState:self.state] sizeWithFont:self.font
                                              constrainedToSize:contentRect.size];
#pragma clang diagnostic pop
    CGSize iconSize = CGSizeEqualToSize(self.iconSize, CGSizeZero) ? [super imageRectForContentRect:contentRect].size : self.iconSize;
    CGFloat totalWidth = size.width + iconSize.width + self.iconMargin;
    CGFloat totalHeight = size.height + iconSize.height + self.iconMargin;
    CGRect rect = {{0, 0}, size};
    switch (self.contentHorizontalAlignment) {
        case UIControlContentHorizontalAlignmentLeft:
            switch (_iconPosition) {
                case SPIconPositionRight:
                    rect.origin.x = CGRectGetMinX(contentRect);
                    break;
                case SPIconPositionLeft:
                    rect.origin.x = CGRectGetMinX(contentRect) + totalWidth - size.width;
                    break;
                default:
                    rect.origin.x = CGRectGetMinX(contentRect);
                    break;
            }
            break;
        case UIControlContentHorizontalAlignmentRight:
            switch (_iconPosition) {
                case SPIconPositionRight:
                    rect.origin.x = CGRectGetMaxX(contentRect) - totalWidth;
                    break;
                case SPIconPositionLeft:
                    rect.origin.x = CGRectGetMaxX(contentRect) - size.width;
                    break;
                default:
                    rect.origin.x = CGRectGetMaxX(contentRect) - size.width;
                    break;
            }
            break;
        case UIControlContentHorizontalAlignmentFill:
            switch (_iconPosition) {
                case SPIconPositionRight:
                    rect.origin.x = CGRectGetMinX(contentRect);
                    break;
                case SPIconPositionLeft:
                    rect.origin.x = CGRectGetMaxX(contentRect) - size.width;
                    break;
                default:
                    rect.origin.x = CGRectGetMinX(contentRect) + (CGRectGetWidth(contentRect) - size.width) / 2;
                    break;
            }
            break;
        default:
            switch (_iconPosition) {
                case SPIconPositionRight:
                    rect.origin.x = CGRectGetMinX(contentRect) + (CGRectGetWidth(contentRect) - totalWidth) / 2;
                    break;
                case SPIconPositionLeft:
                    rect.origin.x = CGRectGetMinX(contentRect) + CGRectGetWidth(contentRect) - (CGRectGetWidth(contentRect) - totalWidth) / 2 - size.width;
                    break;
                default:
                    rect.origin.x = CGRectGetMinX(contentRect) + (CGRectGetWidth(contentRect) - size.width) / 2;
                    break;
            }
            break;
    }
    
    switch (self.contentVerticalAlignment) {
        case UIControlContentVerticalAlignmentTop:
            switch (_iconPosition) {
                case SPIconPositionTop:
                    rect.origin.y = CGRectGetMinY(contentRect) + totalHeight - size.height;
                    break;
                case SPIconPositionBottom:
                    rect.origin.y = CGRectGetMinY(contentRect);
                    break;
                default:
                    rect.origin.y = CGRectGetMinY(contentRect);
                    break;
            }
            break;
        case UIControlContentVerticalAlignmentBottom:
            switch (_iconPosition) {
                case SPIconPositionTop:
                    rect.origin.y = CGRectGetMaxY(contentRect) - size.height;
                    break;
                case SPIconPositionBottom:
                    rect.origin.y = CGRectGetMaxY(contentRect) - totalHeight;
                    break;
                default:
                    rect.origin.y = CGRectGetMaxY(contentRect) - size.height;
                    break;
            }
            break;
        case UIControlContentVerticalAlignmentFill:
            switch (_iconPosition) {
                case SPIconPositionTop:
                    rect.origin.y = CGRectGetMaxY(contentRect) - size.height;
                    break;
                case SPIconPositionBottom:
                    rect.origin.y = CGRectGetMinY(contentRect);
                    break;
                default:
                    rect.origin.y = CGRectGetMinY(contentRect) + (CGRectGetHeight(contentRect) - size.height) / 2;
                    break;
            }
            break;
        default:
            switch (_iconPosition) {
                case SPIconPositionTop:
                    rect.origin.y = CGRectGetMaxY(contentRect) - (CGRectGetHeight(contentRect) - totalHeight) / 2 - size.height;
                    break;
                case SPIconPositionBottom:
                    rect.origin.y = CGRectGetMinY(contentRect) + (CGRectGetHeight(contentRect) - totalHeight) / 2;
                    break;
                default:
                    rect.origin.y = CGRectGetMinY(contentRect) + (CGRectGetHeight(contentRect) - size.height) / 2;
                    break;
            }
            break;
    }
    return rect;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGSize size = CGSizeEqualToSize(self.iconSize, CGSizeZero) ? [super imageRectForContentRect:contentRect].size : self.iconSize;
    CGSize titleSize = [self titleRectForContentRect:contentRect].size;
    
    switch (_iconPosition) {
        case SPIconPositionTop:
        case SPIconPositionBottom:
            size.height = MAX(MIN(CGRectGetHeight(contentRect) - self.iconMargin - titleSize.height, size.height), self.iconSize.height);
            break;
        default:
            size.width = MAX(MIN(CGRectGetWidth(contentRect) - self.iconMargin - titleSize.width, size.width), self.iconSize.width);
            break;
    }
    
    CGFloat totalWidth = size.width + titleSize.width + self.iconMargin;
    CGFloat totalHeight = size.height + titleSize.height + self.iconMargin;
    CGRect rect = {{0, 0}, size};
    switch (self.contentHorizontalAlignment) {
        case UIControlContentHorizontalAlignmentLeft:
            switch (_iconPosition) {
                case SPIconPositionRight:
                    rect.origin.x = CGRectGetMinX(contentRect) + totalWidth - size.width;
                    break;
                case SPIconPositionLeft:
                    rect.origin.x = CGRectGetMinX(contentRect);
                    break;
                default:
                    rect.origin.x = CGRectGetMinX(contentRect);
                    break;
            }
            break;
        case UIControlContentHorizontalAlignmentRight:
            switch (_iconPosition) {
                case SPIconPositionRight:
                    rect.origin.x = CGRectGetMaxX(contentRect) - size.width;
                    break;
                case SPIconPositionLeft:
                    rect.origin.x = CGRectGetMaxX(contentRect) - totalWidth;
                    break;
                default:
                    rect.origin.x = CGRectGetMaxX(contentRect) - size.width;
                    break;
            }
            break;
        case UIControlContentHorizontalAlignmentFill:
            switch (_iconPosition) {
                case SPIconPositionRight:
                    rect.origin.x = CGRectGetMaxX(contentRect) - size.width;
                    break;
                case SPIconPositionLeft:
                    rect.origin.x = CGRectGetMinX(contentRect);
                    break;
                default:
                    rect.origin.x = CGRectGetMinX(contentRect) + (CGRectGetWidth(contentRect) - size.width) / 2;
                    break;
            }
            break;
        default:
            switch (_iconPosition) {
                case SPIconPositionRight:
                    rect.origin.x = CGRectGetMinX(contentRect) + CGRectGetWidth(contentRect) - (CGRectGetWidth(contentRect) - totalWidth) / 2 - size.width;
                    break;
                case SPIconPositionLeft:
                    rect.origin.x = CGRectGetMinX(contentRect) + (CGRectGetWidth(contentRect) - totalWidth) / 2;
                    break;
                default:
                    rect.origin.x = CGRectGetMinX(contentRect) + (CGRectGetWidth(contentRect) - size.width) / 2;
                    break;
            }
            break;
    }
    
    switch (self.contentVerticalAlignment) {
        case UIControlContentVerticalAlignmentTop:
            switch (_iconPosition) {
                case SPIconPositionTop:
                    rect.origin.y = CGRectGetMinY(contentRect);
                    break;
                case SPIconPositionBottom:
                    rect.origin.y = CGRectGetMinY(contentRect) + totalHeight - size.height;
                    break;
                default:
                    rect.origin.y = CGRectGetMinY(contentRect);
                    break;
            }
            break;
        case UIControlContentVerticalAlignmentBottom:
            switch (_iconPosition) {
                case SPIconPositionTop:
                    rect.origin.y = CGRectGetMaxY(contentRect) - totalHeight;
                    break;
                case SPIconPositionBottom:
                    rect.origin.y = CGRectGetMaxY(contentRect) - size.height;
                    break;
                default:
                    rect.origin.y = CGRectGetMaxY(contentRect) - size.height;
                    break;
            }
            break;
        case UIControlContentVerticalAlignmentFill:
            switch (_iconPosition) {
                case SPIconPositionTop:
                    rect.origin.y = CGRectGetMinY(contentRect);
                    break;
                case SPIconPositionBottom:
                    rect.origin.y = CGRectGetMaxY(contentRect) - size.height;
                    break;
                default:
                    rect.origin.y = CGRectGetMinY(contentRect) + (CGRectGetHeight(contentRect) - size.height) / 2;
                    break;
            }
            break;
        default:
            switch (_iconPosition) {
                case SPIconPositionTop:
                    rect.origin.y = CGRectGetMinY(contentRect) + (CGRectGetHeight(contentRect) - totalHeight) / 2;
                    break;
                case SPIconPositionBottom:
                    rect.origin.y = CGRectGetMaxY(contentRect) - (CGRectGetHeight(contentRect) - totalHeight) / 2 - size.height;
                    break;
                default:
                    rect.origin.y = CGRectGetMinY(contentRect) + (CGRectGetHeight(contentRect) - size.height) / 2;
                    break;
            }
            break;
    }
    
    return rect;
}

- (CGSize)intrinsicContentSize
{
    CGRect contentRect = [self contentRectForBounds:self.bounds];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated"
    CGSize titleSize = [[self titleForState:self.state] sizeWithFont:self.font];
#pragma clang diagnostic pop
    CGSize imageSize = CGSizeEqualToSize(self.iconSize, CGSizeZero) ? [super imageRectForContentRect:contentRect].size : self.iconSize;
    
    switch (_iconPosition) {
        case SPIconPositionTop:
        case SPIconPositionBottom:
            return CGSizeMake(MAX(titleSize.width, imageSize.width), titleSize.height + imageSize.height + self.iconMargin);
            
            break;
        default:
            return CGSizeMake(titleSize.width + imageSize.width + self.iconMargin, MAX(titleSize.height, imageSize.height));
            break;
    }
}

- (CGSize)sizeThatFits:(CGSize)size
{
    return [self intrinsicContentSize];
}

@end
