//
//  LMThirdPartyManager.h
//  LMThirdParty
//
//  Created by iOSDev on 17/5/3.
//  Copyright © 2017年 linhongmin. All rights reserved.
//  第三方管理工具类

#import <Foundation/Foundation.h>

/** JPush */
#import <JPUSHService.h>
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif
@interface LMThirdPartyManager : NSObject
+(instancetype)manager;

-(void)setupThirdPartyConfigurationWithApplication:(UIApplication *)application didFinishedLaunchingWithOptions:(NSDictionary *)launchOptions;
-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken;
@end
