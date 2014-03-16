//
//  NSObject+MAKeyValue.h
//  iOS Library
//
//  Created by Andrew Kopanev on 2/3/14.
//  Copyright (c) 2014 Moqod. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

// This category uses objc associated objects feature.
// Add any property to any of your objects on-the-fly.
// Example: userInfo for UIAlertView or event for NSArray. Whatever.
@interface NSObject (MAKeyValue)

// Default association policy is OBJC_ASSOCIATION_RETAIN_NONATOMIC.
- (void)maSetValue:(id)value forKey:(NSString *)key;

// Sets associated 'value' for 'key' with 'associationPolicy'.
- (void)maSetValue:(id)value forKey:(NSString *)key associationPolicy:(objc_AssociationPolicy)associationPolicy;

// Returns value associated with 'key'.
- (id)maValueForKey:(NSString *)key;

@end
