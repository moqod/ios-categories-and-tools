//
//  MDFastTouchesView.m
//  FastTouches
//
//  Created by Andrew Kopanev on 3/24/14.
//  Copyright (c) 2014 Moqod. All rights reserved.
//

#import "MDFastTouchesView.h"

const NSTimeInterval MDFastTouchesViewDefaultDelay			= 0.1;

@interface MDFastTouchesView () {
	NSTimeInterval			_mdTouchTimestamp;
}

@property (nonatomic, retain) UIView		*tappedButton;

@end

@implementation MDFastTouchesView

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
	UIView *view = [super hitTest:point withEvent:event];
	if (UIEventTypeTouches == event.type && YES == [view isKindOfClass:[UIButton class]] && self.tappedButton != view) {
		if (fabs(event.timestamp - _mdTouchTimestamp) > MDFastTouchesViewDefaultDelay || event.timestamp - _mdTouchTimestamp == 0) {
			_mdTouchTimestamp = event.timestamp;
			self.tappedButton = view;
			return view;
		} else {
			return nil;
		}
	} else {
		return view;
	}
}

- (void)dealloc {
	self.tappedButton = nil;
#if !__has_feature(objc_arc)
	[super dealloc];
#endif
}

@end
