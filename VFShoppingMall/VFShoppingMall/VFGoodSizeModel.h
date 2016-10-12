//
//  VFGoodSizeModel.h
//  DKDJForDeliver
//
//  Created by 张允鹏 on 16/9/28.
//  Copyright © 2016年 gushi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface VFGoodSizeModel : NSObject

@property (nonatomic,strong) NSString * specification;//":"黑色",
@property (nonatomic,assign) NSInteger specificationId;//":"11",
@property (nonatomic,assign) NSString *   price;//":null,
@property (nonatomic,assign) NSInteger  stock;//":"50"

+(VFGoodSizeModel* )modelWithDict:(NSDictionary *)dict;

@end
