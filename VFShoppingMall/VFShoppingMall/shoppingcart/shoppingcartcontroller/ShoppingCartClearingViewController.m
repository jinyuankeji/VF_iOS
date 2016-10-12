//
//  ShoppingCartClearingViewController.m
//  VFShoppingMall
//
//  Created by jinyuankeji on 16/10/2.
//  Copyright © 2016年 jinyuankeji. All rights reserved.
//

#import "ShoppingCartClearingViewController.h"
#import "Masonry.h"
#import "ShippingAddressViewController.h"
#import "ShoppingCartClearingModel.h"
#import "NetworkingHandler.h"
@interface ShoppingCartClearingViewController ()
//名字
@property (nonatomic, strong) UILabel *labelName;
//电话
@property (nonatomic, strong) UILabel *labelPhone;
//地址
@property (nonatomic, strong) UILabel *labelAddress;
//商品金额
@property (nonatomic, strong) UILabel *labelgoodsAmount;
//应付金额
@property (nonatomic, strong) UILabel *labelAmount;
//邮费
@property (nonatomic, strong) UILabel *labelFreight;



@property (nonatomic, strong) NSMutableDictionary *dic;

@property (nonatomic, strong) ShoppingCartClearingModel *modelCart;





//http://www.jinyuankeji.net/VF/portal/OrderAction/settlement?userId=2&orderId=14

@end

@implementation ShoppingCartClearingViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configData];
    // Do any additional setup after loading the view.
    [self creatView];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)creatView{


    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20],NSForegroundColorAttributeName:[UIColor blackColor]}];
    
    self.navigationItem.title = @"结算";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"fan"] style:UIBarButtonItemStylePlain target:self action:@selector(handleSend)];
    

    UIView *viewOfTitle = [[UIView alloc] init];
    [self.view addSubview:viewOfTitle];
    viewOfTitle.backgroundColor = [UIColor colorWithRed:244 / 255.0f green:170 / 255.0f blue:39 / 255.0f alpha:1];
    [viewOfTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).with.offset(84);
        make.left.equalTo(self.view).with.offset(0);
        make.right.equalTo(self.view).with.offset(0);
        make.height.offset(180);
        
        
    }];

    self.labelName = [[UILabel alloc] init];
    
    [viewOfTitle addSubview:self.labelName];
    self.labelName.font = [UIFont systemFontOfSize:16];
    self.labelName.textColor = [UIColor whiteColor];
//    self.labelName.backgroundColor = [UIColor whiteColor];
    [self.labelName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewOfTitle).with.offset(20);
        make.left.equalTo(viewOfTitle).with.offset(20);
        make.width.offset(80);
        make.height.offset(20);
        
        
    }];
    self.labelPhone = [[UILabel alloc] init];
    [viewOfTitle addSubview:self.labelPhone];
    self.labelPhone.textColor = [UIColor whiteColor];
//    self.labelPhone.backgroundColor = [UIColor whiteColor];
    self.labelPhone.font = [UIFont systemFontOfSize:16];
    [self.labelPhone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewOfTitle).with.offset(20);
        make.left.equalTo(self.labelName.mas_right).with.offset(20);
        make.width.offset(150);
        make.height.offset(20);
        
    }];
    self.labelAddress = [[UILabel alloc] init];
    self.labelAddress.textColor = [UIColor whiteColor];
    [viewOfTitle addSubview:self.labelAddress];
//    self.labelAddress.backgroundColor = [UIColor whiteColor];
    self.labelAddress.numberOfLines = 2;
    self.labelAddress.font = [UIFont systemFontOfSize:16];
    [self.labelAddress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.labelName.mas_bottom).with.offset(20);
        make.left.equalTo(self.view).with.offset(20);
        make.width.offset(260);
        make.height.offset(70);
        
    }];
    UIButton *buttonOfAddress = [UIButton buttonWithType:UIButtonTypeCustom];
    [viewOfTitle addSubview:buttonOfAddress];
    [buttonOfAddress setTitle:@"其它地址" forState:UIControlStateNormal];
    [buttonOfAddress addTarget:self action:@selector(handleAddress) forControlEvents:UIControlEventTouchUpInside];
    [buttonOfAddress setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [buttonOfAddress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(viewOfTitle).with.offset(-20);
        make.bottom.equalTo(viewOfTitle).with.offset(-20);
        make.height.offset(20);
        make.width.offset(80);
        
    }];

    UILabel *labelOfGoodsAmount = [[UILabel alloc] init];
    [self.view addSubview:labelOfGoodsAmount];
    labelOfGoodsAmount.text = @"应付金额";
    labelOfGoodsAmount.textColor = [UIColor blackColor];
    [labelOfGoodsAmount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewOfTitle.mas_bottom).with.offset(20);
        make.centerX.equalTo(self.view).with.offset(-50);
        make.height.offset(20);
        make.width.offset(80);
        
    }];
    self.labelgoodsAmount = [[UILabel alloc] init];
    [self.view addSubview:self.labelgoodsAmount];
    self.labelgoodsAmount.textColor = [UIColor blackColor];
    [self.labelgoodsAmount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewOfTitle.mas_bottom).with.offset(20);
        make.left.equalTo(labelOfGoodsAmount.mas_right).with.offset(10);
        make.height.offset(20);
        make.width.offset(80);
        
    }];
    UILabel *labelOfFreight = [[UILabel alloc] init];
    [self.view addSubview:labelOfFreight];
    labelOfFreight.text = @"邮费";
    labelOfFreight.textColor = [UIColor grayColor];
    labelOfFreight.font = [UIFont systemFontOfSize:13];
    [labelOfFreight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.labelgoodsAmount.mas_bottom).with.offset(20);
        make.centerX.equalTo(self.view).with.offset(-20);
        make.height.offset(20);
        make.width.offset(80);
        
    }];
    self.labelFreight = [[UILabel alloc] init];
    [self.view addSubview:self.labelFreight];
    self.labelFreight.font = [UIFont systemFontOfSize:13];
    self.labelFreight.textColor = [UIColor grayColor];
    [self.labelFreight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.labelgoodsAmount.mas_bottom).with.offset(20);
        make.left.equalTo(self.view).with.offset(-20);
        make.height.offset(20);
        make.width.offset(80);
        
    }];


}

- (void)configData{
    

    self.dic = [NSMutableDictionary alloc];
    
    NSString *str = @"http://www.jinyuankeji.net/VF/portal/OrderAction/settlement?userId=2&orderId=14";
    NetworkingHandler *nt = [[NetworkingHandler alloc] init];
    
    [nt netWorkingHandlerGETWithURL:str completion:^(id result, NSData *data, NSURLResponse *response, NSError *error) {
        
        //        NSLog(@"asdddd%@", result);
        self.dic = [result objectForKey:@"Data"];
  
        self.labelName.text = [self.dic objectForKey:@"Name"];
        self.labelPhone.text = [self.dic objectForKey:@"phone"];
        self.labelAddress.text = [self.dic objectForKey:@"address"];
        NSString *money = @"¥";
        
        self.labelgoodsAmount.text = [money stringByAppendingString:[self.dic objectForKey:@"goodsAmount"]];
  
        
        
        
        
    }];
    
    
    
}



- (void)handleSend{


    [self.navigationController popToViewController:self.navigationController.childViewControllers[1] animated:YES];
    

}
- (void)handleAddress{

    ShippingAddressViewController *vc = [[ShippingAddressViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    

}



@end
