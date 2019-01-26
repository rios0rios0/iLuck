//
//  AppDelegate.m
//  iLuck
//
//  Created by Felipe Rios on 12/04/12.
//  Copyright (c) 1997 - 2012. All rights reserved.
//

#import "AppDelegate.h"
#import "MasterViewController.h"

@implementation AppDelegate
@synthesize window, masterViewController;

- (void)dealloc
{
    [masterViewController release];
    [window release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self.window addSubview: masterViewController.view];
    [self.window makeKeyAndVisible];
    return YES;
}

@end
