//
//  MDLoadImagesManager.h
//  pkshr
//
//  Created by Andrew Kopanev on 6/15/14.
//  Copyright (c) 2014 moqod. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 * Loads and draws images in background.
 * Use this class when you don't want to block main thread while image is loading.
 * TODO: we need UIImageView category with this functionality.
 */

@interface MDLoadImagesManager : NSObject

+ (instancetype)sharedManager;

- (void)asyncLoadImageAtPath:(NSString *)path notificationName:(NSString *)notificationName userInfo:(id)userInfo;

@end
