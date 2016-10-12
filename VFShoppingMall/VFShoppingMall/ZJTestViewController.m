//
//  TextViewController.m
//  ZJScrollPageView
//
//  Created by jasnig on 16/5/7.
//  Copyright © 2016年 ZeroJ. All rights reserved.
//

#import "ZJTestViewController.h"
#import "FrameMainLFL.h"
#import "MBProgressHUD.h"
#import "brandInfoModel.h"
#import "brandCell.h"
#import "AFNetworking.h"
#import "brandCell.h"
#import "sortNameViewController.h"
@interface ZJTestViewController ()<UITableViewDelegate,UITableViewDataSource,MBProgressHUDDelegate>

@property (nonatomic,weak) UITableView * brandTbView;
@property (nonatomic,strong) MBProgressHUD*progressHUD;

@end

@implementation ZJTestViewController
//- (IBAction)testBtnOnClick:(UIButton *)sender {
//    
//}


- (void)setUpWhenViewWillAppearForTitle:(NSString *)title forIndex:(NSInteger)index firstTimeAppear:(BOOL)isFirstTime {
    if (isFirstTime) {
        if ([title isEqualToString:@"品   牌"]) {
            [self getBrandCellInfo];
            NSLog(@"11111");
        }
       
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.brandArr = [NSMutableArray array];
    
    UITableView * brandView1 = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT-64-80-49)];
    self.brandTbView = brandView1;
    [self.view addSubview:self.brandTbView];

    self.brandTbView.delegate = self;
    self.brandTbView.dataSource = self;
    
}
-(void)viewWillAppear:(BOOL)animated{
//    [self getBrandCellInfo];
}
-(void)getBrandCellInfo{
    
    NSString *url=app_url @"BrandCollectList";
    
    NSDictionary * param=@{@"userId":@"16"};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:url parameters:param progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [self getBrandCellMethod:[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil]];
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
-(void)getBrandCellMethod:(NSDictionary *)dic{
    
    if (_progressHUD)
    {
        [_progressHUD removeFromSuperview];
        _progressHUD = nil;
    }
    for (NSDictionary * brandDic in [dic objectForKey:@"Data"]) {
        brandInfoModel * model = [brandInfoModel modelWithDict:brandDic];
        [self.brandArr addObject:model];
    }
    NSLog(@"%@",dic);
    [self.brandTbView reloadData];
    NSLog(@"%@",self.brandArr[0].detailModelArr[0].goods);
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView==self.brandTbView) {
        brandCell * cell = [brandCell brandWithTableView:tableView];
        return cell;
    }else{
        return nil;
    }
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.brandArr.count;
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    ((brandCell*)cell).model =self.brandArr[indexPath.row];
    NSLog(@"%@",((brandCell*)cell).model.storeName);
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [brandCell cellHeight];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    sortNameViewController * vc = [[sortNameViewController alloc]init];
    vc.sortId = @"13";
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
//     * vc=[[orderDetailViewController alloc]initWithModel:orderModelArr[indexPath.row]];
//    [vc setHidesBottomBarWhenPushed:YES];
//    [self.navigationController pushViewController:vc animated:YES];
}






- (void)dealloc
{
    NSLog(@"%@-----test---销毁", self.description);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
