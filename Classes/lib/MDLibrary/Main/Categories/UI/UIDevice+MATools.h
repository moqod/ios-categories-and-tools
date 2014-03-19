//
//  UIDevice+MATools.h
//  iOS Library
//
//  Created by Andrew Kopanev on 2/16/14.
//  Copyright (c) 2014 Moqod. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *	UIDevice category.
 */

#define MA_DEVICE_IS_PAD							[[UIDevice currentDevice] maIsPad]

@interface UIDevice (MATools)

// Returns unique identfier.
// This identifier generates once when the app is installed.
// After new installation (with deleting the app from device) new identifier is generated.
// This value is excluded from backup.
@property (nonatomic, readonly) NSString			*maUniqueIdentifier;

// Detects - can current device vibrate or not.
// Simply checks device type.
// On 16 Feb 2014 only iPhone can vibrate :)
@property (nonatomic, readonly) BOOL				maCanVibrate;
@property (nonatomic, readonly) BOOL				maCanCall;

// type of the device
@property (nonatomic, readonly) BOOL				maIsPad;

@end
