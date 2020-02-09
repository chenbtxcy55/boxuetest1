//
//  FBCRecodListView.m
//  SSKJ
//
//  Created by 张本超 on 2019/5/15.
//  Copyright © 2019 刘小雨. All rights reserved.

//


#import "FBCRecodListView.h"
#import "SSKJ_NoDataView.h"
#import "FBCRecodTableViewCell.h"
#define kPageSize @"100"
@interface FBCRecodListView()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *maintableView;
@property (nonatomic, assign) NSInteger page;

@property (nonatomic, strong) NSMutableArray *dataSource;
@end
@implementation FBCRecodListView
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
#pragma mark ETF_FBHomeFbtransRecode_URL
-(void)requesttransferList
{
    WS(weakSelf);
    
    
    NSDictionary *params = @{
                             @"p":@(self.page),
                             @"size":kPageSize};
    
    //    [MBProgressHUD showHUDAddedTo:self animated:YES];
    [self.maintableView.mj_footer resetNoMoreData];
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:ETF_FBHomeFbtransRecode_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
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
    NSArray *array = net_model.data[@"res"];
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
    return 1;
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = self.dataSource[indexPath.row];
    FBCRecodTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FBCRecodTableViewCell"];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"FBCRecodTableViewCell" owner:nil options:nil][0];
    }
    cell.orderNumLabel.text = [NSString stringWithFormat:@"订单号 %@",dic[@"order_num"]];
    cell.dateLabel.text = [WLTools convertTimestamp:[dic[@"add_time"] doubleValue] andFormat:@"yyyy-MM-dd HH:mm"];
    cell.limitLabel.text = [NSString stringWithFormat:@"%@-%@CNY",dic[@"min_price"],dic[@"max_price"]];
    NSString *statusString = nil;
    //状态  1待付款 2已付款 3已确认完成 4 申诉中 5已取消
    switch ([dic[@"status"] integerValue]) {
        case 1:
        {
            statusString = @"待付款";
        }
            break;
        case 2:
        {
            statusString = @"已付款";
        }
            break;
        case 3:
        {
            statusString = @"已确认完成";
        }
            break;
        case 4:
        {
             statusString = @"申诉中";
        }
            break;
        case 5:
        {
            statusString = @"已取消";
        }
            break;
        default:
            break;
    }
    cell.statusLabel.text = statusString;
    cell.priceLabel.text = [NSString stringWithFormat:@"%@CNY",dic[@"price"]];
    //1出售 2购买
    cell.goBuyType.text = [dic[@"type"] integerValue] == 1?@"出售":@"购买";
    cell.amountlabel.text = [NSString stringWithFormat:@"%@AB",dic[@"total_num"]];
    cell.totalLable.text = [NSString stringWithFormat:@"%@CNY",dic[@"total_price"]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = self.dataSource[indexPath.row];
    !self.selecetCellBlock?:self.selecetCellBlock(dic);
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 160;
}
@end
