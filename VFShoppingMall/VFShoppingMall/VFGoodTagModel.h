//
//  VFGoodTagModel.h
//  DKDJForDeliver
//
//  Created by 张允鹏 on 16/9/28.
//  Copyright © 2016年 gushi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VFGoodTagModel : NSObject



@property (nonatomic,strong) NSString *  tagId;//":"3,1",
@property (nonatomic,strong) NSString *  tagTitle;//":"正品保证"

+(VFGoodTagModel* )modelWithDict:(NSDictionary *)dict;

@end
