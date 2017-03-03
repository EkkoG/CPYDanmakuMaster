//
//  UIView+CPY_Utils.m
//  Pods
//
//  Created by ciel on 2017/2/27.
//
//

#import "UIView+CPY_Utils.h"

@implementation UIView (CPY_Utils)

- (BOOL)cpy_haveSize {
    if (CGSizeEqualToSize(self.frame.size, CGSizeZero)) {
        return NO;
    }
    if (self.frame.size.height == 0) {
        return NO;
    }
    if (self.frame.size.width == 0) {
        return NO;
    }
    return YES;
}
@end
