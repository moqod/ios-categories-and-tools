//
//  NSArray+MATools.m
//  iOS Library
//
//  Created by Sergey Ryazanov on 27.03.15.
//  Copyright (c) 2015 Moqod. All rights reserved.
//

#import "NSArray+MATools.h"
#import <objc/runtime.h>

@implementation NSArray (MATools)

+ (void)maLoad
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method origImageNamedMethod = class_getClassMethod(self.class, @selector(objectAtIndexedSubscript:));
        method_exchangeImplementations(origImageNamedMethod, class_getClassMethod(self.class, @selector(maObjectAtIndexedSubscript:)));
    });
}

#pragma mark - 
- (id)maObjectAtIndexedSubscript:(NSUInteger)idx
{
    if (idx >= self.count) {
        return nil;
    }
    return [self objectAtIndexedSubscript:idx];
}

- (id)maObjectAtIndex:(NSUInteger)index
{
    if (index >= self.count) {
        return nil;
    }
    return [self objectAtIndex:index];
}

@end
