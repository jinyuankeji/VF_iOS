//
//  shopClassVC.m
//  VFShoppingMall
//
//  Created by gushi on 16/9/28.
//  Copyright © 2016年 jinyuankeji. All rights reserved.
//

#import "shopClassVC.h"
#import "FrameMainLFL.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"
#import "UIImageView+WebCache.h"
#import "classListModel.h"
#import "shopClassCollectionViewCell.h"
#import "shopClassCollectionViewFlowLayout.h"
#import "shopClassDetailModel.h"
#import "sortNameViewController.h"
#import "saleBrandModel.h"

@interface shopClassVC ()<UITableViewDelegate,UITableViewDataSource,MBProgressHUDDelegate,UICollectionViewDelegate,UICollectionViewDataSource>{
    UIView * classView;
    UIView * saleView;
    
    
    //假的
    NSArray * headArr;
    NSArray * titleArr;
    
    
}

@property (nonatomic,strong) NSMutableArray<classListModel*> * classListArr;
@property (nonatomic,strong) MBProgressHUD*progressHUD;
@property (nonatomic,strong) MBProgressHUD*progressHUD2;

@property (nonatomic,strong) NSString * classListTypeNum;

@property (nonatomic,weak) UICollectionView * shopClassCollectionView;
@property (nonatomic,weak) UITableView * classListTb;
@property (nonatomic,weak) UITableView * saleTbView;
@property (nonatomic,strong) NSMutableArray * collectionDataArr;
@property (nonatomic,strong) NSMutableArray<shopClassDetailModel*> * shopClassDetailModelArr;
@property (nonatomic,strong) NSMutableArray<saleBrandModel*> * BrandSortArr;
@property (nonatomic,strong) NSMutableArray<NSString*> * headViewArr;




@end

@implementation shopClassVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    NSArray * arr  = @[@"分类",@"在售品牌"];
    UISegmentedControl * segClass = [[UISegmentedControl alloc]initWithItems:arr];
    [segClass addTarget:self action:@selector(segClassClicked:) forControlEvents:UIControlEventValueChanged];
    segClass.frame = CGRectMake(70, 5, 180, 34);
//    segClass.momentary = NO;  //设置在点击后是否恢复原样
//    segClass.multipleTouchEnabled=NO;  //可触摸
    segClass.selectedSegmentIndex =0;   //指定索引
    segClass.tintColor = [UIColor grayColor];
    self.navigationItem.titleView = segClass;
    
    self.classListArr = [NSMutableArray array];
    self.classListTypeNum = [NSString string];
    self.shopClassDetailModelArr = [NSMutableArray array];
    self.BrandSortArr = [NSMutableArray array];
    self.headViewArr = [NSMutableArray array];
#pragma mark-假数据
    headArr = @[@"A",@"B",@"C",@"D",@"F",@"G",@"H",@"I"];
    titleArr = @[@"阿迪达斯",@"班博",@"潮宏基",@"戴尔",@"芬狄诗",@"高丝",@"海尔",@"爱美丽",];
    //劲霸男装
    //分类界面
    classView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT-64)];
    [self.view addSubview:classView];
    
    UITableView * classTbView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SizeMake_LFL(80, 0).width, DEVICE_HEIGHT-64) style:UITableViewStylePlain];
    self.classListTb = classTbView;
    self.classListTb.delegate = self;
    self.classListTb.dataSource = self;
    [classView addSubview:self.classListTb];
    
