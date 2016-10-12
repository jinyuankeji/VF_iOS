//
//  allCommendModel.m
//  VFShoppingMall
//
//  Created by gushi on 16/10/9.
//  Copyright © 2016年 jinyuankeji. All rights reserved.
//

#import "allCommendModel.h"

@implementation allCommendModel

+(allCommendModel* )modelWithDict:(NSDictionary *)dict{
    return [[self alloc]initWithDictionary:dict];
}
-(instancetype)initWithDictionary:(NSDictionary *)dict{
    if (self=[super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

@end
