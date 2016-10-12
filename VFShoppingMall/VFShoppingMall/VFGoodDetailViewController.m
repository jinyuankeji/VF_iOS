//
//  VFGoodDetailViewController.m
//  DKDJForDeliver
//
//  Created by 张允鹏 on 16/9/28.
//  Copyright © 2016年 gushi. All rights reserved.
//

#import "VFGoodDetailViewController.h"
#import "VFAssessListViewController.h"
#import "UIImageView+WebCache.h"
#import "MBProgressHUD.h"
#import "AFNetworking.h"
#import "FrameAutoScaleLFL.h"
#import "VFGoodModel.h"
#import "allCommentVC.h"

@interface VFGoodDetailViewController ()<MBProgressHUDDelegate>

@property (nonatomic,strong) NSString * storeTitle;

@property (nonatomic,strong) MBProgressHUD * progressHUD;
//测试
@property (nonatomic,strong) NSMutableArray * goodsArr;

@property (nonatomic,weak) VFGoodModel * model;

@property (nonatomic,assign) CGFloat height;

@property (nonatomic,assign) BOOL isCollect;

@property (nonatomic,weak) UIButton * collectBtn;

@property (nonatomic,weak) UIView * goodInfoAndsaledView;

@property (nonatomic,weak) UIScrollView * myScrollView;
@property (nonatomic,strong) UIImageView * imgDetailView;



@end

