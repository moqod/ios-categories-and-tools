//
//  NSFileManager+Tools.h
//  MALibrary
//
//  Created by Andrew Kopanev on 2/22/13.
//  Copyright (c) 2013 Moqod. All rights reserved.
//

#import <Foundation/Foundation.h>

#define NSFileManagerI		[NSFileManager defaultManager]
/**
 *	Category adds useful methods to NSFileManager.
 */

@interface NSFileManager (MATools)

/*
 *	@wanted
 *	- async remove files / directories (more info: http://cocoanetics.github.com/DTFoundation/Categories/NSFileManager(DTFoundation).html )
 *	- ... ?
 */

/**
 *	@return	Returns documents directory
 */
- (NSString *)maDocumentsDirectory;
/**
*@return Returns documents directory which is not backed up by icloud
 */
- (NSString *)maLocalDocumentsDirectory;

/**
 *	@return	Returns caches directory
 */
- (NSString *)maCachesDirectory;

/**
 *	@return	Returns temporary directory
 */
- (NSString *)maTemporaryDirectory;

/** 
* @return Returns an NSArray of NSStrings representing the paths of the items in the directory.
 */
- (NSArray *)maFullPathContentsOfDirectoryAtPath:(NSString *)path error:(NSError **)error;
/**
* @return Determines if the item at given path is a directory
*/
- (BOOL)maIsItemAtPathDirectory:(NSString *)filePath;
/**
 *	@return	Returns attribute with given attribute name for item at path
 */
- (id)maAttribute:(NSString *)attributeName ofItemAtPath:(NSString *)filePath;
/**
*@return Returns file system free size
 */
- (double)maFreeFileSystemSize;
/**
*@return Returns size of directory contents at give path
 */
- (double)maSizeOfDirectoryAtPath:(NSString *)filePath;
/**
 * @param error Pointer on error.
 *@return Returns size of directory contents at give path
 */
- (double)maSizeOfDirectoryAtPath:(NSString *)filePath error:(NSError **)error;
/**
 *	Excluding a file from backups
 *
 *	@param	filePath	Full path to file.
 *
 *	@return	YES, if operation completed success, otherwise NO.
 */
- (BOOL)maAddSkipBackupAttributeToItemAtPath:(NSString *)filePath;
/**
 *	Including a file to backups
 *
 *	@param	filePath	Full path to file.
 *
 *	@return	YES, if operation completed success, otherwise NO.
 */
- (BOOL)maRemoveSkipBackupAttributeFromItemAtPath:(NSString *)filePath;

@end
