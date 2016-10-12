//
//  PaySuccessViewController.m
//  VFShoppingMall
//
//  Created by jinyuankeji on 16/10/3.
//  Copyright © 2016年 jinyuankeji. All rights reserved.
//

#import "PaySuccessViewController.h"
#import "Masonry.h"
@interface PaySuccessViewController ()
@property (nonatomic, strong) UIImageView *imageViewOfRight;
@property (nonatomic, strong) UIImageView *imageViewOfWrong;
@property (nonatomic, strong) UILabel *labelOfPeople;
@property (nonatomic, strong) UILabel *labelOfReceiveAddress;
@property (nonatomic, strong) UILabel *labelOfMoney;


@end

@implementation PaySuccessViewController


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatView];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    
}


- (void)creatView{

    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20],NSForegroundColorAttributeName:[UIColor blackColor]}];
    
    self.navigationItem.title = @"支付成功";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"fan"] style:UIBarButtonItemStylePlain target:self action:@selector(handleSend)];
    
    UIView *viewOfHead = [[UIView alloc] init];
    viewOfHead.backgroundColor = [UIColor colorWithRed:244 / 255.0f green:172 / 255.0f blue:39 / 255.0f alpha:1];
    
    [self.view addSubview:viewOfHead];
    [viewOfHead mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).with.offset(64);
        make.left.equalTo(self.view).with.offset(0);
        make.right.equalTo(self.view).with.offset(0);
        make.height.offset(100);
        
        
    }];
    
    self.imageViewOfRight = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"right"]];
    [viewOfHead addSubview:self.imageViewOfRight];
    [self.imageViewOfRight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewOfHead).with.offset(10);

        make.centerX.equalTo(viewOfHead).with.offset(-50);
        
        
    }];
    
    UILabel *labelOfSuccess = [[UILabel alloc] init];
    labelOfSuccess.text = @"付款成功";
    labelOfSuccess.textColor = [UIColor whiteColor];
    [viewOfHead addSubview:labelOfSuccess];
    labelOfSuccess.font = [UIFont systemFontOfSize:20];
    
    [labelOfSuccess mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewOfHead).with.offset(15);
        make.left.equalTo(self.imageViewOfRight.mas_right).with.offset(5);
        make.height.offset(20);
        make.width.offset(100);
        
        
    }];
    
    UILabel *labelOfSend = [[UILabel alloc] init];
    labelOfSend.text = @"您的包裹正在整装待发";
    labelOfSend.textColor = [UIColor whiteColor];
    [viewOfHead addSubview:labelOfSend];
    labelOfSend.font = [UIFont systemFontOfSize:20];
    [labelOfSend mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(labelOfSuccess.mas_bottom).with.offset(10);
        make.centerX.equalTo(viewOfHead);
        make.left.equalTo(viewOfHead).with.offset(100);
        make.height.offset(20);
        
    }];
    
    UILabel *labelOfReceive = [[UILabel alloc] init];
    [self.view addSubview:labelOfReceive];
    labelOfReceive.text = @"收货人 :";
    [labelOfReceive mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewOfHead.mas_bottom).with.offset(20);
        make.left.equalTo(self.view).with.offset(20);
        make.width.offset(80);
        make.height.offset(20);
    }];
    self.labelOfPeople = [[UILabel alloc] init];
    [self.view addSubview:self.labelOfPeople];
    self.labelOfPeople.text = @"sdfasdfas";
    [self.labelOfPeople mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewOfHead.mas_bottom).with.offset(20);
        make.left.equalTo(labelOfReceive.mas_right).with.offset(5);
        make.height.offset(20);
        make.width.offset(300);
        
    }];
    UILabel *labelOfAddress = [[UILabel alloc] init];
    [self.view addSubview:labelOfAddress];
    labelOfAddress.text = @"收货地址:";
    [labelOfAddress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(labelOfReceive.mas_bottom).with.offset(10);
        make.left.equalTo(self.view).with.offset(20);
        make.width.offset(80);
        make.height.offset(20);
        
    }];
    
    self.labelOfReceiveAddress = [[UILabel alloc] init];
    [self.view addSubview:self.labelOfReceiveAddress];
    self.labelOfReceiveAddress.text = @"asdfsafasdfasdfasdfsdfsdfsadfsaweqrweqrqwerwerwed";
    self.labelOfReceiveAddress.numberOfLines = 2;
    [self.labelOfReceiveAddress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(labelOfReceive.mas_bottom).with.offset(10);
        make.left.equalTo(labelOfAddress.mas_right).with.offset(5);
        make.right.equalTo(self.view).with.offset(-10);
        make.height.offset(40);
        
    }];
    UIView *viewOfOne = [[UIView alloc] init];
    [self.view addSubview:viewOfOne];
