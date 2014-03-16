//
//  UIImage+MALoading.h
//  iOS Library
//
//  Created by Andrew Kopanev on 2/14/14.
//  Copyright (c) 2014 Moqod & Apps With Love. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (MALoading)

+ (UIImage *)maImageWithContentsOfFile:(NSString *)filePath;
- (instancetype)maInitWithContentsOfFile:(NSString *)filePath;

@end
