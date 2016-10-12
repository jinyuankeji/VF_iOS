//
//  shopClassCollectionViewCell.m
//  VFShoppingMall
//
//  Created by gushi on 16/9/29.
//  Copyright © 2016年 jinyuankeji. All rights reserved.
//

#import "shopClassCollectionViewCell.h"

@implementation shopClassCollectionViewCell

#pragma mark - 重写initWihtFrame
-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        
//        self.backgroundColor = [UIColor purpleColor];
        
        UIImageView* imageView = [[UIImageView alloc]init];
        imageView.frame = CGRectMake(5, 10, CGRectGetWidth(self.frame)-10, CGRectGetHeight(self.frame)-35);
        self.imageView = imageView;
        [self.contentView addSubview:self.imageView];
        
        UILabel* label = [[UILabel alloc]init];
        label.frame = CGRectMake(5, CGRectGetMaxY(self.imageView.frame)+15, CGRectGetWidth(self.frame)-10, 20);
//        label.backgroundColor = [UIColor brownColor];
        label.textAlignment = NSTextAlignmentCenter;
        self.label = label;
        [self.contentView addSubview:self.label];
        
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

-(void)buttonClicked{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(collectionViewCell:withButtonClicked:)]) {
        [self.delegate collectionViewCell:self withButtonClicked:self.button];
    }
}


@end
