//
//  FBCSellListView.m
//  SSKJ
//
//  Created by 张本超 on 2019/5/15.
//  Copyright © 2019 刘小雨. All rights reserved.


#import "FBCSellListView.h"
#import "SSKJ_NoDataView.h"
#import "FBCToBuyTableViewCell.h"
#define kPageSize @"100"
@interface FBCSellListView()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *maintableView;
@property (nonatomic, assign) NSInteger page;

@property (nonatomic, strong) NSMutableArray *dataSource;
@end
@implementation FBCSellListView
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self maintableView];
        self.page = 1;
    }
    return self;
}

-(UITableView *)maintableView{
    if (!_maintableView) {
        _maintableView = [[UITableView alloc]initWithFrame:self.bounds style:(UITableViewStylePlain)];
        _maintableView.delegate = self;
        _maintableView.dataSource = self;
        _maintableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        _maintableView.backgroundColor = [UIColor clearColor];
        _maintableView.estimatedRowHeight = 200;
        [self addSubview:_maintableView];
        _maintableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
        _maintableView.sectionHeaderHeight = 0.01;
        WS(weakSelf);
        _maintableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weakSelf headerRefresh];
        }];
        
        _maintableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            [weakSelf footerRefresh];
        }];
    }
    return _maintableView;
}

-(NSMutableArray *)dataSource
{
    if (nil == _dataSource) {
        _dataSource = [NSMutableArray array];
    }
    
    return _dataSource;
}

#pragma mark - 网络请求
#pragma mark 请求转账记录
-(void)requesttransferList
{
    WS(weakSelf);
    
    
    NSDictionary *params = @{
                             @"type":@"2",
                             @"p":@(self.page),
                             @"size":kPageSize};
    
    //    [MBProgressHUD showHUDAddedTo:self animated:YES];
    [self.maintableView.mj_footer resetNoMoreData];
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:ETF_FBHomeFbtransTrading_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf animated:YES];
        WL_Network_Model *net_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if (net_model.status.integerValue == 200) {
            [weakSelf handleHonorListWithModel:net_model];
            
        }else{
            [self endRefresh];
            
            [MBProgressHUD showError:net_model.msg];
        }
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [self endRefresh];
        
        [MBProgressHUD hideHUDForView:weakSelf animated:YES];
    }];
}

-(void)handleHonorListWithModel:(WL_Network_Model *)net_model
{
    NSArray *array = [JB_FBC_DealHall_OrderModel mj_objectArrayWithKeyValuesArray:net_model.data[@"res"]];
    if (array.count != kPageSize.integerValue) {
        self.maintableView.mj_footer.state = MJRefreshStateNoMoreData;
    }else{
        self.maintableView.mj_footer.state = MJRefreshStateIdle;
    }
    
    if (self.page == 1) {
        [self.dataSource removeAllObjects];
    }
    
    [self.dataSource addObjectsFromArray:array];
    
    [SSKJ_NoDataView showNoData:self.dataSource.count!=0 toView:self.maintableView offY:0];
    
    [self endRefresh];
    
    self.page++;
    
    [self.maintableView reloadData];
}
#pragma mark - 下拉刷新
-(void)headerRefresh
{
    self.page = 1;
    [self requesttransferList];
}

-(void)footerRefresh
{
    [self requesttransferList];
}

-(void)endRefresh
{
    if (self.maintableView.mj_header.state == MJRefreshStateRefreshing) {
        [self.maintableView.mj_header endRefreshing];
    }
    if (self.maintableView.mj_footer.state == MJRefreshStateRefreshing) {
        [self.maintableView.mj_footer endRefreshing];
    }
}
#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JB_FBC_DealHall_OrderModel *model = self.dataSource[indexPath.row];
    FBCToBuyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FBCToBuyTableViewCell"];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"FBCToBuyTableViewCell" owner:nil options:nil][0];
    }
    
    [cell setCellWithModel:model];
    
    WS(weakSelf);
    cell.gotoBuyBlock = ^{
        !weakSelf.gotoSellBlock?:weakSelf.gotoSellBlock(model);
    };
    
    return cell;
   
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = self.dataSource[indexPath.row];
    //!self.selecetCellBlock?:self.selecetCellBlock(dic);
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 132;
}
@end
