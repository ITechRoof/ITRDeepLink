//
//  AppDelegate.m
//  ITRDeepLink
//
//  Created by kirthi on 03/09/15.
//  Copyright © 2015 ITechRoof. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "Page1ViewController.h"
#import "Page2ViewController.h"
#import "AppboyKit.h"

@interface AppDelegate ()

@property (strong, nonatomic) UINavigationController *contentViewController;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    _contentViewController = [[UINavigationController alloc] initWithRootViewController:[ViewController controller]];
    self.window.rootViewController = _contentViewController;
    
    [Appboy startWithApiKey:@"4e8d2f42-096c-4fb6-bcc0-b1411cad1007"
              inApplication:application
          withLaunchOptions:launchOptions];
    
    [AppDelegate registerForNotification:[UIApplication sharedApplication]];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

+ (void)registerForNotification:(UIApplication *)application
{
    
    // Register for Push Notitications, if running iOS 8
    if ([application respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        UIUserNotificationType userNotificationTypes = (UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound);
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:userNotificationTypes categories:nil];
        [application registerUserNotificationSettings:settings];
        [application registerForRemoteNotifications];
    } else {
        // Register for Push Notifications before iOS 8
        [application registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert |UIRemoteNotificationTypeSound)];
    }
    
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)newDeviceToken {
    [[Appboy sharedInstance] registerPushToken:
     [NSString stringWithFormat:@"%@", newDeviceToken]];
}

- (void) application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler{
    [[Appboy sharedInstance] registerApplication:application didReceiveRemoteNotification:userInfo fetchCompletionHandler:completionHandler];
}


-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    
    if([[url host] isEqualToString:@"link"]){
        if([[url path] isEqualToString:@"/main"]){
            [_contentViewController setViewControllers:@[[ViewController controller]] animated:YES];
        }else if([[url path] isEqualToString:@"/page1"]){
            [_contentViewController setViewControllers:@[[ViewController controller]] animated:NO];
            [_contentViewController pushViewController:[Page1ViewController controller] animated:YES];
        }else if([[url path] isEqualToString:@"/page2"]){
            [_contentViewController setViewControllers:@[[ViewController controller]] animated:NO];
            [_contentViewController pushViewController:[Page2ViewController controller] animated:YES];
        }
    }
    return YES;
}



@end
