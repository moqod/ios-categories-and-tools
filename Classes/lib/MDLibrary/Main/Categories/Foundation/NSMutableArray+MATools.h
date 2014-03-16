//
//  NSMutableArray+AddObject.h
//  MALibrary
//
//  Created by ako on 11/30/12.
//  Copyright (c) 2012 Moqod. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Method for safe adding adding into an array. 
 Useful when objects constructed on-the-fly and added to some result array.
 */

@interface NSMutableArray (MATools)

/**
 Adds an object to array.
 
 @param object Object to be added, can be nil.
 */

- (void)maAddObject:(id)object;

/**
 Removes all objects in array that equal to a given object.
 Method `removeObject:` removes first match only.
 
 @param object Object to be deleted.
 */

- (void)maRemoveObjectsEqualTo:(id)object;

@end
