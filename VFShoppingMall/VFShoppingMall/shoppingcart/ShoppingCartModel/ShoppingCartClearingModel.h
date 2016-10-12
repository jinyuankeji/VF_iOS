//
//  ShoppingCartClearingModel.h
//  VFShoppingMall
//
//  Created by jinyuankeji on 16/10/8.
//  Copyright © 2016年 jinyuankeji. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShoppingCartClearingModel : NSObject

//名字
@property (nonatomic, strong) NSString *name;
//电话
@property (nonatomic, strong) NSString *phone;
//地址
@property (nonatomic, strong) NSString *address;
//商品金额
@property (nonatomic, strong) NSString *goodsAmount;
//应付金额
@property (nonatomic, strong) NSString *amount;
//邮费
@property (nonatomic, strong) NSString *freight;




@end
