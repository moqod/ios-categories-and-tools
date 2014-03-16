//
//  UIDevice+MAUniqueIdentifier.m
//  AWLLibrary
//
//  Created by Andrew Kopanev on 8/21/13.
//  Copyright (c) 2013 Moqod & Apps with love. All rights reserved.
//

#import "UIDevice+MAUniqueIdentifier.h"
#import "NSFileManager+MATools.h"

@implementation UIDevice (MAUniqueIdentifier)

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

@end
