//
//  MDLoadImagesManager.h
//  pkshr
//
//  Created by Andrew Kopanev on 6/15/14.
//  Copyright (c) 2014 moqod. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MDLoadImagesManager : NSObject

+ (instancetype)sharedManager;

- (void)asyncLoadImageAtPath:(NSString *)path notificationName:(NSString *)notificationName userInfo:(id)userInfo;

@end
