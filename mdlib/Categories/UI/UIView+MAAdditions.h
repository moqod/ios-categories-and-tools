//
//  UIView+MAAdditions.h
//  TFLink
//
//  Created by Sergey Ryazanov on 22.01.15.
//  Copyright (c) 2015 moqod. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (MAAdditions)

#pragma mark * Edges
@property (nonatomic, assign) CGFloat maLeft;
@property (nonatomic, assign) CGFloat maRight;

@property (nonatomic, assign) CGFloat maTop;
@property (nonatomic, assign) CGFloat maBottom;

#pragma mark * Size
@property (nonatomic, assign) CGFloat maWidth;
@property (nonatomic, assign) CGFloat maHeight;

#pragma mark - Location

- (void)setXLocationAfterView:(UIView *)view withSpacing:(CGFloat)space;
- (void)setYLocationAfterView:(UIView *)view withSpacing:(CGFloat)space;
- (void)centrateVerticalInView:(UIView *)view;
- (void)centrateHorizontalInView:(UIView *)view;
- (void)centrateVerticalBasedOnView:(UIView *)view;
- (void)centrateHorizontalBasedOnView:(UIView *)view;

@end
