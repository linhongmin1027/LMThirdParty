//
//  AppDelegate.m
//  LMThirdParty
//
//  Created by iOSDev on 17/5/3.
//  Copyright © 2017年 linhongmin. All rights reserved.
//

#import "AppDelegate.h"
#import "LMTabBarViewController.h"
#import "LMThirdPartyManager.h"
@interface AppDelegate ()

@end

@implementation AppDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //配置第三方
    [[LMThirdPartyManager manager] setupThirdPartyConfigurationWithApplication:application didFinishedLaunchingWithOptions:launchOptions];
    
    //初始化
    _window=[[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    LMTabBarViewController *tabBarVC=[[LMTabBarViewController alloc]init];
    
    _window.rootViewController=tabBarVC;
    
    _window.backgroundColor=[UIColor whiteColor];
    [_window makeKeyAndVisible];
    return YES;
}

-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    [[LMThirdPartyManager manager] application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];



}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
