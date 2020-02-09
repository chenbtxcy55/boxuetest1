

#import "HomepageLockedViewController.h"
#import "HomepageLockRecodViewController.h"
#import "MoneyPswIndexViewController.h"

//view
#import "LockedView.h"
#import "LockedTableViewCell.h"

//model
#import "LockedModel.h"
#import "LockHeaderModel.h"
#define pageSize @"30"
@interface HomepageLockedViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) LockedView *headerView;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) LockHeaderModel *headerModel;

@end

@implementation HomepageLockedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.tableView];
}
-(NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
        
    }
    return _dataArray;
}
-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:(UITableViewStylePlain)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
        _tableView.sectionHeaderHeight = 0.01;
        _tableView.backgroundColor = [UIColor clearColor];
        [self.view addSubview:_tableView];
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
        _tableView.tableHeaderView = self.headerView;
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
//AB_Shop_owner_goods_index
-(void)requestRecordList{
    //AB_Shop_slide_list_post
    
    
    NSDictionary *pamas = @{};
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:kIscm_user_lock_indexApi RequestType:RequestTypePost Parameters:pamas Success:^(NSInteger statusCode, id responseObject) {
        WL_Network_Model * netWorkModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([netWorkModel.status integerValue] == SUCCESSED) {
            
            [self handleRecordListWith:netWorkModel];
            self.headerModel = [[LockHeaderModel alloc]init];
            [self.headerModel setValuesForKeysWithDictionary:netWorkModel.data];
            self.headerView.model = self.headerModel;
            
        }else{
            [MBProgressHUD showError:netWorkModel.msg];
        }
        // [MBProgressHUD showError:netWorkModel.msg];
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}
-(void)handleRecordListWith:(WL_Network_Model *)net_model
{
    
    NSArray *array = [LockedModel mj_objectArrayWithKeyValuesArray:net_model.data[@"list"]];
    if (array.count != pageSize.integerValue) {
        self.tableView.mj_footer.state = MJRefreshStateNoMoreData;
    }else{
        self.tableView.mj_footer.state = MJRefreshStateIdle;
    }
    
  
    [self.dataArray removeAllObjects];
    
    [self.dataArray addObjectsFromArray:array];
    
    //[SSKJ_NoDataView showNoData:self.dataArray.count toView:self.tableView offY:0];
    
    [self endRefresh];
    
    [self.tableView reloadData];
    

    
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

-(LockedView *)headerView
{
    if (!_headerView) {
        _headerView = [[LockedView alloc]init];
        WS(weakSelf);
        _headerView.gobackBlcok  = ^{
            [weakSelf.navigationController popViewControllerAnimated:YES];
        };
        
        _headerView.recodeBlcok  = ^{
            HomepageLockRecodViewController *vc = [[HomepageLockRecodViewController alloc]init];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
    }
    return _headerView;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
//    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
//    statusBar.backgroundColor = [UIColor clearColor];
    self.navigationController.navigationBarHidden = YES;
    
    [self headerRefresh];
    
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBarHidden = NO;
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LockedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LockedTableViewCell"];
    if (!cell) {
        cell = [[LockedTableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"LockedTableViewCell"];
    }
    LockedModel *model = self.dataArray[indexPath.row];
    
    cell.model = model;
   
    WS(weakSelf);
    cell.buyBlock = ^{
        MoneyPswIndexViewController *vc = [[MoneyPswIndexViewController alloc]init];
        vc.idString = model.ID;
        
        vc.modalPresentationStyle = UIModalPresentationOverFullScreen;
       
        [weakSelf.navigationController presentViewController:vc animated:YES completion:^{
            //
            vc.view.superview.backgroundColor = [UIColor clearColor];
        }];
        WS(weakSelf);
        vc.sucessBlock = ^{
            [weakSelf requestRecordList];
        };
    };
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ScaleW(135);
}

@end
