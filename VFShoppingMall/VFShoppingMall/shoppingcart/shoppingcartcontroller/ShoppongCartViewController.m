//
//  ShoppongCartViewController.m
//  VFShoppingMall
//
//  Created by jinyuankeji on 16/9/28.
//  Copyright © 2016年 jinyuankeji. All rights reserved.
//

#import "ShoppongCartViewController.h"
#import "MyViewController.h"
#import "ShoppingCartTableViewCell.h"
#import "NetworkingHandler.h"
#import "ShoppingCartModel.h"
#import "AFNetworking.h"
#import "Masonry.h"
#import "ShoppingCartClearingViewController.h"



@interface ShoppongCartViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray<ShoppingCartModel*> *arrOfShoppingCart;
@property (nonatomic, strong) ShoppingCartModel *modelCart;
@property (nonatomic, strong) UIView *viewOfFoot;
@property (nonatomic, strong) UILabel *labelOfMoney;
@end

@implementation ShoppongCartViewController



//隐藏navigationbar
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatViewTitle];
    [self configTableView];
    [self configData];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
}

- (void)creatViewTitle{
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20],NSForegroundColorAttributeName:[UIColor blackColor]}];
    
    self.navigationItem.title = @"购物车";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"fan"] style:UIBarButtonItemStylePlain target:self action:@selector(handleMy)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(deleteAction)];
    
    
    UIView *headView = [[UIView alloc] init];
    headView.backgroundColor = [UIColor colorWithRed:243 / 255.0f green:243 / 255.0f blue:243 / 255.0f alpha:1];
    headView.frame = CGRectMake(0, 64, DEVICE_HEIGHT, 40);
    [self.view addSubview:headView];
    
    self.viewOfFoot = [[UIView alloc] init];
    self.viewOfFoot.backgroundColor = [UIColor colorWithRed:243 / 255.0f green:243 / 255.0f blue:243 / 255.0f alpha:1];
    
    [self.view addSubview:self.viewOfFoot];
    [self.viewOfFoot mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).with.offset(0);
        make.right.equalTo(self.view).with.offset(0);
        make.bottom.equalTo(self.view).with.offset(0);
        make.height.offset(80);
        
        
    }];
    
    UIButton *buttonFoot = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.viewOfFoot addSubview:buttonFoot];
    self.tableView.tableFooterView = buttonFoot;
    [buttonFoot setTitle:@"结算" forState:UIControlStateNormal];
    [buttonFoot addTarget:self action:@selector(handlerSetClearing) forControlEvents:UIControlEventTouchUpInside];
    
    buttonFoot.backgroundColor = [UIColor colorWithRed:244 / 255.0f green:172 / 255.0f blue:39 / 255.f alpha:1];
    
    [buttonFoot mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).with.offset(0);
        make.right.equalTo(self.view).with.offset(0);
        make.bottom.equalTo(self.view).with.offset(0);
        make.height.offset(50);
        
    }];
    self.labelOfMoney = [[UILabel alloc] init];
    [self.viewOfFoot addSubview:self.labelOfMoney];
    
    
    
    
    
    
}

- (void)handleMy {
    
    
    [self.navigationController popToViewController:self.navigationController.viewControllers[0] animated:YES];
    
    
}

- (void)configTableView{
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 104, DEVICE_WIDTH, DEVICE_HEIGHT - 104) style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    //去除Tabview里面cell之间的下划线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView registerClass:[ShoppingCartTableViewCell class] forCellReuseIdentifier:@"shoppingCart"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = self.viewOfFoot;
    
    
    
}
- (void)configData{
    
    self.arrOfShoppingCart = [NSMutableArray array];
    NSString *str = @"http://www.jinyuankeji.net/VF/portal/OrderAction/shoppingCartList?userId=17";
    NetworkingHandler *nt = [[NetworkingHandler alloc] init];
    
    [nt netWorkingHandlerGETWithURL:str completion:^(id result, NSData *data, NSURLResponse *response, NSError *error) {
        
        //        NSLog(@"asdddd%@", result);
        NSDictionary *dic = [result objectForKey:@"Data"];
        NSLog(@"%@",dic);
        NSArray *arr = [dic objectForKey:@"goodsList"];
        for (NSDictionary *dic in arr) {
            self.modelCart = [[ShoppingCartModel alloc] init];
            [self.modelCart setValuesForKeysWithDictionary:dic];
            [self.arrOfShoppingCart addObject:self.modelCart];
        }
        
        [self.tableView reloadData];
        
        
    }];
    
    
    
    
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.arrOfShoppingCart.count;
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    ShoppingCartTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"shoppingCart" forIndexPath:indexPath];
    cell.model = self.arrOfShoppingCart[indexPath.row];
    
    
    
    return cell;
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    // 2松开手颜色消息
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    // 3点击没有颜色改变
    //    cell.selected = NO;
    
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 180;
    
    
}
-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return UITableViewCellEditingStyleDelete;
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        [self.arrOfShoppingCart removeObjectAtIndex:[indexPath row]];
        [self.tableView deleteRowsAtIndexPaths:[NSMutableArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        
    }
    
    
    
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footView = [[UIView alloc] init];
    return footView;
}

//删除编辑
-(void)deleteAction{
    
    [self.tableView setEditing:!self.tableView.editing animated:YES];
    
    if (self.tableView.editing)
    {
        [self.navigationItem.rightBarButtonItem setTitle:@"删除"];
    }
    else
    {
        [self.navigationItem.rightBarButtonItem setTitle:@"管理"];
    }
    
    
    
    
}
- (void)settlement{
    
    
}

//结算
- (void)handlerSetClearing{
    
    ShoppingCartClearingViewController *vc = [[ShoppingCartClearingViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
    
}




@end
