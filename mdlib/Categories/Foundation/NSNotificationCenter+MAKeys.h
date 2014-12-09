//
//  NSNotificationCenter+Keys.h
//  MALibrary
//
//  Created by ako on 10/17/12.
//  Copyright (c) 2012 Moqod. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *const NSNotificationCenterKeys_Result;
extern NSString *const NSNotificationCenterKeys_UserInfo;
extern NSString *const NSNotificationCenterKeys_Error;

#define NTF_ERROR(x)                            [[x userInfo] objectForKey:NSNotificationCenterKeys_Error]
#define NTF_RESULT(x)                           [[x userInfo] objectForKey:NSNotificationCenterKeys_Result]
#define NTF_USERINFO(x)							[[x userInfo] objectForKey:NSNotificationCenterKeys_UserInfo]

/** 
 * Simplifies results handling.
 * Most of operations have result or error and maybe userInfo.
 * Uses NSNotification userInfo (NSDictionary) as container for packing parameters.
 * Sample: data engine sends notification when network request is done (succeed or failed) and observers can obtain result, error or userInfo using macros.
 */
@interface NSNotificationCenter (MAKeys)

/** Packs result, error and userInfo to NSDictionary with predefined keys and then posts notification.
 
 @param notificationName notificationName.
 @param object Object of notification.
 @param result Object, which will stored in notification.userInfo with NSNotificationCenterKeys_Result key.
 @param error Error, which will stored in notification.userInfo with NSNotificationCenterKeys_Error key.
 @param userInfo Object, which will stored in notification.userInfo with NSNotificationCenterKeys_UserInfo key.
 @see NTF_ERROR()
 @see NTF_RESULT()
 @see NTF_USERINFO()
 */
- (void)maSendNotificationNamed:(NSString *)notificationName object:(id)object result:(id)result error:(NSError *)error userInfo:(id)userInfo;
/**
 *	Packs result and error to NSDictionary with predefined keys and then posts notification.
 * @see -maSendNotificationNamed:object:result:error:userInfo:
 */
- (void)maSendNotificationNamed:(NSString *)notificationName object:(id)object result:(id)result error:(NSError *)error;

/**
 *	Packs result to NSDictionary with predefined keys and then posts notification.
 * @see -maSendNotificationNamed:object:result:error:userInfo:
 */
- (void)maSendNotificationNamed:(NSString *)notificationName object:(id)object result:(id)result;


// thread - related
- (void)maSendNotificationNamed:(NSString *)notificationName object:(id)object result:(id)result onMainThread:(BOOL)onMainThread;
- (void)maSendNotificationNamed:(NSString *)notificationName object:(id)object result:(id)result error:(NSError *)error onMainThread:(BOOL)onMainThread;
- (void)maSendNotificationNamed:(NSString *)notificationName object:(id)object result:(id)result error:(NSError *)error userInfo:(id)userInfo onMainThread:(BOOL)onMainThread;

@end
