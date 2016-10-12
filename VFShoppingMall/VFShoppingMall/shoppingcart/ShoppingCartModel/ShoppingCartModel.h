//
//  ShoppingCartModel.h
//  VFShoppingMall
//
//  Created by jinyuankeji on 16/9/28.
//  Copyright © 2016年 jinyuankeji. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShoppingCartModel : NSObject
//商品图片
@property (nonatomic, strong) NSString *goodsImg;
//商品名字
@property (nonatomic, strong) NSString *name;
//店铺名称
@property (nonatomic, strong) NSString *shop;
//商品型号
@property (nonatomic, strong) NSString *specification;
//商品数量
@property (nonatomic, strong) NSString *num;
//商品价格
@property (nonatomic, strong) NSString *price;
//商品原价格
@property (nonatomic, strong) NSString *oldPrice;


@end
