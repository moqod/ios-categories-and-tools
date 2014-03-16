//
//  UIImage+Tint.m
//
//  Created by Matt Gemmell on 04/07/2010.
//  Copyright 2010 Instinctive Code.
//

#import "UIImage+Tint.h"


@implementation UIImage (MGTint)


- (UIImage *)tintedImageUsingColor:(UIColor *)tintColor;
{
    //UIGraphicsBeginImageContextWithOptions(self.size, NO, 1.0);
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_4_0
    if ([UIScreen instancesRespondToSelector:@selector(scale)]) {
        UIGraphicsBeginImageContextWithOptions([self size], NO, 0.f); // 0.f for scale means "scale for device's main screen".
    } else {
        UIGraphicsBeginImageContext([self size]);
    }
#else
    UIGraphicsBeginImageContext([self size]);
#endif
    
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    
    // draw original image
    [self drawInRect:rect blendMode:kCGBlendModeNormal alpha:1.0f];
    
    // tint image (loosing alpha).
    // kCGBlendModeOverlay is the closest I was able to match the
    // actual process used by apple in navigation bar
    CGContextSetBlendMode(context, kCGBlendModeOverlay);
    [tintColor setFill];
    CGContextFillRect(context, rect);
    
    // mask by alpha values of original image
    [self drawInRect:rect blendMode:kCGBlendModeDestinationIn alpha:1.0f];
    
    UIImage *tintedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return tintedImage;
}





- (UIImage *)imageTintedWithColor:(UIColor *)color
{
	// This method is designed for use with template images, i.e. solid-coloured mask-like images.
	return [self imageTintedWithColor:color fraction:0.0]; // default to a fully tinted mask of the image.
}


- (UIImage *)imageTintedWithColor:(UIColor *)color fraction:(CGFloat)fraction
{
	if (color) {
		// Construct new image the same size as this one.
		UIImage *image;
		
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_4_0
		if ([UIScreen instancesRespondToSelector:@selector(scale)]) {
			UIGraphicsBeginImageContextWithOptions([self size], NO, 0.f); // 0.f for scale means "scale for device's main screen".
		} else {
			UIGraphicsBeginImageContext([self size]);
		}
#else
		UIGraphicsBeginImageContext([self size]);
#endif
		CGRect rect = CGRectZero;
		rect.size = [self size];
		
		// Composite tint color at its own opacity.
		[color set];
		UIRectFill(rect);
		
		// Mask tint color-swatch to this image's opaque mask.
		// We want behaviour like NSCompositeDestinationIn on Mac OS X.
		[self drawInRect:rect blendMode:kCGBlendModeDestinationIn alpha:1.0];
		
		// Finally, composite this image over the tinted mask at desired opacity.
		if (fraction > 0.0) {
			// We want behaviour like NSCompositeSourceOver on Mac OS X.
			[self drawInRect:rect blendMode:kCGBlendModeSourceAtop alpha:fraction];
		}
		image = UIGraphicsGetImageFromCurrentImageContext();
		UIGraphicsEndImageContext();
		
		return image;
	}
	
	return self;
}


//version 3
-(UIImage *)getImageWithUnsaturatedPixelsOfImage:(UIImage *)image
{
    const int RED = 1, GREEN = 2, BLUE = 3;
    
    CGRect imageRect = CGRectMake(0, 0, image.size.width*2, image.size.height*2);
    
    int width = imageRect.size.width, height = imageRect.size.height;
    
    uint32_t * pixels = (uint32_t *) malloc(width*height*sizeof(uint32_t));
    memset(pixels, 0, width * height * sizeof(uint32_t));
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(pixels, width, height, 8, width * sizeof(uint32_t), colorSpace, kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedLast);
    
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), [image CGImage]);
    
    for(int y = 0; y < height; y++) {
        for(int x = 0; x < width; x++) {
            uint8_t * rgbaPixel = (uint8_t *) &pixels[y*width+x];
            uint32_t gray = (0.3*rgbaPixel[RED]+0.59*rgbaPixel[GREEN]+0.11*rgbaPixel[BLUE]);
            
            rgbaPixel[RED] = gray;
            rgbaPixel[GREEN] = gray;
            rgbaPixel[BLUE] = gray;
        }
    }
    
    CGImageRef newImage = CGBitmapContextCreateImage(context);
    
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    free(pixels);
    
    UIImage * resultUIImage = [UIImage imageWithCGImage:newImage scale:2 orientation:0];
    CGImageRelease(newImage);
    
    return resultUIImage;
}

-(UIImage *)getImageWithTintedColor:(UIImage *)image withTint:(UIColor *)color withIntensity:(float)alpha
{
    CGSize size = image.size;
    
    UIGraphicsBeginImageContextWithOptions(size, FALSE, 2);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [image drawAtPoint:CGPointZero blendMode:kCGBlendModeNormal alpha:1.0];
    
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextSetBlendMode(context, kCGBlendModeSourceIn);
    CGContextSetAlpha(context, alpha);
    
    CGContextFillRect(UIGraphicsGetCurrentContext(), CGRectMake(CGPointZero.x, CGPointZero.y, image.size.width, image.size.height));
    
    UIImage * tintedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return tintedImage;
}


@end
