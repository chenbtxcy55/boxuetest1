
#import "Shop_Already_ViewController.h"
#import "Shop_GoodsList_TableViewCell.h"
#import "ICC_PreOrder_GoodsInfo_Model.h"
#import "Shop_PublishView_ViewController.h"

#define kPageSize @"100"

@interface Shop_Already_ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, assign) NSInteger page;
@end

@implementation Shop_Already_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.page = 1;
    [self.view addSubview:self.tableView];
    [kNotifyCenter addObserver:self selector:@selector(reloadOther1:) name:@"reloadOther1" object:nil];
}
-(void)setBottomLine:(CGFloat)bottomLine{
    
    _bottomLine=bottomLine;
    
    self.tableView.frame= CGRectMake(0, 0, ScreenWidth, ScreenHeight-self.bottomLine- (Height_TabBar -49));
    
   
}
-(void)reloadOther1:(NSNotification *)noti
{
    self.page = 1;

    [self requesttransferList];
    
}
-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.page = 1;
    
    [self requesttransferList];
}
-(UITableView *)tableView
{
    if (nil == _tableView) {
        
        NSLog(@"bottomLine:::%f",self.bottomLine);
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight- Height_TabBar -self.bottomLine) style:UITableViewStyleGrouped];
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        if (@available(iOS 11.0, *))
        {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            _tableView.estimatedRowHeight = 100;
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


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ScaleW(240);
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
    Shop_GoodsList_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Shop_GoodsList_TableViewCell"];
    if (cell == nil) {
        cell = [[Shop_GoodsList_TableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"Shop_GoodsList_TableViewCell"];
    }
    ICC_PreOrder_GoodsInfo_Model *goodsModel = self.dataSource[indexPath.row];
    [cell setCellWithModel:goodsModel goodsType:1];
    WS(weakSelf);
    cell.upGoodsBlock = ^(ICC_PreOrder_GoodsInfo_Model *model) {
        [weakSelf upGoodsWithModle:model];
    };
    
    cell.downGoodsBlock = ^(ICC_PreOrder_GoodsInfo_Model *model) {
        UIAlertController *alertViewControler = [UIAlertController alertControllerWithTitle:@"提示" message:@"确认下架该商品吗" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:SSKJLocalized(@"取消", nil) style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
            
        }];
        
        UIAlertAction *sureAction = [UIAlertAction actionWithTitle:SSKJLocalized(@"确认", nil) style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
            
            [weakSelf downGoodsWithModle:model];

            
        }];
        
        [alertViewControler addAction:cancelAction];
        [alertViewControler addAction:sureAction];
        [self showDetailViewController:alertViewControler sender:nil];
        
    };
    
    cell.deleteBlock = ^(ICC_PreOrder_GoodsInfo_Model *model) {
        [weakSelf deleteGoodsWithModle:model];
    };
    
    cell.editBlock = ^(ICC_PreOrder_GoodsInfo_Model *model) {
        [weakSelf editGoodsWithModle:model];
        
    };
    
    return cell;
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
    
    NSDictionary *params =@{@"p":@(_page),
                            @"size":kPageSize};
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:ShangJiaGoodsList_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        
        WL_Network_Model *net_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if (net_model.status.integerValue == 200) {
            
            [weakSelf handleDataWith:net_model];
            
            !weakSelf.backBlock?:weakSelf.backBlock([net_model.data[@"on"] integerValue]);
          
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

-(void)handleDataWith:(WL_Network_Model *)model
{
    if (_page == 1) {
        [self.dataSource removeAllObjects];
    }
    
    NSArray *array = [ICC_PreOrder_GoodsInfo_Model mj_objectArrayWithKeyValuesArray:model.data[@"goods"]];
    if (array.count != [kPageSize integerValue]) {
        self.tableView.mj_footer.state = MJRefreshStateNoMoreData;
    }else{
        self.tableView.mj_footer.state = MJRefreshStateIdle;
    }
    [self.dataSource addObjectsFromArray:array];
    
    if (self.page == 1) {
        [self.dataSource removeAllObjects];
    }
    
    [self.dataSource addObjectsFromArray:array];
    
    [SSKJ_NoDataView showNoData:self.dataSource.count toView:self.tableView offY:ScaleW(40)];
    
    [self endRefresh];
    
    [self.tableView reloadData];
    
    self.page++;
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
};

#pragma mark 上架商品
-(void)upGoodsWithModle:(ICC_PreOrder_GoodsInfo_Model *)model
{
    NSDictionary *dict=@{
                         @"goods_id":model.id,
                         @"store_id":model.store_id
                         };
    
    WS(weakSelf);
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:KShangJiaURL RequestType:RequestTypePost Parameters:dict Success:^(NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        WL_Network_Model *network_Model=[WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if ([network_Model.status isEqualToString:SUCCEED])
        {
            [weakSelf.tableView.mj_header beginRefreshing];
            
            [kNotifyCenter postNotificationName:@"reloadOther1" object:nil];
        }
        else
        {
            [MBProgressHUD showError:network_Model.msg];
            
            return ;
        }
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        WL_Network_Model *network_Model=[WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        [MBProgressHUD showError:network_Model.msg];
    }];
}


#pragma mark 下架商品
-(void)downGoodsWithModle:(ICC_PreOrder_GoodsInfo_Model *)model
{
    
    
    NSDictionary *dict=@{
                         @"goods_id":model.id,
                         @"store_id":model.store_id
                         };
    
     //WlLog(@"\r上下架商品->请求参数：%@",dict);
    
    
    WS(weakSelf);
    
     [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:VPay_Shop_UpGoods_URL RequestType:RequestTypePost Parameters:dict Success:^(NSInteger statusCode, id responseObject) {
         [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        WL_Network_Model *network_Model=[WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if ([network_Model.status isEqualToString:SUCCEED])
        {
            [weakSelf.tableView.mj_header beginRefreshing];
            [kNotifyCenter postNotificationName:@"reloadOther2" object:nil];
        }
        else
        {
          [MBProgressHUD showError:network_Model.msg];
            
            return ;
        }
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
         [MBProgressHUD hideHUDForView:self.view animated:YES];
        WL_Network_Model *network_Model=[WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if ([WLTools judgeString:network_Model.msg])
        {
          [MBProgressHUD showError:network_Model.msg];
            
        }
        else
        {
            
        }
    }];
}


#pragma mark  删除商品

-(void)deleteGoodsWithModle:(ICC_PreOrder_GoodsInfo_Model *)model
{
    WS(weakSelf);
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"提醒" message:@"是否确定删除该商品" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:SSKJLocalized(@"取消", nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action){
     
    }];
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:SSKJLocalized(@"确认", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf requestDeleteGoodsWithModle:model];
   
    }];
    [alertVc addAction:cancleAction];
    [alertVc addAction:confirmAction];
    alertVc.modalPresentationStyle = UIModalPresentationFullScreen;

    [self.navigationController presentViewController:alertVc animated:YES completion:nil];
 
}


-(void)requestDeleteGoodsWithModle:(ICC_PreOrder_GoodsInfo_Model *)model
{
    NSDictionary *dict=@{
                         @"id":model.id,
                         @"op":@(2)
                         };
    
     //WlLog(@"\r上下架商品->请求参数：%@",dict);
    
    
    WS(weakSelf);
    
     [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:VPay_Shop_DeleteGoods_URL RequestType:RequestTypePost Parameters:dict Success:^(NSInteger statusCode, id responseObject) {
         [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        WL_Network_Model *network_Model=[WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if ([network_Model.status isEqualToString:SUCCEED])
        {
            [weakSelf.tableView.mj_header beginRefreshing];
        }
        else
        {
          [MBProgressHUD showError:network_Model.msg];
            
            return ;
        }
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
         [MBProgressHUD hideHUDForView:self.view animated:YES];
        WL_Network_Model *network_Model=[WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if ([WLTools judgeString:network_Model.msg])
        {
          [MBProgressHUD showError:network_Model.msg];
            
        }
        else
        {
            
        }
    }];
}



#pragma mark  编辑商品
-(void)editGoodsWithModle:(ICC_PreOrder_GoodsInfo_Model *)model
{
//    VPay_Shop_Edit_Goods_Controller *addGoodsVc = [[VPay_Shop_Edit_Goods_Controller alloc]init];
//    addGoodsVc.addGoods_type = AddGoodsTypeEdit;
//    addGoodsVc.goodsInfo_model = model;
//    [self.navigationController pushViewController:addGoodsVc animated:YES];
    Shop_PublishView_ViewController *vc = [[Shop_PublishView_ViewController alloc]init];
    vc.model = model;
    
    [self.navigationController pushViewController:vc animated:YES];
}

-(NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

@end
