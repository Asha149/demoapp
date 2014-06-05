//
//  AppDelegate.m
//  BabyMaker
//
//  Created by Ajeet on 2/7/14.
//  Copyright (c) 2014 Ajeet. All rights reserved.
//

#import "AppDelegate.h"
#import <Parse/Parse.h>

@implementation AppDelegate
@synthesize ObjID,LastInsertedObjID,SelectedIndexPath,UserName,Age,userImage,selectedIndex,OvulationImage;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    selectedIndex=0;
    
    UILocalNotification *localNotification=[launchOptions objectForKey:UIApplicationLaunchOptionsLocalNotificationKey];
    
    if(localNotification)
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Local Notification" message:@"Babymaker notification" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles: nil];
        [alert show];
    }
    
    application.applicationIconBadgeNumber = 0;
    
    // Handle launching from a notification
    UILocalNotification *localNotif =[launchOptions objectForKey:UIApplicationLaunchOptionsLocalNotificationKey];
    if (localNotif) {
        NSLog(@"Recieved Notification %@",localNotif);
    }
    
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone || [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
    {
        [Parse setApplicationId:@"8M7eQ6l8vHEoEk3LW4EjZcTVFkUFrxpvVBsCFl97"
                      clientKey:@"qUFnsj0SJve78xpRyxb7GzzzhbMicV27Z6wKMrQT"];
        ViewController *obj = [[ViewController alloc] initWithNibName:@"ViewController_iPhone" bundle:nil];
        self.viewController = obj;
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:obj];
        self.revealSideViewController = [[PPRevealSideViewController alloc] initWithRootViewController:nav];
        [self.revealSideViewController setDirectionsToShowBounce:PPRevealSideDirectionNone];
        [self.revealSideViewController setPanInteractionsWhenClosed:PPRevealSideInteractionContentView | PPRevealSideInteractionNavigationBar];
        self.window.rootViewController = self.revealSideViewController;
        self.window.backgroundColor = [UIColor whiteColor];
        [self.window makeKeyAndVisible];
        return YES;
    }
    else
    {
        self.viewController = [[ViewController alloc] initWithNibName:@"ViewController_iPad" bundle:nil];
    }
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)application:(UIApplication *)app didReceiveLocalNotification:(UILocalNotification *)notif {
    // Handle the notificaton when the app is running
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Notification" message:notif.alertBody delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles: nil];
    [alert show];
    NSLog(@"Recieved Notification %@",notif);
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
