//
//  VFOrderModel.h
//  DKDJForDeliver
//
//  Created by 张允鹏 on 16/9/29.
//  Copyright © 2016年 gushi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VFOrderModel : NSObject

@property (nonatomic,strong) NSString * state;//1",
@property (nonatomic,strong) NSString * orderId;//8",
@property (nonatomic,strong) NSString * storeName;//333三只松鼠",
@property (nonatomic,strong) NSString * goodsTitle;//测试",
@property (nonatomic,strong) NSString * goodsIcon;//http://www.jinyuankej
@property (nonatomic,strong) NSString * price;//1.30",
@property (nonatomic,strong) NSString * costPrice;//20.00",
@property (nonatomic,strong) NSString * num;//1",
@property (nonatomic,strong) NSString * total;//2.30",
@property (nonatomic,strong) NSString * msg;//待付款"

@property (nonatomic,strong) NSString * goods_express_fee;

+(VFOrderModel* )modelWithDict:(NSDictionary *)dict;

@end
