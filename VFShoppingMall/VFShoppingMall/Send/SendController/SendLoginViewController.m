//
//  SendLoginViewController.m
//  VFShoppingMall
//
//  Created by jinyuankeji on 16/9/29.
//  Copyright © 2016年 jinyuankeji. All rights reserved.
//

#import "SendLoginViewController.h"
#import "SendViewController.h"
#import "Masonry.h"
#import "SendNameRegisterViewController.h"
@interface SendLoginViewController ()

@property (nonatomic, strong) UITextField *fieldOfPhoneNumber;


@end

@implementation SendLoginViewController
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
    
    self.navigationItem.title = @"手机注册";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"fan"] style:UIBarButtonItemStylePlain target:self action:@selector(handleSend)];
    

    UILabel *labelOfPhone = [[UILabel alloc] init];
    [self.view addSubview:labelOfPhone];
    labelOfPhone.text = @"将发送验证码到您的手机";
    labelOfPhone.textColor = [UIColor orangeColor];
    
    [labelOfPhone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).with.offset(84);
        make.left.equalTo(self.view).with.offset(20);
        make.width.offset(200);
        make.height.offset(30);
        
        
    }];
    UIView *viewOfOne = [[UIView alloc] init];
    [self.view addSubview:viewOfOne];
    viewOfOne.backgroundColor = [UIColor colorWithRed:215 / 255.0f green:215 / 255.0f blue:215 / 255.0f alpha:1];
    [viewOfOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(labelOfPhone.mas_bottom).with.offset(10);
        make.left.equalTo(self.view).with.offset(20);
        make.right.equalTo(self.view).with.offset(-20);
        make.height.offset(1);
        
    }];
    
    
    
    UILabel *labelOfPhonenumber = [[UILabel alloc] init];
    labelOfPhonenumber.text = @"手机号";
    [self.view addSubview:labelOfPhonenumber];
    [labelOfPhonenumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(labelOfPhone.mas_bottom).with.offset(20);
        make.left.equalTo(self.view).with.offset(20);
        make.width.offset(80);
        make.height.offset(30);
        
        
    }];
    
    self.fieldOfPhoneNumber = [[UITextField alloc] init];
    self.fieldOfPhoneNumber.text = @"请输入密码";
    [self.view addSubview:self.fieldOfPhoneNumber];
    self.fieldOfPhoneNumber.textColor = [UIColor colorWithRed:215 / 255.0f green:215 / 255.0f blue:215 / 255.0f alpha:1];
    [self.fieldOfPhoneNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(labelOfPhone.mas_bottom).with.offset(20);
        make.left.equalTo(labelOfPhonenumber.mas_right).with.offset(20);
        make.right.equalTo(self.view).with.offset(-20);
        make.height.offset(30);
        
        
    }];
    
    
    
    
    
    
    UIView *viewOfBottom = [[UIView alloc] init];
    [self.view addSubview:viewOfBottom];
    viewOfBottom.backgroundColor = [UIColor colorWithRed:234 / 255.0f green:234 / 255.0f blue:234 / 255.0f alpha:1];
    [viewOfBottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.fieldOfPhoneNumber.mas_bottom).with.offset(10);
        make.left.equalTo(self.view).with.offset(0);
        make.right.equalTo(self.view).with.offset(0);
        make.bottom.equalTo(self.view).with.offset(0);
        
    }];
    
    UIButton *buttonDetermine = [UIButton buttonWithType:UIButtonTypeCustom];
    [viewOfBottom addSubview:buttonDetermine];
    buttonDetermine.layer.cornerRadius = 5;
    buttonDetermine.layer.masksToBounds = YES;
    [buttonDetermine addTarget:self action:@selector(handlerNameRegister) forControlEvents:UIControlEventTouchUpInside];
    
    [buttonDetermine setTitle:@"下一步" forState: UIControlStateNormal];
    buttonDetermine.backgroundColor = [UIColor colorWithRed:244 / 255.0f green:172 / 255.0f blue:39 / 255.f alpha:1];
    [buttonDetermine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewOfBottom).with.offset(50);
        make.left.equalTo(self.view).with.offset(30);
        make.right.equalTo(self.view).with.offset(-30);
        make.height.offset(50);
        
        
    }];
    
}




- (void)handlerNameRegister{

    SendNameRegisterViewController *nameRegisterVC = [[SendNameRegisterViewController alloc] init];
    nameRegisterVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:nameRegisterVC animated:YES];

}




- (void)handleSend{
    
    [self.navigationController popToViewController:self.navigationController.viewControllers[0] animated:YES];
    
    
}


@end
