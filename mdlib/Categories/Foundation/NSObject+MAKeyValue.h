//
//  NSObject+MAKeyValue.h
//  iOS Library
//
//  Created by Andrew Kopanev on 2/3/14.
//  Copyright (c) 2014 Moqod. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

/**
 *	Adds any property to any object in runtime using objc associated objects feature.
 *	For example, you can add 'userInfo' property to UIAlertView class, or even to NSArray.
 *	See UIView+MAUserInfo for more information.
 */
@interface NSObject (MAKeyValue)

// Default association policy is OBJC_ASSOCIATION_RETAIN_NONATOMIC.
- (void)maSetValue:(id)value forKey:(NSString *)key;

// Sets associated 'value' for 'key' with 'associationPolicy'.
- (void)maSetValue:(id)value forKey:(NSString *)key associationPolicy:(objc_AssociationPolicy)associationPolicy;

// Returns value associated with 'key'.
- (id)maValueForKey:(NSString *)key;

// Same thing but in one line
@property (nonatomic, retain) id		maUserInfo;

@end
