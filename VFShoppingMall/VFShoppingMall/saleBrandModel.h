//
//  saleBrandModel.h
//  VFShoppingMall
//
//  Created by gushi on 16/10/6.
//  Copyright © 2016年 jinyuankeji. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface saleBrandModel : NSObject

@property (nonatomic,strong) NSString * headViewStr;
@property (nonatomic,strong) NSString * brandid;//"5",
@property (nonatomic,strong) NSString * brand;//"芬狄诗",
@property (nonatomic,strong) NSString * initial;//"F",
@property (nonatomic,strong) NSString * logo;//"http://www.jinyuankeji.net//VF/upg/brand/f@3x.png"

+(saleBrandModel* )modelWithDict:(NSDictionary *)dict;
@end
