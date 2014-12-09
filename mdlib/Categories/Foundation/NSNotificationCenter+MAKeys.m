//
//  NSNotificationCenter+Keys.m
//  MALibrary
//
//  Created by ako on 10/17/12.
//  Copyright (c) 2012 Moqod. All rights reserved.
//

#import "NSNotificationCenter+MAKeys.h"

NSString *const NSNotificationCenterKeys_Result			= @"result";
NSString *const NSNotificationCenterKeys_UserInfo		= @"userInfo";
NSString *const NSNotificationCenterKeys_Error			= @"error";

@implementation NSNotificationCenter (MAKeys)

#pragma mark - helpers

- (NSMutableDictionary *)maResultDictionary:(id)result error:(NSError *)error userInfo:(id)userInfo {
	NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
	[dictionary setValue:result forKey:NSNotificationCenterKeys_Result];
	[dictionary setValue:error forKey:NSNotificationCenterKeys_Error];
	[dictionary setValue:userInfo forKey:NSNotificationCenterKeys_UserInfo];
	return dictionary;
}

#pragma mark - post notifications

- (void)maSendNotificationNamed:(NSString *)notificationName object:(id)object result:(id)result error:(NSError *)error userInfo:(id)userInfo {
	[self maSendNotificationNamed:notificationName object:object result:result error:error userInfo:userInfo onMainThread:NO];
}

- (void)maSendNotificationNamed:(NSString *)notificationName object:(id)object result:(id)result error:(NSError *)error {
	[self maSendNotificationNamed:notificationName object:object result:result error:error userInfo:nil onMainThread:NO];
}

- (void)maSendNotificationNamed:(NSString *)notificationName object:(id)object result:(id)result {
	[self maSendNotificationNamed:notificationName object:object result:result error:nil userInfo:nil onMainThread:NO];
}

- (void)maSendNotificationNamed:(NSString *)notificationName object:(id)object result:(id)result error:(NSError *)error onMainThread:(BOOL)onMainThread{
	[self maSendNotificationNamed:notificationName object:object result:result error:error userInfo:nil onMainThread:onMainThread];
}

- (void)maSendNotificationNamed:(NSString *)notificationName object:(id)object result:(id)result onMainThread:(BOOL)onMainThread{
	[self maSendNotificationNamed:notificationName object:object result:result error:nil userInfo:nil onMainThread:onMainThread];
}

- (void)maSendNotificationNamed:(NSString *)notificationName object:(id)object result:(id)result error:(NSError *)error userInfo:(id)userInfo onMainThread:(BOOL)onMainThread {
    NSNotification *notification = [NSNotification notificationWithName:notificationName object:object userInfo:[self maResultDictionary:result error:error userInfo:userInfo]];
	if (YES == onMainThread && NO == [NSThread isMainThread]) {
        [self performSelectorOnMainThread:@selector(postNotification:) withObject:notification waitUntilDone:NO];
    } else {
        [self postNotification:notification];
    }
}


@end
