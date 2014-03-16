//
//  UIImage+MARoundedCorner.h
//  iOS Library
//
//  Created by Andrew Kopanev on 2/3/14.
//  Copyright (c) 2014 Moqod. All rights reserved.
//

#import <UIKit/UIKit.h>

// Uses UIView+MALibrary

@interface UIImage (MARoundedCorner)

+ (UIImage *)maRoundedImageWithSize:(CGSize)size cornerRadius:(CGFloat)cornerRadius backgroundColor:(UIColor *)backgroundColor;

@end
