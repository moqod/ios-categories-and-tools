//
//  NSNotificationCenter+Keys.m
//  MALibrary
//
//  Created by ako on 10/17/12.
//  Copyright (c) 2012 Moqod & Apps with love All rights reserved.
//

#import "NSNotificationCenter+Keys.h"

NSString *const NSNotificationCenterKeys_Result			= @"result";
NSString *const NSNotificationCenterKeys_UserInfo		= @"userInfo";
NSString *const NSNotificationCenterKeys_Error			= @"error";

@implementation NSNotificationCenter (Keys) 

#pragma mark - helpers

- (NSMutableDictionary *)resultDictionary:(id)result error:(NSError *)error userInfo:(id)userInfo {
	NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
	[dictionary setValue:result forKey:NSNotificationCenterKeys_Result];
	[dictionary setValue:error forKey:NSNotificationCenterKeys_Error];
	[dictionary setValue:userInfo forKey:NSNotificationCenterKeys_UserInfo];
	return dictionary;
}

#pragma mark - post notifications

- (void)maSendNotificationNamed:(NSString *)notificationName object:(id)object result:(id)result error:(NSError *)error userInfo:(id)userInfo {
	[self postNotificationName:notificationName object:object userInfo:[self resultDictionary:result error:error userInfo:userInfo]];
}

- (void)maSendNotificationNamed:(NSString *)notificationName object:(id)object result:(id)result error:(NSError *)error {
	[self maSendNotificationNamed:notificationName object:object result:result error:error userInfo:nil];
}

- (void)maSendNotificationNamed:(NSString *)notificationName object:(id)object result:(id)result {
	[self maSendNotificationNamed:notificationName object:object result:result error:nil userInfo:nil];
}

@end
