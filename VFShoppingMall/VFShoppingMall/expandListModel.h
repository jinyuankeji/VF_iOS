//
//  expandListModel.h
//  VFShoppingMall
//
//  Created by gushi on 16/9/29.
//  Copyright © 2016年 jinyuankeji. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface expandListModel : NSObject

@property (nonatomic,strong) NSString * sortID;
@property (nonatomic,strong) NSString * expandImg;


+(expandListModel* )modelWithDict:(NSDictionary *)dict;

@end
