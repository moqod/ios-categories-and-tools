//
//  UIImage+MARoundedCorner.m
//  iOS Library
//
//  Created by Andrew Kopanev on 2/3/14.
//  Copyright (c) 2014 Moqod. All rights reserved.
//

#import "UIImage+MASimpleImages.h"
#import "UIView+MALibrary.h"

@implementation UIImage (MASimpleImages)

// TODO: draw an image using Quartz
+ (UIImage *)maRoundedImageWithSize:(CGSize)size cornerRadius:(CGFloat)cornerRadius backgroundColor:(UIColor *)backgroundColor {
	// TODO: draw using Quartz
	UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, size.width, size.height)];
	view.backgroundColor = backgroundColor;
	view.layer.cornerRadius = cornerRadius;
	UIImage *roundedImage = [view maSnapshot];
#if !__has_feature(objc_arc)
	[view release];
#endif
	return roundedImage;
}

#pragma mark -

+ (UIImage *)maRectImageWithSize:(CGSize)size backgroundColor:(UIColor *)backgroundColor {
	return [self maRectImageWithSize:size backgroundColor:backgroundColor borderWidth:0.0 borderColor:nil];
}

+ (UIImage *)maRectImageWithSize:(CGSize)size backgroundColor:(UIColor *)backgroundColor borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor {
	UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, size.width, size.height)];
	if (borderColor && borderWidth > 0.0) {
		view.layer.borderColor = borderColor.CGColor;
		view.layer.borderWidth = borderWidth;
	}
	view.backgroundColor = backgroundColor;
#if !__has_feature(objc_arc)
	[view autorelease];
#endif
	return [view maSnapshot];
}

#pragma mark -

- (UIImage *)maStretchableImage {
	CGFloat h = self.size.width * 0.5;
	CGFloat v = self.size.height * 0.5;
	return [self resizableImageWithCapInsets:UIEdgeInsetsMake(h, v, h, v) resizingMode:UIImageResizingModeStretch];
}

@end
