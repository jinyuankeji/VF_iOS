//
//  sortNameDetailModel.h
//  VFShoppingMall
//
//  Created by gushi on 16/10/2.
//  Copyright © 2016年 jinyuankeji. All rights reserved.
//



#import <Foundation/Foundation.h>

@interface sortNameDetailModel : NSObject


@property (nonatomic,strong) NSString * goodsId;//"8",
@property (nonatomic,strong) NSString * goodsTitle;//"苹果5s",
@property (nonatomic,strong) NSString * goodsImg;//"",
@property (nonatomic,strong) NSString * collectState;//"未收藏",
@property (nonatomic,strong) NSString * price;//"6000.00",
@property (nonatomic,strong) NSString * originalPrice;//"6800.00"

+(sortNameDetailModel* )modelWithDict:(NSDictionary *)dict;

@end