@implementation VFGoodDetailViewController{
    UIView * chartView;
    UIButton * lastTypeBtn;
  
    UITextField * countTextField;

}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"商品详细";
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadToolBarView];
    [self getGoodData];
    self.edgesForExtendedLayout =UIRectEdgeNone;
}
-(void)loadToolBarView{
    
    
    UIButton * btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(DEVICE_WIDTH-140,DEVICE_HEIGHT-60-64+10, 130, 40);
    [btn setBackgroundColor:[UIColor colorWithRed:254.0/255.0 green:227.0/255.0 blue:159.0/255.0 alpha:1]];
    [btn setTitle:@"立刻购买" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(buyBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    btn.tag=1;
    [self.view addSubview:btn];
    
    btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(DEVICE_WIDTH-140-140,DEVICE_HEIGHT-60-64+ 10, 130, 40);
    [btn setBackgroundColor:[UIColor colorWithRed:253.0/255.0 green:184.0/255.0 blue:44.0/255.0 alpha:1]];
    btn.tag=2;
    [btn addTarget:self action:@selector(buyBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"加入购物车" forState:UIControlStateNormal];
    [self.view addSubview:btn];
}
-(void)getGoodData{
    
//    NSString * url=@"http://www.jinyuankeji.net//VF/index.php?g=&m=CommodityAction&a=CommodityDetail&userId=1";
    NSString * url=@"http://www.jinyuankeji.net/VF/portal/CommodityAction/CommodityDetail?userId=1";
    
//    NSDictionary * param=@{@"goodsId":self.goodId};
    NSDictionary * param=@{@"goodsId":@"1"};
//    http://www.jinyuankeji.net/VF/portal/CommodityAction/CommodityDetail?userId=1&goodsId=1
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:url parameters:param progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (_progressHUD){
            [_progressHUD removeFromSuperview];
        }
        NSString * str=[[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"%@",str);
        str=[str stringByReplacingOccurrencesOfString:@"null" withString:@"\"\""];
        NSLog(@"%@",str);
        
        NSData * data=[str dataUsingEncoding:NSUTF8StringEncoding];
        [self goodDetailDidReceive:[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil]];
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

-(void)goodDetailDidReceive:(NSDictionary * )dict{
    NSLog(@"%@",dict);
    
    if (![[dict objectForKey:@"Status"] isEqualToString:@"true"]) {
        // 给个alter
        return;
    }
    VFGoodModel * model1= [VFGoodModel modelWithDict:dict];
    self.model =model1;
    NSLog(@"%@",self.model.collectState);
    [self loadScrollView];
}
-(void)loadScrollView{
    self.edgesForExtendedLayout =UIRectEdgeNone;
    
    UIScrollView * scrollView=[[UIScrollView alloc]initWithFrame:RectMake_LFL(0, 0, 375, 667- 60-64)];
    [self.view addSubview: scrollView];
    
    UIImageView * imgView=[[UIImageView alloc]initWithFrame:RectMake_LFL(0, 0, 375, 667.0/2)];
    [imgView sd_setImageWithURL:[NSURL URLWithString:_model.goodsPicture] placeholderImage:[UIImage imageNamed:@"_02"]];
    
    [scrollView addSubview:imgView];
    
    _height=667.0/2;
    
    UIView * lineView=[[UIView alloc]initWithFrame:RectMake_LFL(0, _height, 375, 1)];
    lineView.backgroundColor=[UIColor lightGrayColor];
    [scrollView addSubview: lineView];
    
    _height += 20;
    //价格
    UILabel * label=[[UILabel alloc]initWithFrame:RectMake_LFL(15, _height, 200, 37)];
    label.font=[UIFont systemFontOfSize:16];
    NSString * str=[NSString stringWithFormat:@"￥%.2f   ",self.model.price];
    NSInteger  strLen1=str.length;
    str=[NSString stringWithFormat:@"%@￥%.2f",str,self.model.originalPrice];
    NSMutableAttributedString * aStr=[[NSMutableAttributedString alloc]initWithString:str];
    
    [aStr addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(strLen1, str.length-strLen1)];
    
    [aStr addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(strLen1, str.length-strLen1)];
    
    label.attributedText =aStr;
    [scrollView addSubview:label];
    
    lineView=[[UIView alloc]initWithFrame:RectMake_LFL(290, _height, 1, 37)];
    lineView.backgroundColor=[UIColor lightGrayColor];
    [scrollView addSubview: lineView];
    //收藏按钮
    UIButton * btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=RectMake_LFL(290+(375-290-30)/2, _height +3.5, 30, 30);
    [btn addTarget:self action:@selector(collectBtnclick) forControlEvents:UIControlEventTouchUpInside];
    NSLog(@"collectState:%@",self.model.collectState);
    if ([self.model.collectState isEqualToString:@"已收藏"]) {
        _isCollect=YES;
        [btn setImage:[UIImage imageNamed:@"good_collect"] forState:UIControlStateNormal];
    }else{
        [btn setImage:[UIImage imageNamed:@"good_no_collect"] forState:UIControlStateNormal];
    }
    _collectBtn=btn;
    [scrollView addSubview:btn];
    
    
    _height +=42;
    
    label=[[UILabel alloc]initWithFrame:RectMake_LFL(15, _height, 200, 16)];
    label.font=[UIFont systemFontOfSize:15];
    label.text=self.model.storeTitle;
    [scrollView addSubview:label];
    
    _height +=28;
    
    lineView=[[UIView alloc]initWithFrame:RectMake_LFL(0, _height,375, 1)];
    lineView.backgroundColor=[UIColor colorWithRed:240.0/255.0 green:244.0/255.0 blue:243.0/255.0 alpha:1];
    [scrollView addSubview: lineView];
    _height +=17;
    
    CGFloat tagWidth= 355/3;
    
    if (self.model.tagListArr.count) {
        for (int i=0; i<self.model.tagListArr.count; i++) {
            
            UIView * view=[[UIView alloc]initWithFrame:RectMake_LFL(15 + tagWidth* (i%3 ), _height + 25*(i/3), tagWidth, 15)];
            [scrollView addSubview:view];
            
            UIImageView * imgView=[[UIImageView alloc]initWithFrame:RectMake_LFL(0, 0, 15, 15)];
            imgView.image=[UIImage imageNamed:@"dian"];
            [view addSubview:imgView];
            
            label =[[UILabel alloc]initWithFrame:RectMake_LFL(22, 0, tagWidth-22, 15)];
            label.font=[UIFont systemFontOfSize:14];
            label.text=self.model.tagListArr[i].tagTitle;
            [view addSubview:label];
        }
        _height += (self.model.tagListArr.count/3+1)*25;
        _height+=5;
        
        lineView=[[UIView alloc]initWithFrame:RectMake_LFL(0, _height,375, 8)];
        lineView.backgroundColor=[UIColor colorWithRed:240.0/255.0 green:244.0/255.0 blue:243.0/255.0 alpha:1];
        [scrollView addSubview: lineView];
        _height +=8;
    }

    
    
    _height +=10;
    
    UIView * blockView=[[UIView alloc]initWithFrame:RectMake_LFL(20, _height, 5, 16)];
    blockView.backgroundColor=[UIColor colorWithRed:253.0/255.0 green:148.0/255.0 blue:44.0/255.0 alpha:1];
    [scrollView addSubview:blockView];
    
    label =[[UILabel alloc]initWithFrame:RectMake_LFL(35, _height, 200, 15)];
    label.font=[UIFont systemFontOfSize:15];
    label.text=[NSString stringWithFormat:@"商品评价（%ld）",(long)self.model.assessNum];
    [scrollView addSubview:label];
    _height +=30;
    NSArray * arr1=@[@"好评",@"中评",@"差评"];
    NSArray * arr2=@[[NSString stringWithFormat:@"%@",self.model.assess_good] ,[NSString stringWithFormat:@"%@",self.model.assess_middle] ,[NSString stringWithFormat:@"%@",self.model.assess_bad]];
    for (int i=0; i<3; i++) {
        label =[[UILabel alloc]initWithFrame:RectMake_LFL(20 + 110 *i,_height,90, 23)];
        label.font=[UIFont systemFontOfSize:15];
        label.text=[NSString stringWithFormat:@"%@(%@)",arr1[i],arr2[i]];
        label.textAlignment=NSTextAlignmentCenter;
        label.backgroundColor=[UIColor colorWithRed:254.0/255.0 green:227.0/255.0 blue:159.0/255.0 alpha:1];
        [scrollView addSubview:label];
    }
    _height +=80-30;
    //254 227 159
    lineView=[[UIView alloc]initWithFrame:RectMake_LFL(13, _height,375-26, 5)];
    lineView.backgroundColor=[UIColor colorWithRed:240.0/255.0 green:244.0/255.0 blue:243.0/255.0 alpha:1];
    [scrollView addSubview: lineView];
    _height +=5;
    
    if (self.model.assessListArr.count) {

        VFAssessModel * model = self.model.assessListArr[0];
        UIView * view=[[UIView alloc]initWithFrame:RectMake_LFL(0, _height, 375, 115)];
        [scrollView addSubview:view];
        _height +=115;
        //头像
        UIImageView * imgView=[[UIImageView alloc]initWithFrame:RectMake_LFL(8, 8, 25, 25)];
        [imgView sd_setImageWithURL:[NSURL URLWithString:model.headerImgURL] placeholderImage:nil];
        imgView.backgroundColor=[UIColor grayColor];
        [view addSubview:imgView];
        //用户名
        label =[[UILabel alloc]initWithFrame:RectMake_LFL(16+25, 8, 200, 25)];
        label.font=[UIFont systemFontOfSize:12];
        label.text=model.assessNickName;
        [view addSubview:label];
        // 评论
        label =[[UILabel alloc]initWithFrame:RectMake_LFL(8, 55, 200, 12)];
        label.font=[UIFont systemFontOfSize:12];
        label.text=model.content;
        [view addSubview:label];
        
        label =[[UILabel alloc]initWithFrame:RectMake_LFL(8, 85, 200, 12)];
        label.font=[UIFont systemFontOfSize:12];
        label.text=model.createTime;
        label.textColor=[UIColor lightGrayColor];
        [view addSubview:label];
        
        UIButton * btn=[[UIButton alloc]initWithFrame:RectMake_LFL((375-118)/2, _height, 118, 27)];
        btn.titleLabel.font=[UIFont systemFontOfSize:12];
        [btn addTarget:self action:@selector(moreAssessBtn:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:@"查看全部评论" forState:UIControlStateNormal];
        [btn.layer setMasksToBounds:YES];
        [btn.layer setCornerRadius:8];
        [btn.layer setBorderWidth:1];
        [btn.layer setBorderColor:[UIColor colorWithRed:253.0/255.0 green:184.0/255.0 blue:44.0/255.0 alpha:1].CGColor];
        [btn setTitleColor:[UIColor colorWithRed:253.0/255.0 green:184.0/255.0 blue:44.0/255.0 alpha:1] forState:UIControlStateNormal];;
        [scrollView addSubview:btn];
        
        _height += 27+10;
        lineView=[[UIView alloc]initWithFrame:RectMake_LFL(1, _height,375, 1)];
        lineView.backgroundColor=[UIColor colorWithRed:240.0/255.0 green:244.0/255.0 blue:243.0/255.0 alpha:1];
        [scrollView addSubview: lineView];
        
        
    }
    _height +=15;
    UISegmentedControl * segment=[[UISegmentedControl alloc]initWithFrame:RectMake_LFL(15, _height, 345, 35)];
    [segment insertSegmentWithTitle:@"商品信息" atIndex:0 animated:YES];
    [segment insertSegmentWithTitle:@"咨询与售后" atIndex:1 animated:YES];
    [segment setTintColor:[UIColor colorWithRed:80.0/255.0 green:94.0/255.0 blue:108.0/255.0 alpha:1]];
    [segment addTarget:self action:@selector(goodInfoAndSaled:) forControlEvents:UIControlEventValueChanged];
    [segment setSelectedSegmentIndex:0];
    [scrollView addSubview:segment];
    
//    80 94 108
    _height +=50;
    
    UIView * view=[[UIView alloc]init];
    [scrollView addSubview:view];
    _myScrollView=scrollView;
    
    _goodInfoAndsaledView=view;
    
    [self goodInfoAndSaled:segment];
    
}
-(void)moreAssessBtn:(UIButton *)btn{
//    VFAssessListViewController * vc=[[VFAssessListViewController alloc]init];
//    vc.modelArr=self.model.assessListArr;
//    [self.navigationController pushViewController:vc animated:YES];
    allCommentVC * vc = [[allCommentVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - 商品信息 售后
-(void)goodInfoAndSaled:(UISegmentedControl *)segment{
    __block CGFloat h=0;

    for ( UIView * view in _goodInfoAndsaledView.subviews) {
        [view removeFromSuperview];
    }
    if (segment.selectedSegmentIndex==0) {
        self.imgDetailView=[[UIImageView alloc]init];
//        [imgDetailView sd_setImageWithURL:[NSURL URLWithString:_model.goodsDeatilsImage] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//            if (image) {
//                CGFloat imageH =(image.size.height/image.size.width) * 375;
//                NSLog(@"%f",imageH);
//                imgDetailView.frame=RectMake_LFL(0, 0,375,imageH );
//                h+=imageH;
//            }
//           
//        }];
//        [self.imgDetailView sd_setImageWithURL:[NSURL URLWithString:_model.goodsDeatilsImage]];
//        self.imgDetailView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_model.goodsDeatilsImage]]];
        self.imgDetailView.image = [UIImage imageNamed:@"57f60151335f4"];
        self.imgDetailView.frame = RectMake_LFL(0, 0, 375, 333);
        [_goodInfoAndsaledView addSubview:self.imgDetailView];
        h+=333;
        
    }else{
        UILabel * label=[[UILabel alloc]initWithFrame:RectMake_LFL(15, h, 375, 40)];
        label.text=@"退货说明";
        label.font=[UIFont systemFontOfSize:16];
        [_goodInfoAndsaledView addSubview:label];
        h+=40;
        NSDictionary * attr = @{NSFontAttributeName:[UIFont systemFontOfSize:16]};
        CGFloat H =[_model.returnNote boundingRectWithSize:SizeMake_LFL(345, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil].size.height;
        NSLog(@"%@",_model.returnNote);
        label=[[UILabel alloc]initWithFrame:RectMake_LFL(15, h, 375, H)];
        label.text=_model.returnNote;
        label.numberOfLines=0;
        label.textColor=[UIColor grayColor];
        label.font=[UIFont systemFontOfSize:16];
        [_goodInfoAndsaledView addSubview:label];
        h+=H;
        
        label=[[UILabel alloc]initWithFrame:RectMake_LFL(15, h, 375, 40)];
        label.text=@"换货说明";
        label.font=[UIFont systemFontOfSize:16];
        [_goodInfoAndsaledView addSubview:label];
        h+=40;
        
        attr = @{NSFontAttributeName:[UIFont systemFontOfSize:16]};
        H =[_model.exchangeNote boundingRectWithSize:SizeMake_LFL(345, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil].size.height;
        label=[[UILabel alloc]initWithFrame:RectMake_LFL(15, h, 375, H)];
        label.text=_model.exchangeNote;
        label.numberOfLines=0;
        label.textColor=[UIColor grayColor];
        label.font=[UIFont systemFontOfSize:16];
        [_goodInfoAndsaledView addSubview:label];
        h+=H;
        
        label=[[UILabel alloc]initWithFrame:RectMake_LFL(15, h, 375, 40)];
        label.text=@"售后说明";
        label.font=[UIFont systemFontOfSize:16];
        [_goodInfoAndsaledView addSubview:label];
        h+=40;
        
        attr = @{NSFontAttributeName:[UIFont systemFontOfSize:16]};
        H =[_model.AftermarketNote boundingRectWithSize:SizeMake_LFL(345, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil].size.height;
        label=[[UILabel alloc]initWithFrame:RectMake_LFL(15, h, 375, H)];
        label.text=_model.AftermarketNote;
        label.numberOfLines=0;
        label.textColor=[UIColor grayColor];
        label.font=[UIFont systemFontOfSize:16];
        [_goodInfoAndsaledView addSubview:label];
        h+=H;
        
    }
    _goodInfoAndsaledView.frame=RectMake_LFL(0, _height, 375, h);
    _myScrollView.contentSize=SizeMake_LFL(375, _height+h);
}
#pragma mark - 收藏按钮点击
-(void)collectBtnclick{
    
    NSString * type;
    if (_isCollect==YES) {
        type=@"2";
    }else{
        type=@"1";
    }
    
    
    NSString * urlStr=@"http://www.jinyuankeji.net/VF/portal/CommodityAction/AddCollect?userId=1&goodsId=1&goods_sizeid=22";

//http://www.jinyuankeji.net/VF/portal/CommodityAction/AddCollect?userId=17&goodsId=13&goods_sizeid=22&type=2
    
    NSDictionary * param=@{@"type":type};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:urlStr parameters:param progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [_progressHUD removeFromSuperview];
        NSDictionary * dict =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        if ([[dict objectForKey:@"returnCode"] isEqualToString:@"1"]) {
            
            _isCollect =!_isCollect;
            if (_isCollect) {
                [_collectBtn setImage:[UIImage imageNamed:@"good_collect"] forState:UIControlStateNormal];
            }else{
                [_collectBtn setImage:[UIImage imageNamed:@"good_no_collect"] forState:UIControlStateNormal];
            }
        }
        
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
-(void)buyBtnClick:(UIButton *)btn{
    if (btn.tag==1) {//立刻购买
        [self addShopChartViewWithBuyNow:YES];
    }else{
        [self addShopChartViewWithBuyNow:NO];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)addShopChartViewWithBuyNow:(BOOL )isBuyNow{
    [chartView removeFromSuperview];
    chartView=nil;
    
    chartView=[[UIView alloc]initWithFrame:CGRectMake(0, DEVICE_HEIGHT-64, DEVICE_WIDTH,DEVICE_HEIGHT )];
    chartView.backgroundColor=[UIColor clearColor];
    [self.view addSubview:chartView];
    
    UIButton* shadowBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [shadowBtn setBackgroundColor:[UIColor blackColor]];
    shadowBtn.alpha=0.15;
    shadowBtn.frame=CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT-450);
    [shadowBtn addTarget:self action:@selector(removeChartView) forControlEvents:UIControlEventTouchUpInside];
    [chartView addSubview:shadowBtn];
    
    UIView * whiteView=[[UIView alloc]initWithFrame:RectMake_LFL(0, 667-450, 375, 450)];
    whiteView.backgroundColor=[UIColor whiteColor];
    [chartView addSubview:whiteView];
    
    UIImageView * iconImgView=[[UIImageView alloc]initWithFrame:RectMake_LFL(10, 667-450-15, 90, 90)];
    iconImgView.backgroundColor=[UIColor yellowColor];
    iconImgView.layer.masksToBounds=YES;
    iconImgView.layer.cornerRadius=8;
    iconImgView.layer.borderWidth=4;
    iconImgView.layer.borderColor=[UIColor whiteColor].CGColor;
    [iconImgView sd_setImageWithURL:[NSURL URLWithString:_model.goodsPicture] placeholderImage:nil];
    [chartView addSubview:iconImgView];
    
    CGFloat y=10;
    
    UILabel * label=[[UILabel alloc]initWithFrame:RectMake_LFL(110, y, 200, 18)];
    label.font=[UIFont systemFontOfSize:16];
    label.text=[NSString stringWithFormat:@"￥%.2f",_model.price];
    y+=20;
    [whiteView addSubview: label];
    label.textColor=[UIColor redColor];
    
    label=[[UILabel alloc]initWithFrame:RectMake_LFL(110, y, 200, 18)];
    label.font=[UIFont systemFontOfSize:16];
    label.text=[NSString stringWithFormat:@"库存%.0f件",_model.price];
#pragma mark - 建议在json 中  有个model.sellerCount;
    y+=20;
    [whiteView addSubview: label];
    
    label=[[UILabel alloc]initWithFrame:RectMake_LFL(110, y, 200, 18)];
    label.font=[UIFont systemFontOfSize:16];
    label.text=@"请选择规格或颜色";
    y+=18;
    [whiteView addSubview: label];
    
    y+=15;
    
    UIView * line=[[UIView alloc]initWithFrame:RectMake_LFL(0, y, 375, 1)];
    line.backgroundColor=[UIColor lightGrayColor];
    [whiteView addSubview:line];
    y+=30;
//    for (VFGoodSizeModel  * model in _model.SizeListArr)

    CGFloat upX=10;
    int tag=0;
    NSArray * sizearr = [[NSArray alloc] initWithObjects:@"S",@"M",@"L",@"蓝色",@"红色",@"湖蓝色",@"咖啡色",@"蓝色",@"红色",@"湖蓝色",@"咖啡色",nil];
    for (NSString   * str in sizearr) {
        NSDictionary *dic = [NSDictionary dictionaryWithObject:[UIFont boldSystemFontOfSize:14] forKey:NSFontAttributeName];
        CGSize size = [str sizeWithAttributes:dic];
        //NSLog(@"%f",size.height);
        
        if ( upX +50 + size.width > DEVICE_WIDTH) {
            upX = 10;
            y += 30;
        }
        UIButton *btn= [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(upX, y, size.width+30,25);
        [btn setBackgroundColor:[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1]];
        [btn setTitleColor:[UIColor blackColor] forState:0];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        [btn setTitle:str forState:0];
        btn.layer.cornerRadius = 8;
        btn.layer.borderColor = [UIColor clearColor].CGColor;
        btn.layer.borderWidth = 0;
        [btn.layer setMasksToBounds:YES];
        
        [whiteView addSubview:btn];

        [btn addTarget:self action:@selector(typeBtn:) forControlEvents:UIControlEventTouchUpInside];
        if (tag==0) {
            [btn setBackgroundColor:[UIColor colorWithRed:253.0/255.0 green:184.0/255.0 blue:44.0/255.0 alpha:1]];
            lastTypeBtn=btn;
        }
        tag++;
        upX+=size.width+40;
        
    }
    y+= 30;
    line=[[UIView alloc]initWithFrame:RectMake_LFL(0, y, 375, 1)];
    line.backgroundColor=[UIColor lightGrayColor];
    [whiteView addSubview:line];
    
    label=[[UILabel alloc]initWithFrame:RectMake_LFL(10, y, 200, 45)];
    label.font=[UIFont systemFontOfSize:16];
    label.text=@"购买数量";
    [whiteView addSubview: label];
    
    UIButton * btn=[[UIButton alloc]initWithFrame:RectMake_LFL(375-45, y+10, 35, 25)];
    btn.backgroundColor=[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    [btn setTitle:@"+" forState:UIControlStateNormal];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:18]];
    btn.tag=1;
    [btn addTarget:self action:@selector(coutBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitleColor:[UIColor blackColor] forState:0];
    [whiteView addSubview:btn];
    
    countTextField=[[UITextField alloc]initWithFrame:RectMake_LFL(375-45-45, y+10, 35, 25)];
    countTextField.text=@"0";
    countTextField.textAlignment=NSTextAlignmentCenter;
    countTextField.backgroundColor=[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    [whiteView addSubview:countTextField];
    
    btn=[[UIButton alloc]initWithFrame:RectMake_LFL(375-45-45-45, y+10, 35, 25)];
    btn.backgroundColor=[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    [btn setTitle:@"-" forState:UIControlStateNormal];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:18]];
    btn.tag=2;
    [btn addTarget:self action:@selector(coutBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitleColor:[UIColor blackColor] forState:0];
    [whiteView addSubview:btn];
    
    y+=40;
    line=[[UIView alloc]initWithFrame:RectMake_LFL(0, y, 375, 1)];
    line.backgroundColor=[UIColor lightGrayColor];
    [whiteView addSubview:line];
    
    [UIView animateWithDuration:0.5 animations:^{
        chartView.frame= RectMake_LFL(0, 0, 375,DEVICE_HEIGHT );
    } completion:nil];
    
    btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(0, CGRectGetMaxY(whiteView.bounds)-45-64, DEVICE_WIDTH, 45);
    [btn setTitle:@"确定" forState:0];
    btn.tag =isBuyNow ? 1 : 0;
    [btn addTarget:self action:@selector(chartBuyBtn:) forControlEvents:UIControlEventTouchUpInside];
    [btn setBackgroundColor:mainColor];
    [whiteView addSubview:btn];
}
-(void)chartBuyBtn:(UIButton *)btn{
    if (btn.tag==1) {
        //立刻购买
    }else{
        
    }
}
-(void)coutBtnClick:(UIButton *)btn{
    int count=[countTextField.text intValue];
    if (btn.tag==1) {//+
        if (1) {//库存判断
            count ++ ;
            countTextField.text = [NSString stringWithFormat:@"%d",count];
        }
        
    }else{
        if (count>0) {
            count--;
            countTextField.text = [NSString stringWithFormat:@"%d",count];
        }
    }

}
-(void)typeBtn:(UIButton *)btn{
    if (lastTypeBtn) {
        [lastTypeBtn setBackgroundColor:[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1]];
    }
    [btn setBackgroundColor:[UIColor colorWithRed:253.0/255.0 green:184.0/255.0 blue:44.0/255.0 alpha:1]];
    
    lastTypeBtn=btn;

}
-(void)removeChartView{
    [chartView removeFromSuperview];
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
