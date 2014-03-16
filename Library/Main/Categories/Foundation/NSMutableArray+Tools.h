//
//  NSMutableArray+AddObject.h
//  MALibrary
//
//  Created by ako on 11/30/12.
//  Copyright (c) 2012 Moqod & Apps with love All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Method for safe adding adding into an array. 
 Useful when objects constructed on-the-fly and added to some result array.
 */

@interface NSMutableArray (Tools)

/**
 Adds an object to array.
 
 @param object Object to be added, can be nil.
 */

- (void)safeAddObject:(id)object;

/**
 Removes all objects in array that equals to a given object.
 Standart method `removeObject` removes only one object.
 
 @param object Object to be deleted.
 */

- (void)removeObjectsEqualTo:(id)object;

@end
