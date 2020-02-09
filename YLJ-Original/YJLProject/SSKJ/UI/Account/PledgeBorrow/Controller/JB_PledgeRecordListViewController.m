//
//  JB_PledgeRecordListViewController.m
//  SSKJ
//
//  Created by James on 2019/5/16.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "JB_PledgeRecordListViewController.h"
#import "JB_PledgeRecordTableViewCell.h"
#import "JB_PledgeRecordModel.h"
#import "ETF_AssestRecordHeaderView.h"
#import "ETF_Default_ActionsheetView.h"
#import "JB_Account_Asset_CoinModel.h"
#import "JB_Lend_AddActionSheet_View.h"
#import "HeBi_Default_AlertView.h"

#define kPage_size @"10"
@interface JB_PledgeRecordListViewController ()
<UITableViewDelegate,
UITableViewDataSource,
JB_PledgeRecordTableViewCellDelegate>

@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) ETF_AssestRecordHeaderView *headerView;

@property (nonatomic, copy) NSString *selectedTypeString;
@property (nonatomic, copy) NSString *selectedStateString;

@property (nonatomic, strong) JB_PledgeRecordModel *selectModel;
@end

@implementation JB_PledgeRecordListViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.selectedStateString = @"";
        self.selectedTypeString = @"";
    }
    return self;
}

-(NSMutableArray *)dataSource
{
    if (nil == _dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = SSKJLocalized(@"抵押记录", nil);
    self.view.backgroundColor = kMainBackgroundColor;
    [self.view addSubview:self.mainTableView];

    if (!self.hiddenHeaderView) {
        self.mainTableView.tableHeaderView = self.headerView;
//        [self requestCoinInfoList];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.hiddenHeaderView) {
        
    }else{
        self.navigationController.navigationBar.translucent = NO;
    }
    
    [self headerRefresh];
    
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (self.hiddenHeaderView) {
        
    }else{
        self.navigationController.navigationBar.translucent = YES;
    }
}

#pragma mark -- 网络请求



#pragma mark -
-(void)requestPborrowRecord
{
    NSDictionary *params = @{@"pid":self.coinPid?:@"",
                                 @"page":@(self.page),
                                 @"size":kPage_size,
                                 @"type":self.selectedTypeString,
                                 @"status":self.selectedStateString,};
    
//        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        WS(weakSelf);
        [[WLHttpManager shareManager]requestWithURL_HTTPCode:JB_PledgeBorrow_Record_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
                    [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
            WL_Network_Model *network_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
            if ([network_model.status integerValue] == SUCCESSED) {
                [weakSelf handleTeamDataWithModel:network_model];
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


-(void)handleTeamDataWithModel:(WL_Network_Model *)network_model
{
    
    NSArray *array = [JB_PledgeRecordModel mj_objectArrayWithKeyValuesArray:network_model.data[@"res"]];
    
    if (self.page == 1) {
        [self.dataSource removeAllObjects];
    }
    _page++;
    [self.dataSource addObjectsFromArray:array];
    
    if (array.count != kPage_size.integerValue) {
        self.mainTableView.mj_footer.state = MJRefreshStateNoMoreData;
    }else{
        self.mainTableView.mj_footer.state = MJRefreshStateIdle;
    }
    [SSKJ_NoDataView showNoData:self.dataSource.count toView:self.mainTableView offY:ScaleW(50)];
    
    [self endRefresh];
    
    [self.mainTableView reloadData];
    
    
}

// 赎回

-(void)requestPayBackWithTranID:(NSString *)tranID
{
    
    
    

    NSDictionary *params  = @{
                              @"order_id":tranID?:@"",
                              };
    WS(weakSelf);
    //    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:JB_BorrowPayback_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        WL_Network_Model *network_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if (network_model.status.integerValue == SUCCESSED) {
            [MBProgressHUD showError:network_model.msg];
            [weakSelf headerRefresh];
        }else{
            [MBProgressHUD showError:network_model.msg];
        }
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        //[MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
        
    }];
}
#pragma mark -- JB_PledgeRecordTableViewCellDelegate

// 赎回
- (void)buyBackDidSelectedWithModel:(JB_PledgeRecordModel *)model {
    [self reqeustBuyBackWithID:model.tran_id?:@""];
}


// 补仓
-(void)addDidSelectedWithModel:(JB_PledgeRecordModel *)model
{
    self.selectModel = model;
    [self requestLicaiCoinBalanceWithModel:model];
}

#pragma mark -- UITableViewDelegate,UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JB_PledgeRecordTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    cell.delegate = self;
    cell.recordModel = self.dataSource[indexPath.row];
    
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
        [_mainTableView registerClass:[JB_PledgeRecordTableViewCell class] forCellReuseIdentifier:@"cell"];
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

- (ETF_AssestRecordHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[ETF_AssestRecordHeaderView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleW(50))];
        _headerView.backgroundColor = kMainBackgroundColor;
        _headerView.coinItem.titleLB.text = SSKJLocalized(@"类型", nil);
        _headerView.typeItem.titleLB.text = SSKJLocalized(@"状态", nil);
        _headerView.coinItem.contentLB.text = SSKJLocalized(@"全部", nil);
        _headerView.typeItem.contentLB.text = SSKJLocalized(@"全部", nil);
        
        WS(weakSelf);
        _headerView.coinBlock = ^{
            NSArray *typeArray = @[SSKJLocalized(@"全部", nil),
                                   SSKJLocalized(@"押币借钱", nil),
                                   SSKJLocalized(@"押钱借币", nil)];
            NSArray *typeKeyArray = @[@"",@"1",@"2"];
            [ETF_Default_ActionsheetView showWithItems:typeArray title:@"" selectedIndexBlock:^(NSInteger selectIndex) {
                weakSelf.headerView.coinItem.contentLB.text = typeArray[selectIndex];
                weakSelf.selectedTypeString = typeKeyArray[selectIndex];
                [weakSelf headerRefresh];
            } cancleBlock:^{
                
            }];
        };
        NSArray *stateArray = @[SSKJLocalized(@"全部", nil),
                                SSKJLocalized(@"计息中", nil),
                               SSKJLocalized(@"已赎回", nil)];
        NSArray *stateKeyArray = @[@"",@"1",@"2"];
        _headerView.typeBlock = ^{
            [ETF_Default_ActionsheetView showWithItems:stateArray title:@"" selectedIndexBlock:^(NSInteger selectIndex) {
                weakSelf.headerView.typeItem.contentLB.text = stateArray[selectIndex];
                weakSelf.selectedStateString = stateKeyArray[selectIndex];
                [weakSelf headerRefresh];
            } cancleBlock:^{
                
            }];
        };
    }
    return _headerView;
}



