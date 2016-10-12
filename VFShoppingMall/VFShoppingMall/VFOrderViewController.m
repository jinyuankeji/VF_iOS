//
//  VFOrderViewController.m
//  DKDJForDeliver
//
//  Created by 张允鹏 on 16/9/29.
//  Copyright © 2016年 gushi. All rights reserved.
//

#import "VFOrderViewController.h"
#import "FrameAutoScaleLFL.h"
#import "MJRefresh.h"
#import "MBProgressHUD.h"
#import "AFNetworking.h"
#import "VFOrderModel.h"
#import "UIImageView+WebCache.h"

@interface VFOrderViewController ()<UITableViewDelegate,UITableViewDataSource,MBProgressHUDDelegate>

@property (nonatomic,weak) UITableView * tableView;
@property (nonatomic,strong) NSMutableArray *orderModelArr;
@property (nonatomic,strong) MBProgressHUD *progressHUD;

@end

@implementation VFOrderViewController

-(void)viewWillAppear:(BOOL)animated{

    if (_orderModelArr==nil) {
        [self.tableView.mj_header beginRefreshing];
    }

}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout =UIRectEdgeNone;
    NSLog(@"%ld",(long)self.index);
    UIView * lineView=[[UIView alloc]initWithFrame:RectMake_LFL(0, 0, 375, 10)];
    lineView.backgroundColor=[UIColor colorWithRed:239.0/255.0 green:239.0/255.0 blue:239.0/255.0 alpha:1];
    [self.view addSubview:lineView];
    UITableView * tabelView=[[UITableView alloc]initWithFrame:RectMake_LFL(0, 10, 375,self.view.bounds.size.height)];
    self.tableView=tabelView;
    
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    
//    _tableView.mj_header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        // 进入刷新状态后会自动调用这个block
//        _orderModelArr =[NSMutableArray array];
//        [self getOrderListData];
//    }];
    
    [self.view addSubview:tabelView];
    
    // Do any additional setup after loading the view.
}
- (void)setUpWhenViewWillAppearForTitle:(NSString *)title forIndex:(NSInteger)index firstTimeAppear:(BOOL)isFirstTime {
    if (isFirstTime) {
   
        _tableView.mj_header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
            // 进入刷新状态后会自动调用这个block
            _orderModelArr =[NSMutableArray array];
            [self getOrderListData];
        }];

      
        
    }
}
-(void)getOrderListData{
    NSString *url;
    switch (self.index) {
        case 0:
            url=@"http://www.jinyuankeji.net/VF/portal/OrderAction/BuyerAllOrder";
            break;
        case 1:
            url=@"http://www.jinyuankeji.net/VF/portal/OrderAction/BuyerObligation";
            break;
        case 2:
            url=@"http://www.jinyuankeji.net/VF/portal/OrderAction/Buyerbligation";
//            url=@"http://www.jinyuankeji.net/VF/portal/OrderAction/BuyerObligation";
            break;
        case 3:
            url=@"http://www.jinyuankeji.net/VF/portal/OrderAction/BuyerAssess";
//            url=@"http://www.jinyuankeji.net/VF/portal/OrderAction/BuyerObligation";
            break;
        case 4:
            url=@"http://www.jinyuankeji.net/VF/portal/OrderAction/BuyerAftermarket";
//            url=@"http://www.jinyuankeji.net/VF/portal/OrderAction/BuyerObligation";

            break;
        default:
            break;
    }

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:url parameters:@{@"userId":@"1"} progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (_progressHUD){
            [_progressHUD removeFromSuperview];
        }
        [self orderlistReceive:[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil]];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败：%@",error);
    }];
    
    
    _progressHUD = [[MBProgressHUD alloc] initWithView:self.view];
    _progressHUD.dimBackground = NO;
    [self.view addSubview:_progressHUD];
    [self.view bringSubviewToFront:_progressHUD];
    _progressHUD.delegate = self;
    _progressHUD.labelText = @"加载中...";
    [_progressHUD show:YES];
}

