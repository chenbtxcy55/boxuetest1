
#import "CJHYTimePosionViewController.h"
//#import "CJHYShareViewController.h"
#import "TradePosionTableViewCell.h"
#import "JB_BBTrade_Order_Index_Model.h"
#import "CJHYPosionModel.h"
#import "JB_Market_Index_Model.h"
// tools
#import "ManagerSocket.h"


#define kPageSize  @"1000"

#define marketSocketIdentifier @"sliderMarket"

static NSString * cellID = @"TradePosionTableViewCell";

@interface CJHYTimePosionViewController ()<UITableViewDelegate,UITableViewDataSource,ManagerSocketDelegate>
@property(nonatomic, strong)UITableView *tableView;

@property(nonatomic, strong)NSArray *array;

@property (nonatomic, assign) NSInteger page;

@property (nonatomic, strong) NSMutableArray *dataSource;

// 行情推送
@property (nonatomic, strong) ManagerSocket *klineSocket;

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, assign) NSInteger count;

@end

@implementation CJHYTimePosionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.count = 100;
    
    [self tableView];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(applicationDidBecomeActive:) name:UIApplicationDidBecomeActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(applicationDidEnterBackground:) name:UIApplicationDidEnterBackgroundNotification object:nil];
}


- (void)timerStart{
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(repitTimeAction) userInfo:nil repeats:YES];
}

- (void)timerStop{
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

-(void)dealloc
{
    [self timerStop];

    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}
#pragma mark - 通知（进入后台，进入后台）

-(void)applicationDidBecomeActive:(NSNotification *)notification
{
    [self openSocket];
    
}

-(void)applicationDidEnterBackground:(NSNotification *)notification
{
    
    [self closeSocket];
}
-(void)repitTimeAction
{
   // self.page = 1;
   // [self requestRecordListWithCoinCodeStatus:@"1"];
    
    //[_tableView.mj_header beginRefreshing];
    self.page = 1;
    [self requestRecordListWithCoinCodeStatus:@"1"];
    
//    [self timeWithdataSoure];
    
}

-(void)timeWithdataSoure
{
    NSLog(@"---------%@", [NSDate date]);

    if (self.dataSource.count)
    {
        //
        for (int i = 0; i < self.dataSource.count; i++) {
            CJHYPosionModel *model = self.dataSource[i];
            CGFloat timetal =  model.times.floatValue;
            timetal = timetal - 1;
            NSLog(@"%lf",timetal);
            if (timetal <= 0) {
                [self.dataSource removeObject:model];
            }else{
                model.times = [NSString stringWithFormat:@"%.0f",timetal];
            }

        }
        
        [SSKJ_NoDataView showNoData:self.dataSource.count toView:self.tableView offY:0];
        
        [self.tableView reloadData];
    }
    
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.page = 1;

    
    [self requestRecordListWithCoinCodeStatus:@"1"];
    
//    [self openSocket];
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
     [_timer setFireDate:[NSDate distantFuture]];
    
    [_timer invalidate];
    _timer = nil;
    
//    [self closeSocket];
    
}

#pragma mark - tableView delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.dataSource.count;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return ScaleW(225);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    TradePosionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
   
    cell.timeModel = self.dataSource[indexPath.section];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section>0) {
        
        return ScaleW(10);
        
    }
    return 0;
    
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *view=[UIView new];
    
    
    view.backgroundColor=[UIColor clearColor];
    
    return view;
}
#pragma mark - lazy load
- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor clearColor];
        [_tableView setSeparatorColor:kLineColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        [_tableView registerClass:[TradePosionTableViewCell class] forCellReuseIdentifier:cellID];
        if (@available(iOS 11.0, *)){
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            _tableView.estimatedRowHeight = 0;
            _tableView.estimatedSectionHeaderHeight = 0;
            _tableView.estimatedSectionFooterHeight = 0;
        }else{
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(@0);
            make.top.equalTo(@(ScaleW(0)));
            make.bottom.equalTo(@(-Height_TabBarSafe));
        }];
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
    [self requestRecordListWithCoinCodeStatus:@"1"];
    
    
}

