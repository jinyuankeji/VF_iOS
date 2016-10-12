//
//  MyViewController.m
//  VFShoppingMall
//
//  Created by gushi on 16/9/27.
//  Copyright © 2016年 jinyuankeji. All rights reserved.
//

#import "MyViewController.h"
#import "Masonry.h"
#import "VFOrderListViewController.h"
#import "ShoppongCartViewController.h"
#import "MyWalletViewController.h"
#import "MySetViewController.h"


@interface MyViewController ()

@end

@implementation MyViewController



//隐藏navigationbar
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self creatHeadView];
}

- (void)creatHeadView{
    //头像昵称view
    UIButton *headOfView = [[UIButton alloc] init];
    headOfView.backgroundColor = [UIColor colorWithRed:255 / 255.0f green:185 / 255.0f blue:1 / 255.0f  alpha:1];
    [self.view addSubview:headOfView];
    
    [headOfView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).with.offset(0);
        make.left.equalTo(self.view).with.offset(0);
        make.right.equalTo(self.view).with.offset(0);
        make.height.offset(226);
        
        
    }];
    //设置
    UIButton *buttonoOfSet = [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonoOfSet setImage:[UIImage imageNamed:@"set"] forState:UIControlStateNormal];
    [headOfView addSubview:buttonoOfSet];
    [buttonoOfSet addTarget:self action:@selector(handlerSet) forControlEvents:UIControlEventTouchUpInside];
    
    [buttonoOfSet mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headOfView).with.offset(20);
        make.right.equalTo(headOfView).with.offset(-14);
        make.height.offset(40);
        make.width.offset(40);
        
    }];
    //头像button
    UIButton *buttonHeadView = [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonHeadView setImage:[UIImage imageNamed:@"yuan"] forState:UIControlStateNormal];
    [headOfView addSubview:buttonHeadView];
    [buttonHeadView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).with.offset(34);
        make.centerX.equalTo(headOfView);
        make.size.mas_equalTo(CGSizeMake(100, 100));
        
    }];
    //昵称label
    UILabel *labelOfName = [[UILabel alloc] init];
    labelOfName.text = @"昵称";
    labelOfName.textColor = [UIColor whiteColor];
    labelOfName.font = [UIFont systemFontOfSize: 16];
    
    [headOfView addSubview:labelOfName];
    [labelOfName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(buttonHeadView.mas_bottom).with.offset(26);
        make.centerX.equalTo(headOfView);
        make.height.offset(20);
        
    }];
    
    UILabel *labelOfJiFen = [[UILabel alloc] init];
    labelOfJiFen.text = @"积分";
    labelOfJiFen.textColor = [UIColor whiteColor];
    labelOfJiFen.font = [UIFont systemFontOfSize:16];
    [headOfView addSubview:labelOfJiFen];
    
    [labelOfJiFen mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(labelOfName.mas_bottom).with.offset(16);
        make.centerX.equalTo(headOfView);
        make.height.offset(18);
        
    }];
    
    UIView *viewOfHui = [[UIView alloc] init];
    [self.view addSubview:viewOfHui];
    viewOfHui.backgroundColor = [UIColor colorWithRed:235 / 255.0f  green:235 / 255.0f blue:235 / 255.0f alpha:1];
    [viewOfHui mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headOfView.mas_bottom).with.offset(0);
        make.left.equalTo(self.view).with.offset(0);
        make.right.equalTo(self.view).with.offset(0);
        make.height.offset(18);
        
    }];
    //我的订单button
    UIButton *buttonOfOrder = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:buttonOfOrder];
    buttonOfOrder.backgroundColor = [UIColor whiteColor];
    [buttonOfOrder mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewOfHui.mas_bottom).with.offset(0);
        make.left.equalTo(self.view).with.offset(0);
        make.right.equalTo(self.view).with.offset(0);
        make.height.offset(62);
        
    }];
    
    [buttonOfOrder addTarget:self action:@selector(handleMyOrder) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *imageDing = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ding"]];
    [buttonOfOrder addSubview:imageDing];
    [imageDing mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(buttonOfOrder).with.offset(17);
        make.top.equalTo(buttonOfOrder).with.offset(10);
        make.bottom.equalTo(buttonOfOrder).with.offset(-8);
        make.width.offset(43);
        
    }];
    
    UILabel *labelOfMyDing = [[UILabel alloc] init];
    labelOfMyDing.text = @"我的订单";
    labelOfMyDing.font = [UIFont systemFontOfSize:17];
    labelOfMyDing.textColor = [UIColor colorWithRed:106 / 255.0f green:106 / 255.0f blue:106 / 255.0f alpha:1];
    [buttonOfOrder addSubview:labelOfMyDing];
    [labelOfMyDing mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(buttonOfOrder);
        make.left.equalTo(imageDing.mas_right).with.offset(26);
        make.width.offset(100);
        
    }];
    
    UIImageView *imageOfDingRight = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"you"]];
    [buttonOfOrder addSubview:imageOfDingRight];
    [imageOfDingRight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(buttonOfOrder);
        make.right.equalTo(buttonOfOrder).with.offset(-26);
        make.width.offset(18);
        
    }];
    //宽度为1的view 灰线
    UIView *viewOfHuiOne = [[UIView alloc] init];
    [self.view addSubview:viewOfHuiOne];
    viewOfHuiOne.backgroundColor = [UIColor colorWithRed:235 / 255.0f  green:235 / 255.0f blue:235 / 255.0f alpha:1];
    [viewOfHuiOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(buttonOfOrder.mas_bottom).with.offset(0);
        make.left.equalTo(self.view).with.offset(0);
        make.right.equalTo(self.view).with.offset(0);
        make.height.offset(1);
        
    }];
    //购物车button
    
    UIButton *buttonShoppingCart = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:buttonShoppingCart];
    buttonShoppingCart.backgroundColor = [UIColor whiteColor];
    [buttonShoppingCart addTarget:self action:@selector(handlerShoppingCart) forControlEvents:UIControlEventTouchUpInside];
    //    buttonShoppingCart.layer.backgroundColor = [UIColor colorWithRed:235 / 255.0f green:235 / 255.0f blue:235 / 255.0f alpha:1].CGColor;
    //    [buttonShoppingCart.layer setBorderWidth:1.0];
    [buttonShoppingCart mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewOfHuiOne).with.offset(1);
        make.left.equalTo(self.view).with.offset(0);
        make.right.equalTo(self.view).with.offset(0);
        make.height.offset(62);
        
    }];
    
    UIImageView *imageShopping = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"gou"]];
    [buttonShoppingCart addSubview:imageShopping];
    [imageShopping mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(buttonShoppingCart).with.offset(10);
        make.left.equalTo(buttonShoppingCart).with.offset(16);
        make.bottom.equalTo(buttonShoppingCart).with.offset(-8);
        make.width.offset(40);
        
    }];
    
    UILabel *labelOfShopping = [[UILabel alloc] init];
    labelOfShopping.text = @"购物车";
    labelOfShopping.font = [UIFont systemFontOfSize:17];
    labelOfShopping.textColor = [UIColor colorWithRed:45 / 255.0f green:45 / 255.0f blue:45 / 255.0f alpha:1];
    [buttonShoppingCart addSubview:labelOfShopping];
    [labelOfShopping mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(buttonShoppingCart);
        make.left.equalTo(imageShopping.mas_right).with.offset(28);
        make.width.offset(100);
        
    }];
    
    
    UIImageView *imageOfShoppingRight = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"you"]];
    [buttonShoppingCart addSubview:imageOfShoppingRight];
    [imageOfShoppingRight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(buttonShoppingCart);
        make.right.equalTo(buttonShoppingCart).with.offset(-26);
        make.width.offset(18);
        
    }];
    
    UIView *viewOfShopingHuiOne = [[UIView alloc] init];
    [self.view addSubview:viewOfShopingHuiOne];
    viewOfShopingHuiOne.backgroundColor = [UIColor colorWithRed:235 / 255.0f  green:235 / 255.0f blue:235 / 255.0f alpha:1];
    [viewOfShopingHuiOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(buttonShoppingCart.mas_bottom).with.offset(0);
        make.left.equalTo(self.view).with.offset(0);
        make.right.equalTo(self.view).with.offset(0);
        make.height.offset(1);
        
    }];
    
    //我的钱包button
    UIButton *buttonMyWallet = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:buttonMyWallet];
    buttonMyWallet.backgroundColor = [UIColor whiteColor];
    
    [buttonMyWallet addTarget:self action:@selector(handlerMyWallet) forControlEvents:UIControlEventTouchUpInside];
    [buttonMyWallet mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewOfShopingHuiOne).with.offset(1);
        make.left.equalTo(self.view).with.offset(0);
        make.right.equalTo(self.view).with.offset(0);
        make.height.offset(62);
        
    }];
    
    UIImageView *imageOfMyWallet = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"qian"]];
    [buttonMyWallet addSubview:imageOfMyWallet];
    [imageOfMyWallet mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(buttonMyWallet).with.offset(10);
        make.left.equalTo(buttonMyWallet).with.offset(16);
        make.bottom.equalTo(buttonMyWallet).with.offset(-8);
        make.width.offset(40);
        
    }];
    
    UILabel *labelOfMyWallet = [[UILabel alloc] init];
    labelOfMyWallet.text = @"我的钱包";
    labelOfMyWallet.textColor = [UIColor colorWithRed:45 / 255.0f green:45 / 255.0f blue:45 / 255.0f alpha:1];
    [buttonMyWallet addSubview:labelOfMyWallet];
    labelOfMyWallet.font = [UIFont systemFontOfSize:17];
    [labelOfMyWallet mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(buttonMyWallet);
        make.left.equalTo(imageOfMyWallet.mas_right).with.offset(28);
        make.width.offset(100);
        
    }];
    
    UIImageView *imageOfMyWalletYou = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"you"]];
    [buttonMyWallet addSubview:imageOfMyWalletYou];
    [imageOfMyWalletYou mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(buttonMyWallet);
        make.right.equalTo(buttonMyWallet).with.offset(-26);
        make.width.offset(18);
        
    }];
    
    UIView *viewOfMyWalletHuiOne = [[UIView alloc] init];
    [self.view addSubview:viewOfMyWalletHuiOne];
    viewOfMyWalletHuiOne.backgroundColor = [UIColor colorWithRed:235 / 255.0f  green:235 / 255.0f blue:235 / 255.0f alpha:1];
    [viewOfMyWalletHuiOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(buttonMyWallet.mas_bottom).with.offset(0);
        make.left.equalTo(self.view).with.offset(0);
        make.right.equalTo(self.view).with.offset(0);
        make.height.offset(1);
        
    }];
    
    //分享给朋友button
    UIButton *buttonOfShare = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonOfShare.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:buttonOfShare];
    [buttonOfShare addTarget:self action:@selector(handerShare) forControlEvents:UIControlEventTouchUpInside];
    
    [buttonOfShare mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewOfMyWalletHuiOne).with.offset(1);
        make.left.equalTo(self.view).with.offset(0);
        make.right.equalTo(self.view).with.offset(0);
        make.height.offset(62);
        
    }];
    UIImageView *imageOfShare = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fen"]];
    
    [buttonOfShare addSubview:imageOfShare];
    [imageOfShare mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(buttonOfShare).with.offset(10);
        make.left.equalTo(buttonOfShare).with.offset(16);
        make.bottom.equalTo(buttonOfShare).with.offset(-8);
        make.width.offset(40);
        
    }];
    
    UILabel *labelOfShare = [[UILabel alloc] init];
    labelOfShare.text = @"分享给朋友";
    labelOfShare.font = [UIFont systemFontOfSize:17];
    labelOfShare.textColor = [UIColor colorWithRed:45 / 255.0f green:45 / 255.0f blue:45 / 255.0f alpha:1];
    [buttonOfShare addSubview:labelOfShare];
    
    [labelOfShare mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(buttonOfShare);
        make.left.equalTo(imageOfShare.mas_right).with.offset(28);
        make.width.offset(180);
        
    }];
    UIImageView *imageOfShareYou = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"you"]];
    [buttonOfShare addSubview:imageOfShareYou];
    [imageOfShareYou mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(buttonOfShare);
        make.right.equalTo(buttonOfShare).with.offset(-26);
        make.width.offset(18);
        
    }];
    
    UIView *viewOfShareHuiOne = [[UIView alloc] init];
    [self.view addSubview:viewOfShareHuiOne];
    viewOfShareHuiOne.backgroundColor = [UIColor colorWithRed:235 / 255.0f  green:235 / 255.0f blue:235 / 255.0f alpha:1];
    [viewOfShareHuiOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(buttonOfShare.mas_bottom).with.offset(0);
        make.left.equalTo(self.view).with.offset(0);
        make.right.equalTo(self.view).with.offset(0);
        make.height.offset(1);
        
    }];
    //我的商铺button
    UIButton *buttonOfShops = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:buttonOfShops];
    buttonOfShops.backgroundColor = [UIColor whiteColor];
    [buttonOfShops mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewOfShareHuiOne).with.offset(1);
        make.left.equalTo(self.view).with.offset(0);
        make.right.equalTo(self.view).with.offset(0);
        make.height.offset(62);
        
    }];
    UIImageView *imageOfMyShops = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mai"]];
    [buttonOfShops addSubview:imageOfMyShops];
    [imageOfMyShops mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(buttonOfShops).with.offset(10);
        make.left.equalTo(buttonOfShops).with.offset(16);
        make.bottom.equalTo(buttonOfShops).with.offset(-8);
        make.width.offset(40);
        
    }];
    
    UILabel *labelOfMyShops = [[UILabel alloc] init];
    labelOfMyShops.text = @"我的商铺";
    labelOfMyShops.textColor = [UIColor colorWithRed:45 / 255.0f green:45 / 255.0f blue:45 / 255.0f alpha:1];
    labelOfMyShops.font = [UIFont systemFontOfSize:17];
    [buttonOfShops addSubview:labelOfMyShops];
    [labelOfMyShops mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(buttonOfShops);
        make.left.equalTo(imageOfMyShops.mas_right).with.offset(28);
        make.width.offset(180);
        
    }];
    
    UIImageView *imageOfShopsYou = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"you"]];
    [buttonOfShops addSubview:imageOfShopsYou];
    [imageOfShopsYou mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(buttonOfShops);
        make.right.equalTo(buttonOfShops).with.offset(-26);
        make.width.offset(18);
        
    }];
    UIView *viewOfShopsHuiOne = [[UIView alloc] init];
    [self.view addSubview:viewOfShopsHuiOne ];
    viewOfShopsHuiOne.backgroundColor = [UIColor colorWithRed:235 / 255.0f  green:235 / 255.0f blue:235 / 255.0f alpha:1];
    [viewOfShopsHuiOne  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(buttonOfShops.mas_bottom).with.offset(0);
        make.left.equalTo(self.view).with.offset(0);
        make.right.equalTo(self.view).with.offset(0);
        make.height.offset(1);
        
    }];
}





//跳转到我的订单
- (void)handleMyOrder {
    
    
    
    
    
}
//跳转购物车
- (void)handlerShoppingCart{
    
    ShoppongCartViewController *shoppingCartVC = [[ShoppongCartViewController alloc] init];
    
    shoppingCartVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:shoppingCartVC animated:YES];
    
}
//跳转我的钱包
- (void)handlerMyWallet{
    MyWalletViewController *myWallet = [[MyWalletViewController alloc] init];
    myWallet.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:myWallet animated:YES];
    
    
}
//分享给朋友
- (void)handerShare{
    
    
}
//设置
- (void)handlerSet{

    MySetViewController *mySet = [[MySetViewController alloc] init];
    mySet.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:mySet animated:YES];
    

}


@end
