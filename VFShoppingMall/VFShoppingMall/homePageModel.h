//
//  homePageModel.h
//  VFShoppingMall
//
//  Created by gushi on 16/9/28.
//  Copyright © 2016年 jinyuankeji. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface homePageModel : NSObject

@property (nonatomic,strong) NSString * ADid;
@property (nonatomic,strong) NSString * ADImg;
@property (nonatomic,strong) NSString * ADURL;
@property (nonatomic,strong) NSString * ADTitle;

-(id)initWithDict:(NSDictionary *)dict;

@end
