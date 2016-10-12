//
//  ShoppingCartTableViewCell.m
//  VFShoppingMall
//
//  Created by jinyuankeji on 16/9/28.
//  Copyright © 2016年 jinyuankeji. All rights reserved.
//

#import "ShoppingCartTableViewCell.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"
#import "ShoppingCartModel.h"
@interface ShoppingCartTableViewCell()
@property (nonatomic, strong) UIImageView *goodsImg;
@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UILabel *shop;
@property (nonatomic, strong) UILabel *specificatton;
@property (nonatomic, strong) UILabel *num;
@property (nonatomic, strong) UILabel *price;
@property (nonatomic, strong) UILabel *oldPrice;
@property (nonatomic, assign) NSInteger *count;
@property (nonatomic, weak) UIButton * tmpBtn;





@end

@implementation ShoppingCartTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self config];
    }
    return self;
    
    
}
- (void)config{
    
    self.goodsImg = [[UIImageView alloc] init];
    
    //    self.goodsImg.backgroundColor = [UIColor redColor];
    self.name = [[UILabel alloc] init];
    self.name.numberOfLines = 2;
    self.shop = [[UILabel alloc] init];
    self.specificatton = [[UILabel alloc] init];
    self.num = [[UILabel alloc] init];
    self.price = [[UILabel alloc] init];
    self.oldPrice = [[UILabel alloc] init];
    
    
    
    self.name.font = [UIFont systemFontOfSize:15];
    self.name.textColor = [UIColor colorWithRed:161 / 255.0f green:161 / 255.0f blue:161 / 255.0f alpha:1];
    self.shop.font = [UIFont systemFontOfSize:15];
    self.shop.textColor = [UIColor colorWithRed:161 / 255.0f green:161 / 255.0f blue:161 / 255.0f alpha:1];
    
    self.specificatton.font = [UIFont systemFontOfSize:15];
    self.specificatton.textColor = [UIColor colorWithRed:161 / 255.0f green:161 / 255.0f blue:161 / 255.0f alpha:1];
    
    self.price.font = [UIFont systemFontOfSize:20];
    self.price.textColor = [UIColor colorWithRed:243 / 255.0f green:8 / 255.0f blue:8 / 255.0f alpha:1];
    self.oldPrice.font = [UIFont systemFontOfSize:20];
    self.oldPrice.textColor = [UIColor colorWithRed:161 / 255.0f green:161 / 255.0f blue:161 / 255.0f alpha:1];
    
    self.num.backgroundColor = [UIColor whiteColor];
    self.num.layer.borderColor = [UIColor colorWithRed:239 / 255.0f green:239/ 255.0f blue:239 / 255.0f alpha:1].CGColor;
    self.num.layer.borderWidth = 1.0f;
    self.num.layer.masksToBounds = YES;
    
    [self.contentView addSubview:self.goodsImg];
    [self.contentView addSubview:self.name];
    [self.contentView addSubview:self.shop];
    [self.contentView addSubview:self.specificatton];
    [self.contentView addSubview:self.num];
    [self.contentView addSubview:self.price];
    [self.contentView addSubview:self.oldPrice];
    //高度为1的view
    UIView *viewOfTopOne = [[UIView alloc] init];
    viewOfTopOne.backgroundColor = [UIColor colorWithRed:156 / 255.0f green:156 / 255.0f blue:156 / 255.0f alpha:1];
    [self.contentView addSubview:viewOfTopOne];
    [viewOfTopOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).with.offset(18);
        make.left.equalTo(self.contentView).with.offset(24);
        make.right.equalTo(self.contentView).with.offset(-5);
        make.height.offset(1);
        
    }];
    UIView *viewOfLeft = [[UIView alloc] init];
    viewOfLeft.backgroundColor = [UIColor colorWithRed:156 / 255.0f green:156 / 255.0f blue:156 / 255.0f alpha:1];
    [self.contentView addSubview:viewOfLeft];
    [viewOfLeft mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).with.offset(19);
        make.left.equalTo(self.contentView).with.offset(23);
        make.bottom.equalTo(self.contentView).with.offset(-18);
        make.width.offset(1);
        
    }];
    
    UIView *viewBottom = [[UIView alloc] init];
    viewBottom.backgroundColor = [UIColor colorWithRed:156 / 255.0f green:156 / 255.0f blue:156 / 255.0f alpha:1];
    [self.contentView addSubview:viewBottom];
    [viewBottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).with.offset(24);
        make.right.equalTo(self.contentView).with.offset(-5);
        make.bottom.equalTo(self.contentView).with.offset(-18);
        make.height.offset(1);
        
    }];
    
    UIView *viewRight = [[UIView alloc] init];
    viewRight.backgroundColor = [UIColor colorWithRed:156 / 255.0f green:156 / 255.0f blue:156 / 255.0f alpha:1];
    [self.contentView addSubview:viewRight];
    [viewRight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).with.offset(19);
        make.right.equalTo(self.contentView).with.offset(-5);
        make.bottom.equalTo(self.contentView).with.offset(-18);
        make.width.offset(1);
        
    }];
    
    
    self.buttonOfDian = [UIButton buttonWithType:UIButtonTypeCustom];
    //    [buttonOfDian setImage:[UIImage imageNamed:@"xuanhuang"] forState:UIControlStateNormal];
    [self.contentView addSubview:self.buttonOfDian];
    [self.buttonOfDian setImage:[UIImage imageNamed:@"xuan"] forState:UIControlStateNormal];
    
    [self.buttonOfDian setImage:[UIImage imageNamed:@"xuanhuang"] forState:UIControlStateSelected];
    [self.buttonOfDian addTarget:self action:@selector(buttonDianClicked:) forControlEvents:UIControlEventTouchUpInside];
    //    buttonOfDian.backgroundColor = [UIColor redColor];
    
    [self.buttonOfDian mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).with.offset(19);
        make.left.equalTo(self.contentView).with.offset(1);
        make.bottom.equalTo(self.contentView).with.offset(-19);
        make.right.equalTo(viewOfLeft).with.offset(-2);
        
        
    }];
    
    //图片
    [self.goodsImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).with.offset(23);
        make.left.equalTo(self.contentView).with.offset(31);
        make.bottom.equalTo(self.contentView).with.offset(-23);
        make.width.equalTo(self.goodsImg.mas_height).multipliedBy(3.3 / 4.0f);
        
    }];
    //商品名
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.goodsImg.mas_top).with.offset(5);
        make.left.equalTo(self.goodsImg.mas_right).with.offset(18);
        make.height.offset(40);
        make.width.offset(150);
        
    }];
    //店铺名
    [self.shop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.name.mas_bottom).with.offset(5);
        make.left.equalTo(self.goodsImg.mas_right).with.offset(18);
        make.height.offset(17);
        make.width.offset(200);
        
    }];
    //尺寸
    [self.specificatton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.shop.mas_bottom).with.offset(5);
        make.left.equalTo(self.goodsImg.mas_right).with.offset(18);
        make.height.offset(17);
        make.width.offset(200);
        
    }];
    //数量
    [self.num mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.specificatton.mas_bottom).with.offset(15);
        make.left.equalTo(self.goodsImg.mas_right).with.offset(38);
        make.height.offset(24);
        make.width.offset(24);
        
    }];
    //－button
    UIButton *buttonOfJian = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.contentView addSubview:buttonOfJian];
    buttonOfJian.layer.borderColor = [UIColor colorWithRed:239 / 255.0f green:239/ 255.0f blue:239 / 255.0f alpha:1].CGColor;
    [buttonOfJian.layer setBorderWidth:1.0f];
    
    [buttonOfJian setImage:[UIImage imageNamed:@"jianhao"] forState:UIControlStateNormal];
    [buttonOfJian addTarget:self action:@selector(jianNumber) forControlEvents:UIControlEventTouchUpInside];
    [buttonOfJian mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.specificatton.mas_bottom).with.offset(15);
        make.left.equalTo(self.goodsImg.mas_right).with.offset(18);
        make.right.equalTo(self.num.mas_left).with.offset(0);
        make.height.offset(24);
        
    }];
    //+button
    UIButton *buttonJia = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.contentView addSubview:buttonJia];
    buttonJia.layer.borderColor = [UIColor colorWithRed:239 / 255.0f green:239/ 255.0f blue:239 / 255.0f alpha:1].CGColor;
    [buttonJia.layer setBorderWidth:1.0f];
    [buttonJia addTarget:self action:@selector(jiaNumber) forControlEvents:UIControlEventTouchUpInside];
    
    [buttonJia setImage:[UIImage imageNamed:@"jiahao"] forState:UIControlStateNormal];
    [buttonJia mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.specificatton.mas_bottom).with.offset(15);
        make.left.equalTo(self.num.mas_right).with.offset(0);
        make.width.offset(24);
        make.height.offset(24);
        
    }];
    
    
    
    
    
    
    //价格
    [self.price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.goodsImg.mas_top).with.offset(5);
        make.right.equalTo(self.contentView).with.offset(-4);
        make.height.offset(23);
        make.width.offset(120);
        
    }];
    //原价格
    [self.oldPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.price.mas_bottom).with.offset(5);
        make.right.equalTo(self.contentView).with.offset(-4);
        make.height.offset(23);
        make.width.offset(120);
        
    }];
    //结算
    UIButton *buttonSettlement = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.contentView addSubview:buttonSettlement];
    
    [buttonSettlement setTitle:@"结算" forState:UIControlStateNormal];
    [buttonSettlement addTarget:self action:@selector(settlement) forControlEvents:UIControlEventTouchUpInside];
    buttonSettlement.layer.cornerRadius = 5;
    buttonSettlement.layer.masksToBounds = YES;
    buttonSettlement.backgroundColor = [UIColor colorWithRed:255 / 255.0f green:185 / 255.0f blue:1 / 255.0f alpha:1];
    [buttonSettlement mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).with.offset(-14);
        make.bottom.equalTo(self.contentView).with.offset(-32);
        make.width.offset(80);
        make.height.offset(25);
        
    }];
    
    
    
}

- (void)jiaNumber{
    
    
}
- (void)jianNumber{
    
}
- (void)settlement{
    
    
}
//点击选中
-(void)buttonDianClicked:(UIButton*)btn{
    
    if (_tmpBtn == nil){
        btn.selected = !btn.selected;
        
        
    }
    else {
        btn.selected = NO;
        
    }
    
}
- (void)handlerButtonAction:(BlockButton)block
{
    self.button = block;
}

- (void)setModel:(ShoppingCartModel *)model{
    self.name.text = model.name;
    self.specificatton.text = model.specification;
    self.price.text = model.price;
    self.oldPrice.text = model.oldPrice;
    
    //旧的价格上加横线
    NSMutableAttributedString *newPrice = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",self.oldPrice.text]];
    [newPrice addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, newPrice.length)];
    self.oldPrice.attributedText = newPrice;
    
    
    self.shop.text = model.shop;
    self.num.text = model.num;
    
    self.num.textAlignment = NSTextAlignmentCenter;
    
    [self.goodsImg sd_setImageWithURL:[NSURL URLWithString:model.goodsImg] placeholderImage:nil];
    
    
}


@end
