//
//  VFGoodModel.m
//  DKDJForDeliver
//
//  Created by 张允鹏 on 16/9/28.
//  Copyright © 2016年 gushi. All rights reserved.
//

#import "VFGoodModel.h"


@implementation VFGoodModel

+(VFGoodModel* )modelWithDict:(NSDictionary *)dict{
    return [[self alloc]initWithDictionary:dict];
}
-(instancetype)initWithDictionary:(NSDictionary *)dict{
    if (self=[super init]) {
        self.Status=[dict objectForKey:@"Status"];
        self.returnInfo=[dict objectForKey:@"returnInfo"];

//        "Data":{
        NSDictionary * dic=[dict objectForKey:@"Data"];
        self.sellerId=[[dic objectForKey:@"sellerId"] integerValue];
        self.collectState = [dic objectForKey:@"collectState"] ;
        self.goodsId=[[dic objectForKey:@"goodsId"] integerValue];
        self.storeId=[[dic objectForKey:@"storeId"] integerValue];
        self.storeTitle=[dic objectForKey:@"storeTitle"];
        self.price=[[dic objectForKey:@"price"] floatValue];
        self.originalPrice=[[dic objectForKey:@"originalPrice"] floatValue];
        self.assessNum=[dic objectForKey:@"assessNum"];
        self.assess_good=[dic objectForKey:@"assess_good"];
        self.assess_middle=[dic objectForKey:@"assess_middle"];
        self.assess_bad=[dic objectForKey:@"assess_bad"];
        
        
        self.goodsPicture=[[dict objectForKey:@"goodsPicture"] objectForKey:@"pictureURL"];
        
        
        NSMutableArray * arr=[NSMutableArray array];
        for (NSDictionary * dic in [dict objectForKey:@"tagList"]) {
            VFGoodTagModel * model= [VFGoodTagModel modelWithDict:dic];
            [arr addObject:model];
        }
        self.tagListArr = arr;
        
        arr=[NSMutableArray array];
        for (NSDictionary * dic in [dict objectForKey:@"SizeList"]) {
            VFGoodSizeModel * model= [VFGoodSizeModel modelWithDict:dic];
            [arr addObject:model];
        }
        self.SizeListArr = arr;
    
        
        arr=[NSMutableArray array];
        for (NSDictionary * dic in [dict objectForKey:@"assessList"]) {
            VFAssessModel * model= [VFAssessModel modelWithDict:dic];
            [arr addObject:model];
        }
        self.assessListArr = arr;
        
        self.goodsDeatilsImage=[[dict objectForKey:@"goodsDeatils"] objectForKey:@"imageURL"];
        
        
        dic =[dict objectForKey:@"Note"];
        
        self.returnNote=[dic objectForKey:@"returnNote"];
        self.exchangeNote=[dic objectForKey:@"exchangeNote"];
        self.AftermarketNote=[dic objectForKey:@"AftermarketNote"];
        
        
    }
    return self;
}

@end
