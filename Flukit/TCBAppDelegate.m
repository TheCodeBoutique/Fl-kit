//
//  TCBAppDelegate.m
//  Flukit
//
//  Created by Marin Fischer on 1/11/14.
//  Copyright (c) 2014 TheCodeBoutique. All rights reserved.
//

#import "TCBAppDelegate.h"
#import "TCBLoginViewController.h"
#import "TCBAutoLoginViewController.h"

@implementation TCBAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [Parse setApplicationId:@"dOdFd3NdHQ3911nE23zdzqllCMKarz2RbwP98wab"
                  clientKey:@"pMfkyWqSRKbhKHTA19a6rqH9ufzSxvJzZbnTax8X"];
    
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
    //Facebokk
    [PFFacebookUtils initializeFacebook];
    
    
    //twitter
    [PFTwitterUtils initializeWithConsumerKey:@"B4cNw5FHljbpalPPAMA"
                               consumerSecret:@"M8H1cCz4dYxmihWes96s9v8bujVooeAsTuaSxsJi3Q"];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    [self loadDeviceControllers];
    
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [FBAppCall handleOpenURL:url sourceApplication:sourceApplication withSession:[PFFacebookUtils session]];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [FBAppCall handleDidBecomeActiveWithSession:[PFFacebookUtils session]];
}

- (void)loadDeviceControllers
{
   if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
   {
     //for iphone
//       BOOL autoLogin = [[NSUserDefaults standardUserDefaults] stringForKey:@"autologin"];
//       NSString *username = [[NSUserDefaults standardUserDefaults] stringForKey:@"username"];
//       NSString *password = [[NSUserDefaults standardUserDefaults] stringForKey:@"password"];
       
       TCBLoginViewController *loginViewController = [[TCBLoginViewController alloc] initWithNibName:@"TCBLoginViewController" bundle:nil];
       
//       TCBAutoLoginViewController *autoLoginViewController = [[TCBAutoLoginViewController alloc] initWithNibName:@"TCBAutoLoginViewController" bundle:nil];
       UINavigationController *mainNavigationController = [[UINavigationController alloc] initWithRootViewController:loginViewController];
       [[self window] setRootViewController:mainNavigationController];
   }
//    if (autoLogin && username && password)
//    {
//        [[self window] setRootViewController:autoLoginViewController];
//
//    }
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

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
