//
//  VFAssessModel.h
//  DKDJForDeliver
//
//  Created by 张允鹏 on 16/9/28.
//  Copyright © 2016年 gushi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VFAssessModel : NSObject

@property (nonatomic,assign) NSInteger assessId;//3",
@property (nonatomic,strong) NSString * headerImgURL;//http://wx.
@property (nonatomic,assign) NSInteger appraiserID;//2",
@property (nonatomic,strong) NSString * assessNickName;//小鱼儿",
@property (nonatomic,strong) NSString * content;//好看，穿起来美死了3",
@property (nonatomic,strong) NSString * createTime;//2016-08-15 00:55:59",
@property (nonatomic,strong) NSString * goodsInformation;//":null

+(VFAssessModel* )modelWithDict:(NSDictionary *)dict;
@end
