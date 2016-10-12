//
//  shopDetailCollecCell.m
//  VFShoppingMall
//
//  Created by gushi on 16/10/1.
//  Copyright © 2016年 jinyuankeji. All rights reserved.
//

#import "shopDetailCollecCell.h"
#import "UIImageView+WebCache.h"
#import "FrameMainLFL.h"

@implementation shopDetailCollecCell{
    UIImageView* imageView;
    UILabel* priceLable;
    UILabel * costPriceLable;
    UILabel * discountLable;
    UILabel * nameLable;
}

#pragma mark - 重写initWihtFrame
-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        
        //        self.backgroundColor = [UIColor purpleColor];
        
        imageView = [[UIImageView alloc]init];
        imageView.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)*20/27);

        [self.contentView addSubview:imageView];
        
        priceLable = [[UILabel alloc]init];
        priceLable.frame = CGRectMake(5, CGRectGetMaxY(imageView.frame)+SizeMake_LFL(0, 15).height, SizeMake_LFL(42,100).height, 20);
        
        //        label.backgroundColor = [UIColor brownColor];
       
        [self.contentView addSubview:priceLable];
        
        costPriceLable = [[UILabel alloc]initWithFrame:CGRectMake(30, CGRectGetMaxY(priceLable.frame)+2, 80, 14)];
        costPriceLable.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:costPriceLable];

        
        UIView * linView = [[UIView alloc]initWithFrame:CGRectMake(100, CGRectGetMaxY(priceLable.frame)+2, 1, 14)];
        linView.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:linView];
        
        discountLable = [[UILabel alloc]initWithFrame:CGRectMake(101, CGRectGetMaxY(priceLable.frame)+2, 70, 14)];
        discountLable.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:discountLable];
        
        nameLable = [[UILabel alloc]initWithFrame:CGRectMake(5, CGRectGetMaxY(costPriceLable.frame)+5, 110, 18)];
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
-(void)setModel:(GSShopDetailCollecModel *)model{
    _model = model;
    [imageView sd_setImageWithURL:[NSURL URLWithString:model.goodsIcon]];
    priceLable.text = [NSString stringWithFormat:@"￥%@",model.price];
    NSMutableAttributedString * cosPriceStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"￥%@",model.costPrice]];
    [cosPriceStr addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, cosPriceStr.length)];
    [cosPriceStr addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(0 , cosPriceStr.length)];
    costPriceLable.textColor = [UIColor lightGrayColor];
    costPriceLable.attributedText = cosPriceStr;
    discountLable.text = model.discount;
    nameLable.text = model.goodsTitle;
}



@end
