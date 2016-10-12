//
//  otherAdressVC.m
//  VFShoppingMall
//
//  Created by gushi on 16/10/3.
//  Copyright © 2016年 jinyuankeji. All rights reserved.
//

#import "otherAdressVC.h"
#import "FrameMainLFL.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"
#import "addressModel.h"
#import "ShippingAddressViewController.h"


@interface otherAdressVC ()<MBProgressHUDDelegate>
@property (nonatomic,strong) MBProgressHUD*progressHUD;
@property (nonatomic,strong) NSMutableArray<addressModel*> * addressArr;
@property (nonatomic,weak) UIScrollView * mainScrollView;
@property (nonatomic,weak) UIButton * tmpBtn;



@end

@implementation otherAdressVC{
    int selectNum;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout =UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"地址";
    self.addressArr = [NSMutableArray array];
    UIScrollView * mainScrollView= [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT-SizeMake_LFL(50, 1).width-65)];
    self.mainScrollView = mainScrollView;
    [self.view addSubview:self.mainScrollView];
    
    UIButton * addAddressBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addAddressBtn.frame = CGRectMake(0, DEVICE_HEIGHT-64-SizeMake_LFL(44, 44).height, DEVICE_WIDTH, SizeMake_LFL(44, 44).height);
    [addAddressBtn setBackgroundColor:[UIColor colorWithRed:255.0/255 green:185.0/255  blue:2.0/255  alpha:1]];
    [addAddressBtn setTitle:@"添加收货地址" forState:UIControlStateNormal];
    addAddressBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [addAddressBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [addAddressBtn addTarget:self action:@selector(addAddressBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addAddressBtn];
    

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self getAdressInfo];
    
}

-(void)getAdressInfo{
    //http://www.jinyuankeji.net/VF/portal/OrderAction/
    NSString *url= @"http://www.jinyuankeji.net/VF/portal/OrderAction/AddressList";
    
    NSDictionary * param=@{@"userId":@"1"};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:url parameters:param progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [self getAdressMethod:[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil]];
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
-(void)getAdressMethod:(NSDictionary *)dic{
    [self.addressArr removeAllObjects];
    
    if (_progressHUD)
    {
        [_progressHUD removeFromSuperview];
        _progressHUD = nil;
    }
    NSLog(@"%@",dic);
    for (NSDictionary * dataDic in [dic objectForKey:@"Data"]) {
        addressModel * model = [addressModel modelWithDict:dataDic];
        [self.addressArr addObject:model];
    }
    [self setUpViews];
}
//xuan@2x
//xuanhuang@2x

//375*88
-(void)setUpViews{
    int addressY = 0;
    for (int i=0; i<self.addressArr.count; i++) {
        UIView * addressView = [[UIView alloc]initWithFrame:RectMake_LFL(0, addressY, 375, 125)];
        [self.mainScrollView addSubview:addressView];
        UIButton * xuanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [xuanBtn setBackgroundImage:[UIImage imageNamed:@"xuan"] forState:UIControlStateNormal];
        [xuanBtn setBackgroundImage:[UIImage imageNamed:@"xuanhuang"] forState:UIControlStateSelected];
        xuanBtn.frame = RectMake_LFL(15, 47.5, 15, 15);
        [xuanBtn addTarget:self action:@selector(xuanBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        xuanBtn.tag = i;

        [addressView addSubview:xuanBtn];
        UILabel * nameLable = [[UILabel alloc]initWithFrame:RectMake_LFL(45, 15, 90, 18)];
        nameLable.text = self.addressArr[i].Name;
        
        [addressView addSubview:nameLable];
        
        UILabel * phoneLable = [[UILabel alloc]initWithFrame:RectMake_LFL(150, 15, 200, 18)];
        phoneLable.text = self.addressArr[i].phone;
        [addressView addSubview:phoneLable];
        
        UILabel * addressLable = [[UILabel alloc]initWithFrame:RectMake_LFL(45, 15+18+20, 300, 40)];
        addressLable.numberOfLines = 0;
        addressLable.text = self.addressArr[i].address;
        [addressView addSubview:addressLable];
        
        UILabel * timeLabel = [[UILabel alloc]initWithFrame:RectMake_LFL(45, CGRectGetMaxY(addressLable.frame), 200, 18)];
        timeLabel.text = self.addressArr[i].time;
        [addressView addSubview:timeLabel];
        
        UIButton * editingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [editingBtn setTitle:@"编辑" forState:UIControlStateNormal];
        editingBtn.frame = RectMake_LFL(375-50, 125-50, 50, 50);
        [editingBtn addTarget:self action:@selector(editingClicked:) forControlEvents:UIControlEventTouchUpInside];
        [editingBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        editingBtn.tag = i+self.addressArr.count;
        [addressView addSubview:editingBtn];
        
        if (i<self.addressArr.count-1) {
            UIView * lineView = [[UIView alloc]initWithFrame:RectMake_LFL(45, 124, 375-30, 1)];
            lineView.backgroundColor = [UIColor lightGrayColor];
            [addressView addSubview:lineView];
            
        }
        addressY += 125;
        
    }
    
    
    
}
-(void)xuanBtnClicked:(UIButton*)btn{
    if (_tmpBtn == nil){
        btn.selected = YES;
        _tmpBtn = btn;
    }
    else if (_tmpBtn !=nil && _tmpBtn == btn){
        btn.selected = YES;
        
    }
    else if (_tmpBtn!= btn && _tmpBtn!=nil){
        _tmpBtn.selected = NO;
        btn.selected = YES;
        _tmpBtn = btn;
    }
    
}


-(void)editingClicked:(UIButton *)btn{
    ShippingAddressViewController * vc =[[ShippingAddressViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)addAddressBtnClicked{
    
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
