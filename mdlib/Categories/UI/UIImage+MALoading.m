//
//  UIImage+MALoading.m
//  iOS Library
//
//  Created by Andrew Kopanev on 2/14/14.
//  Copyright (c) 2014 Moqod. All rights reserved.
//

#import "UIImage+MALoading.h"
#import "NSObject+MAKeyValue.h"
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
	[image autorelease];
	return image;
}

- (instancetype)maInitWithContentsOfFile:(NSString *)filePath {
	UIImage *cachedImage = [[self class] maCachedImageForFilePath:filePath];
	if (nil != cachedImage) {
		[self autorelease];
		return [cachedImage retain];
	} else {
		if (self = [self initWithContentsOfFile:filePath]) {
			[[self class] maSetImage:self forFilePath:filePath];
		}
		return self;
	}
}

#pragma mark - bundle images

+ (UIImage *)maImageNamed:(NSString *)imageFileName {
	return [self maImageNamed:imageFileName bundle:[NSBundle mainBundle]];
}

+ (UIImage *)maImageNamed:(NSString *)imageFileName bundle:(NSBundle *)bundle {
	NSString *filePath = [bundle pathForResource:imageFileName ofType:nil];
	return [self maImageWithContentsOfFile:filePath];
}

@end
