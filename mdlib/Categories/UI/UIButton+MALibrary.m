//
//  UIButton+MALibrary.m
//  iOS Library
//
//  Created by Andrew Kopanev on 12/9/14.
//  Copyright (c) 2014 Moqod. All rights reserved.
//

#import "UIButton+MALibrary.h"

@implementation UIButton (MALibrary)

#pragma mark -

+ (UIButton *)maButtonWithImage:(UIImage *)image highlightedImage:(UIImage *)highlightedImage isBackground:(BOOL)isBackground {
	UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
	if (isBackground) {
		[button setBackgroundImage:image forState:UIControlStateNormal];
	} else {
		[button setImage:image forState:UIControlStateNormal];
	}
	if (highlightedImage) {
		if (isBackground) {
			[button setBackgroundImage:highlightedImage forState:UIControlStateHighlighted];
		} else {
			[button setImage:highlightedImage forState:UIControlStateHighlighted];
		}
	}
	button.frame = CGRectMake(0.0, 0.0, image.size.width, image.size.height);
	return button;
}

#pragma mark -

+ (UIButton *)maButtonWithImage:(UIImage *)image {
	return [self maButtonWithImage:image highlightedImage:nil isBackground:NO];
}

+ (UIButton *)maButtonWithImage:(UIImage *)image highlightedImage:(UIImage *)highlightedImage {
	return [self maButtonWithImage:image highlightedImage:highlightedImage isBackground:NO];
}

#pragma mark -

+ (UIButton *)maButtonWithBackgroundImage:(UIImage *)image {
	return [self maButtonWithImage:image highlightedImage:nil isBackground:YES];
}

+ (UIButton *)maButtonWithBackgroundImage:(UIImage *)image highlightedBackgroundImage:(UIImage *)highlightedImage {
	return [self maButtonWithImage:image highlightedImage:highlightedImage isBackground:YES];
}

@end
