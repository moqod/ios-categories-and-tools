//
//  MABaseSampleViewController.m
//  iOS Library
//
//  Created by Andrew Kopanev on 2/3/14.
//  Copyright (c) 2014 Moqod. All rights reserved.
//

#import "MABaseSampleViewController.h"

@implementation MABaseSampleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	_smartScrollView = [[MASmartScrollView alloc] initWithFrame:self.view.bounds];
	[self.view addSubview:_smartScrollView];
}

- (void)dealloc {
	[_smartScrollView release];
	[super dealloc];
}

@end
