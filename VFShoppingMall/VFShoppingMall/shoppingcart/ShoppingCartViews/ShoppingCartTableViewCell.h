//
//  ShoppingCartTableViewCell.h
//  VFShoppingMall
//
//  Created by jinyuankeji on 16/9/28.
//  Copyright © 2016年 jinyuankeji. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^BlockButton)(NSString *str);

@class ShoppingCartModel;

@interface ShoppingCartTableViewCell : UITableViewCell

@property (nonatomic, strong) ShoppingCartModel *model;
@property (nonatomic, strong) NSString *gooImageStr;
@property (nonatomic, strong) UIButton *buttonOfDian;
@property (nonatomic, strong) BlockButton button;
-(void)buttonDianClicked:(UIButton*)btn;
-(void)handlerButtonAction:(BlockButton)block;

@end
