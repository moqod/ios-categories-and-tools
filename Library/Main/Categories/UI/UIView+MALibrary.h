//
//  UIView+MALibrary.h
//  MALibrary
//
//  Created by Andrew Kopanev on 7/24/13.
//  Copyright (c) 2013 Moqod & Apps with love. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MACornersContainer : NSObject

@property (nonatomic, readonly) CGFloat			topLeftCornerRadius;
@property (nonatomic, readonly) CGFloat			topRightCornerRadius;
@property (nonatomic, readonly) CGFloat			bottomLeftCornerRadius;
@property (nonatomic, readonly) CGFloat			bottomRightCornerRadius;

- (id)initWithTopLeft:(CGFloat)topLeft topRight:(CGFloat)topRight bottomLeft:(CGFloat)bottomLeft bottomRight:(CGFloat)bottomRight;
+ (MACornersContainer *)containerWithTopLeft:(CGFloat)topLeft topRight:(CGFloat)topRight bottomLeft:(CGFloat)bottomLeft bottomRight:(CGFloat)bottomRight;

@end

/**
 `UIView` enhancements.
 */

@interface UIView (MALibrary)

/**
 @return Returns view's snapshot image.
 */

- (UIImage *)maShapshot;

/**
 Finds and resigns first responder if any.
 Traverses view's hierarchy recurrently.
 */

- (BOOL)maFindAndResignFirstResponder;

/**
 Removes all subviews.
 */
- (void)maRemoveAllSubviews;

/**
 Rounded corners.
 Default value is nil. Mask IS NOT redraw after layout - take care.
 */
@property (nonatomic, retain) MACornersContainer	*maCornersContainer;

@end
