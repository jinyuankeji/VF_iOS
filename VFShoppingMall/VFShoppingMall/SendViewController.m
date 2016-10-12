//
//  SendViewController.m
//  VFShoppingMall
//
//  Created by gushi on 16/9/27.
//  Copyright © 2016年 jinyuankeji. All rights reserved.
//

#import "SendViewController.h"
#import "Masonry.h"
#import "SendLoginViewController.h"
#import "AFNetworking.h"
#import "MyViewController.h"



@interface SendViewController ()
@property (nonatomic, strong) UITextField *textFieldOfPhone;
@property (nonatomic, strong) UITextField *textFieldOfPassword;

@end

@implementation SendViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self creatView];
    self.view.backgroundColor = [UIColor whiteColor];
    
}

- (void)creatView{
    
    UIImageView *imageOfTitle = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Login_logo"]];
    
    
    [self.view addSubview:imageOfTitle];
    
    
    [imageOfTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).with.offset(80);
        make.centerX.equalTo(self.view);
        make.height.offset(100);
        make.width.offset(100);
        
    }];
    UILabel *labelOfTitleSmall = [[UILabel alloc] init];
    labelOfTitleSmall.text = @"愉快购物尽在VF商城";
    labelOfTitleSmall.textColor = [UIColor colorWithRed:172 / 255.0f green:173 / 255.0f blue:173 / 255.0f alpha:1];
    [self.view addSubview:labelOfTitleSmall];
    labelOfTitleSmall.font = [UIFont systemFontOfSize:17];
    [labelOfTitleSmall mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageOfTitle.mas_bottom).with.offset(20);
        make.centerX.equalTo(self.view);
        make.height.offset(20);
        
    }];
    UILabel *labelOfAccount = [[UILabel alloc] init];
    labelOfAccount.text = @"账号";
    labelOfAccount.backgroundColor = [UIColor whiteColor];
    labelOfAccount.font = [UIFont systemFontOfSize:17];
    [self.view addSubview:labelOfAccount];
    [labelOfAccount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(labelOfTitleSmall.mas_bottom).with.offset(100);
        make.left.equalTo(self.view).with.offset(40);
        make.height.offset(20);
        make.width.offset(50);
        
    }];
    
    self.textFieldOfPhone = [[UITextField alloc] init];
    [self.view addSubview:self.textFieldOfPhone];
    self.textFieldOfPhone.text = @"手机号/邮箱";
    self.textFieldOfPhone.font = [UIFont systemFontOfSize:17];
    self.textFieldOfPhone.textColor = [UIColor colorWithRed:215 / 255.0f green:215 / 255.0f blue:215 / 255.0f alpha:1];
    [self.textFieldOfPhone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(labelOfTitleSmall.mas_bottom).with.offset(100);
        make.left.equalTo(labelOfAccount.mas_right).with.offset(20);
        make.height.offset(20);
        make.right.equalTo(self.view).with.offset(-20);
        
        
    }];
    
    
    
    
    UIView *viewOfPhoneOne = [[UIView alloc] init];
    [self.view addSubview:viewOfPhoneOne];
    viewOfPhoneOne.backgroundColor = [UIColor colorWithRed:192 / 255.0f green:192 / 255.0f blue:192 / 255.0f alpha:1];
    [viewOfPhoneOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textFieldOfPhone.mas_bottom).with.offset(10);
        make.left.equalTo(self.view).with.offset(40);
        make.right.equalTo(self.view).with.offset(-40);
        make.height.offset(1);
        
    }];
    
    UILabel *labelOfPassword = [[UILabel alloc] init];
    [self.view addSubview:labelOfPassword];
    labelOfPassword.text = @"密码";
    labelOfPassword.font = [UIFont systemFontOfSize:17];
    [labelOfPassword mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewOfPhoneOne).with.offset(10);
        make.left.equalTo(self.view).with.offset(40);
        make.height.offset(20);
        make.width.offset(50);
        
    }];
    
    self.textFieldOfPassword = [[UITextField alloc] init];
    [self.view addSubview:self.textFieldOfPassword];
    self.textFieldOfPassword.text = @"登录密码";
    self.textFieldOfPassword.font = [UIFont systemFontOfSize:17];
    self.textFieldOfPassword.textColor = [UIColor colorWithRed:215 / 255.0f green:215 / 255.0f blue:215 / 255.0f alpha:1];
    [self.textFieldOfPassword mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewOfPhoneOne).with.offset(10);
        make.left.equalTo(labelOfPassword.mas_right).with.offset(20);
        make.right.equalTo(self.view).with.offset(-20);
        make.height.offset(20);
        
    }];
    
    
    
    UIView *viewOFPassword = [[UIView alloc] init];
    [self.view addSubview:viewOFPassword];
    viewOFPassword.backgroundColor = [UIColor colorWithRed:192 / 255.0f green:192 / 255.0f blue:192 / 255.0f alpha:1];
    [viewOFPassword mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textFieldOfPassword.mas_bottom).with.offset(10);
        make.left.equalTo(self.view).with.offset(40);
        make.right.equalTo(self.view).with.offset(-40);
        make.height.offset(1);
        
    }];
    
    UIButton *buttonOfLogin = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:buttonOfLogin];
    [buttonOfLogin setTitle:@"登录" forState:UIControlStateNormal];
    [buttonOfLogin addTarget:self action:@selector(handlerLogin) forControlEvents:UIControlEventTouchUpInside];
    buttonOfLogin.layer.cornerRadius = 5;
    buttonOfLogin.layer.masksToBounds = YES;
    buttonOfLogin.backgroundColor = [UIColor colorWithRed:244 / 255.0f green:172 / 255.0f blue:39 / 255.f alpha:1];
    [buttonOfLogin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewOFPassword.mas_bottom).with.offset(80);
        make.centerX.equalTo(self.view);
        make.height.offset(50);
        make.left.equalTo(self.view).with.offset(38);
        
    }];
    
    UIButton *buttonOfRegister = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [self.view addSubview:buttonOfRegister];
    [buttonOfRegister setTitle:@"注册" forState:UIControlStateNormal];
    [buttonOfRegister addTarget:self action:@selector(handlerRegister) forControlEvents:UIControlEventTouchUpInside];
    buttonOfRegister.layer.cornerRadius = 5;
    buttonOfRegister.layer.masksToBounds = YES;
    buttonOfRegister.backgroundColor = [UIColor colorWithRed:252 / 255.0f green:223 / 255.0f blue:138 / 255.f alpha:1];
    [buttonOfRegister mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(buttonOfLogin.mas_bottom).with.offset(10);
        make.centerX.equalTo(self.view);
        make.height.offset(50);
        make.left.equalTo(self.view).with.offset(38);
        
    }];
    
    
    
    
    
    
    
}


- (void)handlerLogin{
  
    
    MyViewController *registerVC = [[MyViewController alloc] init];
    [self.navigationController pushViewController:registerVC animated:YES];
    
}
- (void)handlerRegister{
    
    SendLoginViewController *loginVC = [[SendLoginViewController alloc] init];
    [self.navigationController pushViewController:loginVC animated:YES];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.textFieldOfPhone resignFirstResponder];
    [self.textFieldOfPassword resignFirstResponder];
    
    
    
}

@end
