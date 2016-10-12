//
//  allCommentCell.m
//  VFShoppingMall
//
//  Created by gushi on 16/10/9.
//  Copyright © 2016年 jinyuankeji. All rights reserved.
//

#import "allCommentCell.h"
#import "UIImageView+WebCache.h"
#import "FrameAutoScaleLFL.h"

@implementation allCommentCell{
    UIImageView * iconView;
    UILabel * nameLable;
    UILabel * commendLable;
    UILabel * timeLble;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+(allCommentCell*)allCommendWithTableView:(UITableView *)tableView{
    allCommentCell * cell = [tableView dequeueReusableCellWithIdentifier:@"allCommendCell"];
    if (cell == nil){
        cell = [[allCommentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"allCommendCell"];
    }
    return cell;
}






-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self.contentView removeConstraints:self.contentView.constraints];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        iconView = [[UIImageView alloc]initWithFrame:RectMake_LFL(10, 10, 22, 22)];
        [self.contentView addSubview:iconView];
        nameLable = [[UILabel alloc]initWithFrame:RectMake_LFL(42, 12, 150, 18)];
        [self.contentView addSubview:nameLable];
        commendLable = [[UILabel alloc]initWithFrame:RectMake_LFL(10, 42, 300, 40)];
        commendLable.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:commendLable];
        commendLable.numberOfLines = 0;
        timeLble = [[UILabel alloc]initWithFrame:RectMake_LFL(10, 42+18+10+22, 350, 11)];
        timeLble.textColor = [UIColor lightGrayColor];
        timeLble.font = [UIFont systemFontOfSize:11];
        [self.contentView addSubview:timeLble];
    }
    return self;
}

-(void)setModel:(allCommendModel *)model{
    _model=model;
    [iconView sd_setImageWithURL:[NSURL URLWithString:model.headerImgURL] placeholderImage:[UIImage imageNamed:@"cang"]];
    nameLable.text = model.assessNickName;
    commendLable.text = model.content;
    timeLble.text = [NSString stringWithFormat:@"%@ 颜色分类：%@ 短袖； 尺码：大码5XXL",model.createTime,model.goodsInformation];
    
}
+(CGFloat)cellHeight{
    return SizeMake_LFL(42+18+10+22+28, 42+18+10+22).width;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
