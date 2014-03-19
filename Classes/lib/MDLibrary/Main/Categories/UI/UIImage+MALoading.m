//
//  UIImage+MALoading.m
//  iOS Library
//
//  Created by Andrew Kopanev on 2/14/14.
//  Copyright (c) 2014 Moqod. All rights reserved.
//

#import "UIImage+MALoading.h"
#import "NSObject+MAKeyValue.h"
#import "UIDevice+MATools.h"
#import "UIScreen+MATools.h"
#import <objc/runtime.h>

NSString *const UIImageMALoadingFilePathKey					= @"maPathKey";

static NSMutableDictionary *maImageLoadingCacheDictionary = nil;

@implementation UIImage (MALoading)

#pragma mark - cache stuff

+ (UIImage *)maCachedImageForFilePath:(NSString *)filePath {
	NSValue *pointerValue = [maImageLoadingCacheDictionary objectForKey:filePath];
	return [pointerValue nonretainedObjectValue];
}

+ (void)maSetImage:(UIImage *)image forFilePath:(NSString *)filePath {
	@synchronized(self) {
		// store file path into UIImage object
		[image maSetValue:filePath forKey:UIImageMALoadingFilePathKey associationPolicy:OBJC_ASSOCIATION_COPY_NONATOMIC];
		
		// drop pointer to the cache
		[maImageLoadingCacheDictionary setValue:[NSValue valueWithNonretainedObject:image] forKey:filePath];
	}
}

+ (void)maRemoveImageFromCache:(UIImage *)image {
	NSString *filePath = [image maValueForKey:UIImageMALoadingFilePathKey];
	if (nil != filePath) {
		@synchronized(self) {
			[maImageLoadingCacheDictionary setValue:nil forKey:filePath];
		}
	}
	
}

#pragma mark - category initialization

- (void)maDealloc {
	[[self class] maRemoveImageFromCache:self];
	[self maDealloc];
}

+ (void)maSwizzleDealloc {
	method_exchangeImplementations(class_getInstanceMethod(self, @selector(dealloc)), class_getInstanceMethod(self, @selector(maDealloc)));
}

+ (void)load {
	maImageLoadingCacheDictionary = [[NSMutableDictionary alloc] init];
	[self maSwizzleDealloc];
}

#pragma mark - public initializers

+ (UIImage *)maImageWithContentsOfFile:(NSString *)filePath {
	UIImage *image = [[self alloc] maInitWithContentsOfFile:filePath];
#if !__has_feature(objc_arc)
	[image autorelease];
#endif
	return image;
}

- (instancetype)maInitWithContentsOfFile:(NSString *)filePath {
	UIImage *cachedImage = [[self class] maCachedImageForFilePath:filePath];
	if (nil != cachedImage) {
		// TODO: leak?
		// TODO: add ARC support
		[self autorelease];
		return [cachedImage retain];
	} else {
		if (self = [self initWithContentsOfFile:filePath]) {
			[[self class] maSetImage:self forFilePath:filePath];
		}
		return self;
	}
}

#pragma mark - background images

+ (UIImage *)maBackgroundImageNamed:(NSString *)imageFileName {
    return [self maBackgroundImageNamed:imageFileName bundle:[NSBundle mainBundle]];
}

+ (UIImage *)maBackgroundImageNamed:(NSString *)imageFileName bundle:(NSBundle *)bundle {
	// <basename><usage_specific_modifiers><scale_modifier><device_modifier>.png
	NSString *suffix = [[UIDevice currentDevice] maIsPad] ? @"~ipad" : nil;
	NSString *modifier = MA_SCREEN_HAS_568_HEIGHT ? @"-568h" : nil;
	if (suffix || modifier) {
		NSString *fileExtension = [imageFileName pathExtension] ? [imageFileName pathExtension] : @"";
		NSMutableString *mutableFileName = [NSMutableString stringWithString: [imageFileName stringByDeletingPathExtension]];
		if (modifier) {
			[mutableFileName appendString:modifier];
		}
		if ([[UIScreen mainScreen] maHasRetinaDisplay]) {
			[mutableFileName appendString:@"@2x"];
		}
		if (suffix) {
			[mutableFileName appendString:suffix];
		}
		
		NSString *imageFilePath = [bundle pathForResource:mutableFileName ofType:fileExtension];
		return [self maImageWithContentsOfFile:imageFilePath];
	} else {
		return [self maImageNamed:imageFileName bundle:bundle];
	}
}

+ (UIImage *)maImageNamed:(NSString *)imageFileName {
	return [self maImageNamed:imageFileName bundle:[NSBundle mainBundle]];
}

+ (UIImage *)maImageNamed:(NSString *)imageFileName bundle:(NSBundle *)bundle {
	NSString *filePath = [bundle pathForResource:imageFileName ofType:nil];
	return [self maImageWithContentsOfFile:filePath];
}

@end
