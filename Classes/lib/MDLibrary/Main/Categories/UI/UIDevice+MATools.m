//
//  UIDevice+MATools.m
//  iOS Library
//
//  Created by Andrew Kopanev on 2/16/14.
//  Copyright (c) 2014 Moqod. All rights reserved.
//

#import "UIDevice+MATools.h"
#import "NSFileManager+MATools.h"

@implementation UIDevice (MATools)

#pragma mark - unique identifier

- (NSString *)maUniqueIdentifier {
	static NSString *uniqueIdentifier = nil;
	if (nil == uniqueIdentifier) {
		NSString *udidFilePath = [[[NSFileManager defaultManager] maDocumentsDirectory] stringByAppendingPathComponent:@"___udid.string"];
		uniqueIdentifier = [NSString stringWithContentsOfFile:udidFilePath encoding:NSUTF8StringEncoding error:nil];
#if !__has_feature(objc_arc)
        [uniqueIdentifier retain];
#endif
		if (nil == uniqueIdentifier) {
			// generate uuid
			CFUUIDRef theUUID = CFUUIDCreate(NULL);
#if !__has_feature(objc_arc)
            uniqueIdentifier = (NSString *)CFUUIDCreateString(NULL, theUUID);
#else
            uniqueIdentifier = (NSString *)CFBridgingRelease(CFUUIDCreateString(NULL, theUUID));
#endif
			CFRelease(theUUID);
			
			// save to the file & exclude from backup
			[uniqueIdentifier writeToFile:udidFilePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
			[[NSFileManager defaultManager] maAddSkipBackupAttributeToItemAtPath:udidFilePath];
		}
	}
	return uniqueIdentifier;
}

#pragma mark - vibration

- (BOOL)maCanVibrate {
	return [[[self model] lowercaseString] rangeOfString:@"iphone"].location != NSNotFound;
}

- (BOOL)maCanCall {
    return [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tel://"]];
}

#pragma mark -

- (BOOL)maIsPad {
	return (UIUserInterfaceIdiomPad == [self userInterfaceIdiom]);
}

@end
