//
//  UIColor+Tools.h
//  MALibrary
//
//  Created by Andrew Kopanev on 2/21/13.
//  Copyright (c) 2013 Moqod. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *	Helpful additional methods for UIColor class.
 */

@interface UIColor (MATools)

/**
 @name Debug
 */

/**
 Creates and returns a random color.
 */
+ (UIColor *)maRandomColor;

/**
 @name Color construction
 */

/**
 Creates a color from RGB scheme.
 
 Example: [UIColor colorFromRGB:0x023593]
 
 @param rgb Hex value of a color.
 */

+ (UIColor *)maColorFromRGB:(unsigned int)rgb;

/**
 Creates a color from RGB scheme with given alpha value
 
 Example: [UIColor colorFromRGB:0x023593 alpha:0.5f]
 
 @param rgb Hex value of a color.
 @param alpha Float value of transparency.
 */

+ (UIColor *)maColorFromRGB:(unsigned int)rgb alpha:(CGFloat)alpha;

/**
 Creates a color from integer values with range [0..255].
 
 Example: [UIColor intColorWithRed:255 gree:255 blue:255 alpha:255] returns white color.
 
 @param red Red component of a color.
 @param red Green component of a color.
 @param red Blue component of a color.
 @param red Alpha component of a color.
 */
+ (UIColor *)maIntColorWithRed:(unsigned int)red green:(unsigned int)green blue:(unsigned int)blue alpha:(unsigned int)alpha;

// These methods return color compoments.
@property (nonatomic, readonly) CGFloat		maRed;
@property (nonatomic, readonly) CGFloat		maGreen;
@property (nonatomic, readonly) CGFloat		maBlue;
@property (nonatomic, readonly) CGFloat		maAlpha;

@end
