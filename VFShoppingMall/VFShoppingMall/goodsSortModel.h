//
//  goodsSortModel.h
//  VFShoppingMall
//
//  Created by gushi on 16/9/29.
//  Copyright © 2016年 jinyuankeji. All rights reserved.
//
//"SortTitle": "箱包奢品",
//"SortId": "7",
//"SortIconImg": "http://www.jinyuankeji.net//VF/upg/config/2016-09-27/57ea19b2910da.png"

#import <Foundation/Foundation.h>

@interface goodsSortModel : NSObject

@property (nonatomic,strong) NSString * SortTitle;
@property (nonatomic,strong) NSString * SortId;
@property (nonatomic,strong) NSString * SortIconImg;

+(goodsSortModel* )modelWithDict:(NSDictionary *)dict;


@end
