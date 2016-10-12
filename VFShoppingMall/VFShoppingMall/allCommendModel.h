//
//  allCommendModel.h
//  VFShoppingMall
//
//  Created by gushi on 16/10/9.
//  Copyright © 2016年 jinyuankeji. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface allCommendModel : NSObject


@property (nonatomic,strong) NSString * assessId;//"3",
@property (nonatomic,strong) NSString * headerImgURL;//"",
@property (nonatomic,strong) NSString * appraiserID;//"17",
@property (nonatomic,strong) NSString * assessNickName;//"点点",
@property (nonatomic,strong) NSString * content;//"好看，穿起来美死了3",
@property (nonatomic,strong) NSString * createTime;//"2016-08-15 00:55:59",
@property (nonatomic,strong) NSString * goodsInformation;//"红色"

+(allCommendModel* )modelWithDict:(NSDictionary *)dict;

@end
