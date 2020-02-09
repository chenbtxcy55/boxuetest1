

#import "Shop_OrderListViewController.h"
#import "Shop_OrderDetail_ViewController.h"
#import "ContectShopViewController.h"

//#import "Shop_OrderList_TableViewCell.h"
#import "YLJ_Shop_OrderList_TableViewCell.h"
#import "ICC_Mall_Preorder_Model.h"
#import "NSString+Conversion.h"
#import "SuperPayMoney_View.h"
#import "SuperConfimViewController.h"
#import "RegularExpression.h"
#import "Shop_OrderListRoot_VewController.h"
#import "xiadanViewController.h"
#import "My_SetTPWD_ViewController.h"
#import "YLJOrderDetailViewController.h"
#import "YLJOrderListModel.h"


#define kPageSize @"10"

@interface Shop_OrderListViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UserOrderType _userOrderType;
    NSIndexPath *_selecedIndexPath;
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) xiadanViewController *ensureView;
@end

@implementation Shop_OrderListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.page = 1;
    [self.view addSubview:self.tableView];
    
    [self requesttransferList];
    self.title = @"订单";
    
}

-(void)viewWillAppear:(BOOL)animated

{
    [super viewWillAppear:animated];
    
    
}
-(void)refreshData{
    
    [self.tableView.mj_header beginRefreshing];
    
}
- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
//    [self.tableView.mj_header beginRefreshing];

}
-(UITableView *)tableView
{
    if (nil == _tableView) {
        
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight  - Height_NavBar) style:UITableViewStyleGrouped];
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
        
        _tableView.backgroundColor = kMainColor;

        [_tableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
        
        // [_tableView registerClass:[JB_FBC_DealHall_Cell class] forCellReuseIdentifier:cellid];
        [_tableView registerNib:[UINib nibWithNibName:@"YLJ_Shop_OrderList_TableViewCell" bundle:nil] forCellReuseIdentifier:@"YLJ_Shop_OrderList_TableViewCell"];
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

#pragma mark -  UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
//    return [(YLJ_Shop_OrderList_TableViewCell*)cell cellFactHight];
    return 156;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return ScaleW(0.001);
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
    YLJ_Shop_OrderList_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YLJ_Shop_OrderList_TableViewCell"];
    
    if (cell == nil) {
        
        cell = [[YLJ_Shop_OrderList_TableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"YLJ_Shop_OrderList_TableViewCell"];
    }
    
    YLJOrderListModel *model  = self.dataSource[indexPath.row];
    [cell configCellWithModel:model];
    
    
    return cell;
}


#pragma mark 下单
-(xiadanViewController *)ensureView
{
    if (!_ensureView) {
        _ensureView = [[xiadanViewController alloc]init];
        _ensureView.conTextFild.secureTextEntry = YES;
        WS(weakSelf);
        
        _ensureView.commitBlock = ^{
           
            [weakSelf requstPayRequstPsw:weakSelf.ensureView.conTextFild.text andOrderId:weakSelf.ensureView.dict[@"order_id"]];
            
        };
        
        _ensureView.cancelBlock = ^{
            
            
        };
    }
    return _ensureView;
}

#pragma mark - 上拉、下拉

-(void)headerRefresh
{
    self.page = 1;
    [self requesttransferList];
    
    if (kLogin) {
        //        [self requestUserInfo];
        //        [self requestPayList];
    }
    
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
#pragma mark - 网络请求
-(void)requesttransferList
{
    WS(weakSelf);
    
    NSDictionary *params = @{
//                             @"status":_statusString,
                             @"p":@(self.page),
                             @"size":kPageSize
                             
                             };
  
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:JB_Shop_OrderList RequestType:RequestTypeGet Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        WL_Network_Model *net_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if (net_model.status.integerValue == 200) {
            [weakSelf handleRecordListWith:net_model];
        }else{
            [self.dataSource removeAllObjects];
            [self.tableView reloadData];
            [weakSelf endRefresh];
            
//            [MBProgressHUD showError:net_model.msg];
        }
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [weakSelf endRefresh];
        
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        
    }];
}



-(void)handleRecordListWith:(WL_Network_Model *)net_model
{
    
//    NSArray *array = [net_model.data objectForKey:@"orders"];
    NSArray *array =[YLJOrderListModel mj_objectArrayWithKeyValuesArray:net_model.data[@"orders"]];
    
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    Shop_OrderDetail_ViewController *vc = [[Shop_OrderDetail_ViewController alloc]init];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    
   YLJOrderListModel *model  = self.dataSource[indexPath.row];
    
    YLJOrderDetailViewController *vc=[[YLJOrderDetailViewController alloc]init];
    
    vc.orderID = model.order_id;
    
    [self.navigationController pushViewController:vc animated:YES];
}

