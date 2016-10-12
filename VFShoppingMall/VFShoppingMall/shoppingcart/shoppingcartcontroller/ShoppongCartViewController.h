//
//  ShoppongCartViewController.h
//  VFShoppingMall
//
//  Created by jinyuankeji on 16/9/28.
//  Copyright © 2016年 jinyuankeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShoppingCartModel.h"
@interface ShoppongCartViewController : UIViewController
@property (nonatomic, assign) NSInteger *count;
@property (nonatomic, strong) ShoppingCartModel *model;
@end
