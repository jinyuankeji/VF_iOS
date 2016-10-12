//
//  SendNameRegisterViewController.m
//  VFShoppingMall
//
//  Created by jinyuankeji on 16/10/1.
//  Copyright © 2016年 jinyuankeji. All rights reserved.
//

#import "SendNameRegisterViewController.h"
#import "Masonry.h"
#import "SendSuccessViewController.h"

@interface SendNameRegisterViewController ()
@property (nonatomic, strong) UITextField *textFielDverification;
@property (nonatomic, strong) UITextField *textFielPassword;


@end

@implementation SendNameRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatView];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)creatView{

    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20],NSForegroundColorAttributeName:[UIColor blackColor]}];
    
    self.navigationItem.title = @"用户名注册";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"fan"] style:UIBarButtonItemStylePlain target:self action:@selector(handleSend)];

    UILabel *labelOfDverification = [[UILabel alloc] init];
    [self.view addSubview:labelOfDverification];
    labelOfDverification.text = @"验证码";
    labelOfDverification.font = [UIFont systemFontOfSize:17];
    [labelOfDverification mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).with.offset(84);
        make.left.equalTo(self.view).with.offset(20);
        make.height.offset(30);
        make.width.offset(80);
        
        
    }];
    self.textFielDverification = [[UITextField alloc] init];
    [self.view addSubview:self.textFielDverification];
    self.textFielDverification.text = @"请输入验证码";
    self.textFielDverification.font = [UIFont systemFontOfSize:17];
    self.textFielDverification.textColor = [UIColor colorWithRed:215 / 255.0f green:215 / 255.0f blue:215 / 255.0f alpha:1];
    
    [self.textFielDverification mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).with.offset(84);
        make.left.equalTo(labelOfDverification.mas_right).with.offset(10);
        make.height.offset(30);
        make.width.offset(150);
        
    }];
    UIButton *buttonAcquire = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:buttonAcquire];
    [buttonAcquire setTitle:@"获取验证码" forState:UIControlStateNormal];
    [buttonAcquire setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    buttonAcquire.layer.borderColor = [UIColor orangeColor].CGColor;
    buttonAcquire.layer.borderWidth = 1.0f;
    [buttonAcquire mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).with.offset(84);
        make.right.equalTo(self.view).with.offset(-20);
        make.width.offset(100);
        make.height.offset(30);
        
    }];
    UIView *viewOfAcquireOne = [[UIView alloc] init];
    [self.view addSubview:viewOfAcquireOne];
    viewOfAcquireOne.backgroundColor = [UIColor colorWithRed:215 / 255.0f green:215 / 255.0f blue:215 / 255.0f alpha:1];
    [viewOfAcquireOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textFielDverification.mas_bottom).with.offset(10);
        make.left.equalTo(self.view).with.offset(20);
        make.right.equalTo(self.view).with.offset(-20);
        make.height.offset(1);
        
    }];
    
    UILabel *labelPassword = [[UILabel alloc] init];
    [self.view addSubview:labelPassword];
    labelPassword.text = @"密   码";
    labelPassword.font = [UIFont systemFontOfSize:17];
    [labelPassword mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(labelOfDverification.mas_bottom).with.offset(20);
        make.left.equalTo(self.view).with.offset(20);
        make.height.offset(30);
        make.width.offset(80);
        
    }];
    self.textFielPassword = [[UITextField alloc] init];
    self.textFielPassword.placeholder = @"请设置密码";
    [self.view addSubview:self.textFielPassword];
    self.textFielPassword.textColor = [UIColor colorWithRed:215 / 255.0f green:215 / 255.0f blue:215 / 255.0f alpha:1];
    
    [self.textFielPassword mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(labelOfDverification.mas_bottom).with.offset(20);
        make.left.equalTo(labelPassword.mas_right).with.offset(10);
        make.height.offset(30);
        make.width.offset(150);
        
    }];
    UIView *viewOfPasswordOne = [[UIView alloc] init];
    [self.view addSubview:viewOfPasswordOne];
    viewOfPasswordOne.backgroundColor = [UIColor colorWithRed:215 / 255.0f green:215 / 255.0f blue:215 / 255.0f alpha:1];
    [viewOfPasswordOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textFielPassword.mas_bottom).with.offset(10);
        make.left.equalTo(self.view).with.offset(20);
        make.right.equalTo(self.view).with.offset(-20);
        make.height.offset(1);
        
    }];
    
    UIView *viewOfBottom = [[UIView alloc] init];
    [self.view addSubview:viewOfBottom];
    viewOfBottom.backgroundColor = [UIColor colorWithRed:234 / 255.0f green:234 / 255.0f blue:234 / 255.0f alpha:1];
    [viewOfBottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewOfPasswordOne.mas_bottom).with.offset(10);
        make.left.equalTo(self.view).with.offset(0);
        make.right.equalTo(self.view).with.offset(0);
        make.bottom.equalTo(self.view).with.offset(0);
        
    }];
    
    
    
    
    
    
    UIButton *buttonDetermine = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:buttonDetermine];
    buttonDetermine.backgroundColor = [UIColor colorWithRed:244 / 255.0f green:172 / 255.0f blue:39 / 255.f alpha:1];
    [buttonDetermine setTitle:@"确定" forState:UIControlStateNormal];
    [buttonDetermine addTarget:self action:@selector(handlerSuccess) forControlEvents:UIControlEventTouchUpInside];
    
    buttonDetermine.layer.cornerRadius = 5;
    buttonDetermine.layer.masksToBounds = YES;
    [buttonDetermine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewOfPasswordOne).with.offset(50);
        make.left.equalTo(self.view).with.offset(20);
        make.right.equalTo(self.view).with.offset(-20);
        make.height.offset(50);
        
    }];
    
}




- (void)handlerSuccess{

    SendSuccessViewController *successVC = [[SendSuccessViewController alloc] init];
    
    [self.navigationController pushViewController:successVC animated:YES];
    


}





- (void)handleSend{

  [self.navigationController popToViewController:self.navigationController.viewControllers[1] animated:YES];
    

}
@end
