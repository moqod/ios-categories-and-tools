//
//  UIView+UserInfo.h
//  MALibrary
//
//  Created by Andrew Kopanev on 7/24/13.
//  Copyright (c) 2013 Moqod. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *	Adds any object as user info to UIView.
 *	Standart `tag` property is good, but not suitable in some cases.
 *	This category can be used in any UIView subclass - such as UIAlertView, UIActionSheet, UIControl.
 *	Lovely.
 */

@interface UIView (MAUserInfo)

// Custom object. Will be released automatically when view is deallocated.
@property (nonatomic, retain) id		maUserInfo;

@end
