//
//  JB_Account_Asset_ViewController.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/5/16.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "JB_Account_Asset_ViewController.h"

// view
#import "JB_Account_Asset_Cell.h"
#import "JB_Account_Asset_HeaderView.h"

// model
#import "JB_Account_Asset_CoinModel.h"

// controller
#import "JB_Account_AssetRecord_ViewController.h"
#import "JB_TransferAccountViewController.h"
#import "HeBi_Extract_ViewController.h"
#import "HeBi_Charge_ViewController.h"
#import "JB_CoinTradeListViewController.h"
#import "JB_CoinAssets_DoorViewController.h"
#define kPageSize @"10"

static NSString *cellid = @"JB_Account_Asset_Cell";
@interface JB_Account_Asset_ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) JB_Account_Asset_HeaderView *headerView;

@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, strong) JB_Account_Asset_CoinModel *assetModel;

@end

@implementation JB_Account_Asset_ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (self.assetType == AssetTypeLicai) {
        self.title = SSKJLocalized(@"理财账户", nil);
    }else{
        self.title = SSKJLocalized(@"交易账户", nil);
    }
    
    self.navigationController.navigationBar.translucent = NO;
    
    [self addRightNavItemWithTitle:SSKJLocalized(@"账单记录", nil) color:kMainWihteColor font:systemFont(ScaleW(14))];
    
    [self setUI];

}

-(void)rigthBtnAction:(id)sender
{
    if (self.assetType == AssetTypeLicai) {
        JB_Account_AssetRecord_ViewController *vc = [[JB_Account_AssetRecord_ViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        JB_CoinAssets_DoorViewController *vc = [[JB_CoinAssets_DoorViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }

}

-(NSMutableArray *)dataSource
{
    if (nil == _dataSource) {
        _dataSource = [NSMutableArray arrayWithCapacity:10];
    }
    return _dataSource;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = NO;
    [self headerRefresh];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.translucent = YES;
}

#pragma mark - UI

-(void)setUI
{
    [self.view addSubview:self.tableView];
    
}

-(UITableView *)tableView
{
    if (nil == _tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - Height_NavBar) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.tableHeaderView = self.headerView;
        _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        [_tableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
        _tableView.separatorColor = kLineGrayColor;
        [_tableView registerClass:[JB_Account_Asset_Cell class] forCellReuseIdentifier:cellid];
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
        WS(weakSelf);
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weakSelf headerRefresh];
        }];

    }
    return _tableView;
}


-(JB_Account_Asset_HeaderView *)headerView
{
    if (nil == _headerView) {
        _headerView = [[JB_Account_Asset_HeaderView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleW(159)) assetType:self.assetType];
        WS(weakSelf);
        _headerView.exchangeBlock = ^{
            if (self.assetType == AssetTypeLicai) {
                if (![weakSelf judgePayPassword]) {
                    return;
                }
                JB_TransferAccountViewController *vc = [[JB_TransferAccountViewController alloc]init];
                [weakSelf.navigationController pushViewController:vc animated:YES];
            }else{
                if (![weakSelf judgePayPassword]) {
                    return;
                }
                HeBi_Extract_ViewController *vc = [[HeBi_Extract_ViewController alloc]init];
                [weakSelf.navigationController pushViewController:vc animated:YES];
            }
        };
        
        _headerView.chargeBlock = ^{
            HeBi_Charge_ViewController *vc = [[HeBi_Charge_ViewController alloc]init];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
        
        _headerView.extractBlock = ^{

        };
        
    }
    return _headerView;
}


#pragma mark - UITableViewDelegate UITableViewDatasource

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    JB_Account_Asset_Index_Model *coinModel = self.dataSource[indexPath.row];
    JB_CoinTradeListViewController *vc = [[JB_CoinTradeListViewController alloc]init];
    if (self.assetType == AssetTypeLicai) {
        vc.vcType = JB_CoinTradeListVCType_LiCai;
    }else{
        vc.vcType = JB_CoinTradeListVCType_JiaoYi;
    }
    vc.coinString = coinModel.pname?:@"";
    vc.coinKeyString = coinModel.pid?:@"";
    [self.navigationController pushViewController:vc animated:YES];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return ScaleW(10);
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [[UIView alloc]initWithFrame:CGRectZero];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ScaleW(105);
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JB_Account_Asset_Cell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    JB_Account_Asset_Index_Model *coinModel = self.dataSource[indexPath.row];
    [cell setCellWithModel:coinModel assetType:self.assetType];
    return cell;
}


#pragma mark - 上拉、下拉

-(void)headerRefresh
{
    [self requestLicaiCoinList];
}


-(void)endRefresh
{
    if (self.tableView.mj_header.state == MJRefreshStateRefreshing) {
        [self.tableView.mj_header endRefreshing];
    }
}


#pragma mark - 网络请求
// 请求币种列表
-(void)requestLicaiCoinList
{
    WS(weakSelf);
    
    
    NSString *url = JB_Account_DealAsset_URL;
    if (self.assetType == AssetTypeLicai) {
        url = JB_Account_LicaiAsset_URL;
    }
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:url RequestType:RequestTypePost Parameters:nil Success:^(NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        WL_Network_Model *network_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if ([network_model.status integerValue] == SUCCESSED) {
            [weakSelf handleExchangeListWithModel:network_model];
        }else{
            [weakSelf endRefresh];
            [MBProgressHUD showError:network_model.msg];
        }
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        [weakSelf endRefresh];
        //[MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
    }];
    
}

-(void)handleExchangeListWithModel:(WL_Network_Model *)net_model
{
    
    if (self.assetType == AssetTypeLicai) {
        self.assetModel = [JB_Account_Asset_CoinModel mj_objectWithKeyValues:net_model.data];
    }else{
        self.assetModel = [JB_Account_Asset_CoinModel mj_objectWithKeyValues:net_model.data[@"res"]];
    }
    [self.headerView setViewWithModel:self.assetModel];
    
    NSArray *array = self.assetModel.asset;
    
    [self.dataSource removeAllObjects];
    
    if (array.count != kPageSize.integerValue) {
        self.tableView.mj_footer.state = MJRefreshStateNoMoreData;
    }else{
        self.tableView.mj_footer.state = MJRefreshStateIdle;
    }
    
    [self.dataSource addObjectsFromArray:array];
    
    [SSKJ_NoDataView showNoData:self.dataSource.count toView:self.tableView offY:self.headerView.height];
    
    [self.tableView reloadData];
    
    
    [self endRefresh];
    
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
