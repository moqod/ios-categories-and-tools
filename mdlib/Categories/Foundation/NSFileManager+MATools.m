//
//  NSFileManager+Tools.m
//  MALibrary
//
//  Created by Andrew Kopanev on 2/22/13.
//  Copyright (c) 2013 Thinc. All rights reserved.
//

#import "NSFileManager+MATools.h"

NSString *const NSFileManagerToolsLocalDirectoryName					= @"_local";

#include <sys/xattr.h>

@implementation NSFileManager (MATools)

#pragma mark - directories

// Returns documents directory
- (NSString *)maDocumentsDirectory {
	static NSString *documentsDirectory = nil;
	
	// @todo - do we need to @synchronize this block?
	if (nil == documentsDirectory) {
		documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
#if !__has_feature(objc_arc)
        [documentsDirectory retain];
#endif
        }
	return documentsDirectory;
}

// Returns documents directory
- (NSString *)maLocalDocumentsDirectory {
	static NSString *localDocumentsDirectory = nil;
    
    if (nil == localDocumentsDirectory) {
        localDocumentsDirectory = [[self maDocumentsDirectory] stringByAppendingPathComponent:NSFileManagerToolsLocalDirectoryName];
#if !__has_feature(objc_arc)
        [localDocumentsDirectory retain];
#endif
        [[NSFileManager defaultManager] createDirectoryAtPath:localDocumentsDirectory
                                  withIntermediateDirectories:YES
                                                   attributes:nil
                                                        error:nil];
        [self maAddSkipBackupAttributeToItemAtPath:localDocumentsDirectory];
    }
    
	return localDocumentsDirectory;
}

// Returns caches directory
- (NSString *)maCachesDirectory {
	static NSString *cachesDirectory = nil;
	if (nil == cachesDirectory) {
		cachesDirectory = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
#if !__has_feature(objc_arc)
        [cachesDirectory retain];
#endif
	}
	return cachesDirectory;
}

// Returns temporary directory
- (NSString *)maTemporaryDirectory {
	static NSString *temporaryDirectory = nil;
	if (nil == temporaryDirectory) {
		temporaryDirectory = NSTemporaryDirectory();
#if !__has_feature(objc_arc)
        [temporaryDirectory retain];
#endif
	}
	return temporaryDirectory;
}

- (NSArray *)maFullPathContentsOfDirectoryAtPath:(NSString *)path error:(NSError **)error {
	NSArray *contents = [self contentsOfDirectoryAtPath:path error:error];
	NSMutableArray *contentsWithFullPath = [NSMutableArray array];
	for (NSString *fileName in contents) {
		[contentsWithFullPath addObject:[path stringByAppendingPathComponent:fileName]];
	}
	return contentsWithFullPath;
}

// Determines if given path is a directory
- (BOOL)maIsItemAtPathDirectory:(NSString *)filePath {
	BOOL isDirectory = NO;
	[self fileExistsAtPath:filePath isDirectory:&isDirectory];
	return isDirectory;
}

// Returns attribute with given attribute name for item at path
- (id)maAttribute:(NSString *)attributeName ofItemAtPath:(NSString *)filePath {
	NSError *error = nil;
	NSDictionary *attributes = [self attributesOfItemAtPath:filePath error:&error];
	if (nil != error) {
		NSLog(@"%s item == %@, error == %@", __PRETTY_FUNCTION__, [filePath lastPathComponent], error);
	}
	return [attributes objectForKey:attributeName];
}

#pragma mark - space

- (double)maFreeFileSystemSize {
	double availableBytes = 0.0;
	NSError *error = nil;
	NSDictionary *attributes = [[NSFileManager defaultManager] attributesOfFileSystemForPath:[self maDocumentsDirectory] error:&error];
	if (nil == error) {
		availableBytes = [[attributes objectForKey:NSFileSystemFreeSize] doubleValue];
	} else {
		NSLog(@"%s error == %@", __PRETTY_FUNCTION__, error);
	}
	return availableBytes;
}

- (double)maSizeOfDirectoryAtPath:(NSString *)filePath {
	return [self maSizeOfDirectoryAtPath:filePath error:nil];
}

- (double)maSizeOfDirectoryAtPath:(NSString *)filePath error:(NSError **)error {
	double size = 0.0;
	for (NSString *fpath in [self maFullPathContentsOfDirectoryAtPath:filePath error:error]) {
		size += [[self maAttribute:NSFileSize ofItemAtPath:fpath] doubleValue];
	}
	return size;
}

#pragma mark - backups

// more information: http://developer.apple.com/library/ios/#qa/qa1719/_index.html
- (BOOL)setExcludeBackupAttribute:(BOOL)backupAttribute toItemAtPath:(NSString *)filePath {
	assert( nil != filePath );
	BOOL success = NO;
	if (NULL != &NSURLIsExcludedFromBackupKey) {
		NSError *error = nil;
		NSURL *filePathURL = [NSURL fileURLWithPath:filePath];
		success = [filePathURL setResourceValue:[NSNumber numberWithBool:backupAttribute] forKey:NSURLIsExcludedFromBackupKey error:&error];
		if (NO == success) {
			NSLog(@"%s failed %@ %@, error == %@", __PRETTY_FUNCTION__, backupAttribute ? @"excluding from" : @"including to", [filePath lastPathComponent], error);
		}
	} else {
		u_int8_t attrValue = backupAttribute ? 1 : 0;
		int setxattrResult = setxattr([filePath fileSystemRepresentation], "com.apple.MobileBackup", &attrValue, sizeof(attrValue), 0, 0);
		success = (setxattrResult == 0);
	}
	return success;
}

// Excluding a file from backups
- (BOOL)maAddSkipBackupAttributeToItemAtPath:(NSString *)filePath {
	return [self setExcludeBackupAttribute:YES toItemAtPath:filePath];
}

// Including a file to backups
- (BOOL)maRemoveSkipBackupAttributeFromItemAtPath:(NSString *)filePath {
	return [self setExcludeBackupAttribute:NO toItemAtPath:filePath];
}


@end
