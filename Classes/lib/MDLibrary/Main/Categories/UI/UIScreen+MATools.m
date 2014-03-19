//
//  UIScreen+MATools.m
//  iOS Library
//
//  Created by Andrew Kopanev on 3/19/14.
//  Copyright (c) 2014 Moqod. All rights reserved.
//

#import "UIScreen+MATools.h"

@implementation UIScreen (MATools)

- (BOOL)maHasRetinaDisplay {
	return [[UIScreen mainScreen] scale] > 1.0;
}

- (BOOL)maHas568PointsHeight {
	return fabsf( [[UIScreen mainScreen] bounds].size.height - 568.0f ) < FLT_EPSILON;
}

@end
