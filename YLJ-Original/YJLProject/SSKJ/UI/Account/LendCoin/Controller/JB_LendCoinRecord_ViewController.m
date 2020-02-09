//
//  JB_LendCoinRecord_ViewController.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/5/21.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "JB_LendCoinRecord_ViewController.h"
#import "JB_PledgeRecordTableViewCell.h"
#import "JB_PledgeRecordModel.h"
#define kPage_size @"10"

@interface JB_LendCoinRecord_ViewController ()<UITableViewDelegate,
UITableViewDataSource,JB_PledgeRecordTableViewCellDelegate>
@property (nonatomic, assign) JB_LendCoin_VCType type;

@property (nonatomic, strong) UITableView *mainTableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, assign) NSInteger page;
@end

@implementation JB_LendCoinRecord_ViewController
- (instancetype)initWithType:(JB_LendCoin_VCType)type
{
    self = [super init];
    if (self) {
        self.type = type;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kMainBackgroundColor;
    [self.view addSubview:self.mainTableView];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = NO;
    [self headerRefresh];
    
}

-(NSMutableArray *)dataSource
{
    if (nil == _dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}
#pragma mark - UI

- (UITableView *)mainTableView {
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-Height_NavBar) style:UITableViewStyleGrouped];
        _mainTableView.backgroundColor = kMainBackgroundColor;
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.estimatedRowHeight = ScaleW(64);
        _mainTableView.estimatedSectionFooterHeight = 0;
        _mainTableView.estimatedSectionHeaderHeight = 0;
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_mainTableView registerClass:[JB_PledgeRecordTableViewCell class] forCellReuseIdentifier:@"recordCell"];
        if (@available(iOS 11.0, *)) {
            _mainTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        WS(weakSelf);
        _mainTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weakSelf headerRefresh];
        }];
        //
        //        _mainTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        //            [weakSelf footerRefresh];
        //        }];
    }
    return _mainTableView;
}

#pragma mark -- UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataSource.count;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    JB_PledgeRecordTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"recordCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    cell.recordModel = self.dataSource[indexPath.row];
    cell.delegate = self;
    return cell;
    
}




- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
    
}

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


#pragma mark - JB_PledgeRecordTableViewCellDelegate

- (void)buyBackDidSelectedWithModel:(JB_PledgeRecordModel *)model
{
    [self requestPayBackWithModel:model];
}

#pragma  mark   请求列表

-(void)requestPborrowRecord
{
    NSString *type;
    if (self.type == JB_LendCoin_VCType_RendMoney) {
        type = @"1";
    }else{
        type = @"2";
    }
    
    NSDictionary *params = @{@"page":@(self.page),
                             @"size":@3,
                             @"type":type,
                             @"status":@""};
    
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
    //    [SSKJ_NoDataView showNoData:self.dataSource.count toView:self.mainTableView offY:ScaleW(50)];
    
    [self endRefresh];
    
    [self.mainTableView reloadData];
    
    
}


// 赎回

-(void)requestPayBackWithModel:(JB_PledgeRecordModel *)model
{
    
    
    NSString *type;
    if (self.type == JB_LendCoin_VCType_RendMoney) {
        type = @"1";
    }else{
        type = @"2";
    }
    NSDictionary *params  = @{
                              @"order_id":model.tran_id,
                              };
    WS(weakSelf);
    //    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:JB_BorrowPayback_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        WL_Network_Model *network_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if (network_model.status.integerValue == SUCCESSED) {
            [MBProgressHUD showError:network_model.msg];
            [weakSelf requestPborrowRecord];
        }else{
            [MBProgressHUD showError:network_model.msg];
        }
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
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
