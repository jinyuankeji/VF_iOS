//
//  brandDetailModel.h
//  VFShoppingMall
//
//  Created by gushi on 16/9/30.
//  Copyright © 2016年 jinyuankeji. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface brandDetailModel : NSObject

@property (nonatomic,strong) NSString * goods;
@property (nonatomic,strong) NSString * goodsId;

+(brandDetailModel* )modelWithDict:(NSDictionary *)dict;
@end
