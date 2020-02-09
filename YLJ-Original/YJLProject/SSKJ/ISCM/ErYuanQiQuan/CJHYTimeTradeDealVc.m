//
//  CJHYTimeTradeDealVc.m
//  SSKJ
//
//  Created by 张本超 on 2019/8/27.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "CJHYTimeTradeDealVc.h"
#import "CJHYTimeShareVc.h"
#import "CJHYTradeRecodeTableViewCell.h"
#import "CJHYPosionModel.h"
#import "CJHYShareModel.h"
#define kPageSize  @"15"

static NSString * cellID = @"CJHYTradeRecodeTableViewCell";

@interface CJHYTimeTradeDealVc ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong)UITableView *tableView;

@property(nonatomic, strong)NSArray *array;

@property (nonatomic, assign) NSInteger page;

@property (nonatomic, strong) NSMutableArray *dataSource;
@end

@implementation CJHYTimeTradeDealVc

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self tableView];
}

#pragma mark - tableView delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.dataSource.count;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return ScaleW(170);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    CJHYTradeRecodeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    
    WS(weakSelf);
    CJHYPosionModel *model = self.dataSource[indexPath.section];

    cell.timeModel = model;
    
    cell.shareBlock = ^{
        [weakSelf reaqustShareUrlWithId:model.ID];
    };
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section>0) {
        
        return ScaleW(10);

    }
    return 0;
    
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *view=[UIView new];
    
    
    view.backgroundColor=[UIColor clearColor];
    
    return view;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

#pragma mark - lazy load
- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor clearColor];
        [_tableView setSeparatorColor:kLineColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        [_tableView registerClass:[CJHYTradeRecodeTableViewCell class] forCellReuseIdentifier:cellID];
        if (@available(iOS 11.0, *)){
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            _tableView.estimatedRowHeight = 0;
            _tableView.estimatedSectionHeaderHeight = 0;
            _tableView.estimatedSectionFooterHeight = 0;
        }else{
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(@0);
            make.top.equalTo(@(ScaleW(0)));
            make.bottom.equalTo(@(-Height_TabBarSafe));
        }];
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
#pragma mark - 上拉、下拉

-(void)headerRefresh
{
    self.page = 1;
    [self requestRecordListWithCoinCodeStatus:@"2"];
    
    
}

-(void)footerRefresh
{
    [self requestRecordListWithCoinCodeStatus:@"2"];
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
-(void)requestRecordListWithCoinCodeStatus:(NSString *)status
{
    NSDictionary *params = @{
                             
                             @"p":@(self.page),
                             @"size":kPageSize,
                             
                             };
    WS(weakSelf);
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:KDealdOrdersList RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
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
        [MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
    }];
    
}

-(void)handleExchangeListWithModel:(WL_Network_Model *)net_model
{
    //NSArray *array = [JB_BBTrade_Order_Index_Model mj_objectArrayWithKeyValuesArray:net_model.data[@"res"]];
    
    [self.dataSource removeAllObjects];
    
    [self.tableView reloadData];
    
    NSMutableArray *array = [NSMutableArray array];
    
    for (NSDictionary *dic  in net_model.data) {
        
        CJHYPosionModel *model = [[CJHYPosionModel alloc]init];
        
        [model setValuesForKeysWithDictionary:dic];
        
        [array addObject:model];
    }
    
    if (self.page == 1) {
        
        [self.dataSource removeAllObjects];
        
    }
    
    if (array.count != kPageSize.integerValue) {
        
        self.tableView.mj_footer.state = MJRefreshStateNoMoreData;
    }
    else{
        self.tableView.mj_footer.state = MJRefreshStateIdle;
    }
    
    [self.dataSource addObjectsFromArray:array];
    
    [SSKJ_NoDataView showNoData:self.dataSource.count toView:self.tableView offY:0];
    
    [self.tableView reloadData];
    
    self.page++;
    
    [self endRefresh];
    
}

-(NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
    
}
//Mine_contract_detail_URL分享链接
-(void)reaqustShareUrlWithId:(NSString *)idString
{
    NSDictionary *params = @{
                             @"id":idString,
                             
                             };
    WS(weakSelf);
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:@"" RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        WL_Network_Model *network_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if ([network_model.status integerValue] == SUCCESSED) {
            CJHYShareModel *model = [[CJHYShareModel alloc]init];
            [model setValuesForKeysWithDictionary:network_model.data];
            CJHYTimeShareVc *vc = [[CJHYTimeShareVc alloc]init];
            vc.model = model;
            [self.navigationController pushViewController:vc animated:YES];
            
        }else{
            [weakSelf endRefresh];
            [MBProgressHUD showError:network_model.msg];
        }
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        [weakSelf endRefresh];
        [MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
    }];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self requestRecordListWithCoinCodeStatus:@"2"];
    
}

@end
