//
//  NSString+SizeWithAppFont.m
//  MALibrary
//
//  Created by Sergey on 9/23/13.
//  Copyright (c) 2013 moqod. All rights reserved.
//

#import "NSString+MASizeWithFont.h"

@implementation NSString (MASizeWithFont)

- (CGSize)maSizeWithFont:(UIFont *)font {
    CGSize outSize = [self sizeWithAttributes:[NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName]];
    return [self maRoundedSize:outSize];
}

- (CGSize)maSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size {
    return [self maSizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
}

- (CGSize)maSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode {
    CGSize outSize = [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName] context:nil].size;
    return [self maRoundedSize:outSize];
}

- (CGSize)maSizeWithFont:(UIFont *)font forWidth:(CGFloat)width lineBreakMode:(NSLineBreakMode)lineBreakMode {
    return [self maSizeWithFont:font constrainedToSize:CGSizeMake(width, CGFLOAT_MAX) lineBreakMode:lineBreakMode];
}

- (CGSize)maRoundedSize:(CGSize)size {
    size.width = ceilf(size.width);
    size.height = ceilf(size.height);
    return size;
}

@end
