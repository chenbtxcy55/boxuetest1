

#import "Shop_OrderDetail_ViewController.h"
#import "Shop_OrderDetail_HeaderView.h"
#import "Shop_WriteEmail_View.h"
#import "ServersContactView.h"
#import "NSString+Conversion.h"
#import "SuperPayMoney_View.h"
#import "Super_Myaddress_ViewController.h"
#import "ContectShopViewController.h"

@interface Shop_OrderDetail_ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) Shop_OrderDetail_HeaderView *headerView;
@property (nonatomic, strong) Shop_WriteEmail_View *email_view;
@property (nonatomic, strong) SuperPayMoney_View *ensureView;

@end

@implementation Shop_OrderDetail_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.page = 1;
    [self.view addSubview:self.tableView];
    self.title = SSKJLocalized(@"订单详情", nil);
    
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
//            [weakSelf requstPayRequstPsw:weakSelf.ensureView.conTextFild.text];
            
            weakSelf.ensureView.hidden = YES;
        };
    }
    return _ensureView;
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
        
        
        [_tableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
        
        _tableView.tableHeaderView = self.headerView;
        
   
    }
    return _tableView;
}
-(Shop_OrderDetail_HeaderView *)headerView
{
    if (!_headerView) {
        _headerView = [[Shop_OrderDetail_HeaderView alloc]init];
        WS(weakSelf);
        _headerView.commitBlock = ^{
            weakSelf.email_view.hidden = NO;
        };
        _headerView.isShop = self.isShop;
        
        _headerView.canCoopy = self.isShop;
        
        _headerView.order_id = _order_id;
        
        _headerView.bottomClickedFist = ^(ICC_Mall_OrderDetail_HandleItemType bottomItemType)
        {
            [weakSelf setActionsWithType:bottomItemType];
        };
        _headerView.bottomClickedSecend = ^(ICC_Mall_OrderDetail_HandleItemType bottomItemType) {
            [weakSelf setActionsWithType:bottomItemType];
        };
        
        _headerView.gotoAddressBlock = ^{
            Super_Myaddress_ViewController *vc = [[Super_Myaddress_ViewController alloc]init];
            vc.type = 1;
            [weakSelf.navigationController pushViewController:vc animated:YES];
            
            vc.callBackBlcok = ^(AddressMessageModel * _Nonnull model) {
                weakSelf.headerView.model = model;
            };
        };
    }
    
    return _headerView;
}

-(void)setActionsWithType:(ICC_Mall_OrderDetail_HandleItemType)handleItemType
{
    NSString *orderId = [NSString stringTransformObject:[self.headerView.dataDic objectForKey:@"id"]];
    if (self.headerView.isShop == NO) {
        WS(weakSelf);
        if (handleItemType == kuserCancelOrderEvent) {//取消订单
            
                        UIAlertController *alertViewControler = [UIAlertController alertControllerWithTitle:@"提示" message:@"确认取消该订单吗" preferredStyle:UIAlertControllerStyleAlert];
            
                        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:SSKJLocalized(@"取消", nil) style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
            
                        }];
            
                        UIAlertAction *sureAction = [UIAlertAction actionWithTitle:SSKJLocalized(@"确认", nil) style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
                            [self loadUserCancelOrderDatasWithOrderNumber:orderId];
                        }];
            
                        [alertViewControler addAction:cancelAction];
                        [alertViewControler addAction:sureAction];
                        [self showDetailViewController:alertViewControler sender:nil];
            //[weakSelf.cancleAlertView showWithTitle:@"" message:(@"便宜不等人，请三思而行~")];
            
        } else if (handleItemType == kuserGoPayOrderEvent) {//去支付
            
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];

            NSString *liuYan = [userDefaults objectForKey:@"userLiuYan"];
            if (liuYan.length == 0) {
                liuYan = [self.headerView.dataDic objectForKey:@"liuyan"];
            }
            weakSelf.ensureView.hidden = NO;
            weakSelf.ensureView.commitBlock = ^{
                [weakSelf gotoPayRequstPamasPwd:weakSelf.ensureView.conTextFild.text orderID:orderId];
                weakSelf.ensureView.hidden = YES;
            };
        } else if (handleItemType == kuserSureOrderEvent) {//确认订单
           // [self loadUserSureReceivingGoodsOrderDatasWithOrderNumber:orderId];
        } else if (handleItemType == kuserDeleteOrderEvent) {//删除订单
            UIAlertController *alertViewControler = [UIAlertController alertControllerWithTitle:(@"提示") message:(@"确认删除此订单吗") preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:SSKJLocalized(@"取消", nil) style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
                
            }];
            
            UIAlertAction *sureAction = [UIAlertAction actionWithTitle:SSKJLocalized(@"确认", nil) style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
                [self loadUserDeleteOrderDatasWithOrderNumber:orderId];
            }];
            
            [alertViewControler addAction:cancelAction];
            [alertViewControler addAction:sureAction];
            [self showDetailViewController:alertViewControler sender:nil];
        } else if (handleItemType == kuserContactShopEvent) {//联系商家
            [self loadContactBussinessOrderDatasWithShopID:[NSString stringTransformObject:[self.headerView.dataDic objectForKey:@"shop_id"]]];
        }
    } else if (self.headerView.isShop == YES) {
        
        if (handleItemType == kbusnessSendGoodsOrederEvent) {//商家确认发货
            WS(weakSelf);
            self.email_view.hidden = NO;
            self.email_view.commitBlock = ^(NSString * _Nonnull name, NSString * _Nonnull orderNum) {
                [weakSelf loadSendGoodsOrderDatasWithOrderNumber:orderId wuliuName:name wuliuNumber:orderNum];
                weakSelf.email_view.hidden = YES;
            };
            return;
            
            
            
        }
        
    }
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
//        _email_view.commitBlock = ^{
//            weakSelf.email_view.hidden = YES;
//        };
    }
    return _email_view;
}
#pragma mark - UITableViewDelegate UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ScaleW(210);
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Shop_OrderList_TableViewCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"Shop_OrderList_TableViewCell"];
    }
    
    return cell;
}

