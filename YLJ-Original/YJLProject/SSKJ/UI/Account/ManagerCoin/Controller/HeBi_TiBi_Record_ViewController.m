//
//  HeBi_TiBi_Record_ViewController.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/4/15.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "HeBi_TiBi_Record_ViewController.h"
#import "HeBi_TiBiRecord_Index_Model.h"
#import "HeBi_Default_AlertView.h"
#define kPageSize @"10"

static NSString *cellID = @"HeBi_TiBi_Record_Cell";

@interface HeBi_TiBi_Record_ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) NSInteger cancleIndex;
@end

@implementation HeBi_TiBi_Record_ViewController


-(void)viewDidLoad
{
    [super viewDidLoad];
    if (self.dealType == DealTypeTibi) {
        self.title = SSKJLocalized(@"提币记录", nil);
    }else{
        self.title = SSKJLocalized(@"充币记录", nil);
    }
    
    self.page = 1;
    [self setUI];
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    self.navigationController.navigationBar.translucent = NO;
    [self headerRefresh];
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
//    self.navigationController.navigationBar.translucent = YES;
}

-(NSMutableArray *)dataSource
{
    if (nil == _dataSource) {
        _dataSource = [NSMutableArray arrayWithCapacity:10];
    }
    return _dataSource;
}

#pragma mark - UI
-(void)setUI
{
    [self.view addSubview:self.tableView];
}



-(UITableView *)tableView
{
    if (nil == _tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - Height_TabBar) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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
        
        _tableView.separatorColor = kMainBackgroundColor;
        
        _tableView.backgroundColor = kMainBackgroundColor;
        
        [_tableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];

        [_tableView registerClass:[HeBi_TiBi_Record_Cell class] forCellReuseIdentifier:cellID];
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
    [self requestRecordList];
    
}

-(void)footerRefresh
{
    [self requestRecordList];
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

#pragma mark - UITableViewDelegate UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HeBi_TiBiRecord_Index_Model *model = self.dataSource[indexPath.row];
    if (model.state.integerValue == 3) {
        return ScaleW(150);
    }else{
        return ScaleW(130);
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return ScaleW(5);
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HeBi_TiBi_Record_Cell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    HeBi_TiBiRecord_Index_Model *model = self.dataSource[indexPath.row];
    [cell setCellWithDealType:self.dealType model:model];
    WS(weakSelf);
    cell.cancleBlock = ^{
        weakSelf.cancleIndex = indexPath.row;
        
        [HeBi_Default_AlertView showWithTitle:SSKJLocalized(@"提醒",nil) message:SSKJLocalized(@"是否确定撤销该订单", nil) cancleTitle:SSKJLocalized(@"取消", nil) confirmTitle:SSKJLocalized(@"确定", nil) confirmBlock:^{
            [weakSelf reqeustCancleRecordWithIndex:indexPath.row];
        }];
    };
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


#pragma mark - 网络请求

-(void)requestRecordList
{
    
    NSDictionary *params;
    if (self.dealType == DealTypeTibi) {
        params = @{  @"type":@"cash",
                     @"p":@(self.page),
                     @"size":kPageSize
                     };
    }else{
       params =  @{@"type":@"recharge",
                  @"p":@(self.page),
                  @"s":kPageSize
                  };
    }
    
    
    WS(weakSelf);
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:JB_CoinTiCho_Record_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        WL_Network_Model *network_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if ([network_model.status integerValue] == SUCCESSED) {
//            [MBProgressHUD showError:network_model.msg];
            [weakSelf handleRecordListWith:network_model];

        }else{
            [MBProgressHUD showError:network_model.msg];
        }
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        //[MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
    }];
    
}

-(void)handleRecordListWith:(WL_Network_Model *)net_model
{
    
    NSArray *array = [HeBi_TiBiRecord_Index_Model mj_objectArrayWithKeyValuesArray:net_model.data[@"res"]];
    if (array.count != kPageSize.integerValue) {
        self.tableView.mj_footer.state = MJRefreshStateNoMoreData;
    }else{
        self.tableView.mj_footer.state = MJRefreshStateIdle;
    }
    
    if (self.page == 1) {
        [self.dataSource removeAllObjects];
    }
    
    [self.dataSource addObjectsFromArray:array];
    
    [SSKJ_NoDataView showNoData:self.dataSource.count toView:self.tableView offY:0];
    
    [self endRefresh];
    
    [self.tableView reloadData];
    
    self.page++;
    
}


#pragma mark - 请求提币撤销

-(void)reqeustCancleRecordWithIndex:(NSInteger)index
{
    HeBi_TiBiRecord_Index_Model *model = self.dataSource[index];

    NSDictionary *params = @{
                             @"cash_id":model.id?:@""
                             };
    WS(weakSelf);
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:JB_TiBiCancel_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        WL_Network_Model *network_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if ([network_model.status integerValue] == SUCCESSED) {
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


@end
