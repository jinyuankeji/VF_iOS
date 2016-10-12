//
//  sortNameCollectionViewCell.m
//  VFShoppingMall
//
//  Created by gushi on 16/10/2.
//  Copyright © 2016年 jinyuankeji. All rights reserved.
//

#import "sortNameCollectionViewCell.h"
#import "FrameMainLFL.h"
#import "UIImageView+WebCache.h"

#define cellWidth 183
#define cellHeight 260

@implementation sortNameCollectionViewCell{
    UIImageView* imageView;
    UILabel* priceLable;
    UILabel * costPriceLable;
    UIButton * collectBtn;
    UILabel * nameLable;
    UILabel * collectLable;
}

#pragma mark - 重写initWihtFrame
-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        
        //        self.backgroundColor = [UIColor purpleColor];
        
        imageView = [[UIImageView alloc]init];
        imageView.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetWidth(self.frame)*1.3);
        
        [self.contentView addSubview:imageView];
        
        priceLable = [[UILabel alloc]init];
        priceLable.frame = CGRectMake(5, CGRectGetMaxY(imageView.frame)+SizeMake_LFL(0, 5).height, SizeMake_LFL(72, 72).height, 14);
        priceLable.font = [UIFont systemFontOfSize:14];
        //        label.backgroundColor = [UIColor brownColor];
        
        [self.contentView addSubview:priceLable];
        
        costPriceLable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(priceLable.frame)+3, CGRectGetMaxY(priceLable.frame)-5, 60, 10)];
        costPriceLable.font = [UIFont systemFontOfSize:10];
        [self.contentView addSubview:costPriceLable];
        collectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        collectBtn.frame = CGRectMake(CGRectGetWidth(self.frame)-50, CGRectGetHeight(self.frame)-20, 15, 15);
        [collectBtn setBackgroundImage:[UIImage imageNamed:@"soucangicon@3x_2"] forState:UIControlStateNormal];
        [collectBtn setBackgroundImage:[UIImage imageNamed:@"soucangicons"] forState:UIControlStateSelected];
        [self.contentView addSubview:collectBtn];
        
        collectLable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.frame)-30, CGRectGetHeight(self.frame)-20, 40, 15)];
        collectLable.font = [UIFont systemFontOfSize:15];
        collectLable.text = @"收藏";
        collectLable.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:collectLable];
        
        nameLable = [[UILabel alloc]initWithFrame:CGRectMake(5, CGRectGetMaxY(priceLable.frame)+10, 120, 18)];
        nameLable.textColor = [UIColor lightGrayColor];
        
        [self.contentView addSubview:nameLable];
        
        
        
        
        //        costPriceLable
        
        //        UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
        //        button.frame = CGRectMake(5, CGRectGetMaxY(self.label.frame), CGRectGetWidth(self.frame)-10, 30);
        //        [button setTitle:@"Button" forState:UIControlStateNormal];
        //        button.backgroundColor = [UIColor orangeColor];
        //        self.button = button;
        //        [self.contentView addSubview:self.button];
        //        [self.button addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}
-(void)setModel:(sortNameDetailModel *)model{
    _model = model;
    [imageView sd_setImageWithURL:[NSURL URLWithString:model.goodsImg]];
    priceLable.text = [NSString stringWithFormat:@"￥%@",model.price];
    NSMutableAttributedString * cosPriceStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"￥%@",model.originalPrice]];
    [cosPriceStr addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, cosPriceStr.length)];
    [cosPriceStr addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(0 , cosPriceStr.length)];
    costPriceLable.textColor = [UIColor lightGrayColor];
    costPriceLable.attributedText = cosPriceStr;
    
    nameLable.text = model.goodsTitle;
    if (![model.collectState isEqualToString:@"未收藏"]) {
        [collectBtn setBackgroundImage:[UIImage imageNamed:@"soucangicons"] forState:UIControlStateSelected];
        collectLable.textColor = [UIColor colorWithRed:255.0/255 green:185.0/255  blue:2.0/255  alpha:1];
        
        
    }
}

@end
