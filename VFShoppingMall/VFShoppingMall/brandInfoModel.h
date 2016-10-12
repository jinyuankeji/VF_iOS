//
//  brandInfoModel.h
//  VFShoppingMall
//
//  Created by gushi on 16/9/30.
//  Copyright © 2016年 jinyuankeji. All rights reserved.
////
//
//"storeId": "1",
//"storeName": "美丽说",
//"storeIcon": "http://www.jinyuankeji.net//VF/upg/real/2016-08-29/57c3e50fd94e3.png",


#import <Foundation/Foundation.h>
#import "brandDetailModel.h"

@interface brandInfoModel : NSObject

@property (nonatomic,strong) NSString * storeId;
@property (nonatomic,strong) NSString * storeName;
@property (nonatomic,strong) NSString * storeIcon;
@property (nonatomic,strong) NSString * newnum;
@property (nonatomic,strong) NSMutableArray<brandDetailModel*> * detailModelArr;

+(brandInfoModel* )modelWithDict:(NSDictionary *)dict;

@end
