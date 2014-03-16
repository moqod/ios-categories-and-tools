//
//  UIAlertView+Blocks.m
//  iOS Library
//
//  Created by Alex Severyanov on 23.08.13.
//  Copyright (c) 2013 Moqod. All rights reserved.
//

#import "UIAlertView+MABlocks.h"
#import "NSObject+MAKeyValue.h"

NSString *const MAUIAlertViewBlockPropertyKey = @"MAUIAlertViewBlockPropertyKey";

@implementation UIAlertView (MABlocks)

- (id)initWithTitle:(NSString *)title message:(NSString *)message completitionBlock:(UIAlertViewMACompletionBlock)block cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION {
    self = [self initWithTitle:title message:message delegate:nil cancelButtonTitle:cancelButtonTitle otherButtonTitles:nil];
    if (self) {
        va_list buttonsList;
        va_start(buttonsList, otherButtonTitles);
        for (NSString *anOtherButtonTitle = otherButtonTitles; anOtherButtonTitle != nil; anOtherButtonTitle = va_arg(buttonsList, NSString*)) {
            [self addButtonWithTitle:anOtherButtonTitle];
        }
        va_end(buttonsList);
        self.maCompletitionBlock = block;
        if (block) {
            self.delegate = self;
        }
    }
    return self;
}

- (void)setMaCompletitionBlock:(UIAlertViewMACompletionBlock)completitionBlock {
    if (completitionBlock) {
        self.delegate = self;
		[self maSetValue:completitionBlock forKey:MAUIAlertViewBlockPropertyKey associationPolicy:OBJC_ASSOCIATION_COPY_NONATOMIC];
    } else {
        self.delegate = nil;
    }
}

- (UIAlertViewMACompletionBlock)maCompletitionBlock {
	return [self maValueForKey:MAUIAlertViewBlockPropertyKey];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (self.maCompletitionBlock) {
         self.maCompletitionBlock(alertView, buttonIndex);
    }
}

@end
