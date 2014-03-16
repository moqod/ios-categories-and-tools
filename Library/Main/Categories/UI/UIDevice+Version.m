//
//  UIDevice+Version.m
//  ComeOn
//
//  Created by Chris Weber on 26.04.13.
//  Copyright (c) 2013 Apps with love. All rights reserved.
//

#import "UIDevice+Version.h"

@implementation UIDevice (Version)

+ (BOOL)maIsIOS4OrHigher {
    return [self maIsVersionSupported:4.0];
}

+ (BOOL)maIsIOS5OrHigher {
    return [self maIsVersionSupported:5.0];
}

+ (BOOL)maIsIOS6OrHigher {
    return [self maIsVersionSupported:6.0];
}

+ (BOOL)maIsIOS7OrHigher {
    return [self maIsVersionSupported:7.0];
}

+ (BOOL)maIsVersionSupported:(CGFloat)version {
    return [[[UIDevice currentDevice] systemVersion] floatValue] >= version;
}

@end
