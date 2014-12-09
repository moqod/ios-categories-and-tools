//
//  NSAttributedString+MASizeWithFont.h
//  Nastenka
//
//  Created by Sergey Ryazanov on 24.06.14.
//  Copyright (c) 2014 moqod. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSAttributedString (MASizeWithFont)

- (CGSize)maSizeConstrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode;
- (CGSize)maSizeForWidth:(CGFloat)width lineBreakMode:(NSLineBreakMode)lineBreakMode;
- (CGSize)maSizeConstrainedToSize:(CGSize)size;

@end
