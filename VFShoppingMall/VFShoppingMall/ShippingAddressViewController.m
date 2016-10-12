//
//  ShippingAddressViewController.m
//  VFShoppingMall
//
//  Created by jinyuankeji on 16/10/3.
//  Copyright © 2016年 jinyuankeji. All rights reserved.
//

#import "ShippingAddressViewController.h"
#import "Masonry.h"
#import "MBProgressHUD.h"
#import "AFNetworking.h"


@interface ShippingAddressViewController ()<MBProgressHUDDelegate>
@property (nonatomic,strong) MBProgressHUD*progressHUD;


@end

@implementation ShippingAddressViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveBtnClicked)];
    [self creatView];
}

- (void)creatView{

    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20],NSForegroundColorAttributeName:[UIColor blackColor]}];
    
    self.navigationItem.title = @"收货地址";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"fan"] style:UIBarButtonItemStylePlain target:self action:@selector(handleSend)];
    
    UILabel *labelOfReceiving = [[UILabel alloc] init];
    labelOfReceiving.text = @"收货人";
    labelOfReceiving.textColor = [UIColor blackColor];
    [self.view addSubview:labelOfReceiving];
    [labelOfReceiving mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).with.offset(90);
        make.left.equalTo(self.view).with.offset(20);
        make.height.offset(30);
        make.width.offset(60);
    }];
    
    self.textFieldName = [[UITextField alloc] init];
    [self.view addSubview:self.textFieldName];
    self.textFieldName.placeholder = @"请输入姓名";
    [self.textFieldName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).with.offset(90);
        make.left.equalTo(labelOfReceiving.mas_right).with.offset(20);
        make.right.equalTo(self.view).with.offset(-20);
        make.height.offset(30);
        
    }];
   
    UIView *viewOfNameHui = [[UIView alloc] init];
    viewOfNameHui.backgroundColor = [UIColor colorWithRed:244 / 255.0f green:244 / 255.0f blue:244 / 255.0f alpha:1];
    [self.view addSubview:viewOfNameHui];
    
    [viewOfNameHui mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textFieldName.mas_bottom).with.offset(10);
        make.left.equalTo(self.view).with.offset(20);
        make.right.equalTo(self.view).with.offset(-20);
        make.height.offset(1);
        
    }];
    
    UILabel *labelOfPhone = [[UILabel alloc] init];
    [self.view addSubview:labelOfPhone];
    labelOfPhone.text = @"手机号";
    labelOfPhone.textColor = [UIColor blackColor];
    [labelOfPhone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewOfNameHui).with.offset(10);
        make.left.equalTo(self.view).with.offset(20);
        make.height.offset(30);
        make.width.offset(60);
        
    }];
    self.textFieldPhone = [[UITextField alloc] init];
    [self.view addSubview:self.textFieldPhone];
    self.textFieldPhone.placeholder = @"请输入手机号";
    [self.textFieldPhone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewOfNameHui).with.offset(10);
        make.left.equalTo(labelOfPhone.mas_right).with.offset(20);
        make.right.equalTo(self.view).with.offset(-20);
        make.height.offset(30);
        
    }];
    
    UIView *viewOfPhoneHui = [[UIView alloc] init];
    [self.view addSubview:viewOfPhoneHui];
    viewOfPhoneHui.backgroundColor = [UIColor colorWithRed:244 / 255.0f green:244 / 255.0f blue:244 / 255.0f alpha:1];
    [viewOfPhoneHui mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textFieldPhone.mas_bottom).with.offset(10);
        make.left.equalTo(self.view).with.offset(20);
        make.right.equalTo(self.view).with.offset(-20);
        make.height.offset(1);
        
        
    }];
    UILabel *labelOfTime = [[UILabel alloc] init];
    [self.view addSubview:labelOfTime];
    labelOfTime.text = @"收货时间";
    [labelOfTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewOfPhoneHui).with.offset(10);
        make.left.equalTo(self.view).with.offset(20);
        make.height.offset(30);
        make.width.offset(80);
    }];
    
    self.textFieldTime = [[UITextField alloc] init];
    self.textFieldTime.placeholder = @"周一至周五";
    [self.view addSubview:self.textFieldTime];
    [self.textFieldTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewOfPhoneHui).with.offset(10);
        make.left.equalTo(labelOfTime.mas_right).with.offset(5);
        make.right.equalTo(self.view).with.offset(-20);
        make.height.offset(30);
        
    }];
    UIView *viewOfTimeHui = [[UIView alloc] init];
    [self.view addSubview:viewOfTimeHui];
    viewOfTimeHui.backgroundColor = [UIColor colorWithRed:244 / 255.0f green:244 / 255.0f blue:244 / 255.0f alpha:1];
    [viewOfTimeHui mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textFieldTime.mas_bottom).with.offset(10);
        make.left.equalTo(self.view).with.offset(0);
        make.right.equalTo(self.view).with.offset(0);
        make.height.offset(30);
        
    }];
    UILabel *labelOfAddress = [[UILabel alloc] init];
    [self.view addSubview:labelOfAddress];
    labelOfAddress.text = @"地址类型";
    [labelOfAddress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewOfTimeHui.mas_bottom).with.offset(10);
        make.left.equalTo(self.view).with.offset(20);
        make.height.offset(30);
        make.width.offset(80);
        
    }];
    
    self.textFieldAddress = [[UITextField alloc] init];
    self.textFieldAddress.placeholder = @"公司";
    [self.view addSubview:self.textFieldAddress];
    [self.textFieldAddress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewOfTimeHui.mas_bottom).with.offset(10);
        make.left.equalTo(labelOfAddress.mas_right).with.offset(5);
        make.right.equalTo(self.view).with.offset(-20);
        make.height.offset(30);
        
    }];
    
    UIView *viewOfAddressHui = [[UIView alloc] init];
    [self.view addSubview:viewOfAddressHui];
    viewOfAddressHui.backgroundColor = [UIColor colorWithRed:244 / 255.0f green:244 / 255.0f blue:244 / 255.0f alpha:1];
    [viewOfAddressHui mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textFieldAddress.mas_bottom).with.offset(10);
        make.left.equalTo(self.view).with.offset(20);
        make.right.equalTo(self.view).with.offset(-20);
        make.height.offset(1);
        
        
    }];
    
    
    
    UILabel *labelOfProvince = [[UILabel alloc] init];
    [self.view addSubview:labelOfProvince ];
    labelOfProvince .text = @"省份";
    [labelOfProvince  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewOfAddressHui).with.offset(10);
        make.left.equalTo(self.view).with.offset(20);
        make.height.offset(30);
        make.width.offset(80);
        
    }];
    
    self.textFieldProvince = [[UITextField alloc] init];
    [self.view addSubview:self.textFieldProvince];
    self.textFieldProvince.placeholder = @"请输入省份";
    [self.textFieldProvince mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewOfAddressHui).with.offset(10);
        make.left.equalTo(labelOfProvince.mas_right).with.offset(7);
        make.right.equalTo(self.view).with.offset(-20);
        make.height.offset(30);
        
    }];
    
    UIView *viewOfProvinceHui = [[UIView alloc] init];
    [self.view addSubview:viewOfProvinceHui];
    viewOfProvinceHui.backgroundColor = [UIColor colorWithRed:244 / 255.0f green:244 / 255.0f blue:244 / 255.0f alpha:1];
    [viewOfProvinceHui mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textFieldProvince.mas_bottom).with.offset(10);
        make.left.equalTo(self.view).with.offset(20);
        make.right.equalTo(self.view).with.offset(-20);
        make.height.offset(1);
        
        
    }];
    
    UILabel *labelOfCity = [[UILabel alloc] init];
    [self.view addSubview:labelOfCity];
    labelOfCity.text = @"城市";
    [labelOfCity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewOfProvinceHui).with.offset(10);
        make.left.equalTo(self.view).with.offset(20);
        make.height.offset(30);
        make.width.offset(80);
        
    }];
    self.textFieldCity = [[UITextField alloc] init];
    [self.view addSubview:self.textFieldCity];
    self.textFieldCity.placeholder = @"请输入城市";
    [self.textFieldCity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewOfProvinceHui).with.offset(10);
        make.left.equalTo(labelOfCity.mas_right).with.offset(7);
        make.right.equalTo(self.view).with.offset(-20);
        make.height.offset(30);
        
    }];
    
    UIView *viewOfCityHui = [[UIView alloc] init];
    [self.view addSubview:viewOfCityHui];
    viewOfCityHui.backgroundColor = [UIColor colorWithRed:244 / 255.0f green:244 / 255.0f blue:244 / 255.0f alpha:1];
    [viewOfCityHui mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textFieldCity.mas_bottom).with.offset(10);
        make.left.equalTo(self.view).with.offset(20);
        make.right.equalTo(self.view).with.offset(-20);
        make.height.offset(1);
        
        
    }];

    UILabel *labelOfCounty = [[UILabel alloc] init];
    [self.view addSubview:labelOfCounty];
    labelOfCounty.text = @"县/区";
    [labelOfCounty mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewOfCityHui).with.offset(10);
        make.left.equalTo(self.view).with.offset(20);
        make.height.offset(30);
        make.width.offset(80);
        
    }];
    
    self.textFieldCounty = [[UITextField alloc] init];
    [self.view addSubview:self.textFieldCounty];
    self.textFieldCounty.placeholder = @"请输入县/区";
    [self.textFieldCounty mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewOfCityHui).with.offset(10);
        make.left.equalTo(labelOfCounty.mas_right).with.offset(7);
        make.right.equalTo(self.view).with.offset(-20);
        make.height.offset(30);
        
    }];
    
    UIView *viewOfCountyHui = [[UIView alloc] init];
    [self.view addSubview:viewOfCountyHui];
    viewOfCountyHui.backgroundColor = [UIColor colorWithRed:244 / 255.0f green:244 / 255.0f blue:244 / 255.0f alpha:1];
    [viewOfCountyHui mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textFieldCounty.mas_bottom).with.offset(10);
        make.left.equalTo(self.view).with.offset(20);
        make.right.equalTo(self.view).with.offset(-20);
        make.height.offset(1);
        
        
    }];
    UILabel *labelOfStreet = [[UILabel alloc] init];
    [self.view addSubview:labelOfStreet];
    labelOfStreet.text = @"街道";
    [labelOfStreet mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewOfCountyHui).with.offset(10);
        make.left.equalTo(self.view).with.offset(20);
        make.height.offset(30);
        make.width.offset(80);
        
    }];
    
    self.textFieldStreet = [[UITextField alloc] init];
    [self.view addSubview:self.textFieldStreet];
    self.textFieldStreet.placeholder = @"请输入街道";
    [self.textFieldStreet mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewOfCountyHui).with.offset(10);
        make.left.equalTo(labelOfStreet.mas_right).with.offset(7);
        make.right.equalTo(self.view).with.offset(-20);
        make.height.offset(30);
        
    }];
    
    UIView *viewOfStreetHui = [[UIView alloc] init];
    [self.view addSubview:viewOfStreetHui];
    viewOfStreetHui.backgroundColor = [UIColor colorWithRed:244 / 255.0f green:244 / 255.0f blue:244 / 255.0f alpha:1];
    [viewOfStreetHui mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textFieldStreet.mas_bottom).with.offset(10);
        make.left.equalTo(self.view).with.offset(20);
        make.right.equalTo(self.view).with.offset(-20);
        make.height.offset(1);
        
        
    }];

}

