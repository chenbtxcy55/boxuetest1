//
//  JB_BBTrade_HistoryRecord_ViewController.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/5/15.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "JB_BBTrade_HistoryRecord_ViewController.h"

// view
#import "JB_BBTrade_OrderList_Cell.h"
#import "JB_BBTrade_ShaixuanView.h"
#import "HeBi_Default_AlertView.h"

// model
#import "JB_BBTrade_Order_Index_Model.h"
#import "JB_BBTrade_CoinModel.h"

#define kPageSize @"10"

static NSString *cellid = @"JB_BBTrade_OrderList_Cell";
@interface JB_BBTrade_HistoryRecord_ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) JB_BBTrade_ShaixuanView *shaixuanView;

@property (nonatomic, copy) NSString *coinCode;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *buySellType;

@property (nonatomic, strong) NSArray *coinArray;

@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, assign) NSInteger page;


@end

@implementation JB_BBTrade_HistoryRecord_ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = SSKJLocalized(@"历史记录", nil);
    [self addRightNavgation];
    [self setUI];
    self.page = 1;
    
    self.buySellType = @"";
    self.status = @"4";
    self.coinCode = @"";
    
}


-(void)addRightNavgation
{
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, ScaleW(60), 44)];
    [button setTitle:SSKJLocalized(@"筛选", nil) forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    
    button.titleLabel.font = systemFont(ScaleW(13));
    [button setTitleColor:kMainWihteColor forState:UIControlStateNormal];
    [button addTarget:self action:@selector(shaixuan) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:button];
    
    self.navigationItem.rightBarButtonItem = item;
    
}


-(void)shaixuan
{
    [self.shaixuanView showWithCoinCode:self.coinCode status:self.status buySellType:self.buySellType];
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
    [self headerRefresh];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
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
        _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[JB_BBTrade_OrderList_Cell class] forCellReuseIdentifier:cellid];
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
        
        _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            [weakSelf footerRefresh];
        }];
    }
    return _tableView;
}

- (JB_BBTrade_ShaixuanView *)shaixuanView
{
    if (nil == _shaixuanView) {
        _shaixuanView = [[JB_BBTrade_ShaixuanView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        WS(weakSelf);
        _shaixuanView.confirmBlock = ^(NSString * _Nonnull coinCode, NSString * _Nonnull buySellType, NSString * _Nonnull status) {
            weakSelf.coinCode = coinCode;
            weakSelf.status = status;
            weakSelf.buySellType = buySellType;
            [weakSelf headerRefresh];
        };
    }
    return _shaixuanView;
}

#pragma mark - UITableViewDelegate UITableViewDatasource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSource.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
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
    return ScaleW(222);
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JB_BBTrade_OrderList_Cell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    JB_BBTrade_Order_Index_Model *model = self.dataSource[indexPath.section];
    [cell setCellWithModel:model];
    WS(weakSelf);
    cell.cancleBlock = ^(JB_BBTrade_Order_Index_Model * _Nonnull model) {
        [HeBi_Default_AlertView showWithTitle:SSKJLocalized(@"提示", nil) message:SSKJLocalized(@"是否确认撤销该订单", nil) cancleTitle:SSKJLocalized(@"取消", nil) confirmTitle:SSKJLocalized(@"确认", nil) confirmBlock:^{
            [weakSelf requestCancleWithModel:model];
        }];
    };
    return cell;
}


#pragma mark - 上拉、下拉

-(void)headerRefresh
{
    self.page = 1;
    [self requestRecordListWithCoinCode:self.coinCode buySellType:self.buySellType status:self.status];
    
    if (!self.coinArray.count) {
        [self requestCoinList];
    }
}

-(void)footerRefresh
{
    [self requestRecordListWithCoinCode:self.coinCode buySellType:self.buySellType status:self.status];
}

-(void)endRefresh
{
    if (self.tableView.mj_header.state == MJRefreshStateRefreshing) {
        [self.tableView.mj_header endRefreshing];
    }
    
    if (self.tableView.mj_footer.state == MJRefreshStateRefreshing) {
        [self.tableView.mj_footer endRefreshing];
    }
}


#pragma mark - 网络请求
// 请求挂单列表
-(void)requestRecordListWithCoinCode:(NSString *)code buySellType:(NSString *)buySellType status:(NSString *)status
{
    NSDictionary *params = @{
                             @"mobile":kPhoneNumber,
                             @"code":code,
                             @"p":@(self.page),
                             @"size":kPageSize,
                             @"status":status,
                             @"type":buySellType
                             };
    WS(weakSelf);
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:ETF_BBTrade_OrderList_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
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
    NSArray *array = [JB_BBTrade_Order_Index_Model mj_objectArrayWithKeyValuesArray:net_model.data[@"res"]];
    
    if (self.page == 1) {
        [self.dataSource removeAllObjects];
    }
    
    if (array.count != kPageSize.integerValue) {
        self.tableView.mj_footer.state = MJRefreshStateNoMoreData;
    }else{
        self.tableView.mj_footer.state = MJRefreshStateIdle;
    }
    
    [self.dataSource addObjectsFromArray:array];
    
    [SSKJ_NoDataView showNoData:self.dataSource.count toView:self.tableView offY:0];
    
    [self.tableView reloadData];
    
    self.page++;
    
    [self endRefresh];
    
}


// 请求可筛选币种列表
-(void)requestCoinList
{
    WS(weakSelf);
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:ETF_BBTrade_CoinList_URL RequestType:RequestTypePost Parameters:nil Success:^(NSInteger statusCode, id responseObject) {
        WL_Network_Model *network_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if ([network_model.status integerValue] == SUCCESSED) {
            
            weakSelf.coinArray = [JB_BBTrade_CoinModel mj_objectArrayWithKeyValuesArray:network_model.data];
            
            weakSelf.shaixuanView.coinArray = weakSelf.coinArray;
            
        }else{
            [MBProgressHUD showError:network_model.msg];
        }
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [weakSelf endRefresh];
        //[MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
    }];
}


-(void)requestCancleWithModel:(JB_BBTrade_Order_Index_Model *)model
{
    
    NSDictionary *params = @{
                             @"mobile":kPhoneNumber,
                             @"order_id":model.orders_id
                             };
    WS(weakSelf);
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:ETF_BBTradeCancle_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        WL_Network_Model *network_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if ([network_model.status integerValue] == SUCCESSED) {
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