//    viewOfOne.backgroundColor = [UIColor colorWithRed:235 / 255.0f green:235 / 255.0f blue:235 / 255.0f alpha:1];

    viewOfOne.backgroundColor = [UIColor grayColor];
    [viewOfOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.labelOfReceiveAddress.mas_bottom).with.offset(20);
        make.left.equalTo(self.view).with.offset(20);
        make.right.equalTo(self.view).with.offset(-20);
        make.height.offset(1);
        
        
    }];

    UILabel *labelOfTotalPrice = [[UILabel alloc] init];
    labelOfTotalPrice.text = @"总价";
    [self.view addSubview:labelOfTotalPrice];
    [labelOfTotalPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewOfOne).with.offset(20);
        make.left.equalTo(self.view).with.offset(20);
        make.width.offset(40);
        make.height.offset(20);
        
    }];
    self.labelOfMoney = [[UILabel alloc] init];
    self.labelOfMoney.text = @"121212";
    self.labelOfMoney.textColor = [UIColor redColor];
    
    [self.view addSubview:self.labelOfMoney];
    [self.labelOfMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewOfOne).with.offset(20);
        make.left.equalTo(labelOfTotalPrice.mas_right).with.offset(20);
        make.width.offset(60);
        make.height.offset(20);
        
    }];
    UIButton *buttonOrder = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:buttonOrder];
    [buttonOrder setTitle:@"查看订单" forState:UIControlStateNormal];
    buttonOrder.layer.borderWidth = 1.0f;
    [buttonOrder addTarget:self action:@selector(orderBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [buttonOrder setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    buttonOrder.layer.borderColor = [UIColor grayColor].CGColor;
    [buttonOrder mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).with.offset(50);
        make.top.equalTo(self.labelOfMoney.mas_bottom).with.offset(30);
        make.width.offset(150);
        make.height.offset(40);
    }];
    
    UIButton *buttonReturn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:buttonReturn];
    [buttonReturn setTitle:@"返回首页" forState:UIControlStateNormal];
    [buttonReturn addTarget:self action:@selector(handlerAddress) forControlEvents:UIControlEventTouchUpInside];
    buttonReturn.layer.borderWidth = 1.0f;
    [buttonReturn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    buttonReturn.layer.borderColor = [UIColor grayColor].CGColor;
    [buttonReturn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.labelOfMoney.mas_bottom).with.offset(30);
        make.left.equalTo(buttonOrder.mas_right).with.offset(20);
        make.width.offset(150);
        make.height.offset(40);
        
    }];
    
    UIView *viewOfHui = [[UIView alloc] init];
    viewOfHui.backgroundColor = [UIColor colorWithRed:235 / 255.0f green:235 / 255.0f blue:235 / 255.0f alpha:1];
    [self.view addSubview:viewOfHui];
    [viewOfHui mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(buttonReturn.mas_bottom).with.offset(30);
        make.left.equalTo(self.view).with.offset(0);
        make.right.equalTo(self.view).with.offset(0);
        make.height.offset(15);
        
    }];
    
    UILabel *labelRemind = [[UILabel alloc] init];
    [self.view addSubview:labelRemind];
    labelRemind.text = @"付款成功后,VF商城不会以付款异常、卡单、系统升级为由联系您。请勿泄露银行卡号、手机验证码,否则会造成钱款损失。谨防电话诈骗!";
    labelRemind.numberOfLines = 4;
    [labelRemind mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewOfHui.mas_bottom).with.offset(20);
        make.left.equalTo(self.view).with.offset(20);
        make.right.equalTo(self.view).with.offset(-20);
        make.height.offset(80);
        
    }];
    UIView *viewOfHuiOne = [[UIView alloc] init];
    [self.view addSubview:viewOfHuiOne];
    viewOfHuiOne.backgroundColor = [UIColor colorWithRed:235 / 255.0f green:235 / 255.0f blue:235 / 255.0f alpha:1];

    [viewOfHuiOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(labelRemind.mas_bottom).with.offset(10);
        make.left.equalTo(self.view).with.offset(0);
        make.right.equalTo(self.view).with.offset(0);
        make.bottom.equalTo(self.view).with.offset(0);
    }];
    

}

- (void)handleSend{

    [self.navigationController popToViewController:self.navigationController.childViewControllers[1] animated:YES];


}

#pragma mark-跳转
- (void)handlerAddress{

  


}
-(void)orderBtnClicked{
    
}



@end
