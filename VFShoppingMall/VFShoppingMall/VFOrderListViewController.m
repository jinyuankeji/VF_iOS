//
//  VFOrderListViewController.m
//  DKDJForDeliver
//
//  Created by 张允鹏 on 16/9/29.
//  Copyright © 2016年 gushi. All rights reserved.
//

#import "VFOrderListViewController.h"
#import "ZJScrollPageView.h"
#import "VFOrderViewController.h"


@interface VFOrderListViewController ()<ZJScrollPageViewDelegate>
@property(strong, nonatomic)NSArray<NSString *> *titles;
@property(strong, nonatomic)NSMutableArray <VFOrderViewController *> *childVcs;

@end

@implementation VFOrderListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单";
    
    //必要的设置, 如果没有设置可能导致内容显示不正常
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    ZJSegmentStyle *style = [[ZJSegmentStyle alloc] init];
    style.titleFont =[UIFont systemFontOfSize:16];
    style.selectedTitleColor=[UIColor colorWithRed:253.0/255.0 green:182.0/255.0 blue:10.0/255.0 alpha:1];
    style.scrollLineColor =[UIColor colorWithRed:253.0/255.0 green:182.0/255.0 blue:10.0/255.0 alpha:1];
    style.autoAdjustTitlesWidth=YES;
    //显示滚动条
    
    
    style.showLine = YES;
    // 颜色渐变
    style.gradualChangeTitleColor = YES;
    
    self.titles = @[@"全部",
                    @"待付款",
                    @"待收货",
                    @"待评价",
                    @"售后"
                    ];
    // 初始化
    ZJScrollPageView *scrollPageView = [[ZJScrollPageView alloc] initWithFrame:CGRectMake(0, 64.0, self.view.bounds.size.width, self.view.bounds.size.height - 64.0) segmentStyle:style titles:self.titles parentViewController:self delegate:self];
    
    [self.view addSubview:scrollPageView];
    
    
    _childVcs=[NSMutableArray array];
    for (int i=0; i<5; i++) {
        VFOrderViewController * vc=[[VFOrderViewController alloc] init];
        vc.index=i;
        [self.childVcs addObject:vc];
    }
    
    // Do any additional setup after loading the view.
}
- (NSInteger)numberOfChildViewControllers {
    return self.titles.count;
}


- (UIViewController<ZJScrollPageViewChildVcDelegate> *)childViewController:(UIViewController<ZJScrollPageViewChildVcDelegate> *)reuseViewController forIndex:(NSInteger)index {
    
    
    return _childVcs[index];
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
