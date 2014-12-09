//
//  UIButton+MALibrary.h
//  iOS Library
//
//  Created by Andrew Kopanev on 12/9/14.
//  Copyright (c) 2014 Moqod. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *	Creates buttons with one line of code.
 *	Syntax sugar.
 */

@interface UIButton (MALibrary)

+ (UIButton *)maButtonWithImage:(UIImage *)image;
+ (UIButton *)maButtonWithImage:(UIImage *)image highlightedImage:(UIImage *)highlightedImage;

+ (UIButton *)maButtonWithBackgroundImage:(UIImage *)image;
+ (UIButton *)maButtonWithBackgroundImage:(UIImage *)image highlightedBackgroundImage:(UIImage *)highlightedImage;

@end
