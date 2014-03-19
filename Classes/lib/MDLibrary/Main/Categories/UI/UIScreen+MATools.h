//
//  UIScreen+MATools.h
//  iOS Library
//
//  Created by Andrew Kopanev on 3/19/14.
//  Copyright (c) 2014 Moqod. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *	UIScreen category.
 */

#define MA_SCREEN_HAS_568_HEIGHT					[[UIScreen mainScreen] maHas568PointsHeight]

@interface UIScreen (MATools)

// Returns YES if screen scale > 1.0
@property (nonatomic, readonly) BOOL				maHasRetinaDisplay;

// Returns YES if screen height is 568 points. Thanks, Cap!
@property (nonatomic, readonly) BOOL				maHas568PointsHeight;

@end
