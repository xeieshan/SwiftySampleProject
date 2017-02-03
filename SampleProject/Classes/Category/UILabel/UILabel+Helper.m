//
//  UILabel+Helper.m
//  <#Project Name#>
//
//  Created by <#Project Developer#> on 1/12/16.
//  Copyright (c) 2015 <#Project Name#>. All rights reserved.
//

#import "UILabel+Helper.h"
#import "SampleProject-Swift.h"

@class UIConfiguration;

@implementation UILabel (Helper)
- (void)setSubstituteFontName:(NSString *)name UI_APPEARANCE_SELECTOR {
    UIFontDescriptor *fontDescriptor = self.font.fontDescriptor;
    UIFontDescriptorSymbolicTraits fontDescriptorSymbolicTraits = fontDescriptor.symbolicTraits;
    BOOL isBold = (fontDescriptorSymbolicTraits & UIFontDescriptorTraitBold) != 0;
    BOOL isItalics = (fontDescriptorSymbolicTraits & UIFontDescriptorTraitItalic) != 0;
    if (isBold) {
        self.font = [UIFont fontWithName:[UIConfiguration getUIFONTAPPBOLD] size:self.font.pointSize];
    }else if (isItalics) {
        self.font = [UIFont fontWithName:[UIConfiguration getUIFONTAPPITALIC] size:self.font.pointSize];
    }else{
        self.font = [UIFont fontWithName:name size:self.font.pointSize];
    }
}
@end