#pragma mark - 上拉、下拉

-(void)headerRefresh
{
    self.page = 1;
    [self requestPborrowRecord];
}

-(void)footerRefresh
{
    [self requestPborrowRecord];
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


#pragma mark - 网络请求
// 请求币种列表
-(void)requestLicaiCoinBalanceWithModel:(JB_PledgeRecordModel *)model
{
    WS(weakSelf);
    
    
    NSDictionary *params = @{
                             @"out_code":model.out_pname
                             };
    
    
    NSString *url = JB_LicaiCoinBalance_URL;
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:url RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
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
    
    JB_Account_Asset_Index_Model *assetModel = [JB_Account_Asset_Index_Model mj_objectWithKeyValues:net_model.data];
    WS(weakSelf);
    [JB_Lend_AddActionSheet_View showWithModel:assetModel confirmBlock:^(NSString * _Nonnull number, NSString * _Nonnull pwd) {
        [weakSelf requestConverWithNumber:number pwd:pwd];
    }];
    
}


-(void)requestConverWithNumber:(NSString *)number pwd:(NSString *)pwd
{
    NSDictionary *params = @{
                             @"tran_id":self.selectModel.tran_id,
                             @"out_code":self.selectModel.out_pname,
                             @"num":number,
                             @"tpwd":[WLTools md5:pwd]
                             };
    
    WS(weakSelf);
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:JB_LendCover_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        WL_Network_Model *network_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if ([network_model.status integerValue] == SUCCESSED) {
            [MBProgressHUD showSuccess:network_model.msg];
            [weakSelf headerRefresh];
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


-(void)reqeustBuyBackWithID:(NSString *)tran_id
{
    
    NSDictionary *params = @{@"tran_id":tran_id,
                             @"type":@"1"};
    WS(weakSelf);
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:JB_BuyBackInfo_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        WL_Network_Model *network_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        
        if ([network_model.status integerValue] == SUCCESSED) {
            NSString *fine_rate = network_model.data[@"fine_rate"];
            NSString *is_adv = network_model.data[@"is_adv"];
            [weakSelf buyBackOperateWithID:tran_id?:@""
                                 fine_rate:fine_rate?:@""
                                    is_adv:is_adv?:@""];
        }else{
            [MBProgressHUD showSuccess:network_model.msg];
        }
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        //[MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
    }];
    
}


- (void)buyBackOperateWithID:(NSString *)tran_id fine_rate:(NSString *)fine_rate is_adv:(NSString *)is_adv {
    
    WS(weakSelf);
    if (is_adv.integerValue == 1) {
        NSString *title1 = SSKJLocalized(@"提前赎回将支付", nil);
        NSString *title2 = SSKJLocalized(@"的违约金，确认赎回吗？", nil);
        NSString *content = [NSString stringWithFormat:@"%@%@%%%@",title1?:@"",[WLTools noroundingStringWith:fine_rate.doubleValue afterPointNumber:4],title2?:@""];
        [HeBi_Default_AlertView showWithTitle:SSKJLocalized(@"", nil) message:content cancleTitle:SSKJLocalized(@"取消", nil) confirmTitle:SSKJLocalized(@"确认", nil) confirmBlock:^{
            [weakSelf requestPayBackWithTranID:tran_id?:@""];
        }];
    }else{
        NSString *title1 = SSKJLocalized(@"您确定赎回吗？", nil);
        
        [HeBi_Default_AlertView showWithTitle:SSKJLocalized(@"", nil) message:title1 cancleTitle:SSKJLocalized(@"取消", nil) confirmTitle:SSKJLocalized(@"确认", nil) confirmBlock:^{
            [weakSelf requestPayBackWithTranID:tran_id?:@""];
        }];
    }
}

@end
