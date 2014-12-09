//
//  NSMutableArray+AddObject.m
//  MALibrary
//
//  Created by ako on 11/30/12.
//  Copyright (c) 2012 Moqod. All rights reserved.
//

#import "NSMutableArray+MATools.h"

@implementation NSMutableArray (MATools)

- (void)maAddObject:(id)object {
	if (object) {
		[self addObject:object];
	}
}

- (void)maRemoveObjectsEqualTo:(id)object {
	NSIndexSet *toBeRemoved = [self indexesOfObjectsPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
		return [object isEqual:obj];
	}];
	[self removeObjectsAtIndexes:toBeRemoved];
}

@end