#pragma mark - 上拉、下拉

-(void)headerRefresh
{
    self.page = 1;
    //[self requesttransferList];
    
    if (kLogin) {
        //        [self requestUserInfo];
        //        [self requestPayList];
    }
    
}

-(void)footerRefresh
{
    //[self requesttransferList];
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


//取消订单[用户]
- (void)loadUserCancelOrderDatasWithOrderNumber:(NSString*)orderNumber{
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [params setObject:orderNumber forKey:@"order_id"];
    [params setObject:@"cancel" forKey:@"op"];
    WS(weakSelf);
    //[weakSelf showHudWithString:Languaue1(@"加载中...")];
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:VPay_Shop_UserOrderHandle_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        //[weakSelf hidHud];
        
        WL_Network_Model *network_Model=[WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if ([network_Model.status isEqualToString:SUCCEED]) {
            //[[WL_TipAlert_View sharedAlert] createTip:network_Model.msg];
            
            [weakSelf.headerView loadOrderDetailDatas];
            
        } else {
           // [[WL_TipAlert_View sharedAlert] createTip:network_Model.msg];
            return ;
        }
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
       // [weakSelf hidHud];
        WL_Network_Model *network_Model=[WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if ([WLTools judgeString:network_Model.msg]) {
           // [[WL_TipAlert_View sharedAlert] createTip:network_Model.msg];
            
        } else {
           // [[WL_TipAlert_View sharedAlert] createTip:NetworkFailMessage];
        }
    }];
}
//确认收货[用户]
- (void)loadUserSureReceivingGoodsOrderDatasWithOrderNumber:(NSString*)orderNumber {
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [params setObject:orderNumber forKey:@"order_id"];
    [params setObject:@"finish" forKey:@"op"];
    WS(weakSelf);
   // [weakSelf showHudWithString:Languaue1(@"加载中...")];
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:VPay_Shop_UserOrderHandle_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        //[weakSelf hidHud];
        
        WL_Network_Model *network_Model=[WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if ([network_Model.status isEqualToString:SUCCEED]) {
            //[[WL_TipAlert_View sharedAlert] createTip:network_Model.msg];
            [weakSelf.headerView loadOrderDetailDatas];
            
        } else {
            //[[WL_TipAlert_View sharedAlert] createTip:network_Model.msg];
            return ;
        }
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
       // [weakSelf hidHud];
        WL_Network_Model *network_Model=[WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if ([WLTools judgeString:network_Model.msg]) {
           // [[WL_TipAlert_View sharedAlert] createTip:network_Model.msg];
            
        } else {
            //[[WL_TipAlert_View sharedAlert] createTip:NetworkFailMessage];
        }
    }];
}
//联系商家[用户]
- (void)loadContactBussinessOrderDatasWithShopID:(NSString*)shopID {
//    VPay_Shop_ShopDetail_Controller *shopDetailVC = [[VPay_Shop_ShopDetail_Controller alloc]init];
//    shopDetailVC.shop_id = shopID;
//    [self.navigationController pushViewController:shopDetailVC animated:YES];
    ContectShopViewController *vc = [[ContectShopViewController alloc]init];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:shopID forKey:@"shop_id"];
    vc.dataDic = dic;
    [self.navigationController pushViewController:vc animated:YES];
    
}
//删除订单[用户]
- (void)loadUserDeleteOrderDatasWithOrderNumber:(NSString*)orderNumber{
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [params setObject:orderNumber forKey:@"order_id"];
    [params setObject:@"delete" forKey:@"op"];
    WS(weakSelf);
   // [weakSelf showHudWithString:Languaue1(@"加载中...")];
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:VPay_Shop_UserOrderHandle_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        //[weakSelf hidHud];
        
        WL_Network_Model *network_Model=[WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if ([network_Model.status isEqualToString:SUCCEED]) {
           // [[WL_TipAlert_View sharedAlert] createTip:network_Model.msg];
            [weakSelf.navigationController popViewControllerAnimated:YES];
            
        } else {
            //[[WL_TipAlert_View sharedAlert] createTip:network_Model.msg];
            return ;
        }
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        //[weakSelf hidHud];
        WL_Network_Model *network_Model=[WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if ([WLTools judgeString:network_Model.msg]) {
           // [[WL_TipAlert_View sharedAlert] createTip:network_Model.msg];
            
        } else {
            //[[WL_TipAlert_View sharedAlert] createTip:NetworkFailMessage];
        }
    }];
}
//请求支付订单[用户]
- (void)loadUserGoPayOrderDatasWithOrderNumber:(NSString*)orderNumber payPssword:(NSString*)payPassword liuYanMessage:(NSString*)liuYanMessage{
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [params setObject:orderNumber forKey:@"order_id"];
    [params setObject:payPassword forKey:@"jy_password"];
    if (self.headerView.dataDic) {
        [params setObject:self.headerView.dataDic[@"id"] forKey:@"address_id"];
    }else{
        [params setObject:@"" forKey:@"address_id"];
    }
    [params setObject:liuYanMessage forKey:@"liuyan"];
    WS(weakSelf);
    
    //[weakSelf showHudWithString:Languaue1(@"加载中...")];
    
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:VPay_Shop_ConfirmPay_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        //[weakSelf hidHud];
        
        WL_Network_Model *network_Model=[WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if ([network_Model.status isEqualToString:SUCCEED]){
           // [weakSelf.passwordView hide];
            [weakSelf.headerView loadOrderDetailDatas];
        } else {
           // [[WL_TipAlert_View sharedAlert] createTip:network_Model.msg];
            return ;
        }
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
       // [weakSelf hidHud];
        WL_Network_Model *network_Model=[WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if ([WLTools judgeString:network_Model.msg])
        {
           // [[WL_TipAlert_View sharedAlert] createTip:network_Model.msg];
            
        }
        else
        {
            //[[WL_TipAlert_View sharedAlert] createTip:NetworkFailMessage];
        }
    }];
}