- (void)handleSend{

//    [self.navigationController popToViewController:self.navigationController.viewControllers[1] animated:YES];
    [self.navigationController popViewControllerAnimated:YES];
    


}

-(void)saveBtnClicked{
//    [self addAddressInfo];
}

-(void)addAddressInfo{
    
    NSString *url= @"http://www.jinyuankeji.net/VF/portal/OrderAction/saveAddress";
    
    NSDictionary * param=@{@"userId":@"1",@"name":@"gu",@"telephone":@"111111111111111",@"province":@"sss",@"city":@"='市'&",@"district":@"='区'&",@"street":@"='街道'&",@"detail":@"='具体地址'&",@"flag":@"='状态（1为默认地址）'&",@"addressId":@" = “地址id”（编辑地址）"};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:url parameters:param progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self getAddressMethod:[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil]];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败：%@",error);
    }];
    
    
    _progressHUD = [[MBProgressHUD alloc] initWithView:self.view];
    _progressHUD.dimBackground = NO;
    [self.view addSubview:_progressHUD];
    [self.view bringSubviewToFront:_progressHUD];
    _progressHUD.delegate = self;
    _progressHUD.labelText = @"加载中...";
    [_progressHUD show:YES];
}
-(void)getAddressMethod:(NSDictionary *)dic{
    
    if (_progressHUD)
    {
        [_progressHUD removeFromSuperview];
        _progressHUD = nil;
    }
    
    NSLog(@"%@",dic);
    for (NSDictionary * name in [dic objectForKey:@"Data"]) {
        self.textFieldName.text = [name objectForKey:@"Name"];
    }
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.textFieldStreet resignFirstResponder];
    [self.textFieldCounty resignFirstResponder];
    [self.textFieldCity resignFirstResponder];
    [self.textFieldProvince resignFirstResponder];
    [self.textFieldAddress resignFirstResponder];
    [self.textFieldTime resignFirstResponder];
    [self.textFieldPhone resignFirstResponder];
    [self.textFieldName resignFirstResponder];
}

@end
