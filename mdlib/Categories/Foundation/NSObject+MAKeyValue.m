//
//  NSObject+MAKeyValue.m
//  iOS Library
//
//  Created by Andrew Kopanev on 2/3/14.
//  Copyright (c) 2014 Moqod. All rights reserved.
//

#import "NSObject+MAKeyValue.h"
#import <objc/runtime.h>

NSString *const NSObjectMAKeyValueUserInfoKey			= @"maUserInfoKey";

@implementation NSObject (MAKeyValue)

- (void)maSetValue:(id)value forKey:(NSString *)key {
	[self maSetValue:value forKey:key associationPolicy:OBJC_ASSOCIATION_RETAIN_NONATOMIC];
}

- (void)maSetValue:(id)value forKey:(NSString *)key associationPolicy:(objc_AssociationPolicy)associationPolicy {
	if (nil != key) {
#if !__has_feature(objc_arc)
		objc_setAssociatedObject(self, key, value, associationPolicy);
#else
		objc_setAssociatedObject(self, (__bridge const void *)(key), value, associationPolicy);
#endif
	}
}

- (id)maValueForKey:(NSString *)key {
#if !__has_feature(objc_arc)
    return objc_getAssociatedObject(self, key);
#else
    return objc_getAssociatedObject(self, (__bridge const void *)(key));
#endif
}

#pragma mark -

- (void)setMaUserInfo:(id)userInfo {
	[self maSetValue:userInfo forKey:NSObjectMAKeyValueUserInfoKey];
}

- (id)maUserInfo {
	return [self maValueForKey:NSObjectMAKeyValueUserInfoKey];
}

@end
