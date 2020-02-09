

#import "Super_Myaddress_ViewController.h"
#import "super_AddAddressViewController.h"
#import "AddressRdtingTableViewCell.h"
#import "AddressMessageModel.h"
#import "YLJ_AddressListTableViewCell.h"

@interface Super_Myaddress_ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataAray;
@property (nonatomic, strong)SSKJ_UserInfo_Model *userModel;
@property (nonatomic,strong) UIButton *bottomBtn;
@property (nonatomic,strong) YLJ_AddressListTableViewCell *seletedCell;
//@property (nonatomic,strong) YLJ_AddressListTableViewCell *defaultCell;
@property (nonatomic, copy) NSString *seletedID;
@property (nonatomic) BOOL isDelete;



@end

@implementation Super_Myaddress_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.isDelete = YES;
    self.title = SSKJLocalized(@"收货地址", nil);
    [self.view addSubview:self.tableView];
    
    [self addRightNavItemWithTitle:SSKJLocalized(@"管理", nil) color:kMainWihteColor font:systemFont(ScaleW(15))];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self.view addSubview:self.bottomBtn];
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [self requstUserInfor];
    [self requstAllAddressListRequst];
}
-(NSArray *)dataAray{
    if (!_dataAray) {
        _dataAray = [NSMutableArray array];
    }
    return _dataAray;
}
-(UITableView *)tableView
{
    if (nil == _tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, ScaleW(10),ScreenWidth, ScreenHeight - ScaleW(10) - Height_NavBar) style:UITableViewStyleGrouped];
        if (_type == 1) {
            _tableView.frame = CGRectMake(0, ScaleW(10),ScreenWidth, ScreenHeight - ScaleW(10));
        }
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerNib:[UINib nibWithNibName:@"YLJ_AddressListTableViewCell" bundle:nil] forCellReuseIdentifier:@"YLJ_AddressListTableViewCell"];
        [_tableView setCornerRadius:ScaleW(10)];
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
        
        _tableView.backgroundColor = kMainColor;
        [_tableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
        WS(weakSelf);
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weakSelf requstAllAddressListRequst];
        }];
        
    }
    return _tableView;
}

- (UIButton *)bottomBtn {
    if (!_bottomBtn) {
        _bottomBtn = [FactoryUI createButtonWithFrame:CGRectMake(0, ScreenHeight - ScaleW(44) - Height_NavBar, ScreenWidth, ScaleW(44)) title:@"添加收货地址" titleColor:kMainColor imageName:nil backgroundImageName:nil target:self selector:@selector(addAddressEvent:) font:systemFont(ScaleW(16))];

        _bottomBtn.backgroundColor = kTheMeColor;
    }
    return _bottomBtn;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataAray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ScaleW(120);
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return ScaleW(0.001);
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleW(10))];
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
    YLJ_AddressListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YLJ_AddressListTableViewCell" forIndexPath:indexPath];
    cell.tag = indexPath.row + 2000;
    cell.selectBtn.selected = NO;
