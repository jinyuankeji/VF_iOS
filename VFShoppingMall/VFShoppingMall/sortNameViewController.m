//
//  sortNameViewController.m
//  VFShoppingMall
//
//  Created by gushi on 16/10/2.
//  Copyright © 2016年 jinyuankeji. All rights reserved.
//

#import "sortNameViewController.h"
#import "FrameMainLFL.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"
#import "sortNameDetailModel.h"
#import "sortNameCollectionViewFlowLayout.h"
#import "sortNameCollectionViewCell.h"
#import "VFGoodDetailViewController.h"

@interface sortNameViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,MBProgressHUDDelegate>
@property (nonatomic,strong) MBProgressHUD* progressHUD;
@property (nonatomic,weak)  UICollectionView * sortNameDetailCollecView;
@property (nonatomic,strong) NSMutableArray<sortNameDetailModel*> * sortNameDetailArr;

@end

@implementation sortNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.sortNameDetailArr = [NSMutableArray array];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title = @"收藏页";
#pragma mark-collectionView
    
    //注意：collectionView创建应按照如下方法。一定要有layout参数。initWithFrame
    CGRect collectionViewFrame = CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT);
    
    sortNameCollectionViewFlowLayout* flowLayout= [[sortNameCollectionViewFlowLayout alloc]init];
    UICollectionView* sortNameDetailCollecView = [[UICollectionView alloc]initWithFrame:collectionViewFrame collectionViewLayout:flowLayout];
    self.sortNameDetailCollecView = sortNameDetailCollecView;
//    self.sortNameDetailCollecView
    [self.view addSubview:self.sortNameDetailCollecView];
    
    //注册cell
    [self.sortNameDetailCollecView registerClass:[sortNameCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    self.sortNameDetailCollecView.delegate = self;
    self.sortNameDetailCollecView.dataSource = self;
    
    self.sortNameDetailCollecView.backgroundColor = [UIColor whiteColor];
    
    //自适应大小
    self.sortNameDetailCollecView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self getSortNameDetailInfo];
    
    
}
-(void)getSortNameDetailInfo{
    
    NSString *url=app_url @"SortDetailsList";
//    NSDictionary * param=@{@"sortId":self.sortId};

    
    NSDictionary * param=@{@"sortId":@"13"};
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:url parameters:param progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [self getSortNameDetailMethod:[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil]];
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
-(void)getSortNameDetailMethod:(NSDictionary *)dic{
    [self.sortNameDetailArr removeAllObjects];
    
    if (_progressHUD)
    {
        [_progressHUD removeFromSuperview];
        _progressHUD = nil;
    }
    for (NSDictionary * dataDic in [dic objectForKey:@"Data"]) {
        sortNameDetailModel * sortModel = [sortNameDetailModel modelWithDict:dataDic];
        [self.sortNameDetailArr addObject:sortModel];
        
    }
    NSLog(@"%@",self.sortNameDetailArr[0].goodsId);
    [self.sortNameDetailCollecView reloadData];
}


#pragma mark - CollectionView的数据源代理
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.sortNameDetailArr.count;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    sortNameCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    //    cell.delegate = self;
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    
    sortNameCollectionViewCell* collectionViewCell = (sortNameCollectionViewCell*)cell;
    [collectionViewCell sizeToFit];

    
    collectionViewCell.model = self.sortNameDetailArr[indexPath.row];
 
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"您点击的cell编号为：%ld",indexPath.item);
    VFGoodDetailViewController * vc = [[VFGoodDetailViewController alloc]init];
//    vc.goodId = self.sortNameDetailArr[indexPath.row].goodsId;
    vc.goodId = @"9";
    [self.navigationController pushViewController:vc animated:YES];
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
