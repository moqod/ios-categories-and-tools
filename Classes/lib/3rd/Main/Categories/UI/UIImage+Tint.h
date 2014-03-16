//
//  UIImage+Tint.h
//
//  Created by Matt Gemmell on 04/07/2010.
//  Copyright 2010 Instinctive Code.
//

#import <UIKit/UIKit.h>

@interface UIImage (MGTint)

- (UIImage *)imageTintedWithColor:(UIColor *)color;
- (UIImage *)imageTintedWithColor:(UIColor *)color fraction:(CGFloat)fraction;

//another version
- (UIImage *)tintedImageUsingColor:(UIColor *)tintColor;

//another version
-(UIImage *)getImageWithUnsaturatedPixelsOfImage:(UIImage *)image;
-(UIImage *)getImageWithTintedColor:(UIImage *)image withTint:(UIColor *)color withIntensity:(float)alpha;
@end