#pragma mark-collectionView
    
    //注意：collectionView创建应按照如下方法。一定要有layout参数。initWithFrame
    CGRect collectionViewFrame = CGRectMake(SizeMake_LFL(80, 0).width, 0, DEVICE_WIDTH-SizeMake_LFL(80, 0).width, DEVICE_HEIGHT);
    shopClassCollectionViewFlowLayout* flowLayout= [[shopClassCollectionViewFlowLayout alloc]init];
    UICollectionView* shopClassCollectionView = [[UICollectionView alloc]initWithFrame:collectionViewFrame collectionViewLayout:flowLayout];
    self.shopClassCollectionView = shopClassCollectionView;
    [self.view addSubview:self.shopClassCollectionView];
    
    //注册cell
    [self.shopClassCollectionView registerClass:[shopClassCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    self.shopClassCollectionView.delegate = self;
    self.shopClassCollectionView.dataSource = self;
    
    self.shopClassCollectionView.backgroundColor = [UIColor whiteColor];
    
    //自适应大小
    self.shopClassCollectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    //在售品牌界面
    saleView = [[UIView alloc]initWithFrame:CGRectMake(DEVICE_WIDTH, 0, DEVICE_WIDTH, DEVICE_HEIGHT-300)];
    [self.view addSubview:saleView];
    saleView.backgroundColor = [UIColor whiteColor];
    
    UITableView * saleTbView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT-300) style:UITableViewStylePlain];
    
    self.saleTbView = saleTbView;
    self.saleTbView.delegate = self;
    self.saleTbView.dataSource = self;
    [saleView addSubview:self.saleTbView];
    
    
    


    
}
-(void)viewWillAppear:(BOOL)animated{
    
    [self getInfo];
}
-(void)getInfo{
    
    NSString *url=app_url @"GoodsSort";
    
//    NSDictionary * param=@{@""};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [self getClassModel:[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil]];
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
-(void)getClassModel:(NSDictionary *)dic{

    [self.classListArr removeAllObjects];
    if (_progressHUD)
    {
        [_progressHUD removeFromSuperview];
        _progressHUD = nil;
    }
    NSLog(@"%@",dic);
    
    for (NSDictionary * dict in [dic objectForKey:@"Data"]) {
        NSLog(@"%@",dict);
       classListModel * model = [[classListModel alloc]init];
        model.rootID = [dict objectForKey:@"rootId"] ;
        NSLog(@"%@",model.rootID);
        model.rootTitle = [dict objectForKey:@"rootTitle"];
        [self.classListArr addObject:model];
        
    }
    [self.classListTb reloadData];
    [self.classListTb selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
    
    self.classListTypeNum = self.classListArr[0].rootID;
    
    [self getClassListDetailInfo];

    
}

-(void)getClassListDetailInfo{
    
    NSLog(@"%@",self.classListTypeNum);
    
    NSString *url=app_url @"SegmentationSort";
    
    NSDictionary * param=@{@"rootId":self.classListTypeNum};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:url parameters:param progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [self classDetailMothod:[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil]];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败：%@",error);
    }];
    
    
    _progressHUD2 = [[MBProgressHUD alloc] initWithView:self.view];
    _progressHUD2.dimBackground = NO;
    [self.view addSubview:_progressHUD2];
    [self.view bringSubviewToFront:_progressHUD2];
    _progressHUD2.delegate = self;
    _progressHUD2.labelText = @"加载中...";
    [_progressHUD2 show:YES];
}
-(void)classDetailMothod:(NSDictionary *)dic{
    [self.shopClassDetailModelArr removeAllObjects];

    if (_progressHUD2)
    {
        [_progressHUD2 removeFromSuperview];
        _progressHUD2 = nil;
    }
    NSDictionary * dataDic = [dic objectForKey:@"Data"];
    for (NSDictionary*detailDic in dataDic) {
        shopClassDetailModel * detailModel = [shopClassDetailModel modelWithDict:detailDic];
        [self.shopClassDetailModelArr addObject:detailModel];
    }
    [self.shopClassCollectionView reloadData];
    
    NSLog(@"%@",dic);
}
-(void)getSaleBrandInfo{
    
//    NSString *url=app_url @"BrandSort";
//    http://www.jinyuankeji.net/VF/portal/CommodityAction/BrandSort
    NSString *url =@"http://www.jinyuankeji.net/VF/portal/CommodityAction/BrandSort";
//    NSDictionary * param=@{<#@"state":@"-1",@"pageindex":@"1"#>};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [self getSaleBrandMethod:[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil]];
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
-(void)getSaleBrandMethod:(NSDictionary *)dic{
    [self.BrandSortArr removeAllObjects];
    if (_progressHUD)
    {
        [_progressHUD removeFromSuperview];
        _progressHUD = nil;
    }
    for (NSDictionary * headDic in [dic objectForKey:@"Data"]) {
        [self.headViewArr addObject:(NSString*)headDic];
        
        for (NSDictionary * detailDic in [[dic objectForKey:@"Data"] objectForKey:headDic]) {
            saleBrandModel * model = [saleBrandModel modelWithDict:detailDic];
            [self.BrandSortArr addObject:model];
        }

    }
    NSLog(@"%@",self.headViewArr[1]);

    
    [self.saleTbView reloadData];

}



-(void)segClassClicked:(UISegmentedControl*)sender{
    NSInteger index =[sender selectedSegmentIndex];
    switch (index) {
  
        case 0:
        {
            [UIView animateWithDuration:0.2 animations:^{
                classView.frame = CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT-64);
                self.classListTb.frame =CGRectMake(0, 0, SizeMake_LFL(80, 1).width, DEVICE_HEIGHT-64);
                self.shopClassCollectionView.frame = CGRectMake(SizeMake_LFL(80, 1).width, 0, DEVICE_WIDTH-SizeMake_LFL(80, 1).width, DEVICE_HEIGHT-64);
                
                
                saleView.frame = CGRectMake(DEVICE_WIDTH, 0, DEVICE_WIDTH, DEVICE_HEIGHT-64);

                self.saleTbView.frame = CGRectMake(DEVICE_WIDTH, 0, DEVICE_WIDTH, DEVICE_HEIGHT-64);

//                classView.hidden = NO;
//                saleView.hidden = YES;
            }];

            
        }
            break;
        case 1:{
            [UIView animateWithDuration:0.2 animations:^{
                classView.frame = CGRectMake(-DEVICE_WIDTH, 0, DEVICE_WIDTH, DEVICE_HEIGHT-64);
                saleView.frame = CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT-64);
//                saleView.backgroundColor = [UIColor blueColor];
                self.classListTb.frame =CGRectMake(-DEVICE_WIDTH, 0, SizeMake_LFL(80, 1).width, DEVICE_HEIGHT-64);
                self.shopClassCollectionView.frame = CGRectMake(-DEVICE_WIDTH+SizeMake_LFL(80, 1).width, 0, DEVICE_WIDTH-SizeMake_LFL(80, 1).width, DEVICE_HEIGHT-64);
                self.saleTbView.frame =CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT-64);
                [self getSaleBrandInfo];
                //            classView.hidden = YES;
                //            saleView.hidden = NO;
            }];

        }
            
        default:
            break;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView==self.classListTb) {
        return self.classListArr.count;
    }
    else if (tableView==self.saleTbView){
//        return self.BrandSortArr.count;
        return 1;
    }
    else{
        return 0;
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (tableView==self.saleTbView) {
        return headArr.count;
    }
//    else{
//        return 1;
//    }
    return 1;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (tableView==self.saleTbView) {
//        NSLog(@"%@",self.headViewArr[section]);
//        return self.headViewArr[section];
        return headArr[section];
    }
    else{
        return nil;
    }
    return @"11";
}
//索引
-(NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    if (tableView==self.saleTbView) {
//        if (self.headViewArr.count==0) {
//            return nil;
//        }else{
//            NSLog(@"%@",self.headViewArr[0]);
//        return  self.headViewArr;
//        }
//        return  self.headViewArr;
        return headArr;
    }
    else{
        return nil;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView==self.classListTb) {
        self.classListTypeNum = self.classListArr[indexPath.row].rootID;
        [self getClassListDetailInfo];
    }
    else if (tableView == self.saleTbView){
        sortNameViewController * vc = [[sortNameViewController alloc]init];
        vc.sortId = self.shopClassDetailModelArr[indexPath.row].segId;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else{
        return;
    }
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView==self.classListTb) {
        return 70;
    }
//    else if (tableView==self.foodDetailTableView){
//        return [foodDetailCell cellHeight];
//    }
    return 70;
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (tableView == self.classListTb) {
//        ((foodDetailCell*)cell).detailModel =self.shopDetailInfoArr[indexPath.row];
//        
//        NSLog(@"------%@",((foodDetailCell*)cell).detailModel.Name);
//        NSLog(@"------%@",((foodDetailCell*)cell).detailModel.isDelete);
//        
//    }
//    else{
//        return;
//    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.classListTb) {
        UITableViewCell * classListCell = [tableView dequeueReusableCellWithIdentifier:@"classListCell"];
        if (classListCell == nil){
            classListCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"classListCell"];
            
            classListCell.backgroundColor = [UIColor colorWithRed:230.0/255 green:230.0/255 blue:236.0/255 alpha:0.5];
            UIView * view = [[UIView alloc]initWithFrame:classListCell.frame];
            view.backgroundColor = [UIColor whiteColor];
            classListCell.selectedBackgroundView = view;
            
            //            NSLog(@"%@",self.shopClassArr[0]);
            
        }
        classListCell.textLabel.text = self.classListArr[indexPath.row].rootTitle;
        return classListCell;
    }
    else if (tableView == self.saleTbView){
        

        UITableViewCell * saleCell = [tableView dequeueReusableCellWithIdentifier:@"saleCell"];
        if (saleCell == nil){
            saleCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"saleCell"];
            
            saleCell.backgroundColor = [UIColor colorWithRed:230.0/255 green:230.0/255 blue:236.0/255 alpha:0.5];
            UIView * view = [[UIView alloc]initWithFrame:saleCell.frame];
            view.backgroundColor = [UIColor whiteColor];
            saleCell.selectedBackgroundView = view;
            saleCell.textLabel.text = titleArr[indexPath.section];
            
            //            NSLog(@"%@",self.shopClassArr[0]);
            
        }
        return saleCell;
        
        
        
    }
    return nil;
    
}

#pragma mark - CollectionViewCell的代理方法实现
-(void)collectionViewCell:(shopClassCollectionViewCell *)cell withButtonClicked:(UIButton *)button{
    
    NSLog(@"测试[%@]的button点击,么么哒！！！！",cell.label.text);
}

#pragma mark - CollectionView的数据源代理
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.shopClassDetailModelArr.count;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    shopClassCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
//    cell.delegate = self;
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    
    shopClassCollectionViewCell* collectionViewCell = (shopClassCollectionViewCell*)cell;
    [collectionViewCell sizeToFit];

    [collectionViewCell.imageView sd_setImageWithURL:[NSURL URLWithString:self.shopClassDetailModelArr[indexPath.row].segImg]];
                                                      
    collectionViewCell.label.text = self.shopClassDetailModelArr[indexPath.row].segTitle;
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"您点击的cell编号为：%ld",indexPath.item);
    sortNameViewController * vc = [[sortNameViewController alloc]init];
    vc.sortId = self.shopClassDetailModelArr[indexPath.row].segId;
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
