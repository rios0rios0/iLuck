//
//  AppDelegate.h
//  iLuck
//
//  Created by Felipe Rios on 12/04/12.
//  Copyright (c) 1997 - 2012. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MasterViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate> {
    MasterViewController *masterViewController;
}

@property (strong, nonatomic) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet MasterViewController *masterViewController;

@end
