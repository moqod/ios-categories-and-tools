//
//  NSMutableArray+AddObject.m
//  MALibrary
//
//  Created by ako on 11/30/12.
//  Copyright (c) 2012 Moqod & Apps with love All rights reserved.
//

#import "NSMutableArray+Tools.h"

@implementation NSMutableArray (Tools)

- (void)safeAddObject:(id)object {
	if (object) {
		[self addObject:object];
	}
}

- (void)removeObjectsEqualTo:(id)object {
	NSIndexSet *toBeRemoved = [self indexesOfObjectsPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
		return [object isEqual:obj];
	}];
	[self removeObjectsAtIndexes:toBeRemoved];
}

@end
