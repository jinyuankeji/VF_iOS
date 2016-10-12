//
//  MainViewController.m
//  VFShoppingMall
//
//  Created by gushi on 16/9/27.
//  Copyright © 2016年 jinyuankeji. All rights reserved.
//

#import "MainViewController.h"
#import "FrameMainLFL.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"
#import "UIImageView+WebCache.h"
#import "shopClassVC.h"
#import "homePageModel.h"
#import "SDCycleScrollView.h"
#import "goodsSortModel.h"
#import "goodsSortBtn.h"
#import "UIButton+WebCache.h"
#import "expandListModel.h"
#import "MJRefresh.h"
#import "sortNameViewController.h"
#import "otherAdressVC.h"


@interface MainViewController ()<MBProgressHUDDelegate,SDCycleScrollViewDelegate>{
    CGFloat height;
    SDCycleScrollView *cycleScrollView;
    UIImageView* classBackView;
    UIButton * expandListBtn1;
    UIButton * expandListBtn2;
}

@property (nonatomic,weak) UIScrollView * mainScrollView;
@property (nonatomic,strong) MBProgressHUD*progressHUD;
@property (nonatomic,strong) NSMutableArray * homePageArr;

@property (nonatomic,strong) NSMutableArray<goodsSortModel*> * goodsSortBtnArr;
@property (nonatomic,strong) NSMutableArray<expandListModel*> * expandListArr;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;

    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 100, 40)];
    imageView.image = [UIImage imageNamed:@"VFlogo"];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.navigationItem.titleView = imageView;
    UIScrollView * mainScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT-64-49)];
    self.mainScrollView = mainScrollView;
    [self.view addSubview:self.mainScrollView];
    _mainScrollView.mj_header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        self.goodsSortBtnArr= [NSMutableArray array];
        self.homePageArr = [NSMutableArray array];
        self.expandListArr = [NSMutableArray array];
        
        [self getHomePageInfo];
    }];
   self.title = @"主页";
    UIBarButtonItem * shopClass = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"sou"] style:UIBarButtonItemStylePlain target:self action:@selector(toShopClassVC)];
    self.navigationItem.rightBarButtonItem = shopClass;
    
    [self setUpView];
}

-(void)viewWillAppear:(BOOL)animated{

    if (_homePageArr==nil) {
        [self.mainScrollView.mj_header beginRefreshing];
    }
    [self.homePageArr removeAllObjects];
    [self.expandListArr removeAllObjects];
    [self.goodsSortBtnArr removeAllObjects];
    
//    [self getHomePageInfo];

}


-(void)setUpView{
    height=0;
    cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:RectMake_LFL(0, 0, 375, 150) delegate:self placeholderImage:nil];
    cycleScrollView.autoScrollTimeInterval=4;
    cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    cycleScrollView.backgroundColor=[UIColor whiteColor];
    cycleScrollView.currentPageDotColor = [UIColor whiteColor]; // 自定义分页控件小圆标颜色
    [self.mainScrollView addSubview:cycleScrollView];
    height+=160;
    UIImageView * newVIPView = [[UIImageView alloc]initWithFrame:RectMake_LFL(0, height, 375, 40)];
    newVIPView.backgroundColor = [UIColor greenColor];
    newVIPView.image = [UIImage imageNamed:@"shou01"];
    [self.mainScrollView addSubview:newVIPView];
    height+=50;
    classBackView = [[UIImageView alloc]initWithFrame:RectMake_LFL(16, height, 375-32, 250)];
    classBackView.image  = [UIImage imageNamed:@"feilei"];
    classBackView.userInteractionEnabled = YES;
    [self.mainScrollView addSubview:classBackView];
    
    height+=260;
    
    
    expandListBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    expandListBtn1.frame = RectMake_LFL(0, height, 375, 152);
    [expandListBtn1 addTarget:self action:@selector(expandListBtn1Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.mainScrollView addSubview:expandListBtn1];
    
    height+=162;
    
    expandListBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    expandListBtn2.frame = RectMake_LFL(0, height, 375, 152);

    [self.mainScrollView addSubview:expandListBtn2];
    height+=152;
    
    self.mainScrollView.contentSize = SizeMake_LFL(375, height);
    

    
    
}

