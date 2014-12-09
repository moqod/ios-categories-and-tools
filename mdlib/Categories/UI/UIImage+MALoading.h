//
//  UIImage+MALoading.h
//  iOS Library
//
//  Created by Andrew Kopanev on 2/14/14.
//  Copyright (c) 2014 Moqod. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *	This category provides set of methods for easy images loading.
 *	Main of them is `maImageWithContentsOfFile` - this method adds smart caching for loaded images.
 *	It's like `imageNamed`, but a little bit smarter - it kills images when they not needed anymore.
 *	For example, you can use same image in different views, but want to release it when these views deallocated.
 *	Other methods are for loading background images and some syntax sugar.
 */

@interface UIImage (MALoading)

// Smart `+ (UIImage *)imageWithContentsOfFile:` method implementation.
// Caches image like `+ (UIImage *)imageNamed:` method, but image will be released when nobody owns it.
// See implementation for understanding.
+ (UIImage *)maImageWithContentsOfFile:(NSString *)filePath;
- (instancetype)maInitWithContentsOfFile:(NSString *)filePath;

// Constructs file path using NSBundle's '- (NSString *)pathForResource:ofType:' method.
// Mostly is syntax sugar for developers, but this method also uses `-(UIImage *)maImageWithContentsOfFile:` for smart caching.
+ (UIImage *)maImageNamed:(NSString *)imageFileName;
+ (UIImage *)maImageNamed:(NSString *)imageFileName bundle:(NSBundle *)bundle;

@end
