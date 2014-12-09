//
//  UIView+MALibrary.m
//  MALibrary
//
//  Created by Andrew Kopanev on 7/24/13.
//  Copyright (c) 2013 Moqod. All rights reserved.
//

#import "UIView+MALibrary.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIView (MALibrary)

#pragma mark -

- (UIImage *)maSnapshot {
	UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 0.0f);
	[self.layer renderInContext:UIGraphicsGetCurrentContext()];
	UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return image;
}

#pragma mark -

- (BOOL)maFindAndResignFirstResponder {
	if (self.isFirstResponder) {
        [self resignFirstResponder];
        return YES;
    }
    for (UIView *subView in self.subviews) {
        if ([subView maFindAndResignFirstResponder]) {
            return YES;
		}
    }
    return NO;
}

#pragma mark -

- (void)maRemoveAllSubviews {
	for (UIView *v in self.subviews) {
		[v removeFromSuperview];
	}
}

@end