//确发收货[商家]
- (void)loadBusiSendGoodsOrderDatasWithOrderNumber:(NSString*)orderNumber wuliuName:(NSString *)wuliuName wuliuNumber:(NSString *)wuliuNumber{
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [params setObject:orderNumber forKey:@"order_id"];
    [params setObject:@"fahuo" forKey:@"op"];
    [params setObject:wuliuName forKey:@"wuliuname"];
    [params setObject:wuliuNumber forKey:@"wuliudan"];
    WS(weakSelf);
   // [weakSelf showHudWithString:Languaue1(@"加载中...")];
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:VPay_Shop_BusinessOrderHandle_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
       // [weakSelf hidHud];
        
        WL_Network_Model *network_Model=[WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if ([network_Model.status isEqualToString:SUCCEED]) {
            //[[WL_TipAlert_View sharedAlert] createTip:network_Model.msg];
            [weakSelf.headerView loadOrderDetailDatas];
            
        } else {
            //[[WL_TipAlert_View sharedAlert] createTip:network_Model.msg];
            return ;
        }
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
       // [weakSelf hidHud];
        WL_Network_Model *network_Model=[WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if ([WLTools judgeString:network_Model.msg]) {
           // [[WL_TipAlert_View sharedAlert] createTip:network_Model.msg];
            
        } else {
            //[[WL_TipAlert_View sharedAlert] createTip:NetworkFailMessage];
        }
    }];
}
//删除订单[商家]
- (void)loadBusinessDeleteOrderDatasWithOrderNumber:(NSString*)orderNumber{
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [params setObject:orderNumber forKey:@"order_id"];
    [params setObject:@"delete" forKey:@"op"];
    WS(weakSelf);
    //[weakSelf showHudWithString:Languaue1(@"加载中...")];
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:VPay_Shop_BusinessOrderHandle_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
       // [weakSelf hidHud];
        
        WL_Network_Model *network_Model=[WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if ([network_Model.status isEqualToString:SUCCEED]) {
            //[[WL_TipAlert_View sharedAlert] createTip:network_Model.msg];
            [weakSelf.navigationController popViewControllerAnimated:YES];
            
        } else {
           // [[WL_TipAlert_View sharedAlert] createTip:network_Model.msg];
            return ;
        }
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
       // [weakSelf hidHud];
       // WL_Network_Model *network_Model=[WL_Network_Model mj_objectWithKeyValues:responseObject];
        
//        if ([WLTools judgeString:network_Model.msg]) {
//            //[[WL_TipAlert_View sharedAlert] createTip:network_Model.msg];
//
//        } else {
//           // [[WL_TipAlert_View sharedAlert] createTip:NetworkFailMessage];
//        }
    }];
}

