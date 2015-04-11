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

- (id)maObjectAtIndex:(NSUInteger)index
{
    if (index >= self.count) {
        return nil;
    }
    return [self objectAtIndex:index];
}

@end
