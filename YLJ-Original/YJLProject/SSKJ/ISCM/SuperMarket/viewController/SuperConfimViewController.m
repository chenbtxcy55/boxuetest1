


#import "SuperConfimViewController.h"
#import "Super_Myaddress_ViewController.h"
#import "My_SetTPWD_ViewController.h"
#import "Shop_OrderListRoot_VewController.h"
//My_SetTPWD_ViewController.h
#import "SuperOrderComfirmView.h"
#import "ServersContactView.h"

#import "SuperPayMoney_View.h"
#import "RegularExpression.h"
#import "Shop_WriteEmail_View.h"
#import "xiadanViewController.h"

@interface SuperConfimViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) SuperOrderComfirmView *headerView;
@property (nonatomic, strong) xiadanViewController *ensureView;
@property (nonatomic,strong) Shop_WriteEmail_View *email_view;

@end

@implementation SuperConfimViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.page = 1;
    [self.view addSubview:self.tableView];
//    if (_dataDict) {
//        self.headerView.dataDic2=_dataDict;
//        self.title = SSKJLocalized(@"确认订单", nil);
//        [self requstAllAddressListRequst];
//    }
//    else if(_orderId.length){
//        self.title = SSKJLocalized(@"订单详情", nil);
//        [self buyConfimInforRequst];
//    }
    self.title = SSKJLocalized(@"确认订单", nil);
}

-(UITableView *)tableView
{
    if (nil == _tableView) {
        
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight ) style:UITableViewStyleGrouped];
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
        
        _tableView.tableHeaderView = self.headerView;
        

    }
    return _tableView;
}

