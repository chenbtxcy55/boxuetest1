


#import "HomepageLockRecodViewController.h"


//view
#import "LockedRecodeTableViewCell.h"
//model
#import "LockedRecodModel.h"
#define pageSize @"30"
@interface HomepageLockRecodViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, assign) BOOL dataArraved;

@end

@implementation HomepageLockRecodViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.tableView];
    
    self.view.backgroundColor = kBgColor;
    
    self.title = @"锁仓记录";
    
    self.dataArraved = YES;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self headerRefresh];
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
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, ScaleW(10), ScreenWidth, ScreenHeight - Height_NavBar - ScaleW(10)) style:(UITableViewStylePlain)];
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
    if (!_dataArraved) {
        return;
    }
    self.dataArraved = NO;
    NSDictionary *pamas = @{@"p":@(self.page),@"size":pageSize};
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:kIscm_lock_list_Api RequestType:RequestTypePost Parameters:pamas Success:^(NSInteger statusCode, id responseObject) {
        WL_Network_Model * netWorkModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        self.dataArraved = YES;
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([netWorkModel.status integerValue] == SUCCESSED) {
            
            [self handleRecordListWith:netWorkModel];
            
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
    
    NSArray *array = [LockedRecodModel mj_objectArrayWithKeyValuesArray:net_model.data[@"list"]];
    if (array.count != pageSize.integerValue) {
        self.tableView.mj_footer.state = MJRefreshStateNoMoreData;
    }else{
        self.tableView.mj_footer.state = MJRefreshStateIdle;
    }
    
    if (self.page == 1) {
        [self.dataArray removeAllObjects];
    }
    
    [self.dataArray addObjectsFromArray:array];
    
    [SSKJ_NoDataView showNoData:self.dataArray.count toView:self.tableView offY:0];
    
    [self endRefresh];
    
    [self.tableView reloadData];
    
    self.page++;
    
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


-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LockedRecodeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LockedTableViewCell"];
    if (!cell) {
        cell = [[LockedRecodeTableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"LockedTableViewCell"];
    }
    //cell.dataDic = self.dataArray[indexPath.row];
    LockedRecodModel *model = self.dataArray[indexPath.row];
    cell.model = model;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ScaleW(89);
}

@end
