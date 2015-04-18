//
//  UIImageView+MAImage.m
//  iOS Library
//
//  Created by Sergey Ryazanov on 27.03.15.
//  Copyright (c) 2015 Moqod. All rights reserved.
//

#import "UIImageView+MAImage.h"

@implementation UIImageView (MAImage)

+ (instancetype)maWithImage:(UIImage *)image
{
    return [self maWithImage:image highlightedImage:nil];
}

+ (instancetype)maWithImage:(UIImage *)image highlightedImage:(UIImage *)highlightedImage
{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image highlightedImage:highlightedImage];
    return imageView;
}

#pragma mark - Image

- (void)setMaImage:(UIImage *)maImage
{
    self.image = maImage;
    
    CGRect frame = self.frame;
    frame.size = maImage.size;
    self.frame = frame;
}

- (UIImage *)maImage
{
    return self.image;
}

@end
