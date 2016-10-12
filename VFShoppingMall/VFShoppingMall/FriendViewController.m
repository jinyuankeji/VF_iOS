//
//  ZJVc10Controller.m
//  ZJScrollPageView
//
//  Created by ZeroJ on 16/8/21.
//  Copyright © 2016年 ZeroJ. All rights reserved.
//

#import "FriendViewController.h"
#import "ZJScrollPageView.h"
#import "ZJTestViewController.h"
#import "ZJTest1Controller.h"
#import "FrameMainLFL.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"
#import "brandInfoModel.h"

@interface FriendViewController ()<ZJScrollPageViewDelegate,MBProgressHUDDelegate
>

@property(weak, nonatomic)ZJScrollPageView *scrollPageView;
@property(strong, nonatomic)NSArray<NSString *> *titles;
@property(strong, nonatomic)NSArray<UIViewController<ZJScrollPageViewChildVcDelegate> *> *childVcs;
@property (nonatomic,strong) MBProgressHUD*progressHUD;

@end

@implementation FriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"收藏";
    
    //必要的设置, 如果没有设置可能导致内容显示不正常
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    ZJSegmentStyle *style = [[ZJSegmentStyle alloc] init];
    /// 显示遮盖
    style.showLine = YES;
    
    style.scrollContentView = YES;
    
    style.titleFont = [UIFont systemFontOfSize:26];
    style.titleBigScale = DEVICE_WIDTH/2;
    /// 设置滚动条高度
    
    style.segmentHeight = 50;
    
    //    self.scrollLineColor = [UIColor colorWithRed:255.0/255 green:185.0/255  blue:2.0/255  alpha:1];
    //    selectedTitleColor
    style.scrollLineColor = [UIColor colorWithRed:255.0/255 green:185.0/255  blue:2.0/255  alpha:1];
    style.selectedTitleColor = [UIColor colorWithRed:255.0/255 green:185.0/255  blue:2.0/255  alpha:1];
    
    
//    style.scaleTitle = NO;
//    style.adjustCoverOrLineWidth = YES;
    style.autoAdjustTitlesWidth = YES;
    /// 显示图片 (在显示图片的时候只有下划线的效果可以开启, 其他的'遮盖','渐变',效果会被内部关闭)
//    style.showImage = YES;
    /// 平分宽度
    style.scrollTitle = YES;
    /// 图片位置

//    style.imagePosition = TitleImagePositionTop;
    // 当标题(和图片)宽度总和小于ZJScrollPageView的宽度的时候, 标题会自适应宽度
    
    
    // 初始化
    CGRect scrollPageViewFrame = CGRectMake(0, 64.0, self.view.bounds.size.width, self.view.bounds.size.height - 64.0-49);

    self.titles = @[@"品   牌",
                    @"商   品"
                    ];
    
    ZJScrollPageView *scrollPageView = [[ZJScrollPageView alloc] initWithFrame:scrollPageViewFrame segmentStyle:style titles:_titles parentViewController:self delegate:self];
    self.scrollPageView = scrollPageView;
    // 额外的按钮响应的block
    __weak typeof(self) weakSelf = self;
    self.scrollPageView.extraBtnOnClick = ^(UIButton *extraBtn){
        weakSelf.title = @"点击了extraBtn";
        NSLog(@"点击了extraBtn");
        
    };
    [self.view addSubview:self.scrollPageView];
        
}

-(void)viewWillAppear:(BOOL)animated{
//    [self getBrandCellInfo];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma <#arguments#>
- (NSInteger)numberOfChildViewControllers {
    return self.titles.count;
}

/// 设置图片
- (void)setUpTitleView:(ZJTitleView *)titleView forIndex:(NSInteger)index {
    titleView.normalImage = [UIImage imageNamed:[NSString stringWithFormat:@"normal_%ld", index+1]];
    titleView.selectedImage = [UIImage imageNamed:@"selected"];
}

- (UIViewController<ZJScrollPageViewChildVcDelegate> *)childViewController:(UIViewController<ZJScrollPageViewChildVcDelegate> *)reuseViewController forIndex:(NSInteger)index {
    
    // 根据不同的下标或者title返回相应的控制器, 但是控制器必须要遵守ZJScrollPageViewChildVcDelegate
    // 并且可以通过实现协议中的方法来加载不同的数据
    // 注意ZJScrollPageView不会保证viewWillAppear等生命周期方法一定会调用
    // 所以建议使用ZJScrollPageViewChildVcDelegate中的方法来加载不同的数据
    
    if (index == 0) {
        // 注意这个效果和tableView的deque...方法一样, 会返回一个可重用的childVc
        // 请首先判断返回给你的是否是可重用的
        // 如果为nil就重新创建并返回
        // 如果不为nil 直接使用返回给你的reuseViewController并进行需要的设置 然后返回即可
        ZJTestViewController *childVc = (ZJTestViewController *)reuseViewController;
        if (childVc == nil) {
            childVc = [[ZJTestViewController alloc] init];
        }
        return childVc;
        
    } else if (index == 1) {
        ZJTest1Controller *childVc = (ZJTest1Controller *)reuseViewController;
        if (childVc == nil) {
            childVc = [[ZJTest1Controller alloc] init];
        }
        
        return childVc;
    }
        else {
        ZJTestViewController *childVc = (ZJTestViewController *)reuseViewController;
        if (childVc == nil) {
            childVc = [[ZJTestViewController alloc] init];
            childVc.view.backgroundColor = [UIColor greenColor];
        }
        
        if (index%1==0) {
            childVc.view.backgroundColor = [UIColor orangeColor];
        }
        
        return childVc;
    }
}


@end
