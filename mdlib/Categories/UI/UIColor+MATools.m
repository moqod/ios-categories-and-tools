//
//  UIColor+Tools.m
//  MALibrary
//
//  Created by Andrew Kopanev on 2/21/13.
//  Copyright (c) 2013 Moqod All rights reserved.
//

#import "UIColor+MATools.h"

@implementation UIColor (MATools)

#define UIColor_Tools_RandomValue		( (arc4random() % 256) / 255.0f )

#pragma mark - debugging

+ (UIColor *)maRandomColor {
	return [UIColor colorWithRed:UIColor_Tools_RandomValue green:UIColor_Tools_RandomValue blue:UIColor_Tools_RandomValue alpha:1.0f];
}

#pragma mark - construction

+ (UIColor *)maColorFromRGB:(unsigned int)rgbValue {
	return [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0f green:((float)((rgbValue & 0xFF00) >> 8))/255.0f blue:((float)(rgbValue & 0xFF))/255.0f alpha:1.0f];
}

+ (UIColor *)maColorFromRGB:(unsigned int)rgbValue alpha:(CGFloat)alpha {
	return [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0f green:((float)((rgbValue & 0xFF00) >> 8))/255.0f blue:((float)(rgbValue & 0xFF))/255.0f alpha:alpha];
}

+ (UIColor *)maIntColorWithRed:(unsigned int)red green:(unsigned int)green blue:(unsigned int)blue alpha:(unsigned int)alpha {
	return [UIColor colorWithRed:red / 255.0f green:green / 255.0f blue:blue / 255.0f alpha:alpha / 255.0f];
}

#pragma mark - components

- (CGFloat)maColorComponentAtIndex:(size_t)componentIndex {
	size_t numberOfComponents = CGColorGetNumberOfComponents(self.CGColor);
	if (componentIndex < numberOfComponents) {
		const CGFloat *components = CGColorGetComponents(self.CGColor);
		return components[componentIndex];
	} else {
#ifdef DEBUG
		NSLog(@"%s invalid color component index %zu (number of components == %zu)", __PRETTY_FUNCTION__, componentIndex, numberOfComponents);
#endif
		return 0.0f;
	}
}

- (CGFloat)maRed {
	return [self maColorComponentAtIndex:0];
}

- (CGFloat)maGreen {
	return [self maColorComponentAtIndex:1];
}

- (CGFloat)maBlue {
	return [self maColorComponentAtIndex:2];
}

- (CGFloat)maAlpha {
	return [self maColorComponentAtIndex:3];
}

@end
