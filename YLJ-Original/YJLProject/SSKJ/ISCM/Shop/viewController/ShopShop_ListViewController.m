
#import "ShopShop_ListViewController.h"
#import "Shop_OrderDetail_ViewController.h"

#import "ShopShop_OrderListTableViewCell.h"
#import "ICC_Mall_Preorder_Model.h"
#import "NSString+Conversion.h"
#import "SuperPayMoney_View.h"
#import "Shop_WriteEmail_View.h"
#import "SuperConfimViewController.h"

#define kPageSize @"100"


@interface ShopShop_ListViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) SuperPayMoney_View *ensureView;
@property (nonatomic, strong) Shop_WriteEmail_View *email_view;
//@property (nonatomic, strong) Shop_WriteEmail_View *email_view;
@end

@implementation ShopShop_ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
 
    [self.view addSubview:self.tableView];
}
-(void)refreshData{
    
    [self.tableView.mj_header beginRefreshing];
    
    
}
-(Shop_WriteEmail_View *)email_view
{
    if (!_email_view) {
        _email_view = [[Shop_WriteEmail_View alloc]init];
        WS(weakSelf);
        _email_view.hidden = YES;
        _email_view.cancellBlock = ^{
            weakSelf.email_view.hidden = YES;
        };
        _email_view.commitBlock = ^(NSString * _Nonnull name, NSString * _Nonnull orderNum) {
            
        };
       
    }
    return _email_view;
}
-(void)viewWillAppear:(BOOL)animated

