//
//  LMNaviViewController.m
//  LMThirdParty
//
//  Created by iOSDev on 17/5/3.
//  Copyright © 2017年 linhongmin. All rights reserved.
//

#import "LMNaviViewController.h"

@interface LMNaviViewController ()

@end

@implementation LMNaviViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
}

/**
 *  当第一次调用这个类的时候调用1次
 */
+(void)initialize {
    
    // 设置UIBarButtonItem的主题
    [self setupBarButtonItem];
    
    // 设置导航栏主题
    [self setupnavigationBarTheme];
    [[UINavigationBar appearance] setBarTintColor:[UIColor whiteColor]];
   // [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
}

/**
 *  设置UIBarButtonItem的主题
 */
+(void)setupBarButtonItem {
    // 通过appearance对象能修改项目总所有的UIBarButotnItem的样式
    UIBarButtonItem * appearance = [UIBarButtonItem appearance];
    
    // 设置普通文本的属性样式
    NSMutableDictionary * nomalTextAttrs = [NSMutableDictionary dictionary];
    nomalTextAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    nomalTextAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:14];
    [appearance setTitleTextAttributes:nomalTextAttrs forState:UIControlStateNormal];
    // 设置高亮文本的样式属性
    NSMutableDictionary * highTextAttrs = [NSMutableDictionary dictionary];
    highTextAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    highTextAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:14];
    [appearance setTitleTextAttributes:highTextAttrs forState:UIControlStateHighlighted];
    
    // 设置禁用状态的文字属性
    NSMutableDictionary * enableTextAttrs = [NSMutableDictionary dictionary];
    enableTextAttrs[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    enableTextAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:14];
    [appearance setTitleTextAttributes:enableTextAttrs forState:UIControlStateDisabled];
}

/**
 *  设置导航栏的主题
 */
+ (void)setupnavigationBarTheme {
    UINavigationBar * appearance = [UINavigationBar appearance];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    // 设置导航栏背景
    [appearance setBackgroundImage:[UIImage imageNamed:@"nav_bar"] forBarMetrics:UIBarMetricsDefault];
    
    NSMutableDictionary * enableTextAttrs = [NSMutableDictionary dictionary];
    enableTextAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    //    enableTextAttrs[NSFontAttributeName] = ZiTi;
    [appearance setTitleTextAttributes:enableTextAttrs];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