-(NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

//#pragma mark -- ICC_Mall_UserOrderList_ViewCellDelegate
//-(void)selectedOrderAtIndexPath:(NSIndexPath*)indexPath userHandleType:(ICC_Mall_UserOrderType)handleType {
//    NSDictionary *dataDic = [self.dataSource objectAtIndex:indexPath.row];
//    NSString *orderId = [NSString stringTransformObject:[dataDic objectForKey:@"order_id"]];
//
//    if (handleType == kcancelOrderEvent) {//取消订单
//        _selecedIndexPath = indexPath;
//                UIAlertController *alertViewControler = [UIAlertController alertControllerWithTitle:@"提示" message:@"确认取消该订单吗" preferredStyle:UIAlertControllerStyleAlert];
//
//                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:SSKJLocalized(@"取消", nil) style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
//
//                }];
//
//                UIAlertAction *sureAction = [UIAlertAction actionWithTitle:SSKJLocalized(@"确认", nil) style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
//                    [self loadCancelOrderDatasWithOrderNumber:orderId indexPath:indexPath];
//                }];
//
//                [alertViewControler addAction:cancelAction];
//                [alertViewControler addAction:sureAction];
//                [self showDetailViewController:alertViewControler sender:nil];
//        //[self.cancleAlertView showWithTitle:@"" message:(@"便宜不等人，请三思而行~")];
//
//    } else if (handleType == kgoPayOrderEvent) {//去支付
//        WS(weakSelf);
//
//
//        if ([[SSKJ_User_Tool sharedUserTool].userInfoModel.tpwd length] ) {
//
//            weakSelf.ensureView.modalPresentationStyle = UIModalPresentationOverFullScreen;
//
//            [weakSelf.navigationController presentViewController:weakSelf.ensureView animated:YES completion:^{
//                //
//                weakSelf.ensureView.view.superview.backgroundColor = [UIColor clearColor];
//
//            }];
//
//            weakSelf.ensureView.dict=dataDic;
//
//            weakSelf.ensureView.messageLabel.text = [NSString stringWithFormat:@"金额 %@",dataDic[@"total_price"]];
//
//        }else{
//
//            [MBProgressHUD showError:@"请设置支付密码"];
//
//            My_SetTPWD_ViewController *vc = [[My_SetTPWD_ViewController alloc]init];
//            [weakSelf.navigationController pushViewController:vc animated:YES];
//        }
//    } else if (handleType == ksureOrderEvent) {//确认订单
//        [self loadSureReceivingGoodsOrderDatasWithOrderNumber:orderId];
//    } else if (handleType == kdeleteOrderEvent) {//删除订单
//        UIAlertController *alertViewControler = [UIAlertController alertControllerWithTitle:(@"提示") message:(@"确认删除此订单吗") preferredStyle:UIAlertControllerStyleAlert];
//
//        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:SSKJLocalized(@"取消", nil) style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
//
//        }];
//
//        UIAlertAction *sureAction = [UIAlertAction actionWithTitle:SSKJLocalized(@"确认", nil) style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
//            [self loadDeleteOrderDatasWithOrderNumber:orderId indexPath:indexPath];
//        }];
//
//        [alertViewControler addAction:cancelAction];
//        [alertViewControler addAction:sureAction];
//        [self showDetailViewController:alertViewControler sender:nil];
//    } else if (handleType == kcontactShopEvent) {//联系商家
//        [self loadContactBussinessOrderDatasWithShopID:[NSString stringTransformObject:[dataDic objectForKey:@"shop_id"]]];
//    }
//}
//取消订单
#pragma  makr 取消订单
- (void)loadCancelOrderDatasWithOrderNumber:(NSString*)orderNumber indexPath:(NSIndexPath*)indexPath{
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    
    [params setObject:orderNumber forKey:@"order_id"];
    
    WS(weakSelf);
    //[weakSelf showHudWithString:(@"加载中...")];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:KCanCelUSerOrder RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
       // [weakSelf hidHud];
         [MBProgressHUD hideHUDForView:self.view animated:YES];
        WL_Network_Model *network_Model=[WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if ([network_Model.status isEqualToString:SUCCEED]) {
           // [MBProgressHUD showError:network_Model.msg];
            //取消订单成功，然后刷新数据
            [weakSelf.tableView.mj_header beginRefreshing];
            
        }
        
        [MBProgressHUD showError:network_Model.msg];

    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        
        WL_Network_Model *network_Model=[WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if ([WLTools judgeString:network_Model.msg]) {
            [MBProgressHUD showError:network_Model.msg];
            
        } else {
            //[[WL_TipAlert_View sharedAlert] createTip:NetworkFailMessage];
        }
    }];
}
//支付
#pragma mark 支付
-(void)requstPayRequstPsw:(NSString *)pasw andOrderId:(NSString*)orderId

{
    if (![RegularExpression validatePassword:pasw]) {
        [MBProgressHUD showError:@"请输入正确格式密码"];
        return;
    }
    NSString *str1=[WLTools md5:pasw];
    

    NSDictionary *pamas = @{@"order_id":orderId,@"tpwd":str1};
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:AB_Shop_user_order_pay_post RequestType:RequestTypePost Parameters:pamas Success:^(NSInteger statusCode, id responseObject) {
        WL_Network_Model * netWorkModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([netWorkModel.status isEqualToString:@"200"]) {
            
            self.page=1;
            
           
            [self requesttransferList];
            
            
        }
        
        else
        {
            
        }
        [MBProgressHUD showError:netWorkModel.msg];
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}
//确认收货
-(void)loadSureReceivingGoodsOrderDatasWithOrderNumber:(NSString*)orderNumber {
    UIAlertController *alertViewControler = [UIAlertController alertControllerWithTitle:(@"提示") message:(@"订单无异议，确认收货吗") preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:SSKJLocalized(@"取消", nil) style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
        
    }];
    
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:SSKJLocalized(@"确认", nil) style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
       
        NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
        [params setObject:orderNumber forKey:@"order_id"];
        
        WS(weakSelf);
        // [weakSelf showHudWithString:(@"加载中...")];
        [[WLHttpManager shareManager] requestWithURL_HTTPCode:KUserSureOrder RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
            //   [weakSelf hidHud];
            
            WL_Network_Model *network_Model=[WL_Network_Model mj_objectWithKeyValues:responseObject];
            
            if ([network_Model.status isEqualToString:SUCCEED]) {
                [MBProgressHUD showError:network_Model.msg];
                // [weakSelf loadOrderListDatasWithRquestPage:self.currentPage requestCount:krequstCount];
                [weakSelf.tableView.mj_header beginRefreshing];
            } else {
                [MBProgressHUD showError:network_Model.msg];
                return ;
            }
        } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
            //[weakSelf hidHud];
            WL_Network_Model *network_Model=[WL_Network_Model mj_objectWithKeyValues:responseObject];
            
            if ([WLTools judgeString:network_Model.msg]) {
                [MBProgressHUD showError:network_Model.msg];
                
            } else {
                // [[WL_TipAlert_View sharedAlert] createTip:NetworkFailMessage];
            }
        }];
    }];
    [alertViewControler addAction:cancelAction];
    [alertViewControler addAction:sureAction];
    [self showDetailViewController:alertViewControler sender:nil];
}
//联系商家
- (void)loadContactBussinessOrderDatasWithShopID:(NSString*)shopID {
    ContectShopViewController *vc = [[ContectShopViewController alloc]init];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:shopID forKey:@"shop_id"];
    vc.dataDic = dic;
    [self.navigationController pushViewController:vc animated:YES];
}
//删除订单
- (void)loadDeleteOrderDatasWithOrderNumber:(NSString*)orderNumber indexPath:(NSIndexPath*)indexPath{
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [params setObject:orderNumber forKey:@"order_id"];
    WS(weakSelf);
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:KdeleteOrder RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        //[weakSelf hidHud];
         [MBProgressHUD hideHUDForView:self.view animated:YES];
        WL_Network_Model *network_Model=[WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if ([network_Model.status isEqualToString:SUCCEED]) {
            [MBProgressHUD showError:network_Model.msg];
//            UITableView *tableView = (UITableView*)[self.storeTablesArr objectAtIndex:self.selectedIndex];
//            [self.dataSource  removeObjectAtIndex:[indexPath section]];
            [weakSelf.tableView.mj_header beginRefreshing];
            
            
        } else {
            [MBProgressHUD showError:network_Model.msg];
            return ;
        }
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
       // [weakSelf hidHud];
        WL_Network_Model *network_Model=[WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if ([WLTools judgeString:network_Model.msg]) {
            [MBProgressHUD showError:network_Model.msg];
            
        } else {
            //[[WL_TipAlert_View sharedAlert] createTip:NetworkFailMessage];
        }
    }];
}
//请求支付订单
- (void)loadGoPayOrderDatasWithOrderNumber:(NSString*)orderNumber payPssword:(NSString*)payPassword liuYanMessage:(NSString*)liuYanMessage{
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    
    [params setObject:orderNumber forKey:@"order_id"];
    [params setObject:payPassword forKey:@"jy_password"];

    [params setObject:liuYanMessage forKey:@"liuyan"];
    WS(weakSelf);
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];

    [[WLHttpManager shareManager] requestWithURL_HTTPCode:VPay_Shop_ConfirmPay_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        //[weakSelf hidHud];
       [MBProgressHUD hideHUDForView:self.view  animated:YES];
        WL_Network_Model *network_Model=[WL_Network_Model mj_objectWithKeyValues:responseObject];

        if ([network_Model.status isEqualToString:SUCCEED]){
           // [weakSelf.passwordView hide];
           // [weakSelf loadOrderListDatasWithRquestPage:self.currentPage requestCount:krequstCount];
            
             [weakSelf.tableView.mj_header beginRefreshing];
        } else {
            [MBProgressHUD showError:network_Model.msg];
            return ;
        }
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
       // [weakSelf hidHud];
        WL_Network_Model *network_Model=[WL_Network_Model mj_objectWithKeyValues:responseObject];

        if ([WLTools judgeString:network_Model.msg])
        {
            [MBProgressHUD showError:network_Model.msg];

        }
        else
        {
            //[[WL_TipAlert_View sharedAlert] createTip:NetworkFailMessage];
        }
    }];
}
@end
