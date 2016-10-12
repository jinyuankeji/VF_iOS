//
//  shopClassDetailModel.h
//  VFShoppingMall
//
//  Created by gushi on 16/9/29.
//  Copyright © 2016年 jinyuankeji. All rights reserved.
//
//"segId": "2",
//"segTitle": "上衣",
//"segImg": "http://www.jinyuankeji.net//VF/tpl/simplebootx/Public/F_lei/images/1.jpg"
#import <Foundation/Foundation.h>

@interface shopClassDetailModel : NSObject

@property (nonatomic,strong) NSString * segId;
@property (nonatomic,strong) NSString * segTitle;
@property (nonatomic,strong) NSString * segImg;

+(shopClassDetailModel* )modelWithDict:(NSDictionary *)dict;

@end