-(void)gotoPayRequstPamasPwd:(NSString *)paw orderID:(NSString *)orderID
{
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:VPay_Shop_BusinessOrderHandle_URL RequestType:RequestTypePost Parameters:@{@"order_id":orderID,@"jy_password":paw} Success:^(NSInteger statusCode, id responseObject) {
        // [weakSelf hidHud];
        
        WL_Network_Model *network_Model=[WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if ([network_Model.status isEqualToString:SUCCEED]) {
            //[[WL_TipAlert_View sharedAlert] createTip:network_Model.msg];
            [self.navigationController popViewControllerAnimated:YES];
            
        } else {
            // [[WL_TipAlert_View sharedAlert] createTip:network_Model.msg];
            return ;
        }
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        
        //        }
    }];
}
//确发收货
- (void)loadSendGoodsOrderDatasWithOrderNumber:(NSString*)orderNumber wuliuName:(NSString *)wuliuName wuliuNumber:(NSString *)wuliuNumber{
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
//    order_id    是    int    订单ID
//    shipping_comp_name    是    string    物流公司名称
//    shipping_sn
    [params setObject:orderNumber forKey:@"order_id"];

    [params setObject:wuliuName forKey:@"shipping_comp_name"];
    [params setObject:wuliuNumber forKey:@"shipping_sn"];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:VPay_Shop_BusinessOrderHandle_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        WL_Network_Model *network_Model=[WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if ([network_Model.status isEqualToString:SUCCEED]) {
            [MBProgressHUD showError:network_Model.msg];
            
//            [self requstAllAddressListRequst];

             [self.headerView loadOrderDetailDatas];
            
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

-(void)requstAllAddressListRequst
{
    //AB_Shop_shop_address_index_post
    NSDictionary *params = @{@"page":@"1",@"size":@"50"};
    WS(weakSelf);
    
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:AB_Shop_shop_address_index_post RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        WL_Network_Model * netWorkModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([netWorkModel.status isEqualToString:@"200"]) {
            
            NSMutableArray *array = [NSMutableArray array];
            
            for (NSDictionary *dic in [netWorkModel.data objectForKey:@"res"])
            {
                AddressMessageModel *model = [[AddressMessageModel alloc]init];
                [model setValuesForKeysWithDictionary:dic];
                [array addObject:model];
                
            }
            if (!array.count) {
                self.headerView.hasAddress = NO;
            }else{
                self.headerView.model = array.firstObject;
            }
            
            
            
        }
        else
        {
            [MBProgressHUD showError:netWorkModel.msg];
        }
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self.tableView.mj_header endRefreshing];
    }];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self requstAllAddressListRequst];
}
@end
