//
//  MySetViewController.m
//  VFShoppingMall
//
//  Created by jinyuankeji on 16/10/2.
//  Copyright © 2016年 jinyuankeji. All rights reserved.
//

#import "MySetViewController.h"
#import "SDImageCache.h"
#import "Masonry.h"
#import "SendViewController.h"
@interface MySetViewController ()
@property (nonatomic, assign) float flog;
@property (nonatomic, strong) UIAlertView *alertView;
@property (nonatomic, strong) UIButton *cacheButton;
@end

@implementation MySetViewController

//隐藏navigationbar
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    SDImageCache *sdimage = [[SDImageCache alloc] init];
    self.flog = [sdimage checkTmpSize];
    
    // 2.
    NSString *string = [NSString stringWithFormat:@"%.2fM", self.flog];
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatView];
    self.view.backgroundColor = [UIColor colorWithRed:244 / 255.0f green:244 / 255.0f blue:244 / 255.0f alpha:1];
}

- (void)creatView{
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20],NSForegroundColorAttributeName:[UIColor blackColor]}];
    
    self.navigationItem.title = @"设置";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"fan"] style:UIBarButtonItemStylePlain target:self action:@selector(handleSend)];
    
    UILabel *labelOfNews = [[UILabel alloc] init];
    [self.view addSubview:labelOfNews];
    labelOfNews.backgroundColor = [UIColor whiteColor];
    labelOfNews.text = @"  消息提醒";
    labelOfNews.textColor = [UIColor blackColor];
    
    [labelOfNews mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).with.offset(84);
        make.left.equalTo(self.view).with.offset(0);
        make.right.equalTo(self.view).with.offset(0);
        make.height.offset(60);
        
    }];
    
    UISwitch *switchOfNews = [[UISwitch alloc] init];
    [self.view addSubview:switchOfNews];
    switchOfNews.onTintColor = [UIColor orangeColor];
    
    [switchOfNews setOn:NO];
    [switchOfNews addTarget:self action:@selector(switchAction) forControlEvents:UIControlEventValueChanged];
    [switchOfNews mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(labelOfNews);
        make.right.equalTo(labelOfNews).with.offset(-20);
        
        
    }];
    
    self.cacheButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:self.cacheButton];
    self.cacheButton.backgroundColor = [UIColor whiteColor];
    self.cacheButton.contentHorizontalAlignment =  UIControlContentHorizontalAlignmentLeft;
    self.cacheButton.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [self.cacheButton setTitle:@"清除本地缓存" forState:UIControlStateNormal];
    [self.cacheButton addTarget:self action:@selector(handlerCache) forControlEvents:UIControlEventTouchUpInside];
    
    [self.cacheButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [self.cacheButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(labelOfNews.mas_bottom).with.offset(20);
        make.left.equalTo(self.view).with.offset(0);
        make.right.equalTo(self.view).with.offset(0);
        make.height.offset(60);
        
        
    }];
    
    
    UIButton *buttonOfOpinion = [[UIButton alloc] init];
    [self.view addSubview:buttonOfOpinion];
    buttonOfOpinion.contentHorizontalAlignment =  UIControlContentHorizontalAlignmentLeft;
    buttonOfOpinion.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    buttonOfOpinion.backgroundColor = [UIColor whiteColor];
    [buttonOfOpinion setTitle:@"意见反馈" forState:UIControlStateNormal];
    [buttonOfOpinion setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [buttonOfOpinion mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.cacheButton.mas_bottom).with.offset(20);
        make.left.equalTo(self.view).with.offset(0);
        make.right.equalTo(self.view).with.offset(0);
        make.height.offset(60);
        
        
    }];
    UIView *viewOneHui = [[UIView alloc] init];
    [self.view addSubview:viewOneHui];
    viewOneHui.backgroundColor = [UIColor colorWithRed:244 / 255.0f green:244 / 255.0f blue:244 / 255.0f alpha:1];
    [viewOneHui mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(buttonOfOpinion.mas_bottom).with.offset(1);
        make.left.equalTo(self.view).with.offset(0);
        make.right.equalTo(self.view).with.offset(0);
        make.height.offset(1);
        
    }];
    
    
    UIButton *buttonOfUs = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:buttonOfUs];
    buttonOfUs.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    buttonOfUs.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    buttonOfUs.backgroundColor = [UIColor whiteColor];
    [buttonOfUs setTitle:@"关于我们" forState:UIControlStateNormal];
    [buttonOfUs setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [buttonOfUs mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewOneHui).with.offset(0);
        make.left.equalTo(self.view).with.offset(0);
        make.right.equalTo(self.view).with.offset(0);
        make.height.offset(60);
        
        
    }];
    
    
    UIButton *buttonExit = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:buttonExit];
    buttonExit.backgroundColor = [UIColor colorWithRed:244 / 255.0f green:172 / 255.0f blue:39 / 255.f alpha:1];
    
    [buttonExit setTitle:@"退出当前账号" forState:UIControlStateNormal];
    [buttonExit addTarget:self action:@selector(handlerExit) forControlEvents:UIControlEventTouchUpInside];
    
    
    [buttonExit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(buttonOfUs.mas_bottom).with.offset(80);
        make.left.equalTo(self.view).with.offset(40);
        make.right.equalTo(self.view).with.offset(-40);
        make.height.offset(60);
        
    }];
    
    
}
- (void)handleSend{
    
    
    [self.navigationController popToViewController:self.navigationController.viewControllers[0] animated:YES];
    
    
    
}

- (void)switchAction{
    
    
}
-(void)handlerCache{
    self.alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"你确定清除缓存么" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    
    
    [self.alertView show];
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
{
    if (buttonIndex == 1) {
        SDImageCache *sdimage = [[SDImageCache alloc] init];
        [sdimage clearMemory];
        [sdimage clearDisk];
        self.flog = [sdimage checkTmpSize];
        
        NSString *strtitle = [NSString stringWithFormat:@"%.2fM", self.flog];
        [self.cacheButton setTitle:strtitle forState:UIControlStateNormal];
    }
    self.alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确定要清除缓存?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    
    
}

- (void)handlerExit{
    
    
    
    
}




@end