//    if (!cell) {
//        cell = [[AddressRdtingTableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"AddressRdtingTableViewCell"];
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//
//    }
    AddressMessageModel *model = self.dataAray[indexPath.row];
    cell.model = model;
    WS(weakSelf);
    cell.defultBlock = ^{
       [weakSelf setDefultAddress:model.ID];
    };

    cell.edtingBlock = ^{
        [weakSelf setEdtingAddress:model];
    };
    cell.selectBlock = ^{
        weakSelf.seletedID = model.ID;
        YLJ_AddressListTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        weakSelf.seletedCell = cell;
        for (int i = 0 ; i < self.dataAray.count; i ++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
            YLJ_AddressListTableViewCell *cCell = [self.tableView cellForRowAtIndexPath:indexPath];
            if (weakSelf.seletedCell.tag != cCell.tag) {
                        cCell.selectBtn.selected = NO;
            } else {
                cCell.selectBtn.selected = YES;
            }
        }
    };
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (!self.isDelete) {
        return;
    }
    
    AddressMessageModel *model = self.dataAray[indexPath.row];
    !self.callBackBlcok?:self.callBackBlcok(model);
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)requstAllAddressListRequst
{
    //AB_Shop_shop_address_index_post
    NSDictionary *params = @{@"account":[[SSKJ_User_Tool sharedUserTool] getAccount],@"page":@"1",@"size":@"50"};
    WS(weakSelf);
    
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:AB_Shop_shop_address_index_post RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        [weakSelf.tableView.mj_header endRefreshing];
        WL_Network_Model * netWorkModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([netWorkModel.status isEqualToString:@"200"]) {
            [weakSelf.dataAray removeAllObjects];
            
            for (NSDictionary *dic in  [netWorkModel.data objectForKey:@"res"] )
            {
                
                AddressMessageModel *model = [[AddressMessageModel alloc]init];
                
                [model setValuesForKeysWithDictionary:dic];
                
                [weakSelf.dataAray addObject:model];
               
            }
            
//             [SSKJ_NoDataView showNoData:self.dataAray.count toView:self.tableView offY:0 andImg:@"noAdressIcon"];
            
            [weakSelf.tableView reloadData];
           
        }
        else
        {
            [MBProgressHUD showError:netWorkModel.msg];
        }
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [weakSelf.tableView.mj_header endRefreshing];
    }];
}
- (void)rigthBtnAction:(UIButton *)sender
{
    if (self.dataAray.count == 0) {
        return;
    }
    if (self.isDelete) {
        self.isDelete = NO;
        [self addRightNavItemWithTitle:@"取消" color:kMainWihteColor font:systemFont(ScaleW(15))];
        
        [self.bottomBtn setTitle:@"删除" forState:UIControlStateNormal];
        for (int i = 0 ; i < self.dataAray.count; i ++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
            YLJ_AddressListTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
            cell.selectBtn.hidden = NO;
        }
    } else {
        [self addRightNavItemWithTitle:@"管理" color:kMainWihteColor font:systemFont(ScaleW(15))];
        self.isDelete = YES;
        for (int i = 0 ; i < self.dataAray.count; i ++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
            YLJ_AddressListTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
            cell.selectBtn.hidden = YES;
        }
        [self.bottomBtn setTitle:@"添加收货地址" forState:UIControlStateNormal];
    }
    
    
}

- (void)addAddressEvent:(UIButton *)sender {
    if ([sender.titleLabel.text isEqualToString:@"添加收货地址"]) {
        super_AddAddressViewController *vc = [[super_AddAddressViewController alloc]init];
        vc.edtingType = 1;
        vc.type = self.type;
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        //删除
        if (self.seletedID.length > 0) {
            [self setDeleteAddress:self.seletedID];
        } else {
        }
    }

}

#pragma mark -----设置默认地址

-(void)setDefultAddress:(NSString *)idString
{
    NSDictionary *params = @{@"address_id":idString};
   
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:AB_Shop_shop_address_default_post RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        WL_Network_Model * netWorkModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([netWorkModel.status isEqualToString:@"200"]) {
           
            [self requstAllAddressListRequst];
        }
        else
        {
            
        }
        [MBProgressHUD showError:netWorkModel.msg];
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}
//AB_Shop_address_delete_post
-(void)setDeleteAddress:(NSString *)idString
{
    NSDictionary *params = @{@"address_id":idString};
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:AB_Shop_address_delete_post RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        WL_Network_Model * netWorkModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([netWorkModel.status isEqualToString:@"200"]) {
            
            [self requstAllAddressListRequst];
        }
        else
        {
            
        }
        [MBProgressHUD showError:netWorkModel.msg];
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}
#pragma mark -----设置默认地址

-(void)setEdtingAddress:(AddressMessageModel *)model
{
    super_AddAddressViewController *vc = [[super_AddAddressViewController alloc]init];
    vc.edtingType = 2;
    vc.type = self.type;
    vc.model = model;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)sdad {
    
}

@end
