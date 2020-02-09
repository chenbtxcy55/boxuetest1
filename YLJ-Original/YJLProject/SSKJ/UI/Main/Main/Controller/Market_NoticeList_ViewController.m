//
//  Market_NoticeList_ViewController.m
//  ZYW_MIT
//
//  Created by 赵亚明 on 2019/4/8.
//  Copyright © 2019 Wang. All rights reserved.
//

#import "Market_NoticeList_ViewController.h"

#import "Market_Notice_Cell.h"

#import "My_NewsDetail_ViewController.h"

#import "GoCoin_TradingGuide_Model.h"

#define kPage_Size @"10"

@interface Market_NoticeList_ViewController ()<UITableViewDelegate,UITableViewDataSource>
    
@property (nonatomic,strong) UITableView *tableView;
    
@property (nonatomic,strong) NSMutableArray *dataSource;
    
@property (nonatomic, assign) NSInteger page;


@end

@implementation Market_NoticeList_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = SSKJLocalized(@"公告", nil);
    
    [self tableView];
        
    self.page = 1;
    
    [self requestGetjyznGUrl];
}
    
    
    
#pragma mark - 列表表格视图
-(UITableView *)tableView
{
    if (_tableView==nil)
    {
        _tableView=[[UITableView alloc] init];
        
        _tableView.delegate=self;
        
        _tableView.dataSource=self;
        
        _tableView.backgroundColor=kMainBackgroundColor;
        
        _tableView.separatorStyle =  UITableViewCellSeparatorStyleNone;
        _tableView.estimatedRowHeight = ScaleW(64);
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        if (@available(iOS 11.0, *))
        {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
 
        }
        else
        {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        
        [self.view addSubview:_tableView];
        
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(@0);
            
            make.width.equalTo(@(ScreenWidth));
            
            make.top.equalTo(@1);
            
            make.bottom.equalTo(@(0));
            
        }];
        
        _tableView.mj_header=[MJRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
        
        WS(weakSelf);
        
        _tableView.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            
            [weakSelf footerRefresh];
        }];
        
    }
    
    return _tableView;
}
    
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}


    
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Market_Notice_Cell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"NoticeCell%ld",(long)indexPath.row]];
    
    if (cell == nil) {
        
        cell = [[Market_Notice_Cell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithFormat:@"NoticeCell%ld",(long)indexPath.row]];
    }
    
    [cell initDataWithModel:self.dataSource[indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GoCoin_TradingGuide_Model *model = self.dataSource[indexPath.row];
    My_NewsDetail_ViewController *vc = [[My_NewsDetail_ViewController alloc]init];
    vc.newsID = model.ID;
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark -- 获取交易指南 --
- (void)requestGetjyznGUrl
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    WS(weakSelf);
    NSDictionary *params = @{
                             @"p":@(self.page),
                             @"s":kPage_Size
                             };
    
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:ETF_NoticeList_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        WL_Network_Model * netWorkModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        if ([netWorkModel.status isEqualToString:@"200"]) {
            
            [weakSelf handleListWithModel:netWorkModel];
            
        }
        else
        {
            [MBProgressHUD showError:netWorkModel.msg];
            [weakSelf endRefresh];
            
        }
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        
    }];
   
}
    
    
-(void)handleListWithModel:(WL_Network_Model *)model
{
    NSArray * array = [GoCoin_TradingGuide_Model mj_objectArrayWithKeyValuesArray:model.data[@"res"]];
    
    if (self.page == 1) {
        [self.dataSource removeAllObjects];
    }
    
    
    if (array.count != kPage_Size.integerValue) {
        self.tableView.mj_footer.state = MJRefreshStateNoMoreData;
    }else{
        self.tableView.mj_footer.state = MJRefreshStateIdle;
    }
    
    [self.dataSource addObjectsFromArray:array];
    
    [SSKJ_NoDataView showNoData:self.dataSource.count toView:self.tableView offY:0];
    
    self.page++;
    
    [self endRefresh];
    
    [self.tableView reloadData];
    
}
    
- (void)headerRefresh
{
    self.page = 1;
    
    [self requestGetjyznGUrl];
    
}
    
- (void)footerRefresh
{
    [self requestGetjyznGUrl];
    
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

- (NSMutableArray *)dataSource
{
    if (_dataSource == nil) {
        
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
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
