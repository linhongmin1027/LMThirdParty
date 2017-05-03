//
//  LMHomeViewController.m
//  LMThirdParty
//
//  Created by iOSDev on 17/5/3.
//  Copyright © 2017年 linhongmin. All rights reserved.
//

#import "LMHomeViewController.h"
#define getUrl @"http://www.quanmin.tv/json/page/app_images?p=2&rid=-1&rcat=-1&uid=7240211&screen=2&device=649ECB48-3FA2-4413-93F1-3D905D6A0699&sw=375.0&sh=667.0&ch=APPStore&refer="
/** “uid”:”17”*/
/**  返回的数据：
 {
 “code”:”1”            //1表示为分销用户，2表示不是分销用户
 “rank”:”1”            //1:普通用户,2：vip用户,3:金牌用户,4:钻石用户
 }  */
#define postUrl @"http://121.43.170.12/index.php?g=app&m=share&a=is_drp"

@interface LMHomeViewController ()

@end

@implementation LMHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
