//
//  JB_Account_Licai_OrderList_ViewController.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/5/16.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "JB_Account_Licai_OrderList_ViewController.h"
#import "JB_Licai_Record_Cell.h"
#import "JB_Account_Licai_Record_Index_Model.h"
#import "FBDeal_Segment_Control.h"
#import "HeBi_Default_AlertView.h"
#define kPageSize @"10"

static NSString *cellID = @"JB_Licai_Record_Cell";
@interface JB_Account_Licai_OrderList_ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) FBDeal_Segment_Control *segmentControl;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, assign) NSInteger page;

@property (nonatomic, copy) NSString *status;
@end

@implementation JB_Account_Licai_OrderList_ViewController



-(void)viewDidLoad
{
    [super viewDidLoad];
    self.title = SSKJLocalized(@"理财记录", nil);
    self.page = 1;
    [self setUI];
    self.status = @"";
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (!self.isChildVc) {
        self.navigationController.navigationBar.translucent = NO;
    }
    
    [self headerRefresh];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    if (!self.isChildVc) {
        self.navigationController.navigationBar.translucent = YES;
    }
    

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
    if (!self.isChildVc) {
        [self.view addSubview:self.segmentControl];
    }
    [self.view addSubview:self.tableView];
}

-(FBDeal_Segment_Control *)segmentControl
{
    if (nil == _segmentControl) {
        _segmentControl = [[FBDeal_Segment_Control alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleW(42)) titles:@[SSKJLocalized(@"全部", nil),SSKJLocalized(@"理财中", nil),SSKJLocalized(@"已成功", nil)] normalColor:kTextDarkBlueColor selectedColor:kTextLightBlueColor fontSize:ScaleW(15)];
        _segmentControl.backgroundColor = kSubBackgroundColor;
        WS(weakSelf);
        _segmentControl.selectedIndexBlock = ^BOOL(NSInteger index) {
            if (index == 0) {
                weakSelf.status = @"";
            }else if(index == 1){
                weakSelf.status = @"1";
            }else if (index == 2){
                weakSelf.status = @"2";
            }
            
            [weakSelf headerRefresh];
            return YES;
        };
    }
    return _segmentControl;
}


-(UITableView *)tableView
{
    if (nil == _tableView) {
        
        
        CGFloat startY = self.segmentControl.bottom + ScaleW(10);
        CGFloat height = ScreenHeight - self.segmentControl.bottom - ScaleW(10);
        if (self.isChildVc) {
            startY = 0;
            height = ScreenHeight - startY - Height_NavBar - ScaleW(42);
        }
                
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, startY, ScreenWidth, height) style:UITableViewStyleGrouped];
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
        
        [_tableView registerClass:[JB_Licai_Record_Cell class] forCellReuseIdentifier:cellID];
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

//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return ScaleW(238);
//}

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
    JB_Licai_Record_Cell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    JB_Account_Licai_Record_Index_Model *model = self.dataSource[indexPath.row];
    [cell setCellWihtModel:model];
    WS(weakSelf);
    cell.cancleBlock = ^(JB_Account_Licai_Record_Index_Model * _Nonnull model) {
        [weakSelf reqeustBuyBackWithID:model.tran_id?:@""];
    };
    
    return cell;
}



#pragma mark - 网络请求

#pragma mark - 网络请求

-(void)requestRecordList
{
    
    NSDictionary *params = @{
                             @"p":@(self.page),
                             @"size":kPageSize,
                             @"status":self.status               // 0全部 1理财中 2已赎回
                             };
    
    WS(weakSelf);
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:JB_Account_LicaiRecord_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        WL_Network_Model *network_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if ([network_model.status integerValue] == SUCCESSED) {
            
            [weakSelf handleRecordListWith:network_model];
            
        }else{
            [MBProgressHUD showError:network_model.msg];
        }
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [weakSelf endRefresh];
        //[MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
    }];
    
}


-(void)handleRecordListWith:(WL_Network_Model *)net_model
{
    
    NSArray *array = [JB_Account_Licai_Record_Index_Model mj_objectArrayWithKeyValuesArray:net_model.data[@"res"]];
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

-(void)reqeustCancleRecordWithID:(NSString *)tran_id
{
    
    NSDictionary *params = @{
                             @"order_id":tran_id,
                             };
    
    WS(weakSelf);
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:JB_Account_LicaiCancle_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        WL_Network_Model *network_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if ([network_model.status integerValue] == SUCCESSED) {
            
            [MBProgressHUD showSuccess:network_model.msg];
            [weakSelf headerRefresh];
        }else{
            [MBProgressHUD showError:network_model.msg];
        }
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [weakSelf endRefresh];
        //[MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
    }];
    
}


-(void)reqeustBuyBackWithID:(NSString *)tran_id
{
    
    NSDictionary *params = @{@"tran_id":tran_id,
                             @"type":@"2"};
    WS(weakSelf);
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:JB_BuyBackInfo_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        WL_Network_Model *network_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];

        if ([network_model.status integerValue] == SUCCESSED) {
            NSString *fine_rate = network_model.data[@"fine_rate"];
            NSString *is_adv = network_model.data[@"is_adv"];
            [weakSelf buyBackOperateWithID:tran_id?:@""
                                 fine_rate:fine_rate?:@""
                                    is_adv:is_adv?:@""];
        }else{
            [MBProgressHUD showSuccess:network_model.msg];
        }
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        //[MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
    }];
    
}


- (void)buyBackOperateWithID:(NSString *)tran_id fine_rate:(NSString *)fine_rate is_adv:(NSString *)is_adv {
    
    WS(weakSelf);
    if (is_adv.integerValue == 1) {
        NSString *title1 = SSKJLocalized(@"提前赎回本金借贷利息将按照天计算，将支付", nil);
        NSString *title2 = SSKJLocalized(@"的违约金，确认赎回？", nil);
        NSString *content = [NSString stringWithFormat:@"%@%@%%%@",title1?:@"",[WLTools noroundingStringWith:fine_rate.doubleValue afterPointNumber:4],title2?:@""];
        [HeBi_Default_AlertView showWithTitle:SSKJLocalized(@"", nil) message:content cancleTitle:SSKJLocalized(@"取消", nil) confirmTitle:SSKJLocalized(@"确认", nil) confirmBlock:^{
            [weakSelf reqeustCancleRecordWithID:tran_id?:@""];
        }];
    }else{
        NSString *title1 = SSKJLocalized(@"您确定赎回吗？", nil);
        
        [HeBi_Default_AlertView showWithTitle:SSKJLocalized(@"", nil) message:title1 cancleTitle:SSKJLocalized(@"取消", nil) confirmTitle:SSKJLocalized(@"确认", nil) confirmBlock:^{
            [weakSelf reqeustCancleRecordWithID:tran_id?:@""];
        }];
    }
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
