//
//  shopClassCollectionViewCell.h
//  VFShoppingMall
//
//  Created by gushi on 16/9/29.
//  Copyright © 2016年 jinyuankeji. All rights reserved.
//

#import <UIKit/UIKit.h>
@class shopClassCollectionViewCell;

@protocol shopClassCollectionViewCellDelegate <NSObject>
@optional
-(void)collectionViewCell:(shopClassCollectionViewCell*)cell withButtonClicked:(UIButton*)button;

@end
@interface shopClassCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) UIImageView* imageView;
@property (weak, nonatomic) UILabel* label;
@property (weak, nonatomic) UIButton* button;
@property (weak, nonatomic) id<shopClassCollectionViewCellDelegate> delegate;

@end
