//
//  NSMutableArray+AddObject.h
//  MALibrary
//
//  Created by ako on 11/30/12.
//  Copyright (c) 2012 Moqod. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *	Category adds two methods, one for adding any objects (incapsulates nil-checking) and one for removing objects.
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
 Uses 'isEqual:' for comparsion.
 
 @param object Object to be deleted.
 */

- (void)maRemoveObjectsEqualTo:(id)object;

@end
