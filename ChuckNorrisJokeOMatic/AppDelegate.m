//
//  AppDelegate.m
//  ChuckNorrisJokeOMatic
//
//  Created by Ventura Rangel on 5/1/13.
//  Copyright (c) 2013 Antifragile Development. All rights reserved.
//

#import "AppDelegate.h"
#import "ChuckViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
   
    UIViewController *viewController = [[ChuckViewController alloc] initWithNibName:@"ChuckViewController" bundle:[NSBundle mainBundle]];
    
    self.window.rootViewController = viewController;
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

@end
