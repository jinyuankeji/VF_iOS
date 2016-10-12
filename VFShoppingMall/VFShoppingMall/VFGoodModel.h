//
//  VFGoodModel.h
//  DKDJForDeliver
//
//  Created by 张允鹏 on 16/9/28.
//  Copyright © 2016年 gushi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "VFGoodTagModel.h"
#import "VFGoodSizeModel.h"
#import "VFAssessModel.h"

@interface VFGoodModel : NSObject


@property (nonatomic,strong) NSString * Status;//true",
@property (nonatomic,strong) NSString * returnInfo;//",
//"Data":{
@property (nonatomic,assign) NSInteger sellerId;//1",
@property (nonatomic,assign) NSInteger goodsId;//9",
@property (nonatomic,assign) NSInteger storeId;//1",
@property (nonatomic,strong) NSString * storeTitle;//美丽说",
@property (nonatomic,strong) NSString * goodsTitle;//哈哈哈哈哈哈哈哈哈哈哈哈",
@property (nonatomic,strong) NSString * collectState;//未收藏",
@property (nonatomic,assign) CGFloat price;//9000.00",
@property (nonatomic,assign) CGFloat originalPrice;//9999.00",

@property (nonatomic,strong) NSString * assessNum;//":13,
@property (nonatomic,strong) NSString * assess_good;//":16,
@property (nonatomic,strong) NSString * assess_middle;//":0,
@property (nonatomic,strong) NSString * assess_bad;//":3

@property (nonatomic,strong) NSString * goodsPicture;//":{
//    "pictureURL;///VF/upg/goods/2016-08-29/57c3e7bfbc265.png"
//},
@property (nonatomic,strong) NSArray <VFGoodTagModel *>* tagListArr;
//"tagList":[
//           {
//               "tagId;//3,1",
//               "tagTitle;//正品保证"
//           }
//           ],
@property (nonatomic,strong) NSArray <VFGoodSizeModel *>* SizeListArr;//":[
//            {
//                "specification;//白色",
//                "specificationId;//12",
//                "price":null,
//                "stock;//52"
//            }
//            ],
@property (nonatomic,strong) NSArray <VFAssessModel *>* assessListArr;//":[
//              {
//                  "assessId;//3",
//                  "headerImgURL;//http://wx.qlogo.cn/mmopen/QjIjSQvpbRV2QdAuQSzOKZF2bhkmH9tuohtfdiaL8mp5zS2aeL6bGMDKnOXglLo151VlpTbISreibCxdibibHSGlib1tahyCwheIl/0",
//                  "appraiserID;//2",
//                  "assessNickName;//小鱼儿",
//                  "content;//好看，穿起来美死了3",
//                  "createTime;//2016-08-15 00:55:59",
//                  "goodsInformation":null
//              }
//              ],
@property (nonatomic,strong) NSString * goodsDeatilsImage;//":{

@property (nonatomic,strong) NSString * returnNote;//退货说明（没写呢）",
@property (nonatomic,strong) NSString * exchangeNote;//换货说明（没写呢）",
@property (nonatomic,strong) NSString * AftermarketNote;//售后说明（没写呢）"
//}

+(VFGoodModel* )modelWithDict:(NSDictionary *)dict;

@end
