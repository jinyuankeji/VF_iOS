//
//  homePageModel.m
//  VFShoppingMall
//
//  Created by gushi on 16/9/28.
//  Copyright © 2016年 jinyuankeji. All rights reserved.
//

#import "homePageModel.h"

@implementation homePageModel

+(homePageModel* )modelWithDict:(NSDictionary *)dict{
    return [[self alloc]initWithDictionary:dict];
}

-(id)initWithDict:(NSDictionary *)dict{
    if (self=[super init]) {
        self.ADid = [dict objectForKey:@"ADid"];
        self.ADImg = [dict objectForKey:@"ADImg"];
        self.ADURL = [dict objectForKey:@"ADURL"];
        self.ADTitle = [dict objectForKey:@"ADTitle"];
    }
    return self;
}



@end