-(void)footerRefresh
{
    [self requestRecordListWithCoinCodeStatus:@"1"];
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
// 请求挂单列表
-(void)requestRecordListWithCoinCodeStatus:(NSString *)status
{
    NSDictionary *params = @{
                             
                             @"p":@(self.page),
                             @"size":kPageSize,
                             
                             };
    WS(weakSelf);
    
//    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:KNowOrdersList RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        WL_Network_Model *network_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if ([network_model.status integerValue] == SUCCESSED) {
           
            [weakSelf handleExchangeListWithModel:network_model];
        }else{
             [MBProgressHUD showError:network_model.msg];
        }
        [weakSelf endRefresh];
//
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        [weakSelf endRefresh];
        [MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
    }];
    
}

-(void)handleExchangeListWithModel:(WL_Network_Model *)net_model
{
    //NSArray *array = [JB_BBTrade_Order_Index_Model mj_objectArrayWithKeyValuesArray:net_model.data[@"res"]];
    
    
    
    NSMutableArray *array = [NSMutableArray array];
    
    for (NSDictionary *dic  in net_model.data) {
        CJHYPosionModel *model = [[CJHYPosionModel alloc]init];
        [model setValuesForKeysWithDictionary:dic];
        [array addObject:model];
    }
    
    if (self.page == 1) {
        [self.dataSource removeAllObjects];
    }
    
    if (array.count != kPageSize.integerValue) {
        self.tableView.mj_footer.state = MJRefreshStateNoMoreData;
    }else{
        self.tableView.mj_footer.state = MJRefreshStateIdle;
    }
    
    [self.dataSource addObjectsFromArray:array];
    
    [SSKJ_NoDataView showNoData:self.dataSource.count toView:self.tableView offY:0];
    
    [self.tableView reloadData];
    
    self.page++;
    
    [self endRefresh];

    [self timerStart];
    
}

-(NSDate *) timeStampWithOffsetTime:(NSInteger) offsetTime {
    NSDate* date = [NSDate dateWithTimeIntervalSinceNow:offsetTime];//获取当前时间 offsetTime 秒后的时间
    return date;
    
}
-(NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
    
}



#pragma mark - socket

-(void)openSocket
{
    WS(weakSelf);
    if (!self.klineSocket.socketIsConnected) {
        self.klineSocket.delegate = self;
        [self.klineSocket openConnectSocketWithConnectSuccess:^{
            NSString *type = [WLTools wlDictionaryToJson:@{@"code":@"all"}];
            
            [weakSelf.klineSocket socketSendMsg:type];
        }];
    }
    
}

-(NSDictionary *)dicWithData:(id)data
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSDictionary *singleGoodsDatas = nil;
    if ([data isKindOfClass:[NSString class]]) {
        singleGoodsDatas = [self dictionaryWithJsonString:data];
        dic = [singleGoodsDatas mutableCopy];
    } else if ([data isKindOfClass:[NSDictionary class]])
    {
        singleGoodsDatas = data;
        NSString *goodsCode = [WLTools stringTransformObject:[singleGoodsDatas objectForKey:@"code"]];
        [dic setObject:singleGoodsDatas forKey:goodsCode];
    }
    return dic;
    
}

-(void)closeSocket
{
    if (self.klineSocket.socketIsConnected) {
        self.klineSocket.delegate = nil;
        [self.klineSocket closeConnectSocket];
    }
    
    
}
-(ManagerSocket *)klineSocket
{
    if (nil == _klineSocket) {
        _klineSocket = [[ManagerSocket alloc]initWithUrl:BBMarketSocketUrl identifier:marketSocketIdentifier];
    }
    return _klineSocket;
}
#pragma mark - 长连接收到推送数据
-(void)socketDidReciveData:(id)data identifier:(NSString *)identifier
{
    
    NSDictionary *dic = [self dicWithData:data];
    if ([identifier isEqualToString:marketSocketIdentifier]){
        JB_Market_Index_Model *socketModel = [JB_Market_Index_Model mj_objectWithKeyValues:dic];
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"postionSockedLongPost" object:socketModel];
    }
    
}
- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

@end
