//
//  TKRoundedView.h
//  TKRoundedView
//
//  Created by Tomasz Kuźma on 1/6/13.
//  Copyright (c) 2013 Tomasz Kuźma. All rights reserved.
//

typedef NS_OPTIONS(NSUInteger, TKRoundedCorner) {
    TKRoundedCornerNone         = 0,
    TKRoundedCornerTopRight     = 1 <<  0,
    TKRoundedCornerBottomRight  = 1 <<  1,
    TKRoundedCornerBottomLeft   = 1 <<  2,
    TKRoundedCornerTopLeft      = 1 <<  3,
	TKRoundedCornerAll			= (TKRoundedCornerTopRight | TKRoundedCornerBottomRight | TKRoundedCornerBottomLeft | TKRoundedCornerTopLeft),
	TKRoundedCornerTop			= (TKRoundedCornerTopRight | TKRoundedCornerTopLeft),
	TKRoundedCornerBottom		= (TKRoundedCornerBottomRight | TKRoundedCornerBottomLeft),
};

typedef NS_OPTIONS(NSUInteger, TKDrawnBorderSides) {
    TKDrawnBorderSidesNone				= 0,
    TKDrawnBorderSidesRight				= 1 <<  0,
    TKDrawnBorderSidesLeft				= 1 <<  1,
    TKDrawnBorderSidesTop				= 1 <<  2,
    TKDrawnBorderSidesBottom			= 1 <<  3,
	TKDrawnBorderSidesAll				= (TKDrawnBorderSidesRight | TKDrawnBorderSidesLeft | TKDrawnBorderSidesTop | TKDrawnBorderSidesBottom),
	TKDrawnBorderSidesAllButBottom		= (TKDrawnBorderSidesRight | TKDrawnBorderSidesLeft | TKDrawnBorderSidesTop),
	TKDrawnBorderSidesAllButTop			= (TKDrawnBorderSidesRight | TKDrawnBorderSidesLeft | TKDrawnBorderSidesBottom),
};

typedef NS_ENUM(NSInteger, TKGradientDirection) {
    TKGradientDirectionHorizontal,
    TKGradientDirectionVertical,
    TKGradientDirectionUp,
    TKGradientDirectionDown,
};

typedef NS_ENUM(NSUInteger, MDPositionType) {
	MDPositionSingle = 0,
	MDPositionTop,
	MDPositionMiddle,
	MDPositionBottom,
};

#define POSITION_TYPE(index, count)			( count > 1 ? ( index == 0 ? MDPositionTop : ( index == count - 1 ? MDPositionBottom : MDPositionMiddle ) ) : MDPositionSingle )

@interface TKRoundedView : UIView

/* Which borders should be drawn - default TKDrawnBordersSidesAll - only not rounded borders can *NOT* be drawn atm  */
@property (nonatomic, assign) TKDrawnBorderSides drawnBordersSides;

/* Which corners should be rounded - default TKRoundedCornerAll */
@property (nonatomic, assign) TKRoundedCorner roundedCorners;

/* Fill color of the figure - default white */
@property (nonatomic, strong) UIColor *fillColor;

/* Stroke color for the figure, default is light gray */
@property (nonatomic, strong) UIColor *borderColor;

/* Border line width, default 1.0f */
@property (nonatomic, assign) CGFloat borderWidth;

/* Corners radius , default 15.0f */
@property (nonatomic, assign) CGFloat cornerRadius;

/* Direction of the gradient [options -, |,  /,  \] (if there will be a gradient drawn), default vertical  */
@property (nonatomic, assign) TKGradientDirection gradientDirection;

/* NSArray of NSDictionaries with NSNumber with color's locations and the UIColor object, default nil  */
@property (nonatomic, strong) NSArray *gradientColorsAndLocations;

@property (nonatomic, assign) MDPositionType	positionType;

@end
