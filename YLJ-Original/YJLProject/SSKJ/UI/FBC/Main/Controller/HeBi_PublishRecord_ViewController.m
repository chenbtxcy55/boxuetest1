//
//  HeBi_PublishRecord_ViewController.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/4/15.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "HeBi_PublishRecord_ViewController.h"
#import "HeBi_FB_OrderDetail_ViewController.h"

// view
#import "HeBi_PublishRecord_Cell.h"
#import "HeBi_Default_AlertView.h"
#import "JB_FBC_Publish_TitleView.h"
// model
#import "HeBi_FB_PublishRecord_Index_Model.h"

#define kPageSize @"10"

static NSString *cellID = @"HeBi_PublishRecord_Cell";



@interface HeBi_PublishRecord_ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) JB_FBC_Publish_TitleView *mainTitleView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) NSInteger cancleIndex;

@end

@implementation HeBi_PublishRecord_ViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.titleView = self.mainTitleView;
    
    self.page = 1;
    [self setUI];
    
    if (self.publishType == PublishTypeSell) {
        [self.mainTitleView setSelectIndex:0];
    }else{
        [self.mainTitleView setSelectIndex:1];
    }
}

-(JB_FBC_Publish_TitleView *)mainTitleView
{
    if (nil == _mainTitleView) {
        _mainTitleView = [[JB_FBC_Publish_TitleView alloc]initWithFrame:CGRectZero buyTitle:SSKJLocalized(@"购买记录", nil) sellTitle:SSKJLocalized(@"出售记录", nil)];
        WS(weakSelf);
        _mainTitleView.changeTypeBlock = ^(BuySellType buySellType) {
            weakSelf.publishType = buySellType;
            [weakSelf.dataSource removeAllObjects];
            [weakSelf.tableView reloadData];
            
            weakSelf.page = 1;
            [weakSelf requestRecordListWithShowLoading:YES];
        };
    }
    return _mainTitleView;
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
    self.page = 1;
    
    [self requestRecordListWithShowLoading:YES];
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
        
//        _tableView.separatorColor = kMainBackgroundColor;
        
        _tableView.backgroundColor = kBgColor;
        
        [_tableView registerClass:[HeBi_PublishRecord_Cell class] forCellReuseIdentifier:cellID];
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
    [self requestRecordListWithShowLoading:NO];
    
}

-(void)footerRefresh
{
    [self requestRecordListWithShowLoading:NO];
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
    return self.dataSource.count;//self.dataSource.count
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ScaleW(170);
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return ScaleW(10);
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
    HeBi_PublishRecord_Cell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    [cell setCellWithPublishType:self.publishType];
    
    HeBi_FB_PublishRecord_Index_Model *model = self.dataSource[indexPath.section];
    
    [cell setCellWithModel:model];
    WS(weakSelf);
    cell.cancleBlock = ^{
        weakSelf.cancleIndex = indexPath.section;
//        [weakSelf.cancleAlertView showWithTitle:SSKJLocalized(@"撤销订单", nil) message:SSKJLocalized(@"每日最多可以取消3次，超过3次将无法购买/出售AB", nil) cancleTitle:SSKJLocalized(@"取消", nil) confirmTitle:SSKJLocalized(@"确定", nil)];
        [HeBi_Default_AlertView showWithTitle:SSKJLocalized(@"撤销订单", nil) message:SSKJLocalized(@"确定撤销订单", nil) cancleTitle:SSKJLocalized(@"取消", nil) confirmTitle:SSKJLocalized(@"确定", nil) confirmBlock:^{
            
                [weakSelf requestCancleOrderWithIndex:weakSelf.cancleIndex];
            
        }];
        
    };
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}


#pragma mark - 网络请求

-(void)requestRecordListWithShowLoading:(BOOL)showLoading
{
       NSString * type = @"pmma";
    if (self.publishType == PublishTypeSell) {
        type = @"sell";
    }
    
    
    NSDictionary *params = @{
                             @"account":[SSKJ_User_Tool sharedUserTool].getAccount,
                             @"type":type,
                             @"p":@(self.page),
                             @"size":kPageSize
                             };
    
    if (showLoading) {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    }
    WS(weakSelf);
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:FBC_PublishOrderList_URL RequestType:RequestTypeGet Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        WL_Network_Model *net_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if (net_model.status.integerValue == SUCCESSED) {
            [weakSelf handleRecordListWith:net_model];
        }else{
            [self endRefresh];

            [MBProgressHUD showError:net_model.msg];
        }
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        //[MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
        [self endRefresh];

    }];
}

-(void)handleRecordListWith:(WL_Network_Model *)net_model
{
    
    NSArray *array = [HeBi_FB_PublishRecord_Index_Model mj_objectArrayWithKeyValuesArray:net_model.data[@"res"]];
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

#pragma mark - 请求撤单

-(void)requestCancleOrderWithIndex:(NSInteger)index
{
        NSString *type = @"pmma";
    if (self.publishType == PublishTypeSell) {
     
        type = @"sell";
    }
    
    HeBi_FB_PublishRecord_Index_Model *model = self.dataSource[index];
    
    NSDictionary *params = @{
                             @"account":[SSKJ_User_Tool sharedUserTool].userInfoModel.account,
                             @"type":type,
                             @"id":model.ID
                             };
    
    
    WS(weakSelf);
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:FBC_PublishCancleOrder_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        WL_Network_Model *net_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if (net_model.status.integerValue == SUCCESSED) {
            [MBProgressHUD showSuccess:net_model.msg];
            [weakSelf headerRefresh];
        }else{
            [MBProgressHUD showError:net_model.msg];
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
