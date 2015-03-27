//
//  UIImageView+MAImage.h
//  iOS Library
//
//  Created by Sergey Ryazanov on 27.03.15.
//  Copyright (c) 2015 Moqod. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (MAImage)

/**
 *  Set new image for UIImageView and change the UIImageView size to the size of the image.
 *
 *  Return image of UIImageView.
 */
@property (nonatomic, retain) UIImage *maImage;

+ (instancetype)maWithImage:(UIImage *)image highlightedImage:(UIImage *)highlightedImage;
+ (instancetype)maWithImage:(UIImage *)image;


@end
