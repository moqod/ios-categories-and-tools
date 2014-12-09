//
//  MDLoadImagesManager.m
//  pkshr
//
//  Created by Andrew Kopanev on 6/15/14.
//  Copyright (c) 2014 moqod. All rights reserved.
//

#import "MDLoadImagesManager.h"
#import "NSNotificationCenter+MAKeys.h"
#import <UIKit/UIKit.h>

@interface MDLoadImagesManager ()

@property (nonatomic, retain) NSOperationQueue *loadingOperationQueue;

@end

@implementation MDLoadImagesManager

+ (instancetype)sharedManager {
    static dispatch_once_t pred;
    static id sharedInstance = nil;
    dispatch_once(&pred, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (id)init {
	if (self = [super init]) {
		self.loadingOperationQueue = [NSOperationQueue new];
#if !__has_feature(objc_arc)
		[self.loadingOperationQueue autorelease];
#endif
		self.loadingOperationQueue.maxConcurrentOperationCount = 1;
	}
	return self;
}

#pragma mark -

- (void)asyncLoadImageAtPath:(NSString *)path notificationName:(NSString *)notificationName userInfo:(id)userInfo {
	[self.loadingOperationQueue addOperationWithBlock:^{
		UIImage *image = [self decompressedImageWithContentsOfFile:path];
		[[NSNotificationCenter defaultCenter] maSendNotificationNamed:notificationName object:self result:image error:nil userInfo:userInfo onMainThread:YES];
	}];
}

#pragma mark -

- (void)dealloc {
	self.loadingOperationQueue = nil;
#if !__has_feature(objc_arc)
	[super dealloc];
#endif
}

#pragma mark -

// I guess we took it from SDWebImage
// pls put copyright...
- (UIImage *)decompressedImageWithContentsOfFile:(NSString *)filePath {
	UIImage *image = [UIImage imageWithContentsOfFile:filePath];
	if(nil == image) return image;
    if (image.images)
    {
        // Do not decode animated images
        return image;
    }
	
    CGImageRef imageRef = image.CGImage;
    CGSize imageSize = CGSizeMake(CGImageGetWidth(imageRef), CGImageGetHeight(imageRef));
    CGRect imageRect = (CGRect){.origin = CGPointZero, .size = imageSize};
	
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGBitmapInfo bitmapInfo = CGImageGetBitmapInfo(imageRef);
	
    int infoMask = (bitmapInfo & kCGBitmapAlphaInfoMask);
    BOOL anyNonAlpha = (infoMask == kCGImageAlphaNone ||
                        infoMask == kCGImageAlphaNoneSkipFirst ||
                        infoMask == kCGImageAlphaNoneSkipLast);
	
    // CGBitmapContextCreate doesn't support kCGImageAlphaNone with RGB.
    // https://developer.apple.com/library/mac/#qa/qa1037/_index.html
    if (infoMask == kCGImageAlphaNone && CGColorSpaceGetNumberOfComponents(colorSpace) > 1)
    {
        // Unset the old alpha info.
        bitmapInfo &= ~kCGBitmapAlphaInfoMask;
		
        // Set noneSkipFirst.
        bitmapInfo |= kCGImageAlphaNoneSkipFirst;
    }
    // Some PNGs tell us they have alpha but only 3 components. Odd.
    else if (!anyNonAlpha && CGColorSpaceGetNumberOfComponents(colorSpace) == 3)
    {
        // Unset the old alpha info.
        bitmapInfo &= ~kCGBitmapAlphaInfoMask;
        bitmapInfo |= kCGImageAlphaPremultipliedFirst;
    }
	
    // It calculates the bytes-per-row based on the bitsPerComponent and width arguments.
    CGContextRef context = CGBitmapContextCreate(NULL,
                                                 imageSize.width,
                                                 imageSize.height,
                                                 CGImageGetBitsPerComponent(imageRef),
                                                 0,
                                                 colorSpace,
                                                 bitmapInfo);
    CGColorSpaceRelease(colorSpace);
	
    // If failed, return undecompressed image
    if (!context) return image;
	
    CGContextDrawImage(context, imageRect, imageRef);
    CGImageRef decompressedImageRef = CGBitmapContextCreateImage(context);
	
    CGContextRelease(context);
	
    UIImage *decompressedImage = [UIImage imageWithCGImage:decompressedImageRef scale:image.scale orientation:image.imageOrientation];
    CGImageRelease(decompressedImageRef);
    return decompressedImage;
}

@end
