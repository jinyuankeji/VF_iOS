//
//  GSShopDetailCollecModel.h
//  VFShoppingMall
//
//  Created by gushi on 16/10/1.
//  Copyright © 2016年 jinyuankeji. All rights reserved.
//



#import <Foundation/Foundation.h>

@interface GSShopDetailCollecModel : NSObject


@property (nonatomic,strong) NSString *  goodsId;//"28",
@property (nonatomic,strong) NSString *  goodsTitle;//"苹果5s",
@property (nonatomic,strong) NSString *  goodsIcon;//"http://www.jinyuankeji.net//VF/upg/goods/2016-08-10/57aaa071d2cca.png",
@property (nonatomic,strong) NSString *  price;//"6000.00",
@property (nonatomic,strong) NSString *  costPrice;//"6800.00",
@property (nonatomic,strong) NSString *  discount;//"8.8折

+(GSShopDetailCollecModel* )modelWithDict:(NSDictionary *)dict;

@end
