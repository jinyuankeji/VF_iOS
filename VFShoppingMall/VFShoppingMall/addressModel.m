//
//  addressModel.m
//  VFShoppingMall
//
//  Created by gushi on 16/10/3.
//  Copyright © 2016年 jinyuankeji. All rights reserved.
//

//@property (nonatomic,strong) NSString * addressId;//"6",
//@property (nonatomic,strong) NSString * Name;//"刘超41",
//@property (nonatomic,strong) NSString * phone;//"18940089653",
//@property (nonatomic,strong) NSString * address;//"北京2朝阳区3第五大道4北京南站西侧100米5额鹅鹅鹅",
//@property (nonatomic,strong) NSString * time ;//""

#import "addressModel.h"

@implementation addressModel

+(addressModel* )modelWithDict:(NSDictionary *)dict{
    return [[self alloc]initWithDictionary:dict];
}
-(instancetype)initWithDictionary:(NSDictionary *)dict{
    if (self=[super init]) {
        self.addressId = [dict objectForKey:@"addressId"];
        
        self.Name = [dict objectForKey:@"Name"];

        self.phone = [dict objectForKey:@"phone"];

        self.address = [dict objectForKey:@"address"];

        self.time = [dict objectForKey:@"time"];

    }
    return self;
}

@end
