//
//  MASmartScrollView.m
//  MALibrary
//
//  Created by Andrew Kopanev on 2/25/13.
//  Copyright (c) 2013 Moqod. All rights reserved.
//

#import "MASmartScrollView.h"
#import "NSString+MASizeWithFont.h"

const int MASmartScrollViewSubviewTag			= 1;

@interface MASmartScrollView () {
	UIScrollView	*_scrollView;
}
- (void)realignScrollviewSubviews;
@end

@implementation MASmartScrollView

#pragma mark - initialization

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
		self.backgroundColor = [UIColor whiteColor];
		self.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
		_scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
		_scrollView.canCancelContentTouches = NO;
		_scrollView.delaysContentTouches = NO;
		_scrollView.backgroundColor = self.backgroundColor;
		_scrollView.opaque = YES;
		[self addSubview:_scrollView];
    }
    return self;
}

#pragma mark - helpers

- (UILabel *)labelWithFont:(UIFont *)font text:(NSString *)text {
	UILabel *textLabel = [[[UILabel alloc] initWithFrame:CGRectZero] autorelease];
	textLabel.numberOfLines = 0;
	textLabel.text = text;
	textLabel.backgroundColor = _scrollView.backgroundColor;
	textLabel.font = font;
	return textLabel;
}

#pragma mark - public

- (void)addTitleText:(NSString *)titleText {
	[self addSubview:[self labelWithFont:[UIFont boldSystemFontOfSize:14.0f] text:titleText]];
	[self setNeedsLayout];
}

- (void)addDescriptionText:(NSString *)descriptionText {
	[self addSubview:[self labelWithFont:[UIFont systemFontOfSize:14.0f] text:descriptionText]];
	[self setNeedsLayout];
}

- (void)addSourceCodeText:(NSString *)sourceCodeText {
	[self addSubview:[self labelWithFont:[UIFont fontWithName:@"CourierNewPSMT" size:12.0f] text:sourceCodeText]];
	[self setNeedsLayout];
}

#pragma mark - layout stuff

- (void)realignScrollviewSubviews {
	const CGFloat offset = 8.0f;
	const CGFloat offsetBetweenViews = 10.0f;
	const CGFloat initialHorizontalMargin = 5.0f;
	CGFloat currentY = initialHorizontalMargin;

	BOOL previousViewWasLabel = NO;
	for (UIView *v in _scrollView.subviews) {
		if (v.tag == MASmartScrollViewSubviewTag) {
			BOOL currentViewIsLabel = [v isKindOfClass:[UILabel class]];
			// add Y offset
			currentY += ( (currentViewIsLabel && previousViewWasLabel) || (currentY < initialHorizontalMargin + 1.0f)) ? 2.0f : offsetBetweenViews;
			if ([v isKindOfClass:[UILabel class]]) {
				float labelWidth = _scrollView.bounds.size.width - offset * 2.0f;
				UILabel *label = (UILabel *)v;
				CGSize size = [label.text maSizeWithFont:label.font constrainedToSize:CGSizeMake(labelWidth, FLT_MAX)];
				label.frame = CGRectMake(offset, currentY, labelWidth, size.height);
			} else {
				v.frame = CGRectMake( floorf(_scrollView.bounds.size.width * 0.5f - v.bounds.size.width * 0.5f), currentY, v.bounds.size.width, v.bounds.size.height );
			}
			previousViewWasLabel = currentViewIsLabel;
			currentY = CGRectGetMaxY(v.frame);
		}
	}
	
	currentY += initialHorizontalMargin;
	
	_scrollView.contentSize = CGSizeMake(_scrollView.bounds.size.width, currentY);
	[_scrollView flashScrollIndicators];
}

- (void)addSubview:(UIView *)view {
	if (view == _scrollView) {
		[super addSubview:_scrollView];
	} else {
		view.tag = MASmartScrollViewSubviewTag;
		[_scrollView addSubview:view];
	}
}

- (void)layoutSubviews {
	[super layoutSubviews];
	_scrollView.frame = self.bounds;
	[self realignScrollviewSubviews];
}

#pragma mark - memory management

- (void)dealloc {
	[_scrollView release];
	[super dealloc];
}

@end
