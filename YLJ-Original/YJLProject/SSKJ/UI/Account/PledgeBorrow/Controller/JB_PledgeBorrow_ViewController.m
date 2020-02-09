//
//  JB_PledgeBorrow_ViewController.m
//  SSKJ
//
//  Created by James on 2019/5/16.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "JB_PledgeBorrow_ViewController.h"
#import "JB_PledgeBorrowTableViewCell.h"
#import "JB_PledgeBorrowModel.h"
#import "JB_WalletHeaderView.h"
#import "JB_PledgeRecordListViewController.h"
#import "JB_LendCoin_ViewController.h"
#import "JB_TransferAccountViewController.h"
#import "JB_CoinTradeListViewController.h"
#import "JB_Account_Asset_CoinModel.h"
#define kPage_size @"10"
@interface JB_PledgeBorrow_ViewController ()
<UITableViewDelegate,
UITableViewDataSource>
@property (nonatomic, strong) UITableView *mainTableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) JB_WalletHeaderView *headerView;
@property (nonatomic, strong) JB_Account_Asset_CoinModel *assetModel;

@end

@implementation JB_PledgeBorrow_ViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.dataSource = [[NSMutableArray alloc]init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = SSKJLocalized(@"抵押借款", nil);
    self.view.backgroundColor = kMainBackgroundColor;
    [self.view addSubview:self.mainTableView];
    self.mainTableView.tableHeaderView = self.headerView;
    [self addRightNavItemWithTitle:SSKJLocalized(@"抵押记录", nil)
                             color:kMainWihteColor
                              font:[UIFont systemFontOfSize:ScaleW(14)]];
    
    
}

- (void)rigthBtnAction:(id)sender {
    JB_PledgeRecordListViewController *vc = [[JB_PledgeRecordListViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = NO;
    [self headerRefresh];
    
    
    
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.translucent = YES;
}

#pragma mark -- buttonClick
- (void)rendMoneyButtonClick {
    JB_LendCoin_ViewController *vc = [[JB_LendCoin_ViewController alloc]initWithType:JB_LendCoin_VCType_RendMoney];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)rendCoinButtonClick {
    JB_LendCoin_ViewController *vc = [[JB_LendCoin_ViewController alloc]initWithType:JB_LendCoin_VCType_RendCoin];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)turnCoinButtonClick {
    JB_TransferAccountViewController *vc = [[JB_TransferAccountViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark -- 网络请求

#pragma mark - 请求资产
// 请求币种列表
-(void)requestPborrow
{
    WS(weakSelf);
    
    NSString *url = JB_Account_LicaiAsset_URL;
    
//    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:url RequestType:RequestTypePost Parameters:nil Success:^(NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        WL_Network_Model *network_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if ([network_model.status integerValue] == SUCCESSED) {
//            [weakSelf handleExchangeListWithModel:network_model];
            weakSelf.assetModel = [JB_Account_Asset_CoinModel mj_objectWithKeyValues:network_model.data];
            [weakSelf.headerView setViewWithModel:self.assetModel];
        }else{
            [MBProgressHUD showError:network_model.msg];
        }
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        //[MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
    }];
    
}

-(void)requestPborrowList
{
    WS(weakSelf);
    
    NSString *url = JB_PledgeLendMoney_URL;
    
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
    
    NSArray *array = [JB_PledgeBorrowModel mj_objectArrayWithKeyValuesArray:net_model.data];
    
    
    [self.dataSource removeAllObjects];
    
    if (array.count != kPage_size.integerValue) {
        self.mainTableView.mj_footer.state = MJRefreshStateNoMoreData;
    }else{
        self.mainTableView.mj_footer.state = MJRefreshStateIdle;
    }
    
    [self.dataSource addObjectsFromArray:array];
    
    [SSKJ_NoDataView showNoData:self.dataSource.count toView:self.mainTableView offY:self.headerView.height];
    
    [self.mainTableView reloadData];
    
    
    [self endRefresh];
    
}
#pragma mark -- UITableViewDelegate,UITableViewDataSource

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    JB_PledgeBorrowModel *model = self.dataSource[indexPath.row];
    JB_PledgeRecordListViewController *vc = [[JB_PledgeRecordListViewController alloc]init];
    vc.coinPid = model.pid;
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JB_PledgeBorrowTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    [cell configureCellWithModel:self.dataSource[indexPath.row]];
    
    return cell;
}

- (UITableView *)mainTableView {
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-Height_NavBar) style:UITableViewStylePlain];
        _mainTableView.backgroundColor = kMainBackgroundColor;
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.estimatedRowHeight = ScaleW(64);
        _mainTableView.estimatedSectionFooterHeight = 0;
        _mainTableView.estimatedSectionHeaderHeight = 0;
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_mainTableView registerClass:[JB_PledgeBorrowTableViewCell class] forCellReuseIdentifier:@"cell"];
        if (@available(iOS 11.0, *)) {
            _mainTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        WS(weakSelf);
        _mainTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weakSelf headerRefresh];
        }];
        
        _mainTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            [weakSelf footerRefresh];
        }];
    }
    return _mainTableView;
}

- (JB_WalletHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[JB_WalletHeaderView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleW(157))];
        _headerView.bgIM.image = [UIImage imageNamed:@"dyjk_bg_icon"];
        [_headerView.rechargeButton addTarget:self action:@selector(rendMoneyButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [_headerView.carryButton addTarget:self action:@selector(rendCoinButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [_headerView.turnButton addTarget:self action:@selector(turnCoinButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _headerView;
}


#pragma mark - 上拉、下拉

-(void)headerRefresh
{
    self.page = 1;
    [self requestPborrowList];
    [self requestPborrow];
}

-(void)footerRefresh
{
    [self requestPborrowList];
}

-(void)endRefresh
{
    //    UITableView *tableView = _type == 0 ? self.teamTableView : self.incomeTableView;
    if (self.mainTableView.mj_header.state == MJRefreshStateRefreshing) {
        [self.mainTableView.mj_header endRefreshing];
    }
    
    if (self.mainTableView.mj_footer.state == MJRefreshStateRefreshing) {
        [self.mainTableView.mj_footer endRefreshing];
    }
}



@end
