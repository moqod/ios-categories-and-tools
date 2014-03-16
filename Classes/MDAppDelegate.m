//
//  MDAppDelegate.m
//  iOS Library
//
//  Created by Andrew Kopanev on 11/18/13.
//  Copyright (c) 2013 Moqod. All rights reserved.
//

#import "MDAppDelegate.h"
#import "MAMainViewController.h"

@implementation MDAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];	
	self.window.rootViewController = [[[UINavigationController alloc] initWithRootViewController:[[[MAMainViewController alloc] init] autorelease]] autorelease];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

@end