-(void)orderlistReceive:(NSDictionary *)dic{

    [self.tableView.mj_header endRefreshing];
    
    if (![[dic objectForKey:@"Status"] isEqualToString:@"true"]) {
        //错误提示。。。
        return;
    }

    NSLog(@"%@",dic);
    for (NSDictionary *dict in [dic objectForKey:@"Data"]) {
        VFOrderModel * model=[VFOrderModel modelWithDict:dict];
        [self.orderModelArr addObject:model];
    }
    [self.tableView reloadData];
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellTableIdentifier = @"CellTableIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellTableIdentifier];
    
    if (cell == nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellTableIdentifier];
        
        
        
        CGFloat height=0;
        // tag 1 shop名
        UILabel * label=[[UILabel alloc]initWithFrame:RectMake_LFL(12, height, 200, 40)];
        label.font=[UIFont systemFontOfSize:14];
        label.tag=1;
        [cell.contentView addSubview:label];
        //tag 2  state
        label=[[UILabel alloc]initWithFrame:RectMake_LFL(375-12-150, height, 150, 40)];
        label.textAlignment=NSTextAlignmentRight;
        label.font=[UIFont systemFontOfSize:14];
        label.tag=2;
        label.textColor=[UIColor colorWithRed:255.0/255.0 green:185.0/255.0 blue:1.0/255.0 alpha:1];
        [cell.contentView addSubview:label];
    
        height +=40;
        
        UIView * backView=[[UIView alloc]initWithFrame:RectMake_LFL(0, height, 375, 80)];
        backView.backgroundColor=[UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1];
        [cell.contentView addSubview:backView];
        // icon
        UIImageView * imgView=[[UIImageView alloc]initWithFrame:RectMake_LFL(10, 10, 60, 60)];
        imgView.tag=3;
        [backView addSubview:imgView];
        
        //good name
        
        label=[[UILabel alloc]init];//WithFrame:RectMake_LFL(10, 0, 200, 40)];
        label.font=[UIFont systemFontOfSize:14];
        label.tag=4;
        [backView addSubview:label];
        
        for (int i = 5; i<8; i++) {
            label=[[UILabel alloc]initWithFrame:RectMake_LFL(375-12-150, 10+16*(i-5), 150, 16)];
            label.textAlignment=NSTextAlignmentRight;
            label.font=[UIFont systemFontOfSize:14];
            label.tag=i;
            [backView addSubview:label];
        }
        
        
        height += 80;
        
        label=[[UILabel alloc]initWithFrame:RectMake_LFL(375-12-300, height, 300, 40)];
        label.textAlignment=NSTextAlignmentRight;
        label.font=[UIFont systemFontOfSize:14];
        label.tag=8;
        [cell.contentView addSubview:label];
        
        
        
        height +=40;
        
//        UIView * lineView=[[UIView alloc]initWithFrame:RectMake_LFL(0, height, 375, 0.5)];
//        lineView.backgroundColor=[UIColor colorWithRed:239.0/255.0 green:239.0/255.0 blue:239.0/255.0 alpha:1];
//        [cell.contentView addSubview:lineView];
//        1.全部订单：删除订单，追加评论
//        2.代付款：取消订单，付款
//        3.待收货：延长收货（做个假的，不谢功能，接口也没有），查看物流（接口目前没有，先留着），确认收货
//        4.待评价：删除订单，评价
//        5.售后：没有button，交易成功变成退款成功
//        height += 5;
        CGFloat BtnWidth= 75;
        int btnCount;
        NSArray * btnTitleArr;
        switch (self.index) {
            case 0:
                btnCount=2;
                btnTitleArr=@[@"删除订单",@"追加评论"];
                break;
            case 1:{
                btnCount=2;
                btnTitleArr=@[@"取消订单",@"付款"];
            }
                break;
            case 2:
                btnCount=3;
                btnTitleArr=@[@"延长收货",@"查看物流",@"确认收货"];
                break;
            case 3:
                btnCount=2;
                btnTitleArr=@[@"删除订单",@"评价"];
                break;
            case 4:
                btnCount = 0;
//                btnTitleArr = @[@"11"];
            
               
                break;
            default:
                break;
        }
        CGFloat X=375-BtnWidth-12;
        for (int i=0; i<btnCount; i++) {
            UIButton * btn=[UIButton buttonWithType:UIButtonTypeCustom];
            btn.tag=i;
            [btn addTarget:self action:@selector(allOrderBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            btn.frame=RectMake_LFL(X, height, BtnWidth, 30);
            [btn.layer setMasksToBounds:YES];
//            [btn.layer setCornerRadius:8];
            [btn.layer setBorderColor:[UIColor lightGrayColor].CGColor];
            [btn.layer setBorderWidth:0.5];
            [btn.titleLabel setFont:[UIFont systemFontOfSize:16]];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btn setTitle:btnTitleArr[i] forState:UIControlStateNormal];
            X-=87;
            [cell.contentView addSubview:btn];
        }
        if (self.index != 4) {
            height +=40;
        }
        UIView * lineView=[[UIView alloc]initWithFrame:RectMake_LFL(0, height, 375, 10)];
        lineView.backgroundColor=[UIColor colorWithRed:239.0/255.0 green:239.0/255.0 blue:239.0/255.0 alpha:1];
        [cell.contentView addSubview:lineView];

    }
    VFOrderModel * model= self.orderModelArr[indexPath.row];
    
    UILabel *shopName = (UILabel *)[cell.contentView viewWithTag:1];
    UILabel *orderState = (UILabel *)[cell.contentView viewWithTag:2];
    UIImageView *iconImgView = (UIImageView *)[cell.contentView viewWithTag:3];
    UILabel *goodName = (UILabel *)[cell.contentView viewWithTag:4];
    UILabel *price = (UILabel *)[cell.contentView viewWithTag:5];
    UILabel *costPrice = (UILabel *)[cell.contentView viewWithTag:6];
    UILabel *numLabel = (UILabel *)[cell.contentView viewWithTag:7];
    UILabel *totalLabel = (UILabel *)[cell.contentView viewWithTag:8];
    
    shopName.text=model.storeName;
    orderState.text=model.msg;
    [iconImgView sd_setImageWithURL:[NSURL URLWithString:model.goodsIcon] placeholderImage:nil];
    
    price.text=[NSString stringWithFormat:@"￥%@", model.price];
    price.textColor=[UIColor lightGrayColor];
    
    NSMutableAttributedString * aStr=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"￥%@", model.costPrice]];
    
    [aStr addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0 , aStr.length)];
    
    [aStr addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(0 , aStr.length)];
    
    costPrice.attributedText =aStr;
    costPrice.textColor=[UIColor lightGrayColor];
    
    numLabel.text=model.num;
    totalLabel.text=[NSString stringWithFormat:@"共%@件商品 合计:￥%@(含运费￥0.00)",model.num,model.total];
    
    goodName.text=model.goodsTitle;
    goodName.numberOfLines=0;

    NSDictionary * attr = @{NSFontAttributeName:[UIFont systemFontOfSize:18]};
    CGFloat H =[model.goodsTitle boundingRectWithSize:SizeMake_LFL(220, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil].size.height;
    goodName.frame=RectMake_LFL(84, 10, 220, H);

    return cell;
}
-(void)allOrderBtnClick:(UIButton *)btn{
    switch (self.index) {
        case 0:
            //@[@"删除订单",@"追加评论"];
            if (btn.tag==0) {
                
                
            }else{
                
            }
            break;
        case 1:
            //@[@"取消订单",@"付款"];
            if (btn.tag==0) {
                
            }else{
                
            }
            break;
        case 2:
            //@[@"延长收货",@"查看物流",@"确认收货"];
  
            break;
        case 3:
            //@[@"删除订单",@"评价"];
            break;
        case 4:
            
            break;
        default:
            break;
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _orderModelArr.count;
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.index==4) {
        return CGRectGetMaxY(RectMake_LFL(0, 0, 0, 210-40));
    }else{
        return  CGRectGetMaxY(RectMake_LFL(0, 0, 0, 210)) ;
    }
    
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