{
    [super viewWillAppear:animated];
    [self.tableView.mj_header beginRefreshing];
    self.page = 1;
    [self requesttransferList];
}
-(UITableView *)tableView
{
    if (nil == _tableView) {
        
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight -  ScaleW(45) - Height_NavBar) style:UITableViewStyleGrouped];
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
        
        _tableView.separatorColor = kMainColor;
        
        _tableView.backgroundColor = kMainColor;

        [_tableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
        
        // [_tableView registerClass:[JB_FBC_DealHall_Cell class] forCellReuseIdentifier:cellid];
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

#pragma mark - UITableViewDelegate UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    //return ScaleW(300);
    return [(ShopShop_OrderListTableViewCell*)cell cellFactHight];
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
    ShopShop_OrderListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Shop_OrderList_TableViewCell"];
    if (cell == nil) {
        cell = [[ShopShop_OrderListTableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"Shop_OrderList_TableViewCell"];
    }
    
    NSDictionary *dic = self.dataSource[indexPath.row];
    cell.delegate = (id<ICC_Mall_BusinessOrderList_ViewCellDelegate>)self;
    
    cell.indexPath = indexPath;
    
    [cell updateViewWithOrderDatas:dic];
    
    
    return cell;
}
-(SuperPayMoney_View *)ensureView
{
    if (!_ensureView) {
        _ensureView = [[SuperPayMoney_View alloc]init];
        _ensureView.conTextFild.secureTextEntry = YES;
        _ensureView.messageLabel.hidden = YES;
        WS(weakSelf);
        weakSelf.ensureView.hidden = YES;
        _ensureView.commitBlock = ^{
            //[weakSelf requstPayRequstPsw:weakSelf.ensureView.conTextFild.text];
            weakSelf.ensureView.hidden = YES;
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
    
    
    //    if (self.dealType == BuySellTypeSell) {
    //        type = @"1";
    //    }
   
    NSArray *typeArray=@[@"all",@"wait_pay",@"already_pay",@"already_shipments",@"already_complete"];
    
    NSString *type=typeArray[_selectedIndex];
    
    NSDictionary *params = @{
                             @"status":type,
                             @"p":@(self.page),
                             @"size":kPageSize
                             
                             };
 
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:VPay_Shop_shop_order_index_post_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
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
        
        //[MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
    }];
}



-(void)handleRecordListWith:(WL_Network_Model *)net_model
{
    
    NSArray *array = [net_model.data objectForKey:@"orders"];
    
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SuperConfimViewController *vc=[SuperConfimViewController new];
    
  
    NSDictionary *dic = self.dataSource[indexPath.row];
    vc.orderId = dic[@"order_id"];
    vc.isShop = YES;
    
    [self.navigationController pushViewController:vc animated:YES];
}

-(NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}
#pragma mark -- ICC_MallViewCellDelegate

-(void)selectedOrderAtIndexPath:(NSIndexPath*)indexPath userHandleType:(ICC_Mall_BusinessOrderType)handleType {
    NSDictionary *dataDic = [self.dataSource objectAtIndex:indexPath.section];
   
    NSString *orderId = [NSString stringTransformObject:[dataDic objectForKey:@"order_id"]];
    if (handleType == ksureSendSendGoodOrderEvent) {//确认发货订单

        
        self.email_view.hidden = NO;
        WS(weakSelf);
        self.email_view.commitBlock = ^(NSString * _Nonnull name, NSString * _Nonnull orderNum) {
            [weakSelf loadSendGoodsOrderDatasWithOrderNumber:orderId wuliuName:name wuliuNumber:orderNum];
            weakSelf.email_view.hidden = YES;
        };
    }
#pragma mark    取消订单
    else if (handleType == kcancelHadFinishedOrderEvent) {
        UIAlertController *alertViewControler = [UIAlertController alertControllerWithTitle:@"提示" message:@"确认取消该订单吗" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:SSKJLocalized(@"取消", nil) style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
            
        }];
        
        UIAlertAction *sureAction = [UIAlertAction actionWithTitle:SSKJLocalized(@"确认", nil) style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
            
            [self cancelOrderID:orderId andIndex:indexPath];
            
        }];
        
        [alertViewControler addAction:cancelAction];
        [alertViewControler addAction:sureAction];
        [self showDetailViewController:alertViewControler sender:nil];
    }
    else if (handleType == kdeleteHadFinishedOrderEvent) {//删除订单
        UIAlertController *alertViewControler = [UIAlertController alertControllerWithTitle:@"提示" message:@"确认删除此订单吗" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:SSKJLocalized(@"取消", nil) style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
            
        }];
        
        UIAlertAction *sureAction = [UIAlertAction actionWithTitle:SSKJLocalized(@"确认", nil) style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
            //            [self loadDeleteOrderDatasWithOrderNumber:orderId indexPath:indexPath];
        }];
        
        [alertViewControler addAction:cancelAction];
        [alertViewControler addAction:sureAction];
        [self showDetailViewController:alertViewControler sender:nil];
    }
}
-(void)cancelOrderID:(NSString*)orderId andIndex:(NSIndexPath*)indexpath{
    
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [params setObject:orderId forKey:@"order_id"];
    
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:KShopCancelOrder RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        
        WL_Network_Model * netWorkModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        [self.tableView.mj_header endRefreshing];

        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([netWorkModel.status integerValue] == SUCCESSED) {
        
            [self requesttransferList];
            [self.tableView.mj_header endRefreshing];

        }
        
        
        [MBProgressHUD showError:netWorkModel.msg];

    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
    }];
}
- (NSString *)orderListStatus {
    switch (self.selectedIndex) {
        case 0:
            return @"";
            break;
        case 1:
            return @"unpay";
            break;
        case 2:
            return @"wait_fahuo";
            break;
        case 3:
            return @"wait_shouhuo";
            break;
        case 4:
            return @"finish";
            break;
        default:
            return @"";
            break;
    }
}
//确发收货
#pragma mark 发货

- (void)loadSendGoodsOrderDatasWithOrderNumber:(NSString*)orderNumber wuliuName:(NSString *)wuliuName wuliuNumber:(NSString *)wuliuNumber{
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [params setObject:orderNumber forKey:@"order_id"];
    [params setObject:wuliuName forKey:@"shipping_comp_name"];
    [params setObject:wuliuNumber forKey:@"shipping_sn"];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:VPay_Shop_BusinessOrderHandle_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        WL_Network_Model *network_Model=[WL_Network_Model mj_objectWithKeyValues:responseObject];
  
        if ([network_Model.status isEqualToString:SUCCEED]) {
            [MBProgressHUD showError:network_Model.msg];
            
            [self requesttransferList];
            
        } else {
            [MBProgressHUD showError:network_Model.msg];
            return ;
        }
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        WL_Network_Model *network_Model=[WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if ([WLTools judgeString:network_Model.msg]) {
             [MBProgressHUD showError:network_Model.msg];
            
        } else {
            
        }
    }];
}

@end
