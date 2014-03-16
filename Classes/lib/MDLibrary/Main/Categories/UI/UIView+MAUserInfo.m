//
//  UIView+UserInfo.m
//  MALibrary
//
//  Created by Andrew Kopanev on 7/24/13.
//  Copyright (c) 2013 Moqod. All rights reserved.
//

#import "UIView+MAUserInfo.h"
#import <objc/runtime.h>

NSString *const UIViewUserInfoKey					= @"MAUIViewUserInfoKey";

@implementation UIView (MAUserInfo)

- (void)setMaUserInfo:(id)userInfo {
#if !__has_feature(objc_arc)
    objc_setAssociatedObject(self, UIViewUserInfoKey, userInfo, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
#else
    objc_setAssociatedObject(self, (__bridge const void *)(UIViewUserInfoKey), userInfo, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
#endif
}

- (id)maUserInfo {
#if !__has_feature(objc_arc)
    return objc_getAssociatedObject(self, UIViewUserInfoKey);
#else 
    return objc_getAssociatedObject(self, (__bridge const void *)(UIViewUserInfoKey));
#endif
}

@end