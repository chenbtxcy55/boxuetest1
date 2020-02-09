//
//  JB_FBC_OrderList_ViewController.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/5/17.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "JB_FBC_OrderList_ViewController.h"
#import "HeBi_FB_OrderDetail_ViewController.h"

#import "JB_FBC_DealOrder_Cell.h"
#import "JB_FBC_DealOrder_Model.h"
#import "FBDeal_Segment_Control.h"

#define kPageSize @"10"

static NSString *cellid = @"JB_FBC_DealOrder_Cell";
@interface JB_FBC_OrderList_ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong)  UILabel *label;
@end

@implementation JB_FBC_OrderList_ViewController



-(void)viewDidLoad
{
    [super viewDidLoad];
    self.page = 1;
    [self setUI];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self headerRefresh];
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
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, _height) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        if (@available(iOS 11.0, *))
        {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            _tableView.estimatedRowHeight = 10;
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
        
        [_tableView registerClass:[JB_FBC_DealOrder_Cell class] forCellReuseIdentifier:cellid];
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
    [self requesttransferList];
    
}

-(void)footerRefresh
{
    [self requesttransferList];
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
    return ScaleW(110);
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
    JB_FBC_DealOrder_Cell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    JB_FBC_DealOrder_Model *model = self.dataSource[indexPath.section];
    [cell setCellWithModel:model];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    JB_FBC_DealOrder_Model *model = self.dataSource[indexPath.section];
    HeBi_FB_OrderDetail_ViewController *vc = [[HeBi_FB_OrderDetail_ViewController alloc]init];
    vc.orderNumber = model.order_num;
    [self.navigationController pushViewController:vc animated:YES];
}



#pragma mark - 网络请求
-(void)requesttransferList
{
    WS(weakSelf);
    NSDictionary *params = @{
                             @"p":@(self.page),
                             @"size":kPageSize
                             };
    
    if (_index == 0) {
        params = @{
                   @"p":@(self.page),
                   @"size":kPageSize
                   };
    }else{
        // int    1待付款 2已付款 3已确认完成 4 申述中 5取消
        NSInteger type = 0;
        if (_index == 1) {
            type = 1;
        }
        if (_index == 2) {
           type = 2;
        }
        if (_index == 3) {
            type = 4;
        }
        if (_index == 4) {
            type = 5;
        }
        if (_index == 5) {
            type = 3;
        }
        params = @{
                   @"p":@(self.page),
                   @"size":kPageSize,
                   @"type":@(type)
                   };
    }
   
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:ETF_FBHomeFbtransRecode_URL RequestType:RequestTypeGet Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        WL_Network_Model *net_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if (net_model.status.integerValue == 200) {
            [weakSelf handleRecordListWith:net_model];
        }else{
            [weakSelf endRefresh];
            
            [MBProgressHUD showError:net_model.msg];
        }
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [weakSelf endRefresh];
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        //[MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
    }];
}


-(void)handleRecordListWith:(WL_Network_Model *)net_model
{
    
    NSArray *array = [JB_FBC_DealOrder_Model mj_objectArrayWithKeyValuesArray:net_model.data[@"res"]];
    if (array.count != kPageSize.integerValue) {
        self.tableView.mj_footer.state = MJRefreshStateNoMoreData;
    }else{
        self.tableView.mj_footer.state = MJRefreshStateIdle;
    }
    
    if (self.page == 1) {
        [self.dataSource removeAllObjects];
    }
    
    [self.dataSource addObjectsFromArray:array];
    
//    [SSKJ_NoDataView showNoData:self.dataSource.count toView:self.tableView offY:0];
    
    [self endRefresh];
    
    [self.tableView reloadData];
    
    self.page++;
    
}



#pragma mark  下单

-(void)requestDealWithParams:(NSDictionary *)dic
{
    WS(weakSelf);
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:Main_Get_create_order_URL RequestType:RequestTypePost Parameters:dic Success:^(NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        WL_Network_Model *net_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if (net_model.status.integerValue == 200) {
                        
        }else{
            
            [MBProgressHUD showError:net_model.msg];
            
        }
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        
        //[MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
        
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
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

-(void)setIndex:(NSInteger)index
{
    _index = index;
    
}

@end