-(SuperOrderComfirmView *)headerView
{
    if (!_headerView) {
        _headerView = [[SuperOrderComfirmView alloc]init];
        WS(weakSelf);
        _headerView.commitBlock = ^{
            
            [weakSelf confimOrder];

        };
        _headerView.userSureBlock = ^{
            //删除
            UIAlertController *alertViewControler = [UIAlertController alertControllerWithTitle:@"提示" message:@"确认已收货" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:SSKJLocalized(@"取消", nil) style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
                
            }];
            
            UIAlertAction *sureAction = [UIAlertAction actionWithTitle:SSKJLocalized(@"确认", nil) style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
                
                [weakSelf userSuerOrder];

                
            }];
            
            [alertViewControler addAction:cancelAction];
            [alertViewControler addAction:sureAction];
            [weakSelf showDetailViewController:alertViewControler sender:nil];
            
        };
        _headerView.shopSureBlock = ^{
            
            [weakSelf shopSUreOrder];
            
        };
        _headerView.shopCancelBlock  = ^{
            
            //取消
            UIAlertController *alertViewControler = [UIAlertController alertControllerWithTitle:@"提示" message:@"确认取消该订单吗" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:SSKJLocalized(@"取消", nil) style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
                
            }];
            
            UIAlertAction *sureAction = [UIAlertAction actionWithTitle:SSKJLocalized(@"确认", nil) style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
                
                [weakSelf shopCancelOrder];
                
                
            }];
            
            [alertViewControler addAction:cancelAction];
            [alertViewControler addAction:sureAction];
            [weakSelf showDetailViewController:alertViewControler sender:nil];
            
            
            
        };
        _headerView.cancelBlock = ^{
            
            //取消
            UIAlertController *alertViewControler = [UIAlertController alertControllerWithTitle:@"提示" message:@"确认取消该订单吗" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:SSKJLocalized(@"取消", nil) style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
                
            }];
            
            UIAlertAction *sureAction = [UIAlertAction actionWithTitle:SSKJLocalized(@"确认", nil) style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
               
                [weakSelf cancelOrder];
                
                
            }];
            
            [alertViewControler addAction:cancelAction];
            [alertViewControler addAction:sureAction];
            [weakSelf showDetailViewController:alertViewControler sender:nil];
            
            
            
        };
        _headerView.deleteBlock  = ^{
            
            //删除
            UIAlertController *alertViewControler = [UIAlertController alertControllerWithTitle:@"提示" message:@"确认删除此订单吗" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:SSKJLocalized(@"取消", nil) style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
                
            }];
            
            UIAlertAction *sureAction = [UIAlertAction actionWithTitle:SSKJLocalized(@"确认", nil) style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
                
                [weakSelf deleteOrder];
                
                
            }];
            
            [alertViewControler addAction:cancelAction];
            [alertViewControler addAction:sureAction];
            [weakSelf showDetailViewController:alertViewControler sender:nil];
            
        };
        
        _headerView.payBlock = ^{
            SsLog(@"pay");
            
            //支付
            if ([[SSKJ_User_Tool sharedUserTool].userInfoModel.tpwd length] ) {
            
                weakSelf.ensureView.modalPresentationStyle = UIModalPresentationOverFullScreen;
                
                [weakSelf.navigationController presentViewController:weakSelf.ensureView animated:YES completion:^{
                                //
                    weakSelf.ensureView.view.superview.backgroundColor = [UIColor clearColor];
                    
                }];
                
                
                weakSelf.ensureView.messageLabel.text = [NSString stringWithFormat:@"%@ %@",SSKJLocalized(@"金额", nil),weakSelf. headerView.dataDic[@"price"]];
            
            }else{
            
                [MBProgressHUD showError:SSKJLocalized(@"请设置支付密码", nil)];
                
                My_SetTPWD_ViewController *vc = [[My_SetTPWD_ViewController alloc]init];
                [weakSelf.navigationController pushViewController:vc animated:YES];
            }
        };
        
        
        _headerView.hasAddress = NO;
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
-(void)userSuerOrder{
    UIAlertController *alertViewControler = [UIAlertController alertControllerWithTitle:SSKJLocalized(@"提示", nil) message:SSKJLocalized(@"订单无异议，确认收货吗", nil) preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:SSKJLocalized(@"取消", nil) style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
        
    }];
    
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:SSKJLocalized(@"确认", nil) style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
        
        [self userSuerOrder];
        
     
    }];
    [alertViewControler addAction:cancelAction];
    [alertViewControler addAction:sureAction];
    [self showDetailViewController:alertViewControler sender:nil];
    
    
}
-(void)userSureOrder{
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    
    [params setObject:_orderId forKey:@"order_id"];
    
    WS(weakSelf);
    // [weakSelf showHudWithString:(@"加载中...")];
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:KUserSureOrder RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        //   [weakSelf hidHud];
        
        WL_Network_Model *network_Model=[WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if ([network_Model.status isEqualToString:SUCCEED]) {
            [MBProgressHUD showError:network_Model.msg];
            // [weakSelf loadOrderListDatasWithRquestPage:self.currentPage requestCount:krequstCount];
            [weakSelf.tableView.mj_header beginRefreshing];
            [self buyConfimInforRequst];
            
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
}
#pragma  mark 发货

-(void)shopSUreOrder{
    
    self.email_view.hidden = NO;
    
    WS(weakSelf);
    self.email_view.commitBlock = ^(NSString * _Nonnull name, NSString * _Nonnull orderNum) {
        
        [weakSelf loadSendGoodsOrderDatasWithOrderNumber:self->_orderId wuliuName:name wuliuNumber:orderNum];
        weakSelf.email_view.hidden = YES;
    };
}
-(void)shopCancelOrder{
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    
    [params setObject:_orderId forKey:@"order_id"];
    
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:KShopCancelOrder RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        
        WL_Network_Model * netWorkModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        [self.tableView.mj_header endRefreshing];
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([netWorkModel.status integerValue] == SUCCESSED) {
            
            
            [self buyConfimInforRequst];
            
            [self.navigationController popViewControllerAnimated:YES];
            
        }
        
        
        [MBProgressHUD showError:netWorkModel.msg];
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
    }];
}
-(void)deleteOrder{
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    
    [params setObject:_orderId forKey:@"order_id"];
    
    WS(weakSelf);
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:KdeleteOrder RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        //[weakSelf hidHud];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        WL_Network_Model *network_Model=[WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if ([network_Model.status isEqualToString:SUCCEED]) {
            
            [MBProgressHUD showError:network_Model.msg];
           
        
            [weakSelf.navigationController popViewControllerAnimated:YES];
            
            
            
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
-(void)cancelOrder{
    
    [self shopCancelOrder];
    
   
}

-(void)confimOrder{
    
    
    NSMutableDictionary *pamas = [NSMutableDictionary new];
//    goods_id    是    int    商品ID
//    address_id    是    int    地址ID
//    pay_type    是    int    支付方式1:可售，2:待售
//    num    是    int    购买数量
//    note
    if (!self.headerView.model) {
     
        showAlert(SSKJLocalized(@"请选择地址", nil));
        return;
        
    }
    if (!self.headerView.dataDic2) {
        
        showAlert(SSKJLocalized(@"订单错误,无法下单！", nil));
        
        return;
    }
    
    [pamas setObject:self.headerView.model.ID  forKey:@"address_id"];
    
    [pamas setObject:self.headerView.dataDic2[@"goods_id"]  forKey:@"goods_id"];

    [pamas setObject:self.headerView.dataDic2[@"payment_method"]  forKey:@"pay_type"];

    [pamas setObject:self.headerView.dataDic2[@"num"]   forKey:@"num"];

    if (!self.headerView.model) {
        
        showAlert(SSKJLocalized(@"请选择收货地址", nil));

        return;
    }
    
    if (self.headerView.momoView.text.length) {
        
        [pamas setObject:self.headerView.momoView.text forKey:@"note"];

    }
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];

    [[WLHttpManager shareManager]requestWithURL_HTTPCode:KConfimOerder RequestType:RequestTypeGet Parameters:pamas Success:^(NSInteger statusCode, id responseObject) {

        WL_Network_Model * netWorkModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        [self.tableView.mj_header endRefreshing];
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        if ([netWorkModel.status integerValue] == SUCCESSED) {
            WS(weakSelf);

            SuperConfimViewController *vc=[SuperConfimViewController new];
            
            vc.orderId=netWorkModel.data[@"order_id"];
            
         
            
            [weakSelf.navigationController pushViewController:vc animated:YES];
            
            
//            weakSelf.ensureView.modalPresentationStyle = UIModalPresentationOverFullScreen;
//            [weakSelf.navigationController presentViewController:weakSelf.ensureView animated:YES completion:^{
//                //
//                weakSelf.ensureView.view.superview.backgroundColor = [UIColor clearColor];
//            }];
//
//            NSString *typeStr=self->_dataDict[@"payment_method"];
//
//            NSInteger type = [typeStr integerValue];
//
//            CGFloat money;
//
//            if (type ==1) {
//
//                money = [self->_dataDict[@"can_sell_price"] floatValue]*[self->_dataDict[@"num"] floatValue]+[self->_dataDict[@"freight"] floatValue];
//
//            }
//            else{
//
//                money = [self->_dataDict[@"wait_sell_price"] floatValue]*[self->_dataDict[@"num"] floatValue]+[self->_dataDict[@"freight"] floatValue];
//            }
//
//            weakSelf.ensureView.messageLabel.text = [NSString stringWithFormat:@"金额 %@YEC",[WLTools noroundingStringWith:money afterPointNumber:4]];
            
        }else{
            [MBProgressHUD showError:netWorkModel.msg];
        }
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
    }];
}
-(void)requstAllAddressListRequst
{
    //AB_Shop_shop_address_index_post
    NSDictionary *params = @{@"page":@"1",@"size":@"5"};
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
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];

    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self.tableView.mj_header endRefreshing];
    }];
}
-(xiadanViewController *)ensureView
{
    if (!_ensureView) {
        _ensureView = [[xiadanViewController alloc]init];
        _ensureView.conTextFild.secureTextEntry = YES;
        WS(weakSelf);
        
        _ensureView.commitBlock = ^{
        [weakSelf requstPayRequstPsw:weakSelf.ensureView.conTextFild.text];
            
        };
        
        _ensureView.cancelBlock = ^{
            
            
        };
    }
    return _ensureView;
}


