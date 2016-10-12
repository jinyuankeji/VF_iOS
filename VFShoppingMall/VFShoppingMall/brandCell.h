//
//  brandCell.h
//  VFShoppingMall
//
//  Created by gushi on 16/9/30.
//  Copyright © 2016年 jinyuankeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "brandInfoModel.h"

@interface brandCell : UITableViewCell

+(brandCell*)brandWithTableView:(UITableView *)tableView;
+(CGFloat) cellHeight;

@property (nonatomic,strong) brandInfoModel * model;



@end
