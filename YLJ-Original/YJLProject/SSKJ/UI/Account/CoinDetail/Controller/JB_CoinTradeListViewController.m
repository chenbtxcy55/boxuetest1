//
//  JB_CoinTradeListViewController.m
//  SSKJ
//
//  Created by James on 2019/5/16.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "JB_CoinTradeListViewController.h"
#import "JB_CoinTradeModel.h"
#import "JB_CoinTradeTableViewCell.h"
#define kPage_size @"10"
@interface JB_CoinTradeListViewController ()
<UITableViewDelegate,
UITableViewDataSource>
@property (nonatomic, strong) UITableView *mainTableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) UIView *headerView;
@end

@implementation JB_CoinTradeListViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSource = [[NSMutableArray alloc]init];
    self.title = [NSString stringWithFormat:@"%@",self.coinString?:@"ETH"];
    self.view.backgroundColor = kMainBackgroundColor;
    [self.view addSubview:self.mainTableView];

    self.mainTableView.tableHeaderView = self.headerView;
    
    
    
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



#pragma mark -- 网络请求

#pragma mark - 请求资产
-(void)requestPborrowRecord
{
    NSString *type = @"1";
    if (self.vcType == JB_CoinTradeListVCType_JiaoYi) {
        type = @"1";
    }else{
        type = @"2";
    }
        NSDictionary *params = @{
                                 @"page":@(self.page),
                                 @"size":kPage_size,
                                 @"pid":self.coinKeyString?:@"",
                                 @"type":type
                                 };
    
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        WS(weakSelf);
        [[WLHttpManager shareManager]requestWithURL_HTTPCode:JB_Re_Asset_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
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
    
    NSArray *array = [JB_CoinTradeModel mj_objectArrayWithKeyValuesArray:network_model.data[@"res"]];
    
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


#pragma mark -- UITableViewDelegate,UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
        return self.dataSource.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JB_CoinTradeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    cell.tradeModel = self.dataSource[indexPath.row];
    
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
        [_mainTableView registerClass:[JB_CoinTradeTableViewCell class] forCellReuseIdentifier:@"cell"];
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

- (UIView *)headerView {
    if (!_headerView) {
        _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleW(40))];
        _headerView.backgroundColor = kMainBackgroundColor;
        UILabel *timeLB = [[UILabel alloc]initWithFrame:CGRectMake(ScaleW(15), 0, ScaleW(100), ScaleW(40))];
        timeLB.textColor = [UIColor colorWithHexStringToColor:@"878ff5"];
        timeLB.font = [UIFont systemFontOfSize:ScaleW(13)];
        timeLB.text = SSKJLocalized(@"时间", nil);
        [_headerView addSubview:timeLB];
        
        UILabel *numberLB = [[UILabel alloc]initWithFrame:CGRectMake(ScaleW(200), 0, ScaleW(100), ScaleW(40))];
        numberLB.textColor = [UIColor colorWithHexStringToColor:@"878ff5"];
        numberLB.font = [UIFont systemFontOfSize:ScaleW(13)];
        numberLB.text = SSKJLocalized(@"数量", nil);
        [_headerView addSubview:numberLB];
        
        UILabel *markLB = [[UILabel alloc]initWithFrame:CGRectMake(ScaleW(300), 0, ScaleW(60), ScaleW(40))];
        markLB.textAlignment = NSTextAlignmentRight;
        markLB.textColor = [UIColor colorWithHexStringToColor:@"878ff5"];
        markLB.font = [UIFont systemFontOfSize:ScaleW(13)];
        markLB.text = SSKJLocalized(@"描述", nil);
        [_headerView addSubview:markLB];
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

@end
