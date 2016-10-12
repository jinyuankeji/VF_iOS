//
//  allCommentVC.m
//  VFShoppingMall
//
//  Created by gushi on 16/10/9.
//  Copyright © 2016年 jinyuankeji. All rights reserved.
//

#import "allCommentVC.h"
#import "allCommentCell.h"
#import "MBProgressHUD.h"
#import "AFNetworking.h"

@interface allCommentVC ()<UITableViewDelegate,UITableViewDataSource,MBProgressHUDDelegate>

@property (nonatomic,weak) UITableView * commentTbView;
@property (nonatomic,strong) MBProgressHUD *progressHUD;
@property (nonatomic,strong) NSMutableArray<allCommendModel*> * commendArr;

@end

@implementation allCommentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"全部评论";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    UITableView * commentView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT-64) style:UITableViewStylePlain];
    commentView.delegate = self;
    commentView.dataSource = self;
    self.commentTbView = commentView;
    self.commendArr = [NSMutableArray array];
    [self.view addSubview:self.commentTbView];
    
    [self getAllCommendInfo];
    
    
    // Do any additional setup after loading the view.
}
-(void)getAllCommendInfo{
    
    NSString *url=app_url @"AllAssess?userId=17&goodsId=9&AssessState=0";
    
//    NSDictionary * param=@{<#@"state":@"-1",@"pageindex":@"1"#>};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [self getAllCommendMethod:[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil]];
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
-(void)getAllCommendMethod:(NSDictionary *)dic{
    
    if (_progressHUD)
    {
        [_progressHUD removeFromSuperview];
        _progressHUD = nil;
    }
    NSLog(@"%@",dic);
    for (NSDictionary * dataDic in [[dic objectForKey:@"Data"] objectForKey:@"assessList"]) {
        allCommendModel * model = [allCommendModel modelWithDict:dataDic];
        [self.commendArr addObject:model];
    }
    [self.commentTbView reloadData];
    NSLog(@"%@",self.commendArr[0].content);
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    allCommentCell * cell = [allCommentCell allCommendWithTableView:tableView];
    cell.model = self.commendArr[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  [allCommentCell cellHeight];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.commendArr.count;
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
