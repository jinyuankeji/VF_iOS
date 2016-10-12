//
//  SendSuccessViewController.m
//  VFShoppingMall
//
//  Created by jinyuankeji on 16/10/1.
//  Copyright © 2016年 jinyuankeji. All rights reserved.
//

#import "SendSuccessViewController.h"
#import "Masonry.h"
#import "MyViewController.h"
@interface SendSuccessViewController ()
@property (nonatomic, strong) UITextField *textFieldName;

@end

@implementation SendSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self creatView];
    self.view.backgroundColor = [UIColor whiteColor];
    
}

- (void)creatView{

    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20],NSForegroundColorAttributeName:[UIColor blackColor]}];
    
    self.navigationItem.title = @"完善个人信息";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"fan"] style:UIBarButtonItemStylePlain target:self action:@selector(handleSend)];

    UIImageView *imageViewHead = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"huan"]];
    [self.view addSubview:imageViewHead];
    [imageViewHead mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).with.offset(100);
        make.centerX.equalTo(self.view);
        make.height.offset(150);
        make.width.offset(150);
        
        
    }];
    
    UILabel *labelOfMe = [[UILabel alloc] init];
    labelOfMe.text = @"我就是我, 是颜色不一样的烟火";
    [self.view addSubview:labelOfMe];
    [labelOfMe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageViewHead.mas_bottom).with.offset(30);
        make.centerX.equalTo(self.view);
        make.width.offset(240);
        make.height.offset(20);
        
        
    }];

    self.textFieldName = [[UITextField alloc] init];
    [self.view addSubview:self.textFieldName];
    
    self.textFieldName.text = @"设置昵称";
    self.textFieldName.textColor = [UIColor colorWithRed:215 / 255.0f green:215 / 255.0f blue:215 / 255.0f alpha:1];
    
    [self.textFieldName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(labelOfMe.mas_bottom).with.offset(100);
        make.left.equalTo(self.view).with.offset(20);
        make.height.offset(20);
        make.width.equalTo(self.view).with.offset(-20);
        
        
    }];
    UIButton *buttonSuccess = [[UIButton alloc] init];
    [self.view addSubview:buttonSuccess];
    [buttonSuccess setTitle:@"填写完成" forState:UIControlStateNormal];
    [buttonSuccess addTarget:self action:@selector(handlerMy) forControlEvents:UIControlEventTouchUpInside];
    
    buttonSuccess.backgroundColor = [UIColor colorWithRed:244 / 255.0f green:172 / 255.0f blue:39 / 255.f alpha:1];
    
    [buttonSuccess mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textFieldName.mas_bottom).with.offset(20);
        make.left.equalTo(self.view).with.offset(20);
        make.right.equalTo(self.view).with.offset(-20);
        make.height.offset(60);
        
        
    }];
    
    

}

- (void)handleSend{

    [self.navigationController popToViewController:self.navigationController.viewControllers[2] animated:YES];


}
- (void)handlerMy{

//    MyViewController *myVC = [[MyViewController alloc] init];
//    [self.navigationController pushViewController:myVC animated:YES];
    


}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.textFieldName resignFirstResponder];


}


@end
