//
//  HPRAppDelegate.m
//  Project Raynor
//
//  Created by Nicolas Langley on 2/27/14.
//  Copyright (c) 2014 Hierarchy. All rights reserved.
//

#import <Parse/Parse.h>
#import <MMDrawerController.h>
#import <MMDrawerBarButtonItem.h>
#import "HPRAppDelegate.h"
#import "HPRCenterViewController.h"
#import "HPRLeftDrawerViewController.h"

@implementation HPRAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    // Adding Keys for Parse
    [Parse setApplicationId:@"6Glf46uTWQeVaEkSpsxigbYoYGQ0eWUCEL9iKoBN"
                  clientKey:@"HiZ5o4kHzYLMwLQjWaHcM6M1uqVArM9OUtqmJxuT"];
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
    // Setup center & draw views
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    HPRLeftDrawerViewController * leftDrawer = [[HPRLeftDrawerViewController alloc] init];
    HPRCenterViewController * center = [[HPRCenterViewController alloc] init];
    
    // Create navigation controller with root as center view
    UINavigationController *navController = [[UINavigationController alloc]
                                             initWithRootViewController:center];
    MMDrawerController * drawerController = [[MMDrawerController alloc]
                                             initWithCenterViewController:navController
                                             leftDrawerViewController:leftDrawer];
    // Set gesture masks for drawer controller
    [drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeBezelPanningCenterView];
    [drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeBezelPanningCenterView];
    
    // Set drawer controller references
    self.window.rootViewController = drawerController;
    [center setDrawerController:drawerController];
    [leftDrawer setDrawerController:drawerController];
    
    // Make window visible
    [self.window makeKeyAndVisible];
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
