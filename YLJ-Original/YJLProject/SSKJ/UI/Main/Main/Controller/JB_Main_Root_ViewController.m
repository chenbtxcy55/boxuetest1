////
////  JB_Main_Root_ViewController.m
////  SSKJ
////
////  Created by 刘小雨 on 2019/5/10.
////  Copyright © 2019年 刘小雨. All rights reserved.
////
//
//#import "JB_Main_Root_ViewController.h"
//#import "MarketCoinCell.h"
//#import "HomepageHeaderView.h"
//#import "JB_Market_Index_Model.h"
//#import "ManagerSocket.h"
//#import "JB_Main_BannerModel.h"
//#import "JB_BBTrade_MarketDetail_ViewController.h"
//#import "HeBi_Version_Model.h"
//#import "HeBi_Version_AlertView.h"
//#import "Market_NoticeList_ViewController.h"
//#define marketSocketIdentifier @"sliderMarket"
//
//static NSString *cellid = @"MarketCoinCell";
//
//@interface JB_Main_Root_ViewController ()<UITableViewDelegate,UITableViewDataSource,ManagerSocketDelegate>
//@property (nonatomic, strong) UITableView *tableView;
//@property (nonatomic, strong) NSMutableArray *dataSource;
//@property (nonatomic, strong) NSArray *noticeArray;
//@property (nonatomic, strong) UIView *sectionView;
//@property (nonatomic, strong) HomepageHeaderView *headerView;
//
//@property (nonatomic, strong) ManagerSocket *marketSocket;
//
//@property (nonatomic, strong) HeBi_Version_Model *versionModel;
//
//@property (nonatomic, assign) BOOL isFirstPost; // 是否是第一次发送通知
//@end
//
//@implementation JB_Main_Root_ViewController
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//   
//    [self.view addSubview:self.tableView];
//    self.isFirstPost = YES;
//    
//    [self checkVersion];
//}
//
//-(void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//
//    [self headerRefresh];
//    if (kLogin && ![SSKJ_User_Tool sharedUserTool].userInfoModel) {
//        [self requestUserInfo];
//    }
//}
//
//-(void)viewWillDisappear:(BOOL)animated
//{
//    [super viewWillDisappear:animated];
//    [MBProgressHUD hideHUDForView:self.view animated:YES];
//}
//
//-(HomepageHeaderView *)headerView
//{
//    if (!_headerView) {
//        _headerView = [[HomepageHeaderView alloc]init];
//        WS(weakSelf);
//        _headerView.coinTapBlock = ^(JB_Market_Index_Model * _Nonnull coinModel) {
//            JB_BBTrade_MarketDetail_ViewController *vc = [[JB_BBTrade_MarketDetail_ViewController alloc]init];
//            vc.coinModel = coinModel;
//            [weakSelf.navigationController pushViewController:vc animated:YES];
//        };
//        
//        _headerView.newListBlock = ^{
//            Market_NoticeList_ViewController *vc = [[Market_NoticeList_ViewController alloc]init];
//            [weakSelf.navigationController pushViewController:vc animated:YES];
//        };
//        
//        _headerView.newsIndexBlock = ^(NSInteger index) {
//            NSDictionary *dic = weakSelf.noticeArray[index];
//            My_NewsDetail_ViewController *vc = [[My_NewsDetail_ViewController alloc]init];
//            vc.newsID = dic[@"id"];
//            [weakSelf.navigationController pushViewController:vc animated:YES];
//        };
//    }
//    return _headerView;
//}
//
//-(void)rightAction:(UIButton *)sender
//{
//    
//}
//
//
//-(NSMutableArray *)dataSource
//{
//    if (nil == _dataSource) {
//        _dataSource = [NSMutableArray arrayWithCapacity:10];
//    }
//    return _dataSource;
//}
//
//
//-(UITableView *)tableView
//{
//    if (!_tableView) {
//        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - Height_NavBar - Height_TabBar) style:(UITableViewStylePlain)];
//        _tableView.delegate = self;
//        _tableView.dataSource = self;
//        [_tableView registerClass:[MarketCoinCell class] forCellReuseIdentifier:cellid];
//        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//        _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
//        _tableView.sectionHeaderHeight = 0.01;
//        _tableView.backgroundColor = [UIColor clearColor];
//        //_tableView.tableHeaderView = self.headerView;
//        [self.view addSubview:_tableView];
//        if (@available(iOS 11.0, *))
//        {
//            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
//            _tableView.estimatedRowHeight = 0;
//            _tableView.estimatedSectionHeaderHeight = 0;
//            _tableView.estimatedSectionFooterHeight = 0;
//        }
//        else
//        {
//            self.automaticallyAdjustsScrollViewInsets = NO;
//        }
//        _tableView.tableHeaderView = self.headerView;
//        WS(weakSelf);
//        _tableView.mj_header  = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//            [weakSelf headerRefresh];
//        }];
//        
//    }
//    
//    return _tableView;
//}
//
//-(void)headerRefresh
//{
//    [self requestMarketList];
//    [self requestBanner];
//}
//
//-(void)endRefresh
//{
//    [self.tableView.mj_header endRefreshing];
//}
//
//#pragma mark - UITableViewDataSource
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    return self.dataSource.count;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    MarketCoinCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
//    JB_Market_Index_Model *model = self.dataSource[indexPath.row];
//    [cell setCellWithModel:model];
//    
//    return cell;
//}
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    JB_BBTrade_MarketDetail_ViewController *vc = [[JB_BBTrade_MarketDetail_ViewController alloc]init];
//    vc.coinModel = self.dataSource[indexPath.row];
//    [self.navigationController pushViewController:vc animated:YES];
//}
//
//#pragma mark - UITableViewDelegate
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return ScaleW(50);
//}
//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    return self.sectionView;
//}
//-(CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return self.sectionView.height;
//}
//-(UIView *)sectionView{
//    if (!_sectionView) {
//        _sectionView = [[UIView alloc]initWithFrame:CGRectMake(0, 0  , ScreenWidth, ScaleW(70))];
//        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(32), ScaleW(23), ScaleW(3), ScaleW(15))];
//        line.backgroundColor = kTextLightBlueColor;
//        [_sectionView addSubview:line];
//        UILabel *marketLabel = [[UILabel alloc]initWithFrame:CGRectMake(ScaleW(11) + line.right, line.top, ScaleW(100), ScaleW(15))];
//        [marketLabel label:marketLabel font:ScaleW(15) textColor:kTextLightBlueColor text:SSKJLocalized(@"行情", nil)];
//        [_sectionView addSubview:marketLabel];
//        UIView *bomLine = [[UIView alloc]initWithFrame:CGRectMake(0, ScaleW(57), ScreenWidth, 1)];
//        bomLine.backgroundColor = UIColorFromRGB(0x242647);
//        [_sectionView addSubview:bomLine];
//        _sectionView.backgroundColor = kMianBgColor;
//    }
//    return _sectionView;
//}
//
//
//
//
//#pragma mark - 网络请求 请求行情列表
//-(void)requestMarketList
//{
//    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    
//    
//    
//    NSDictionary *params = @{
//                             @"qu":@(1)
//                             };
//    
//    WS(weakSelf);
//    
//    [[WLHttpManager shareManager] requestWithURL_HTTPCode:ETF_BBTrade_MarketList_URL RequestType:RequestTypeGet Parameters:params Success:^(NSInteger statusCode, id responseObject)
//     {
//         [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
//         [weakSelf.tableView.mj_header endRefreshing];
//         WL_Network_Model *network_Model=[WL_Network_Model mj_objectWithKeyValues:responseObject];
//         [weakSelf endRefresh];
//         if (network_Model.status.integerValue == SUCCESSED)
//         {
//             [weakSelf handleMarketListWith:network_Model];
//         }else{
//             [MBProgressHUD showError:network_Model.msg];
//         }
//     } Failure:^(NSError *error, NSInteger statusCode, id responseObject)
//     {
//         [weakSelf endRefresh];
//         [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
//         [weakSelf.tableView.mj_header endRefreshing];
//         //[MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
//     }];
//}
//
//
//-(void)handleMarketListWith:(WL_Network_Model *)network_model
//{
//    NSArray *array = [JB_Market_Index_Model mj_objectArrayWithKeyValuesArray:network_model.data];
//    [self.dataSource removeAllObjects];
//    
//    [self.dataSource addObjectsFromArray:array];
//    
//    [self.tableView reloadData];
//    
//    self.headerView.coinArray = self.dataSource;
//    
//    [self openSocket];
//    
//    
//    if (self.isFirstPost) {
//        self.isFirstPost = NO;
//        [[NSNotificationCenter defaultCenter]postNotificationName:@"didGetCoinModel" object:self.dataSource.firstObject];
//    }
//    
//    
//    
//    
//    
//}
//
//#pragma mark - 网络请求 请求行情列表
//-(void)requestBanner
//{
//    
//    WS(weakSelf);
//    
//    [[WLHttpManager shareManager] requestWithURL_HTTPCode:ETF_Main_GetBanner_URL RequestType:RequestTypeGet Parameters:nil Success:^(NSInteger statusCode, id responseObject)
//     {
//         [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
//         WL_Network_Model *network_Model=[WL_Network_Model mj_objectWithKeyValues:responseObject];
//         
//         if (network_Model.status.integerValue == SUCCESSED)
//         {
//             [weakSelf handleBannerListWithModel:network_Model];
//         }else{
//             [MBProgressHUD showError:network_Model.msg];
//         }
//     } Failure:^(NSError *error, NSInteger statusCode, id responseObject)
//     {
//         //[MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
//     }];
//}
//
//
//-(void)handleBannerListWithModel:(WL_Network_Model *)net_model
//{
//    NSArray *bannerArray = net_model.data[@"banner"];
//    
//    NSMutableArray *array = [NSMutableArray array];
//    for (NSDictionary *dic  in bannerArray) {
//        [array addObject:dic[@"banner_url"]];
//    }
//    
//    self.headerView.bannerArray = array;
//    
//    NSArray *noticeArray = net_model.data[@"article"];
//    self.noticeArray = noticeArray;
//    array = [NSMutableArray arrayWithCapacity:1];
//    for (NSDictionary *dic in noticeArray) {
//        [array addObject:dic[@"title"]];
//    }
//    
//    self.headerView.noticeArray = array;
//    
//}
//
//#pragma mark - socket
//
//#pragma mark - socket
//-(void)openSocket
//{
//    WS(weakSelf);
//    if (![self.marketSocket socketIsConnected]) {
//        self.marketSocket.delegate = self;
//        [self.marketSocket openConnectSocketWithConnectSuccess:^{
//            NSString *type = [WLTools wlDictionaryToJson:@{@"code":@"all"}];
//            
//            [weakSelf.marketSocket socketSendMsg:type];
//        }];
//    }
//    
//}
//-(ManagerSocket *)marketSocket
//{
//    if (nil == _marketSocket) {
//        _marketSocket = [[ManagerSocket alloc]initWithUrl:BBMarketSocketUrl identifier:marketSocketIdentifier];
//    }
//    return _marketSocket;
//}
//
//-(void)closeSocket
//{
//    
//    if (![self.marketSocket socketIsConnected]) {
//        self.marketSocket.delegate = nil;
//        [self.marketSocket closeConnectSocket];
//        
//    }
//}
//
//
//#pragma mark -- ManagerSocketDelegate
//-(void)socketDidReciveData:(id)data identifier:(NSString *)identifier
//{
//    
//    NSDictionary *dic = [self dicWithData:data];
//    if ([identifier isEqualToString:marketSocketIdentifier]){
//        JB_Market_Index_Model *socketModel = [JB_Market_Index_Model mj_objectWithKeyValues:dic];
//        
//        for (int i = 0; i < self.dataSource.count; i++) {
//            JB_Market_Index_Model *model = self.dataSource[i];
//            if ([socketModel.code isEqualToString:model.code]) {
//                model.price = socketModel.price;
//                model.change = socketModel.change;
//                model.changeRate = socketModel.changeRate;
//                model.cnyPrice = socketModel.cnyPrice;
//                [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:i inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
//                
//                [self.headerView didGetSocketModel:model];
//                break;
//            }
//        }
//        
//        
//    }
//    
//}
//
//
//-(NSDictionary *)dicWithData:(id)data
//{
//    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
//    NSDictionary *singleGoodsDatas = nil;
//    if ([data isKindOfClass:[NSString class]]) {
//        singleGoodsDatas = [self dictionaryWithJsonString:data];
//        dic = [singleGoodsDatas mutableCopy];
//    } else if ([data isKindOfClass:[NSDictionary class]])
//    {
//        singleGoodsDatas = data;
//        NSString *goodsCode = [WLTools stringTransformObject:[singleGoodsDatas objectForKey:@"code"]];
//        [dic setObject:singleGoodsDatas forKey:goodsCode];
//    }
//    return dic;
//    
//}
//
//- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
//    if (jsonString == nil) {
//        return nil;
//    }
//    
//    NSString *newJsonString = [NSString stringWithFormat:@"[%@]",jsonString];
//    
//    newJsonString = [newJsonString stringByReplacingOccurrencesOfString:@"}{" withString:@"},{"];
//    
//    NSData *jsonData = [newJsonString dataUsingEncoding:NSUTF8StringEncoding];
//    NSError *err;
//    NSArray *array = [NSJSONSerialization JSONObjectWithData:jsonData
//                                                     options:NSJSONReadingMutableContainers
//                                                       error:&err];
//    if(err) {
//        NSLog(@"json解析失败：%@",err);
//        return nil;
//    }
//    return array.firstObject;
//}
//
//#pragma mark 请求个人中心
//
//
//
//-(void)requestUserInfo
//{
//    NSDictionary *params = @{
//                             
//                             };
//    WS(weakSelf);
//    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    [[WLHttpManager shareManager]requestWithURL_HTTPCode:JB_Account_UserInfo_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
//        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
//        WL_Network_Model *network_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
//        if ([network_model.status integerValue] == SUCCESSED) {
//            SSKJ_UserInfo_Model *model = [SSKJ_UserInfo_Model mj_objectWithKeyValues:network_model.data];
//            [SSKJ_User_Tool sharedUserTool].userInfoModel = model;
//            
//        }else{
//            [MBProgressHUD showError:network_model.msg];
//        }
//    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
//        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
//        //[MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
//    }];
//    
//}
//
//
//#pragma mark - 检测版本更新
//-(void)checkVersion
//{
//    NSDictionary *dict=@{@"version":AppVersion,
//                         @"type":@"2"
//                         };
//    
//    SsLog(@"\r版本->请求参数：%@",dict);
//    
//    WS(weakSelf);
//    
//    [[WLHttpManager shareManager]requestWithURL_HTTPCode:JB_CheckVersion_URL RequestType:RequestTypePost Parameters:dict Success:^(NSInteger statusCode, id responseObject) {
//        WL_Network_Model *network_Model=[WL_Network_Model mj_objectWithKeyValues:responseObject];
//        
//        if (network_Model.status.integerValue == SUCCESSED)
//        {
//            weakSelf.versionModel=[HeBi_Version_Model mj_objectWithKeyValues:network_Model.data];
//            
//            [HeBi_Version_AlertView showWithModel:weakSelf.versionModel confirmBlock:^{
//                [weakSelf upgrade_Button_Event];
//            } cancleBlock:^{
//                
//            }];
//        }else{
//            
//        }
//        
//    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
//        
//    }];
//    
//}
//
//
//#pragma mark - 版本更新控制 立即更新 事件
//-(void)upgrade_Button_Event
//{
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.versionModel.addr]];
//}
//
//
//
//@end
