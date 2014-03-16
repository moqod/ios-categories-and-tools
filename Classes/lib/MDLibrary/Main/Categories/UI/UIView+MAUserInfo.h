//
//  UIView+UserInfo.h
//  MALibrary
//
//  Created by Andrew Kopanev on 7/24/13.
//  Copyright (c) 2013 Moqod. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 Adds custom object as user info to UIView. Can be used in any UIView subclass - such as UIAlertView, UIActionSheet, UIControl.
 Lovely.
 */

@interface UIView (MAUserInfo)

/**
 Custom object. Will be released automatically when view is deallocated.
 Name of the property has prefix 'ma' to avoid custom views which may already implement stuff like userInfo.
 */
@property (nonatomic, retain) id		maUserInfo;

@end
