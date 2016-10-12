//
//  brandCell.m
//  VFShoppingMall
//
//  Created by gushi on 16/9/30.
//  Copyright © 2016年 jinyuankeji. All rights reserved.
//

#import "brandCell.h"
#import "FrameMainLFL.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"
#import "UIImageView+WebCache.h"

@implementation brandCell{
    UIImageView * iconImageView;
    UILabel * storeNameLb;
    UILabel * numShopLb;
    UIScrollView * shopDetailScroView;
    int num;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+(brandCell*)brandWithTableView:(UITableView *)tableView{
    brandCell * cell = [tableView dequeueReusableCellWithIdentifier:@"brandCell"];
    if (cell == nil){
        cell = [[brandCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"brandCell"];
    }
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self.contentView removeConstraints:self.contentView.constraints];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        UIView * backView = [[UIView alloc]initWithFrame:RectMake_LFL(0, 0, 375, 30)];
        backView.alpha = 0.2;
        backView.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:backView];
        iconImageView = [[UIImageView alloc]initWithFrame:RectMake_LFL(13, 9+30, 40, 40)];

        [self.contentView addSubview:iconImageView];
        
        storeNameLb = [[UILabel alloc]initWithFrame:RectMake_LFL(55, 26+30, 200, 32)];
        storeNameLb.font = [UIFont systemFontOfSize:26];
        
        [self.contentView addSubview:storeNameLb];
        
        numShopLb = [[UILabel alloc]initWithFrame:RectMake_LFL(375-130, 23+30, 150, 26)];
        
        [self.contentView addSubview:numShopLb];
        
        UIImageView * arrowImage = [[UIImageView alloc]initWithFrame:RectMake_LFL(375-23, 23+30, 5, 26)];
        arrowImage.image = [UIImage imageNamed:@"you"];
        [self.contentView addSubview:arrowImage];
        
        shopDetailScroView = [[UIScrollView alloc]initWithFrame:RectMake_LFL(13, 60+30, 375-13, 90)];

        shopDetailScroView.alwaysBounceHorizontal = YES;
        [self.contentView addSubview:shopDetailScroView];
        


    }
    return self;
}

-(void)setModel:(brandInfoModel *)model{
    _model = model;
    [iconImageView sd_setImageWithURL:[NSURL URLWithString:model.storeIcon]];
    storeNameLb.text = self.model.storeName;
    numShopLb.text = [NSString stringWithFormat:@"上新%@件商品",self.model.newnum];
    num = [model.newnum intValue];
    int x=0;
    for (int i=0; i<num; i++) {
        UIImageView * detailImage = [[UIImageView alloc]initWithFrame:RectMake_LFL(x, 0, 88, 88)];
        [detailImage sd_setImageWithURL:[NSURL URLWithString:model.detailModelArr[i].goods]];
        NSLog(@"%@",model.detailModelArr[0].goods);
        x += 92;
        [shopDetailScroView addSubview:detailImage];
    }
    shopDetailScroView.contentSize = SizeMake_LFL(92*num-4, 88);

}
+(CGFloat)cellHeight{
    return SizeMake_LFL(150, 180).height;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
