//
//  VFGoodSizeModel.m
//  DKDJForDeliver
//
//  Created by 张允鹏 on 16/9/28.
//  Copyright © 2016年 gushi. All rights reserved.
//

#import "VFGoodSizeModel.h"

@implementation VFGoodSizeModel

+(VFGoodSizeModel* )modelWithDict:(NSDictionary *)dict{
    return [[self alloc]initWithDictionary:dict];
}
-(instancetype)initWithDictionary:(NSDictionary *)dict{
    if (self=[super init]) {
//        [self setValuesForKeysWithDictionary:dict];
        self.specification=[dict objectForKey:@"specification"];//":"黑色",
        self.specificationId=[[dict objectForKey:@"specificationId"] integerValue];//":"11",
        self.price=[dict objectForKey:@"price"] ;//":null,
        self.stock=[[dict objectForKey:@"stock"] integerValue];
    }
    return self;
}

@end
