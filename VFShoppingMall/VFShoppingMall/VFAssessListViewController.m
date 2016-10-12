//
//  VFAssessListViewController.m
//  VFShoppingMall
//
//  Created by 张允鹏 on 16/10/6.
//  Copyright © 2016年 jinyuankeji. All rights reserved.
//

#import "VFAssessListViewController.h"
#import "FrameAutoScaleLFL.h"
#import "UIImageView+WebCache.h"
@interface VFAssessListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , weak) UITableView * tableView;

@end

@implementation VFAssessListViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout =UIRectEdgeNone;
    UIView * lineView=[[UIView alloc]initWithFrame:RectMake_LFL(0, 0, 375, 1)];
    lineView.backgroundColor=[UIColor colorWithRed:239.0/255.0 green:239.0/255.0 blue:239.0/255.0 alpha:1];
    [self.view addSubview:lineView];
    
    UITableView * tabelView=[[UITableView alloc]initWithFrame:RectMake_LFL(0, 1, 375,self.view.bounds.size.height)];
    self.tableView=tabelView;
    
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:tabelView];
    // Do any additional setup after loading the view.
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.modelArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellTableIdentifier = @"CellTableIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellTableIdentifier];
    
    if (cell == nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellTableIdentifier];
    
        //头像
        UIImageView * imgView=[[UIImageView alloc]initWithFrame:RectMake_LFL(8, 8, 25, 25)];
        imgView.tag=1;
        imgView.backgroundColor=[UIColor grayColor];
        [cell.contentView addSubview:imgView];
        //用户名
        UILabel * label =[[UILabel alloc]initWithFrame:RectMake_LFL(16+25, 8, 200, 25)];
        label.font=[UIFont systemFontOfSize:12];
        label.tag=2;
        [cell.contentView addSubview:label];
        // 评论
        label =[[UILabel alloc]initWithFrame:RectMake_LFL(8, 55, 200, 12)];
        label.font=[UIFont systemFontOfSize:12];
        label.tag=3;
        [cell.contentView addSubview:label];
        
        label =[[UILabel alloc]initWithFrame:RectMake_LFL(8, 85, 200, 12)];
        label.font=[UIFont systemFontOfSize:12];
        label.tag=4;
        label.textColor=[UIColor lightGrayColor];
        [cell.contentView addSubview:label];
        
        
        UIView * lineView=[[UIView alloc]initWithFrame:RectMake_LFL(1, 114,375, 1)];
        lineView.backgroundColor=[UIColor colorWithRed:240.0/255.0 green:244.0/255.0 blue:243.0/255.0 alpha:1];
        [cell.contentView addSubview: lineView];
    }
    VFAssessModel * model = self.modelArr[indexPath.row];
    UIImageView * imgView=(UIImageView *)[cell.contentView viewWithTag:1];
    [imgView sd_setImageWithURL:[NSURL URLWithString:model.headerImgURL] placeholderImage:nil];
    UILabel * label=(UILabel *)[cell.contentView viewWithTag:2];
    label.text=model.assessNickName;
    label=(UILabel *)[cell.contentView viewWithTag:3];
    label.text=model.content;
    label=(UILabel *)[cell.contentView viewWithTag:4];
    label.text=model.createTime;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  CGRectGetMaxY(RectMake_LFL(0, 0, 0, 115));
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
