//
//  UIView+MALibrary.h
//  MALibrary
//
//  Created by Andrew Kopanev on 7/24/13.
//  Copyright (c) 2013 Moqod. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *	Some cool methods for UIView.
 *	My favorite is method `- (BOOL)maFindAndResignFirstResponder`.
 */

@interface UIView (MALibrary)

/**
 @return Returns view's snapshot image.
 */
- (UIImage *)maSnapshot;

/**
 Finds and resigns first responder if any.
 Traverses view's hierarchy recurrently.
 */
- (BOOL)maFindAndResignFirstResponder;

/**
 Removes all subviews.
 */
- (void)maRemoveAllSubviews;

@end
