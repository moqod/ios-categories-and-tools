//
//  UIImage+MALoading.h
//  iOS Library
//
//  Created by Andrew Kopanev on 2/14/14.
//  Copyright (c) 2014 Moqod. All rights reserved.
//

#import <UIKit/UIKit.h>

// This category caches images initialized with contents of file.
// When an image is deallocated - then cache is cleared.
// Useful when you load same images in different views.

@interface UIImage (MALoading)

// Smart 'imageWithContentsOfFile' method implementation.
+ (UIImage *)maImageWithContentsOfFile:(NSString *)filePath;
- (instancetype)maInitWithContentsOfFile:(NSString *)filePath;

// Useful for loading background images (like splash images, etc).
+ (UIImage *)maBackgroundBundleImageWithContentsOfFile:(NSString *)imageFileName;
+ (UIImage *)maBackgroundBundleImageWithContentsOfFile:(NSString *)imageFileName fromBundle:(NSBundle *)bundle;
+ (UIImage *)maBundleImageWithContentsOfFile:(NSString *)imageFileName;
+ (UIImage *)maBundleImageWithContentsOfFile:(NSString *)imageFileName fromBundle:(NSBundle *)bundle;

@end
