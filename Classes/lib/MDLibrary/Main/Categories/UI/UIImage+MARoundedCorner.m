//
//  UIImage+MARoundedCorner.m
//  iOS Library
//
//  Created by Andrew Kopanev on 2/3/14.
//  Copyright (c) 2014 Moqod. All rights reserved.
//

#import "UIImage+MARoundedCorner.h"
#import "UIView+MALibrary.h"

@implementation UIImage (MARoundedCorner)

// TODO: draw an image using Quartz
+ (UIImage *)maRoundedImageWithSize:(CGSize)size cornerRadius:(CGFloat)cornerRadius backgroundColor:(UIColor *)backgroundColor {
	// TODO: draw using Quartz
	UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, size.width, size.height)];
	view.backgroundColor = backgroundColor;
	view.layer.cornerRadius = cornerRadius;
	UIImage *roundedImage = [view maShapshot];
#if !__has_feature(objc_arc)
	[view release];
#endif
	return roundedImage;
}

@end
