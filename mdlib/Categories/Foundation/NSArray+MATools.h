//
//  NSArray+MATools.h
//  iOS Library
//
//  Created by Sergey Ryazanov on 27.03.15.
//  Copyright (c) 2015 Moqod. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (MATools)

/**
 *  Replaces objectAtIndexedSubscript: on a safe maObjectAtIndexedSubscript:
 *
 *  @Note Makes code like: array[index] safer.
 */
+ (void)maLoad;

/**
 *  Safe method for objectAtIndexedSubscript:
 *
 *  @param idx An index of the array.
 *
 *  @Note If index is outside the array bounds, it returns nil.
 *
 *  @return The object located at index or nil if index is outside the array bounds.
 */
- (id)maObjectAtIndexedSubscript:(NSUInteger)idx;

/**
 *  Safe method for indexOfObject:
 *
 *  @param index An index of the array.
 *
 *  @Note If index is outside the array bounds, it returns nil.
 *
 *  @return The object located at index or nil if index is outside the array bounds.
 */
- (id)maObjectAtIndex:(NSUInteger)index;

@end
