//
//  MAImageSampleViewController.m
//  iOS Library
//
//  Created by Andrew Kopanev on 2/4/14.
//  Copyright (c) 2014 Moqod. All rights reserved.
//

#import "MAImageSampleViewController.h"
#import "UIImage+MASimpleImages.h"
#import "UIButton+MALibrary.h"

@interface MAImageSampleViewController ()

@end

@implementation MAImageSampleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	[self.smartScrollView addTitleText:@"UIImage+MARoundedCorner"];
	[self.smartScrollView addDescriptionText:@"Creates rounded image with one line of code."];
	[self.smartScrollView addDescriptionText:@"Really useful as button's background image and other stretchable stuff."];
	[self.smartScrollView addDescriptionText:@"\nMethod:"];
	[self.smartScrollView addSourceCodeText:@"+ (UIImage *)maRoundedImageWithSize:(CGSize)size cornerRadius:(CGFloat)cornerRadius backgroundColor:(UIColor *)backgroundColor;"];
	
	CGFloat viewSize = floorf(self.view.bounds.size.width * 0.55f);
	const CGFloat cornerRadius = floorf(viewSize * 0.25);
	[self.smartScrollView addDescriptionText:@"\nUIImageView with rounded image:"];
	UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, viewSize, viewSize)];
	imageView.image = [UIImage maRoundedImageWithSize:imageView.bounds.size cornerRadius:cornerRadius backgroundColor:[UIColor darkGrayColor]];
	[self.smartScrollView addSubview:imageView];
	
	[self.smartScrollView addDescriptionText:@"\nUIButton with stretchable background image:"];
	
	const CGFloat buttonCornerRadius = 6.0f;
	const CGFloat buttonHeight = 40.0f;
	UIImage *roundedButtonImage = [[UIImage maRoundedImageWithSize:CGSizeMake(buttonCornerRadius * 2.0f, buttonCornerRadius * 2.0f) cornerRadius:buttonCornerRadius backgroundColor:[UIColor orangeColor]] maStretchableImage];
	UIImage *roundedSelectedButtonImage = [[UIImage maRoundedImageWithSize:CGSizeMake(buttonCornerRadius * 2.0f, buttonCornerRadius * 2.0f) cornerRadius:buttonCornerRadius backgroundColor:[UIColor greenColor]] maStretchableImage];
	UIButton *button = [UIButton maButtonWithBackgroundImage:roundedButtonImage highlightedBackgroundImage:roundedSelectedButtonImage];
	button.frame = CGRectMake(0.0f, 0.0f, viewSize, buttonHeight);
	[button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
	[button setTitle:@"Button" forState:UIControlStateNormal];
	[self.smartScrollView addSubview:button];
	
	UIImage *rectImage = [UIImage maRectImageWithSize:CGSizeMake(buttonHeight, buttonHeight) backgroundColor:[UIColor whiteColor] borderWidth:2.0 borderColor:[UIColor blackColor]];
	UIButton *button2 = [UIButton maButtonWithBackgroundImage:[rectImage maStretchableImage]];
	button2.frame = CGRectMake(0.0f, 0.0f, self.view.bounds.size.width - 40.0, buttonHeight);
	[button2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
	[button2 setTitle:@"Button" forState:UIControlStateNormal];
	[self.smartScrollView addSubview:button2];
}

@end
