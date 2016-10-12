//
//  MyWalletViewController.m
//  VFShoppingMall
//
//  Created by jinyuankeji on 16/9/29.
//  Copyright © 2016年 jinyuankeji. All rights reserved.
//

#import "MyWalletViewController.h"
#import "MyViewController.h"
#import "Masonry.h"
@interface MyWalletViewController ()

@property (nonatomic, strong) UILabel *labelOfMoney;


@end

@implementation MyWalletViewController
//隐藏navigationbar
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatView];
    self.view.backgroundColor = [UIColor whiteColor];
    
}

- (void)creatView{
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20],NSForegroundColorAttributeName:[UIColor blackColor]}];
    
    self.navigationItem.title = @"我的钱包";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"fan"] style:UIBarButtonItemStylePlain target:self action:@selector(handleMy)];
    UIView *viewOfHead = [[UIView alloc] initWithFrame:CGRectMake(0, 64, DEVICE_WIDTH, 260)];
    [self.view addSubview:viewOfHead];
    viewOfHead.backgroundColor = [UIColor colorWithRed:130 / 255.0f green:129 / 255.0f blue:129 / 255.0f alpha:1];
    UIImageView *imageViewOfZhuan = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"zhuan"]];
    [self.view addSubview:imageViewOfZhuan];
    [imageViewOfZhuan mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(viewOfHead);
        make.top.equalTo(viewOfHead).with.offset(52);
        make.height.offset(90);
        
    }];
    UILabel *labelOfChange = [[UILabel alloc] init];
    [self.view addSubview:labelOfChange];
    labelOfChange.text = @"零钱";
    labelOfChange.textColor = [UIColor whiteColor];
    [labelOfChange mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageViewOfZhuan.mas_bottom).with.offset(22);
        make.centerX.equalTo(viewOfHead);
        make.height.offset(20);
        
    }];
    
    self.labelOfMoney = [[UILabel alloc] init];
    [self.view addSubview:self.labelOfMoney];
    self.labelOfMoney.text = @"¥ 150.46";
    self.labelOfMoney.textColor = [UIColor whiteColor];
    [self.labelOfMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(labelOfChange.mas_bottom).with.offset(10);
        make.centerX.equalTo(viewOfHead);
        make.height.offset(20);
        
    }];
    
    
    UIButton *buttonOfRecharge = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:buttonOfRecharge];
    buttonOfRecharge.layer.cornerRadius = 5;
    buttonOfRecharge.layer.masksToBounds = YES;
    [buttonOfRecharge setTitle:@"充值" forState:UIControlStateNormal];
    [buttonOfRecharge addTarget:self action:@selector(handlerRecharge) forControlEvents:UIControlEventTouchUpInside];
    buttonOfRecharge.backgroundColor = [UIColor colorWithRed:244 / 255.0f green:172 / 255.0f blue:39 / 255.f alpha:1];
    [buttonOfRecharge mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewOfHead.mas_bottom).with.offset(130);
        make.centerX.equalTo(self.view);
        make.height.offset(60);
        make.left.equalTo(self.view).with.offset(94);
        
    }];
    UIButton *buttonOfWithdraw = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:buttonOfWithdraw];
    buttonOfWithdraw.layer.cornerRadius = 5;
    buttonOfWithdraw.layer.masksToBounds = YES;
    [buttonOfWithdraw setTitle:@"提现" forState:UIControlStateNormal];
    [buttonOfWithdraw addTarget:self action:@selector(handlerWithdraw) forControlEvents:UIControlEventTouchUpInside];
    buttonOfWithdraw.backgroundColor = [UIColor colorWithRed:252 / 255.0f green:223 / 255.0f blue:138 / 255.f alpha:1];
    [buttonOfWithdraw mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(buttonOfRecharge.mas_bottom).with.offset(20);
        make.centerX.equalTo(self.view);
        make.height.offset(60);
        make.left.equalTo(self.view).with.offset(94);
        
    }];
    
    
}
//充值
- (void)handlerRecharge {
    
    
    
}
//提现
- (void)handlerWithdraw{
    
    
}
- (void)handleMy {
    
    
    [self.navigationController popToViewController:self.navigationController.viewControllers[0] animated:YES];
    
    
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
