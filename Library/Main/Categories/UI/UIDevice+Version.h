//
//  UIDevice+Version.h
//  ComeOn
//
//  Created by Chris Weber on 26.04.13.
//  Copyright (c) 2013 Apps with love. All rights reserved.
//


/**
 *	Category for checking version of the device.
 */
@interface UIDevice (Version)
/**
 *	Checking current device version for support ios 4 features.
 *
 *	@return	YES if current device version supports ios 4 features, otherwise NO.
 */
+ (BOOL) maIsIOS4OrHigher;
/**
 *	Checking current device version for support ios 5 features.
 *
 *	@return	YES if current device version supports ios 5 features, otherwise NO.
 */
+ (BOOL) maIsIOS5OrHigher;
/**
 *	Checking current device version for support ios 6 features.
 *
 *	@return	YES if current device version supports ios 6 features, otherwise NO.
 */
+ (BOOL) maIsIOS6OrHigher;
/**
 *	Checking current device version for support ios 7 features.
 *
 *	@return	YES if current device version supports ios 7 features, otherwise NO.
 */
+ (BOOL) maIsIOS7OrHigher;
/**
 *	Checking current device version for support ios features for some version.
 *
 *	@param	version	Version of ios, features of it should be supported in current ios.
 *
 *	@return	YES if current device version supports features which available in some version, otherwise NO.
 */
+ (BOOL)maIsVersionSupported:(CGFloat)version;

@end
