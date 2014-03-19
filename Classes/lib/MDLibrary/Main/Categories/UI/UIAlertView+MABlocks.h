//
//  UIAlertView+Blocks.h
//  iOS Library
//
//  Created by Alex Severyanov on 23.08.13.
//  Copyright (c) 2013 Moqod. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *	Adds completition block to UIAlertView.
 *	Uses NSObject+MAKeyValue.h.
 */

typedef void (^UIAlertViewMACompletionBlock)(UIAlertView *alertView, NSUInteger buttonIndex);

@interface UIAlertView (MABlocks)
/**
 *	Completition block for alert. Has alertView and buttonIndex parameters. When setted then delegate for this alert is current alert.
 */
@property (nonatomic, copy) UIAlertViewMACompletionBlock  maCompletitionBlock;
/**
 *	Created alert view with completition block
 *
 *	@param	title	title
 *	@param	message	message
 *	@param	block	completition block
 *	@param	cancelButtonTitle	cancel button title
 *	@param	otherButtonTitles	other buttons
 *
 *	@return	alert view
 */
- (id)initWithTitle:(NSString *)title message:(NSString *)message completitionBlock:(UIAlertViewMACompletionBlock)block cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;

@end