-(void)getHomePageInfo{
    
    NSString *url=app_url @"HomePage";
    
    //    NSDictionary * param=@{<#@"state":@"-1",@"pageindex":@"1"#>};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [self getInfoMothod:[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil]];
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
//广告数据获取
-(void)getInfoMothod:(NSDictionary *)dic{
    [self.mainScrollView.mj_header endRefreshing];
    
    if (_progressHUD)
    {
        [_progressHUD removeFromSuperview];
        _progressHUD = nil;
    }

    NSLog(@"%@",dic);
    NSDictionary * dataDic = [dic objectForKey:@"Data"];
    NSDictionary * adverDic = [dataDic objectForKey:@"advertisement"];
    NSString * str = [NSString string];
    for (NSDictionary * dict1 in adverDic) {
        str = [dict1 objectForKey:@"ADImg"];
        [self.homePageArr addObject:str];
        
    }
    NSLog(@"%@",self.homePageArr[0]);
    cycleScrollView.imageURLStringsGroup = self.homePageArr;
    
    NSDictionary * goodsSortDic = [dataDic objectForKey:@"goodsSort"];
    
    for (NSDictionary * sortDic in goodsSortDic) {
        goodsSortModel * goodsModel = [goodsSortModel modelWithDict:sortDic];
        [self.goodsSortBtnArr addObject:goodsModel];
        
    }
    int btnX = 28;
    int btnY = 15;
    int btnW = 64;
    int btnH = 75;
    for (int i=0; i<self.goodsSortBtnArr.count; i++) {
        goodsSortBtn * goodsBtn = [goodsSortBtn buttonWithType:UIButtonTypeCustom];
        if (DEVICE_WIDTH==375) {
//            goodsBtn.titleLabel.font = [UIFont systemFontOfSize:10];
            [goodsBtn.titleLabel setFont:[UIFont systemFontOfSize:10]];
        }
        
        goodsBtn.frame = RectMake_LFL(btnX, btnY, btnW, btnH);
        [goodsBtn sd_setImageWithURL:[NSURL URLWithString:self.goodsSortBtnArr[i].SortIconImg] forState:UIControlStateNormal];
        [goodsBtn setTitle:self.goodsSortBtnArr[i].SortTitle forState:UIControlStateNormal];
        [goodsBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
        [goodsBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        goodsBtn.tag = i;
        [goodsBtn addTarget:self action:@selector(goodsSortBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        [classBackView addSubview:goodsBtn];
        btnX += 64;
        if (i==4) {
            btnX=2;
            btnY=94;
        }
        if (i==9) {
            btnX=28;
            btnY=175;
            
        }
       
        
    }
    
    NSDictionary * expandListDic = [dataDic objectForKey:@"expandList"];
    for (NSDictionary * expandDic in expandListDic) {
        expandListModel * expandModel = [expandListModel modelWithDict:expandDic];
        [self.expandListArr addObject:expandModel];
    }
    [expandListBtn1 sd_setImageWithURL:[NSURL URLWithString:self.expandListArr[0].expandImg] forState:UIControlStateNormal];
    
    [expandListBtn2 sd_setImageWithURL:[NSURL URLWithString:self.expandListArr[1].expandImg] forState:UIControlStateNormal];
    NSLog(@"%@",self.expandListArr[1].expandImg);
    
    
//    NSMutableArray *imagePathArr = [[NSMutableArray alloc] init];
//    for (int i = 0; i < [ary count]; ++i) {
//        NSDictionary *dict = (NSDictionary*)[ary objectAtIndex:i];
//        if (![dict isKindOfClass:[NSDictionary class]]) {
//            continue;
//        }
//        model = [[homePageModel alloc]initWithDict:dic];
//        
//        [imagePathArr addObject:model1.imageNetPath];
//        cycleScrollView.imageURLStringsGroup = imagePathArr;
//    }



}

-(void)goodsSortBtnClicked:(UIButton*)btn{
    NSLog(@"%ld",(long)btn.tag);
    NSUInteger i = btn.tag;
    sortNameViewController * vc = [[sortNameViewController alloc]init];
//    vc.sortId = self.goodsSortBtnArr[i].SortId;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark 广告点击代理
//-(void)clickViewGetModel:(NSObject *)model Type:(int)type{
//    if(model == nil)
//        return;
//    AdvModel *adv = (AdvModel *)model;
//    if (adv.advType == 2) {//点评
//        FShop4ListModel *shop = [[FShop4ListModel alloc] init];
//        shop.shopid = adv.dataID;
//        shop.shopname = @"";
//        [app setShopMode:shop];
//        ShopNewViewController *controller = [[ShopNewViewController alloc] init];
//        UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:controller];
//
//        [self presentViewController:navController animated:YES completion:^{
//        }];
//
//    }else if (adv.advType == 3) {//菜单
//        FShop4ListModel *shop = [[FShop4ListModel alloc] init];
//        shop.shopid = adv.dataID;
//        shop.shopname = @"";
//        [app setShopMode:shop];
//
//        ShopNewViewController *controller = [[ShopNewViewController alloc] init];
//        UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:controller];
//
//        [self presentViewController:navController animated:YES completion:^{
//
//        }];
//    }
//
//}


-(void)toShopClassVC{
    shopClassVC * vc = [[shopClassVC alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
}
#pragma mark-扩展分类Clicked
-(void)expandListBtn1Clicked{
    NSLog(@"111");
//    otherAdressVC * vc = [[otherAdressVC alloc]init];
//    vc.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:vc animated:YES];
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
