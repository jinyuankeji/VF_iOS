//
//  shopDetailCollecCell.h
//  VFShoppingMall
//
//  Created by gushi on 16/10/1.
//  Copyright © 2016年 jinyuankeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GSShopDetailCollecModel.h"

@interface shopDetailCollecCell : UICollectionViewCell

//@property (nonatomic,weak) UIImageView * shopImageView;
//@property (nonatomic,weak) UILabel * priceLable;
//@property (nonatomic,weak) UILabel * costPriceLable;
//@property (nonatomic,weak) UILabel * discountLable;
//@property (nonatomic,weak) UILabel * shopTitleLable;

@property (nonatomic,strong) GSShopDetailCollecModel * model;

@end
