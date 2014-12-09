//
//  NSAttributedString+MASizeWithFont.m
//  Nastenka
//
//  Created by Sergey Ryazanov on 24.06.14.
//  Copyright (c) 2014 moqod. All rights reserved.
//

#import "NSAttributedString+MASizeWithFont.h"

@implementation NSAttributedString (MASizeWithFont)

- (CGSize)maSizeConstrainedToSize:(CGSize)size {
    return [self maSizeConstrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
}

- (CGSize)maSizeForWidth:(CGFloat)width lineBreakMode:(NSLineBreakMode)lineBreakMode {
    return [self maSizeConstrainedToSize:CGSizeMake(width, CGFLOAT_MAX) lineBreakMode:lineBreakMode];
}

- (CGSize)maSizeConstrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode {
    CGSize outSize = CGSizeZero;
    if ([self respondsToSelector:@selector(boundingRectWithSize:options:context:)]) {
        outSize = [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil].size;
    }
    return [self maRoundedSize:outSize];
}

#pragma mark - Helpers
- (CGSize)maRoundedSize:(CGSize)size {
    size.width = ceilf(size.width);
    size.height = ceilf(size.height);
    return size;
}

@end
