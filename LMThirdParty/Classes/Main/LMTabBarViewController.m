//
//  LMTabBarViewController.m
//  LMThirdParty
//
//  Created by iOSDev on 17/5/3.
//  Copyright © 2017年 linhongmin. All rights reserved.
//

#import "LMTabBarViewController.h"

#import "LMNaviViewController.h"

#import "LMHomeViewController.h"
#import "LMSecondViewController.h"
#import "LMThirdViewController.h"
#import "LMMineViewController.h"
@interface LMTabBarViewController ()

@end

@implementation LMTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupChildControllers];
}
#pragma mark  - 设置子控制器
- (void)setupChildControllers {
    // 添加子控制器
    // 1. 首页
    LMHomeViewController * home = [[LMHomeViewController alloc] init];
    [self addOneChildViewControllerToTabBar:home
                                      title:@"首页"
                             nomalImageName:@"btn_tabbar_home_normal"
                            selectImageName:@"btn_tabbar_home_selected"];
    
    // 3. 第二个Item
    LMSecondViewController * market1 = [[LMSecondViewController alloc] init];
    [self addOneChildViewControllerToTabBar:market1
                                      title:@"直播"
                             nomalImageName:@"btn_tabbar_zhibo_normal"
                            selectImageName:@"btn_tabbar_zhibo_selected"];
    
    // 2. 第三个Item
    LMThirdViewController * attention = [[LMThirdViewController alloc] init];
    [self addOneChildViewControllerToTabBar:attention
                                      title:@"主播"
                             nomalImageName:@"btn_tabbar_guanzhu_normal"
                            selectImageName:@"btn_tabbar_guanzhu_selected"];
    
    
    // 3. 我的
    LMMineViewController * market = [[LMMineViewController alloc] init];
    [self addOneChildViewControllerToTabBar:market
                                      title:@"我的"
                             nomalImageName:@"btn_tabbar_wode_normal"
                            selectImageName:@"btn_tabbar_wode_selected"];
}




#pragma mark  - 添加子控制器
- (void)addOneChildViewControllerToTabBar:(UIViewController *)controller
                                    title:(NSString *)title
                           nomalImageName:(NSString *)nomalImageName
                          selectImageName:(NSString *)selectImageName {
    
    // 设置标题
    controller.tabBarItem.title = title;
    controller.navigationItem.title = title;
    // 设置未选中图片
    controller.tabBarItem.image = [UIImage imageNamed:nomalImageName];
    
    // 选中状态下的图片，默认为苹果渲染，取消渲染
    UIImage * selectImage = [UIImage imageNamed:selectImageName];
    selectImage = [selectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    controller.tabBarItem.selectedImage = selectImage;
    
    // 设置选中状态下的文字颜色
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    dict[NSForegroundColorAttributeName] = kAllColor;
    [controller.tabBarItem setTitleTextAttributes:dict forState:UIControlStateSelected];
    
    
    // 添加子控制器到导航控制器中
    LMNaviViewController * nav = [[LMNaviViewController alloc] initWithRootViewController:controller];
    // 添加子控制器
    [self addChildViewController:nav];
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
