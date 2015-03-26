//
//  UIView+MAAdditions.m
//  MAAdditions
//
//  Created by Sergey Ryazanov on 22.01.15.
//  Copyright (c) 2015 moqod. All rights reserved.
//

#import "UIView+MAAdditions.h"

@implementation UIView (MAAdditions)

#pragma mark * Edges

- (void)setMaLeft:(CGFloat)maLeft
{
    self.frame = ({
        CGRect frame = self.frame;
        frame.origin.x = maLeft;
        frame;
    });
}

- (CGFloat)maLeft
{
    return self.frame.origin.x;
}

- (void)setMaRight:(CGFloat)maRight
{
    self.frame = ({
        CGRect frame = self.frame;
        frame.origin.x = maRight - frame.size.width;
        frame;
    });
}

- (CGFloat)maRight
{
    return CGRectGetMaxX(self.frame);
}

- (void)setMaTop:(CGFloat)maTop
{
    self.frame = ({
        CGRect frame = self.frame;
        frame.origin.y = maTop;
        frame;
    });
}

- (CGFloat)maTop
{
    return self.frame.origin.y;
}

- (void)setMaBottom:(CGFloat)maBottom
{
    self.frame = ({
        CGRect frame = self.frame;
        frame.origin.y = maBottom - frame.size.height;
        frame;
    });
}

- (CGFloat)maBottom
{
    return CGRectGetMaxY(self.frame);
}

#pragma mark * Size

- (void)setMaWidth:(CGFloat)maWidth
{
    self.frame = ({
        CGRect frame = self.frame;
        frame.size.width = maWidth;
        frame;
    });
}

- (CGFloat)maWidth
{
    return self.bounds.size.width;
}

- (void)setMaHeight:(CGFloat)maHeight
{
    self.frame = ({
        CGRect frame = self.frame;
        frame.size.height = maHeight;
        frame;
    });
}

- (CGFloat)maHeight
{
    return self.bounds.size.height;
}

- (CGSize)maSize
{
    return self.bounds.size;
}

- (void)setMaSize:(CGSize)maSize
{
    CGRect bounds = self.bounds;
    bounds.size = maSize;
    self.bounds = bounds;
}


#pragma mark - Location

- (void)setXLocationAfterView:(UIView *)view withSpacing:(CGFloat)space
{
    self.maLeft = floor(view.maRight + space);
}

- (void)setYLocationAfterView:(UIView *)view withSpacing:(CGFloat)space
{
    self.maTop = floor(view.maBottom + space);
}

- (void)centrateVerticalInView:(UIView *)view
{
    self.maTop = floor(CGRectGetMidY(view.bounds) - self.maHeight * 0.5f);
}

- (void)centrateHorizontalInView:(UIView *)view
{
    self.maLeft = floor(CGRectGetMidX(view.bounds) - self.maWidth * 0.5f);
}

- (void)centrateVerticalBasedOnView:(UIView *)view
{
    self.maTop = floor(CGRectGetMidY(view.frame) - self.maHeight * 0.5f);
}

- (void)centrateHorizontalBasedOnView:(UIView *)view
{
    self.maLeft = floor(CGRectGetMidX(view.frame) - self.maWidth *0.5f);
}


@end
