//
//  GSTabBarController.m
//  VFShoppingMall
//
//  Created by gushi on 16/9/27.
//  Copyright © 2016年 jinyuankeji. All rights reserved.
//

#import "GSTabBarController.h"
#import "MainViewController.h"
#import "FriendViewController.h"
#import "SendViewController.h"
#import "VFOrderListViewController.h"
#import "MyViewController.h"
#import "GSNavController.h"

@interface GSTabBarController ()

@end

@implementation GSTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addController];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+(void)initialize{
    UITabBarItem * tabBarItem = [UITabBarItem appearance];
    UIColor * tabBarItemTestColor = [UIColor colorWithRed:255.0/255 green:185.0/255  blue:2.0/255  alpha:1];
    NSDictionary * dict = @{NSForegroundColorAttributeName:tabBarItemTestColor};
    [tabBarItem setTitleTextAttributes:dict forState:UIControlStateSelected];
}


-(void)addController{
    
    MainViewController * mainVC= [[MainViewController alloc]init];
    [self addChildViewController:mainVC title:@"主页" normalImageName:@"foot_02hui" selectedImageName:@"foot_02"];
    
    FriendViewController * friendVC = [[FriendViewController alloc]init];
    [self addChildViewController:friendVC title:@"好友" normalImageName:@"foot_03hui" selectedImageName:@"foot_03"];
    
    SendViewController * sendVC  = [[SendViewController alloc]init];
    [self addChildViewController:sendVC title:@"发" normalImageName:@"设置_07" selectedImageName:@""];
    VFOrderListViewController * orderVC = [[VFOrderListViewController alloc]init];
    [self addChildViewController:orderVC title:@"订单" normalImageName:@"foot_05hui" selectedImageName:@"foot_05"];
    
    MyViewController * myVC = [[MyViewController alloc]init];
    [self addChildViewController:myVC title:@"我的" normalImageName:@"foot_06hui" selectedImageName:@"foot_06"];
}
-(void)addChildViewController:(UIViewController*)viewController title:(NSString*)title normalImageName:(NSString*)normalImageName selectedImageName:(NSString*)selectedImageName{
    GSNavController * navigationController = [[GSNavController alloc]initWithRootViewController:viewController];
    [self addChildViewController:navigationController];
    
    //设置tabBarItem的title、image
    navigationController.tabBarItem.title = title;
    navigationController.tabBarItem.image = [[UIImage imageNamed:normalImageName]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    navigationController.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImageName]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
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
