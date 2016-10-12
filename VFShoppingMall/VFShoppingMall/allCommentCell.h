//
//  allCommentCell.h
//  VFShoppingMall
//
//  Created by gushi on 16/10/9.
//  Copyright © 2016年 jinyuankeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "allCommendModel.h"


@interface allCommentCell : UITableViewCell

@property (nonatomic,strong) allCommendModel * model;

+(allCommentCell*)allCommendWithTableView:(UITableView *)tableView;

+(CGFloat)cellHeight;

@end
