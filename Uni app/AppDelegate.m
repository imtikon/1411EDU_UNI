//
//  AppDelegate.m
//  Uni app
//
//  Created by Imtiaz Hossain on 11/21/14.
//  Copyright (c) 2014 Imtiaz Hossain. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

// Set StoryBoard for other resolution-size devices
-(void) setStoryBoard {
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenHeight = screenRect.size.height;
    NSLog(@"screenHeight== %f", screenHeight);
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        if (screenHeight < 568) {
            NSLog(@"== 4S iPhone ==");
            /*UIStoryboard *iPhoneV6Storyboard = [UIStoryboard storyboardWithName:@"4S_Main" bundle:nil];
            UIViewController *initialViewController = [iPhoneV6Storyboard instantiateInitialViewController];
            self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
            self.window.rootViewController  = initialViewController;
            [self.window makeKeyAndVisible];*/
        }else{
            NSLog(@"== 5S iPhone ==");
            /*UIStoryboard *iPhoneV7Storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            UIViewController *initialViewController = [iPhoneV7Storyboard instantiateInitialViewController];
            self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
            self.window.rootViewController  = initialViewController;
            [self.window makeKeyAndVisible];*/
        }
    }else{
        NSLog(@"==iPad==");
        /*UIStoryboard *iPhoneV6Storyboard = [UIStoryboard storyboardWithName:@"Main_iPad" bundle:nil];
        UIViewController *initialViewController = [iPhoneV6Storyboard instantiateInitialViewController];
        self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        self.window.rootViewController  = initialViewController;
        [self.window makeKeyAndVisible];*/
    }
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    // Change the background color of navigation bar
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:38.0/255.0 green:14.0/255.0 blue:63.0/255.0 alpha:1.0]];
    
    // Change the font style of the navigation bar
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowColor = [UIColor colorWithRed:38.0/255.0 green:14.0/255.0 blue:63.0/255.0 alpha:1.0];
    shadow.shadowOffset = CGSizeMake(0, 0);
    [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                           [UIColor colorWithRed:191.0/255.0 green:148.0/255.0 blue:70.0/255.0 alpha:1.0], NSForegroundColorAttributeName,
                                                           shadow, NSShadowAttributeName,
                                                           [UIFont fontWithName:@"Helvetica-Light" size:18.0], NSFontAttributeName, nil]];
    
    
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
