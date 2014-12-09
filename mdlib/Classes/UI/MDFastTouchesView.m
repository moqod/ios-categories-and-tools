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
	if (self.tappedButton) {
        CGPoint localPoint = [self convertPoint:point toView:self.tappedButton];
        if (CGRectContainsPoint(self.tappedButton.bounds, localPoint)) {
            return [super hitTest:point withEvent:event];
        }
        return nil;
    }
    UIView *view = [super hitTest:point withEvent:event];
	if (UIEventTypeTouches == event.type && YES == [view isKindOfClass:[UIButton class]] && self.tappedButton != view) {
		if (fabs(event.timestamp - _mdTouchTimestamp) > MDFastTouchesViewDefaultDelay) {
			_mdTouchTimestamp = event.timestamp;
			self.tappedButton = view;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                self.tappedButton = nil;
            });
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
