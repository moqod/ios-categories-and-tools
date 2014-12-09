//
//  UIView+MARoundedCorner.m
//  iOS Library
//
//  Created by Andrew Kopanev on 3/19/14.
//  Copyright (c) 2014 Moqod. All rights reserved.
//

#import "UIView+MARoundedCorner.h"
#import <QuartzCore/QuartzCore.h>
#import <objc/runtime.h>

@implementation MACornersContainer

- (id)initWithTopLeft:(CGFloat)topLeft topRight:(CGFloat)topRight bottomLeft:(CGFloat)bottomLeft bottomRight:(CGFloat)bottomRight {
	if (self = [super init]) {
		_topLeftCornerRadius = topLeft;
		_topRightCornerRadius = topRight;
		_bottomLeftCornerRadius = bottomLeft;
		_bottomRightCornerRadius = bottomRight;
	}
	return self;
}

- (BOOL)isEqual:(MACornersContainer *)object {
	// TODO: update floats comparsion
	// TODO: also we should compare mask size, corner radius is not enough
	return [object isKindOfClass:[self class]] && object.topLeftCornerRadius == self.topLeftCornerRadius && object.topRightCornerRadius == self.topRightCornerRadius && object.bottomLeftCornerRadius == self.bottomLeftCornerRadius && object.bottomRightCornerRadius == self.bottomRightCornerRadius;
}

+ (MACornersContainer *)containerWithTopLeft:(CGFloat)topLeft topRight:(CGFloat)topRight bottomLeft:(CGFloat)bottomLeft bottomRight:(CGFloat)bottomRight {
	MACornersContainer *container =  [[self alloc] initWithTopLeft:topLeft topRight:topRight bottomLeft:bottomLeft bottomRight:bottomRight];
#if !__has_feature(objc_arc)
    [container autorelease];
#endif
    return container;
}

@end

static inline UIImage* MTDContextCreateRoundedMask( CGRect rect, CGFloat radius_tl, CGFloat radius_tr, CGFloat radius_bl, CGFloat radius_br );

// keys
NSString *const UIViewMALibraryCornersContainerKey			= @"UIViewMALibraryCornersContainerKey";

@implementation UIView (MARoundedCorner)

#pragma mark -

- (void)setMaCornersContainer:(MACornersContainer *)maCornersContainer {
	if (NO == [self.maCornersContainer isEqual:maCornersContainer])  {
#if !__has_feature(objc_arc)
        objc_setAssociatedObject(self, UIViewMALibraryCornersContainerKey, maCornersContainer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
#else
        objc_setAssociatedObject(self, (__bridge const void *)(UIViewMALibraryCornersContainerKey), maCornersContainer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
#endif
		
		// apply layer mask
		if (maCornersContainer) {
			UIImage *mask = MTDContextCreateRoundedMask(self.bounds, maCornersContainer.topLeftCornerRadius, maCornersContainer.topRightCornerRadius, maCornersContainer.bottomLeftCornerRadius, maCornersContainer.bottomRightCornerRadius);
			CALayer *layerMask = [CALayer layer];
			layerMask.frame = self.bounds;
			layerMask.contents = (id)mask.CGImage;
			self.layer.mask = layerMask;
		} else {
			self.layer.mask = nil;
		}
	}
}

- (MACornersContainer *)maCornersContainer {
#if !__has_feature(objc_arc)
    return objc_getAssociatedObject(self, UIViewMALibraryCornersContainerKey);
#else
    return objc_getAssociatedObject(self, (__bridge const void *)(UIViewMALibraryCornersContainerKey));
#endif
}

@end

static inline UIImage* MTDContextCreateRoundedMask( CGRect rect, CGFloat radius_tl, CGFloat radius_tr, CGFloat radius_bl, CGFloat radius_br ) {
	
    CGContextRef context;
    CGColorSpaceRef colorSpace;
	CGFloat scale = [[UIScreen mainScreen] scale];
	
	radius_tl *= scale;
	radius_tr *= scale;
	radius_bl *= scale;
	radius_br *= scale;
	rect.size.width *= scale;
	rect.size.height *= scale;
	
    colorSpace = CGColorSpaceCreateDeviceRGB();
	
    // create a bitmap graphics context the size of the image
    context = CGBitmapContextCreate( NULL, rect.size.width, rect.size.height, 8, 0, colorSpace, (CGBitmapInfo)kCGImageAlphaPremultipliedLast );
	
    // free the rgb colorspace
    CGColorSpaceRelease(colorSpace);
	
    if ( context == NULL ) {
        return NULL;
    }
	
    // create mask
    CGFloat minx = CGRectGetMinX( rect ), midx = CGRectGetMidX( rect ), maxx = CGRectGetMaxX( rect );
    CGFloat miny = CGRectGetMinY( rect ), midy = CGRectGetMidY( rect ), maxy = CGRectGetMaxY( rect );
	
    CGContextBeginPath( context );
    CGContextSetGrayFillColor( context, 1.0, 0.0 );
    CGContextAddRect( context, rect );
    CGContextClosePath( context );
    CGContextDrawPath( context, kCGPathFill );
	
    CGContextSetGrayFillColor( context, 1.0, 1.0 );
    CGContextBeginPath( context );
    CGContextMoveToPoint( context, minx, midy );
    CGContextAddArcToPoint( context, minx, miny, midx, miny, radius_bl );
    CGContextAddArcToPoint( context, maxx, miny, maxx, midy, radius_br );
    CGContextAddArcToPoint( context, maxx, maxy, midx, maxy, radius_tr );
    CGContextAddArcToPoint( context, minx, maxy, minx, midy, radius_tl );
    CGContextClosePath( context );
    CGContextDrawPath( context, kCGPathFill );
	
    // Create CGImageRef of the main view bitmap content, and then
    // release that bitmap context
    CGImageRef bitmapContext = CGBitmapContextCreateImage( context );
    CGContextRelease( context );
	
    // convert the finished resized image to a UIImage
    UIImage *theImage = [UIImage imageWithCGImage:bitmapContext];
    // image is retained by the property setting above, so we can
    // release the original
    CGImageRelease(bitmapContext);
	
    // return the image
    return theImage;
}
