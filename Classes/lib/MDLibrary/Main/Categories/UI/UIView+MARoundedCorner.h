//
//  UIView+MARoundedCorner.h
//  iOS Library
//
//  Created by Andrew Kopanev on 3/19/14.
//  Copyright (c) 2014 Moqod. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *	Represents rounded corners.
 */
@interface MACornersContainer : NSObject

@property (nonatomic, readonly) CGFloat			topLeftCornerRadius;
@property (nonatomic, readonly) CGFloat			topRightCornerRadius;
@property (nonatomic, readonly) CGFloat			bottomLeftCornerRadius;
@property (nonatomic, readonly) CGFloat			bottomRightCornerRadius;

- (id)initWithTopLeft:(CGFloat)topLeft topRight:(CGFloat)topRight bottomLeft:(CGFloat)bottomLeft bottomRight:(CGFloat)bottomRight;
+ (MACornersContainer *)containerWithTopLeft:(CGFloat)topLeft topRight:(CGFloat)topRight bottomLeft:(CGFloat)bottomLeft bottomRight:(CGFloat)bottomRight;

@end

/**
 *	Adds custom rounded corners. You can specify any of them - top left, bottom right, etc.
 */

@interface UIView (MARoundedCorner)

/**
 Rounded corners.
 Default value is nil. Update mask after bounds change.
 */
@property (nonatomic, retain) MACornersContainer	*maCornersContainer;

@end
