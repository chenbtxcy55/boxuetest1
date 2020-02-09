//
//  JB_FBC_DealHall_ViewController.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/5/17.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "JB_FBC_DealHall_ViewController.h"
#import "HeBi_FB_OrderDetail_ViewController.h"
#import "JB_FBC_DealHall_Cell.h"
#import "JB_FBC_DealHall_OrderModel.h"
#import "JB_PayWayModel.h"
#import "HeBi_Default_AlertView.h"
#import "BLSafeCenterViewController.h"
/*#import "Mine_payWays_ViewController.h"*/

#define kPageSize @"10"

static NSString *cellid = @"JB_FBC_DealHall_Cell";

@interface JB_FBC_DealHall_ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) HeBi_BuySell_AlertView *buySellAlertView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) NSArray *payListArray;

@end

@implementation JB_FBC_DealHall_ViewController


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
        
        [_tableView registerClass:[JB_FBC_DealHall_Cell class] forCellReuseIdentifier:cellid];
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



-(HeBi_BuySell_AlertView *)buySellAlertView
{
    if (nil == _buySellAlertView) {
        _buySellAlertView = [[HeBi_BuySell_AlertView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        WS(weakSelf);
        _buySellAlertView.confirmBlock = ^(NSDictionary * _Nonnull dic) {
                [weakSelf requestDealWithParams:dic];
        };
    }
    return _buySellAlertView;
}


#pragma mark - 上拉、下拉

-(void)headerRefresh
{
    self.page = 1;
    [self requesttransferList];
    

        [self requestUserInfo];
//        [self requestPayList];

    
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
    return self.dataSource.count;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ScaleW(140);
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
    JB_FBC_DealHall_Cell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    JB_FBC_DealHall_OrderModel *model = self.dataSource[indexPath.section];
    [cell setCellWithModel:model buySellType:self.dealType];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
//    JB_FBC_DealHall_OrderModel *model1 = self.dataSource[indexPath.section];
//
//    [self.buySellAlertView showWithModel:model1 buySellType:self.dealType];
    
//    HeBi_FB_OrderDetail_ViewController *vc = [HeBi_FB_OrderDetail_ViewController new];
//    [self.navigationController pushViewController:vc animated:YES];
//    return;
//
    if (![SSKJ_User_Tool sharedUserTool].userInfoModel.mobile) {
        [self presentLoginController];
        return;
    }
    
    // 判断支付方式是否匹配
    JB_FBC_DealHall_OrderModel *model = self.dataSource[indexPath.section];
    
    if ([model.account isEqualToString:[[SSKJ_User_Tool sharedUserTool]getAccount]]) {
        [MBProgressHUD showError:SSKJLocalized(@"不能和自己交易", nil)];
        return;
    }
    
//    if (self.dealType == BuySellTypeBuy) {
//        if (![self judgeFristCertificate]) {
//            return;
//        }
//    }
    
    if (self.dealType == BuySellTypeSell) {
        
        if (![self judgeFristCertificate]) {
            return;
        }
        
        if (![self judgeSecondCertificate]) {
            return;
        }
    }
    
    

    if (![self judgePayPassword]) {
        return;
    }
    
//    if (![self isMatchPayMethodWithOrderModel:model] && self.dealType == BuySellTypeSell) {
//
//        NSMutableString *payList = [NSMutableString string];
//        if (model.pay_wx.integerValue == 1) {
//            [payList appendString:SSKJLocalized(@"微信", nil)];
//        }
//
//        if (model.pay_alipay.integerValue == 1) {
//            if (payList.length == 0) {
//                [payList appendString:SSKJLocalized(@"支付宝", nil)];
//            }else{
//                [payList appendFormat:@"、%@",SSKJLocalized(@"支付宝", nil)];
//            }
//        }
//        if (model.pay_backcard.integerValue == 1) {
//            if (payList.length == 0) {
//                [payList appendString:SSKJLocalized(@"银行卡", nil)];
//            }else{
//                [payList appendFormat:@"、%@",SSKJLocalized(@"银行卡", nil)];
//            }
//        }
//
//        NSString *message;
//
//        if (self.dealType == BuySellTypeBuy) {
//            message = [NSString stringWithFormat:@"卖家仅支付通过%@收款，您需要添加并激活相应支付方式",payList];
//        }else{
//            message = [NSString stringWithFormat:@"买家仅支付通过%@向您付款，您需要添加并激活相应支付方式",payList];
//        }
//
//        WS(weakSelf);
//        [HeBi_Default_AlertView showWithTitle:@"" message:message cancleTitle:SSKJLocalized(@"取消", nil) confirmTitle:SSKJLocalized(@"添加", nil) confirmBlock:^{
//           /* Mine_payWays_ViewController *vc = [[Mine_payWays_ViewController alloc]init];
//            [weakSelf.navigationController pushViewController:vc animated:YES];*/
//        }];
//
//        return;
//    }
    
    [OTCVerifyDealTool startVerifyCompletion:^{
        [self.buySellAlertView showWithModel:model buySellType:self.dealType];
    }];
    
}



#pragma mark - 网络请求
-(void)requesttransferList
{
    WS(weakSelf);
    
    
    NSString *type = @"pmma";
    if (self.dealType == BuySellTypeBuy) {
        type = @"sell";
    }
    
    NSDictionary *params = @{
                             @"type":type,
                             @"p":@(self.page),
                             @"size":kPageSize
                             
                             };
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:ETF_FBHomeFbtransTrading_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
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
    
    NSArray *array = [JB_FBC_DealHall_OrderModel mj_objectArrayWithKeyValuesArray:net_model.data[@"res"]];
    if (array.count != kPageSize.integerValue) {
        self.tableView.mj_footer.state = MJRefreshStateNoMoreData;
    }else{
        self.tableView.mj_footer.state = MJRefreshStateIdle;
    }
    
    if (self.page == 1) {
        [self.dataSource removeAllObjects];
    }
    
    [self.dataSource addObjectsFromArray:array];
    
//    [SSKJ_NoDataView showNoData:self.dataSource.count toView:self.tableView offY:ScaleW(30)];
    
    [self endRefresh];
    
    [self.tableView reloadData];
    
    self.page++;
    
}



#pragma mark  下单

-(void)requestDealWithParams:(NSDictionary *)dic
{
    
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    [MBProgressHUD showHUDAddedTo:window animated:YES];
    
    WS(weakSelf);
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:Main_Get_create_order_URL RequestType:RequestTypePost Parameters:dic Success:^(NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:window animated:YES];
        WL_Network_Model *net_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if (net_model.status.integerValue == 200) {
            
            [weakSelf.buySellAlertView hide];
            
            NSString *orderNumber = net_model.data[@"order_num"];
            HeBi_FB_OrderDetail_ViewController *vc = [[HeBi_FB_OrderDetail_ViewController alloc]init];
            vc.orderNumber = orderNumber;
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            
            [MBProgressHUD showError:net_model.msg];

        }
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        
        //[MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];

        [MBProgressHUD hideHUDForView:window animated:YES];
    }];
}



