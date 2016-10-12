//
//  ShippingAddressViewController.h
//  VFShoppingMall
//
//  Created by jinyuankeji on 16/10/3.
//  Copyright © 2016年 jinyuankeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShippingAddressViewController : UIViewController

//收货人姓名
@property (nonatomic, strong) UITextField *textFieldName;
//手机号
@property (nonatomic, strong) UITextField *textFieldPhone;
//收货时间
@property (nonatomic, strong) UITextField *textFieldTime;
//地址类型
@property (nonatomic, strong) UITextField *textFieldAddress;
//省份
@property (nonatomic, strong) UITextField *textFieldProvince;
//城市
@property (nonatomic, strong) UITextField *textFieldCity;
//县
@property (nonatomic, strong) UITextField *textFieldCounty;
//街道
@property (nonatomic, strong) UITextField *textFieldStreet;

@end