-(void)requstPayRequstPsw:(NSString *)pasw

{
    
    if (![RegularExpression validatePassword:pasw]) {
        
        [MBProgressHUD showError:@"请输入正确格式密码"];
        
        return;
    }
   
    NSString *str1=[WLTools md5:pasw];
    
    NSDictionary *pamas = @{@"order_id":_orderId,@"tpwd":str1};

    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:AB_Shop_user_order_pay_post RequestType:RequestTypePost Parameters:pamas Success:^(NSInteger statusCode, id responseObject) {
        
        WL_Network_Model * netWorkModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        if ([netWorkModel.status isEqualToString:@"200"]) {
            
            Shop_OrderListRoot_VewController * vc = [[Shop_OrderListRoot_VewController alloc]init];
            
            [self.navigationController pushViewController:vc animated:YES];
            
        }
        
        else
        {
            
        }
        [MBProgressHUD showError:netWorkModel.msg];
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
    }];
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

-(void)buyConfimInforRequst

{
//    ,@"store_id":_store_id
    NSDictionary *pamas = @{@"order_id":_orderId
                           
                            };
    
      [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:AB_Shop_user_order_confirm RequestType:RequestTypePost Parameters:pamas Success:^(NSInteger statusCode, id responseObject) {
        
        WL_Network_Model * netWorkModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        if ([netWorkModel.status isEqualToString:@"200"]) {
            
            
            if (![[netWorkModel.data objectForKey:@"order_detail"] isKindOfClass:[NSNull class]]) {
                
                NSMutableDictionary *dict=[[netWorkModel.data objectForKey:@"order_detail"] mutableCopy];
                [dict setObject:[NSString stringWithFormat:@"%d",self->_isShop] forKey:@"isShop"];
                
            
                self.headerView.dataDic =dict;
                
            }
           
           
            if (![[netWorkModel.data objectForKey:@"user_detail"] isKindOfClass:[NSNull class]]) {
                
                self.headerView.adressDict=netWorkModel.data[@"user_detail"];
                
            }
            
         
        }
        
        else
        {
            
        }
       // [MBProgressHUD showError:netWorkModel.msg];
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
    }];
    
    /* ;*/
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    

    
  
}
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
            
            
            [self buyConfimInforRequst];
            
            
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

@end