-(void)requestPayList
{
    WS(weakSelf);
//    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:JB_Account_PayList_URL RequestType:RequestTypePost Parameters:nil Success:^(NSInteger statusCode, id responseObject) {
//        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        WL_Network_Model *net_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if (net_model.status.integerValue == 200) {
            weakSelf.payListArray = [JB_PayWayModel mj_objectArrayWithKeyValuesArray:net_model.data];
            
        }else{
            
            [MBProgressHUD showError:net_model.msg];
        }
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        //[MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];

//        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
    }];
}
//ETF_FBHomeFbtransTrading_URL

// 自己的支付方式和订单支持的支付方式是否匹配
-(BOOL)isMatchPayMethodWithOrderModel:(JB_FBC_DealHall_OrderModel *)orderModel
{
    if (orderModel.pay_wx.integerValue == 1) {
        for (JB_PayWayModel *payModel in self.payListArray) {
            if ([payModel.type isEqualToString:@"wx"] && payModel.status.integerValue == 1) {
                return YES;
            }
        }
    }
    
    if (orderModel.pay_alipay.integerValue == 1) {
        for (JB_PayWayModel *payModel in self.payListArray) {
            if ([payModel.type isEqualToString:@"alipay"] && payModel.status.integerValue == 1) {
                return YES;
            }
        }
    }
    
    if (orderModel.pay_backcard.integerValue == 1) {
        for (JB_PayWayModel *payModel in self.payListArray) {
            if ([payModel.type isEqualToString:@"backcard"] && payModel.status.integerValue == 1) {
                return YES;
            }
        }
    }
    
    
    return NO;
}



#pragma mark 请求个人中心



-(void)requestUserInfo
{
    NSDictionary *params = @{
                             
                             };
    WS(weakSelf);
//    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:JB_Account_UserInfo_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
//        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        WL_Network_Model *network_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if ([network_model.status integerValue] == SUCCESSED) {
            SSKJ_UserInfo_Model *model = [SSKJ_UserInfo_Model mj_objectWithKeyValues:network_model.data];
            [SSKJ_User_Tool sharedUserTool].userInfoModel = model;
            
        }else{
            [MBProgressHUD showError:network_model.msg];
        }
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
//        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
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
