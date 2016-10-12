//
//  ZJTest1Controller.m
//  ZJScrollPageView
//
//  Created by ZeroJ on 16/6/30.
//  Copyright © 2016年 ZeroJ. All rights reserved.
//

#import "ZJTest1Controller.h"
#import "FrameMainLFL.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"
#import "UIImageView+WebCache.h"
#import "shopDetailCollecCell.h"
#import "shopDatailFlowLayout.h"
#import "GSShopDetailCollecModel.h"
#import "sortNameViewController.h"


@interface ZJTest1Controller ()<UICollectionViewDelegate,UICollectionViewDataSource,MBProgressHUDDelegate>
@property (nonatomic,strong) MBProgressHUD* progressHUD;
@property (nonatomic,weak)  UICollectionView * shopDetailCollecView;
@property (nonatomic,strong) NSMutableArray<GSShopDetailCollecModel*> * shopDetailArr;

@end

@implementation ZJTest1Controller

- (void)setUpWhenViewWillAppearForTitle:(NSString *)title forIndex:(NSInteger)index firstTimeAppear:(BOOL)isFirstTime {
    if (isFirstTime) {
        if ([title isEqualToString:@"商   品"]) {
            [self getShopDetailInfo];
            NSLog(@"11111");
        }
        
    }
}
-(void)getShopDetailInfo{
    
    NSString *url=app_url @"commodityCollectList";
    
    NSDictionary * param=@{@"userId":@"17"};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:url parameters:param progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [self getShopDetailMothod:[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil]];
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
-(void)getShopDetailMothod:(NSDictionary *)dic{
    
    if (_progressHUD)
    {
        [_progressHUD removeFromSuperview];
        _progressHUD = nil;
    }
    NSLog(@"%@",dic);
    for (NSDictionary * dataDic in [dic objectForKey:@"Data"]) {
        GSShopDetailCollecModel * model = [GSShopDetailCollecModel modelWithDict:dataDic];
        [self.shopDetailArr addObject:model];
    }
    [self.shopDetailCollecView reloadData];
    NSLog(@"%@",self.shopDetailArr[0].goodsIcon);
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.shopDetailArr = [NSMutableArray array];
    
#pragma mark-collectionView
    
    //注意：collectionView创建应按照如下方法。一定要有layout参数。initWithFrame
    CGRect collectionViewFrame = CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT);
    shopDatailFlowLayout* flowLayout= [[shopDatailFlowLayout alloc]init];
    UICollectionView* shopDetailCollecView = [[UICollectionView alloc]initWithFrame:collectionViewFrame collectionViewLayout:flowLayout];
    self.shopDetailCollecView = shopDetailCollecView;
    [self.view addSubview:self.shopDetailCollecView];
    
    //注册cell
    [self.shopDetailCollecView registerClass:[shopDetailCollecCell class] forCellWithReuseIdentifier:@"cell"];
    
    self.shopDetailCollecView.delegate = self;
    self.shopDetailCollecView.dataSource = self;
    
    self.shopDetailCollecView.backgroundColor = [UIColor whiteColor];
    
    //自适应大小
    self.shopDetailCollecView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - CollectionView的数据源代理
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.shopDetailArr.count;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    shopDetailCollecCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    //    cell.delegate = self;
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    
    shopDetailCollecCell* collectionViewCell = (shopDetailCollecCell*)cell;
    [collectionViewCell sizeToFit];
//    [collectionViewCell.shopImageView sd_setImageWithURL:[NSURL URLWithString:self.shopDetailArr[indexPath.row].goodsIcon]];
    
    collectionViewCell.model = self.shopDetailArr[indexPath.row];
    
//    collectionViewCell.shopImageView = self.shopDetailArr[indexPath.row].goodsIcon;
//    collectionViewCell.priceLable = self.shopDetailArr[indexPath.row].price;
//    collectionViewCell.costPriceLable = self.shopDetailArr[indexPath.row].costPrice;
//    collectionViewCell.discountLable = self.shopDetailArr[indexPath.row].discount;
//    collectionViewCell.shopTitleLable = self.shopDetailArr[indexPath.row].goodsTitle;
    
    

}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"您点击的cell编号为：%ld",indexPath.item);
    sortNameViewController * vc = [[sortNameViewController alloc]init];
    vc.sortId = self.shopDetailArr[indexPath.row].goodsId;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
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
