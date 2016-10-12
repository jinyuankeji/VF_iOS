//
//  addressModel.h
//  VFShoppingMall
//
//  Created by gushi on 16/10/3.
//  Copyright © 2016年 jinyuankeji. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface addressModel : NSObject

@property (nonatomic,strong) NSString * addressId;//"6",
@property (nonatomic,strong) NSString * Name;//"刘超41",
@property (nonatomic,strong) NSString * phone;//"18940089653",
@property (nonatomic,strong) NSString * address;//"北京2朝阳区3第五大道4北京南站西侧100米5额鹅鹅鹅",
@property (nonatomic,strong) NSString * time ;//""


+(addressModel* )modelWithDict:(NSDictionary *)dict;


@end
