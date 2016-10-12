//
//  brandInfoModel.m
//  VFShoppingMall
//
//  Created by gushi on 16/9/30.
//  Copyright © 2016年 jinyuankeji. All rights reserved.
//

#import "brandInfoModel.h"

@implementation brandInfoModel

+(brandInfoModel* )modelWithDict:(NSDictionary *)dict{
    return [[self alloc]initWithDictionary:dict];
}
-(instancetype)initWithDictionary:(NSDictionary *)dict{
    if (self=[super init]) {
        self.storeId = [dict objectForKey:@"storeId"];
        self.storeName = [dict objectForKey:@"storeName"];
        self.storeIcon = [dict objectForKey:@"storeIcon"];
        self.newnum = [dict objectForKey:@"newnum"];
        self.detailModelArr = [NSMutableArray array];
        for (NSDictionary * detailDic in [dict objectForKey:@"Recommend"]) {
            brandDetailModel * model = [brandDetailModel modelWithDict:detailDic];
            [self.detailModelArr addObject:model];
        }
    }
    return self;
}

@end
