//
//  UIImage+MARoundedCorner.h
//  iOS Library
//
//  Created by Andrew Kopanev on 2/3/14.
//  Copyright (c) 2014 Moqod. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *	Creates rounded image with give background color and corner radius.
 *	Useful for creating buttons with stretchable background images, etc.
 *	Uses UIView+MALibrary.
 */

@interface UIImage (MASimpleImages)

// rounded image
+ (UIImage *)maRoundedImageWithSize:(CGSize)size cornerRadius:(CGFloat)cornerRadius backgroundColor:(UIColor *)backgroundColor;

// rect image
+ (UIImage *)maRectImageWithSize:(CGSize)size backgroundColor:(UIColor *)backgroundColor;
+ (UIImage *)maRectImageWithSize:(CGSize)size backgroundColor:(UIColor *)backgroundColor borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

// returns stretchable image (stretch point == center)
- (UIImage *)maStretchableImage;

@end
