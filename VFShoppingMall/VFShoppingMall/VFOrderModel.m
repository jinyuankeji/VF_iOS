//
//  VFOrderModel.m
//  DKDJForDeliver
//
//  Created by 张允鹏 on 16/9/29.
//  Copyright © 2016年 gushi. All rights reserved.
//

#import "VFOrderModel.h"

@implementation VFOrderModel

+(VFOrderModel* )modelWithDict:(NSDictionary *)dict{
    return [[self alloc]initWithDictionary:dict];
}
-(instancetype)initWithDictionary:(NSDictionary *)dict{
    if (self=[super init]) {
        self.state=[dict objectForKey:@"state"];
        self.orderId=[dict objectForKey:@"orderId"];;//8",
        self.storeName=[dict objectForKey:@"storeName"];;//333三只松鼠",
        self.goodsTitle=[dict objectForKey:@"goodsTitle"];;//测试",
        self.goodsIcon=[dict objectForKey:@"goodsIcon"];;//http://www.jinyuankej
        self.price=[dict objectForKey:@"price"];;//1.30",
        self.costPrice=[dict objectForKey:@"costPrice"];;//20.00",
        self.num=[dict objectForKey:@"num"];;//1",
        self.total=[dict objectForKey:@"total"];;//2.30",
        self.msg=[dict objectForKey:@"msg"];;//待付款"
        self.goods_express_fee=[dict objectForKey:@"goods_express_fee"];;
    }
    return self;
}

@end
