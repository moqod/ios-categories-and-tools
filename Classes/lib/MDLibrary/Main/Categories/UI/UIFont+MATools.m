//
//  UIFont+MATools.m
//  iOS Library
//
//  Created by Andrew Kopanev on 2/16/14.
//  Copyright (c) 2014 Moqod. All rights reserved.
//

#import "UIFont+MATools.h"

@implementation UIFont (MATools)

- (CGFloat)maLineHeight {
    return ceilf(self.lineHeight);
}

@end
