
//
//  My_Generalize_RootViewController.m
//  ZYW_MIT
//
//  Created by 刘小雨 on 2019/3/29.
//  Copyright © 2019年 Wang. All rights reserved.
//

#import "My_Generalize_RootViewController.h"
#import "My_Generalize_Cell.h"
#import "My_Generalize_View.h"
#import "My_PromoteDetail_ViewController.h"
#import "My_Protocol_ViewController.h"
#import "My_Yuanli_ViewController.h"
#import "My_Generalize_BottomView.h"

#import "My_PromoteDetail_Model.h"
#import "My_Invicate_ViewController.h"

@interface My_Generalize_RootViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) My_Generalize_View *headerView;
@property (nonatomic, strong) My_Generalize_BottomView *bottomView;
@property (nonatomic, strong) NSArray *dataSource;

@property (nonatomic, strong) My_PromoteDetail_Model *detailModel;
@end

@implementation My_Generalize_RootViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = SSKJLocalized(@"我的推广", nil);
    self.view.backgroundColor = kMainBackgroundColor;
    
    
    [self setUI];
    
    [self requestGenerialInfo];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = NO;
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.translucent = YES;
}

-(NSArray *)dataSource
{
    if (nil == _dataSource) {
        _dataSource = [NSMutableArray arrayWithArray:@[SSKJLocalized(@"我要推广", nil),SSKJLocalized(@"我的客户", nil),SSKJLocalized(@"佣金明细", nil)]];
    }
    return _dataSource;
}

#pragma mark - ui
-(void)setUI
{
    [self.view addSubview:self.bottomView];
    [self.view addSubview:self.tableView];
    
//    [self.view addSubview:self.bottomView];
    self.bottomView.y = ScreenHeight - self.bottomView.height - Height_NavBar;
}

-(UITableView *)tableView
{
    if (nil == _tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - Height_NavBar) style:UITableViewStylePlain];
        _tableView.backgroundColor = kMainBackgroundColor;
        _tableView.separatorColor = kLineGrayColor;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[My_Generalize_Cell class] forCellReuseIdentifier:NSStringFromClass([self class])];
        if (@available(iOS 11.0, *))
        {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            _tableView.estimatedRowHeight = 0;
            _tableView.estimatedSectionHeaderHeight = 0;
            _tableView.estimatedSectionFooterHeight = 0;
        }
        else
        {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        _tableView.tableHeaderView = self.headerView;
        _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
        WS(weakSelf);
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weakSelf requestGenerialInfo];
        }];
        
    }
    return _tableView;
}

-(My_Generalize_View *)headerView
{
    if (nil == _headerView) {
        _headerView = [[My_Generalize_View alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleW(100))];
    }
    return _headerView;
}


#pragma mark - UITableViewDelegate UITableViewDatsSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ScaleW(55);
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    My_Generalize_Cell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    cell.title = self.dataSource[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {  // 我要推广
        My_Invicate_ViewController *vc = [[My_Invicate_ViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 1){    // 我的好友
        My_PromoteDetail_ViewController *vc = [[My_PromoteDetail_ViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if (indexPath.row == 2){      // 获得的原力
        My_Yuanli_ViewController *vc = [[My_Yuanli_ViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}


-(My_Generalize_BottomView *)bottomView
{
    if (nil == _bottomView) {
        _bottomView = [[My_Generalize_BottomView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 0)];
        WS(weakSelf);
        _bottomView.privateBlock = ^{
            My_Protocol_ViewController *vc = [[My_Protocol_ViewController alloc]init];
            vc.protocolType = PROTOCOLTYPEPRIVATE;
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
        
        _bottomView.serviceBlock = ^{
            My_Protocol_ViewController *vc = [[My_Protocol_ViewController alloc]init];
            vc.protocolType = PROTOCOLTYPESERVICE;
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
        
        _bottomView.faceBookBlock = ^{
            [weakSelf faceBookEvent];
        };
        
        _bottomView.tweentterBlock = ^{
            [weakSelf tweentterEvent];
        };
        
        _bottomView.gitHubBlock = ^{
            [weakSelf gitHubEvent];
        };
        
    }
    return _bottomView;
}


#pragma mark - 网络请求

-(void)requestGenerialInfo
{
    NSDictionary *params = @{};
    WS(weakSelf);
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:JB_MyHome_ClientLink_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        WL_Network_Model *network_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if ([network_model.status integerValue] == SUCCESSED) {
            My_PromoteDetail_Model *detailModel = [My_PromoteDetail_Model mj_objectWithKeyValues:network_model.data];
            [weakSelf.headerView setViewWithModel:detailModel];
        }else{
            [MBProgressHUD showError:network_model.msg];
        }
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        //[MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
    }];
}


-(void)faceBookEvent
{
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"https://www.facebook.com/GoCoiner"]];
}

-(void)tweentterEvent
{
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"https://gocoin.com/twitter"]];
}

-(void)gitHubEvent
{
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"https://github.com/GoCoin"]];
}

@end
