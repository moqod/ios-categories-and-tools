//
//  MAColorSampleViewController.m
//  iOS Library
//
//  Created by Andrew Kopanev on 2/3/14.
//  Copyright (c) 2014 Moqod. All rights reserved.
//

#import "MAColorSampleViewController.h"
#import "UIColor+MATools.h"

@interface MAColorSampleViewController ()

@end

@implementation MAColorSampleViewController

- (void)viewDidLoad {
    [super viewDidLoad];

	[self.smartScrollView addTitleText:@"UIColor+MATools"];
	[self.smartScrollView addDescriptionText:@"This category adds helpful methods to UIColor class.\n\nList of the methods below:"];
	[self.smartScrollView addSourceCodeText:@"+ (UIColor *)maRandomColor;"];
	[self.smartScrollView addSourceCodeText:@"+ (UIColor *)maColorFromRGB:(unsigned int)rgb;"];
	[self.smartScrollView addSourceCodeText:@"+ (UIColor *)maColorFromRGB:(unsigned int)rgb alpha:(CGFloat)alpha;"];
	[self.smartScrollView addSourceCodeText:@"+ (UIColor *)maIntColorWithRed:(unsigned int)red green:(unsigned int)green blue:(unsigned int)blue alpha:(unsigned int)alpha;"];
	
	[self.smartScrollView addDescriptionText:@"\nRandomly colored UIView:"];
	CGFloat viewSize = floorf(self.view.bounds.size.width * 0.55f);
	UIView *randomlyColoredView = [[[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, viewSize, viewSize)] autorelease];
	randomlyColoredView.backgroundColor = [UIColor maRandomColor];
	[self.smartScrollView addSubview:randomlyColoredView];
	
	[self.smartScrollView addDescriptionText:@"\n #FFCCBB color:"];
	UIView *rgbColoredView = [[[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, viewSize, viewSize)] autorelease];
	rgbColoredView.backgroundColor = [UIColor maColorFromRGB:0xffccbb];
	[self.smartScrollView addSubview:rgbColoredView];
	
								   
}

@end
