//
//  JB_BBTrade_SliderMarket_ViewController.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/5/14.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "JB_BBTrade_SliderMarket_ViewController.h"

// view
#import "JB_BBTrade_SliderMarket_Cell.h"
#import "JB_BBTrade_SliderHeaderView.h"

// model
#import "JB_Market_Index_Model.h"
// tools
#import "ManagerSocket.h"


#define marketSocketIdentifier @"sliderMarket"

static NSString *cellid = @"JB_BBTrade_SliderMarket_Cell";
@interface JB_BBTrade_SliderMarket_ViewController ()<UITableViewDelegate,UITableViewDataSource,ManagerSocketDelegate>
@property (nonatomic, strong) UIButton *sliderButton;               // 侧边栏返回按钮
@property (nonatomic, strong) JB_BBTrade_SliderHeaderView *headerView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, assign) NSInteger index;

@property (nonatomic, strong) ManagerSocket *marketSocket;
@end

@implementation JB_BBTrade_SliderMarket_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kMainBackgroundColor;
    self.index = 0;
    [self.view addSubview:self.tableView];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self requestMarketListWithIndex:0];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self closeSocket];
}

-(NSMutableArray *)dataSource
{
    if (nil == _dataSource) {
        _dataSource = [NSMutableArray arrayWithCapacity:10];
    }
    return _dataSource;
}


#pragma mark - UI

-(JB_BBTrade_SliderHeaderView *)headerView
{
    if (nil == _headerView) {
        _headerView = [[JB_BBTrade_SliderHeaderView alloc]initWithFrame:CGRectMake(0, 0, self.sliderWidth, ScaleW(0))];
        _headerView.backgroundColor = kSubBackgroundColor;
        WS(weakSelf);
        _headerView.selectblock = ^(NSInteger index) {
            weakSelf.index = index;
            [weakSelf requestMarketListWithIndex:index];
        };
        
        _headerView.dismissBlock = ^{
            [weakSelf sliderDismiss];
        };
    }
    return _headerView;
}

-(UITableView *)tableView
{
    if (nil == _tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = kSubBackgroundColor;
        _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
        _tableView.tableHeaderView = self.headerView;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[JB_BBTrade_SliderMarket_Cell class] forCellReuseIdentifier:cellid];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.separatorColor = kMainBackgroundColor;
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
            [weakSelf requestMarketListWithIndex:weakSelf.index];
        }];
    }
    return _tableView;
}

#pragma mark - UITableViewDelegate UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ScaleW(66);
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JB_BBTrade_SliderMarket_Cell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    JB_Market_Index_Model *model = self.dataSource[indexPath.row];
    [cell setCellWithModel:model];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    JB_Market_Index_Model *model = self.dataSource[indexPath.row];
    if (self.selectCoinBlock) {
        self.selectCoinBlock(model);
    }
    
    [self sliderDismiss];
}

#pragma mark - socket
-(void)openSocket
{
    WS(weakSelf);
    if (![self.marketSocket socketIsConnected]) {
        self.marketSocket.delegate = self;
        [self.marketSocket openConnectSocketWithConnectSuccess:^{
            NSString *type = [WLTools wlDictionaryToJson:@{@"code":@"all"}];
            
            [weakSelf.marketSocket socketSendMsg:type];
        }];
    }
    
}
-(ManagerSocket *)marketSocket
{
    if (nil == _marketSocket) {
        _marketSocket = [[ManagerSocket alloc]initWithUrl:BBMarketSocketUrl identifier:marketSocketIdentifier];
    }
    return _marketSocket;
}

-(void)closeSocket
{
    
    if (![self.marketSocket socketIsConnected]) {
        self.marketSocket.delegate = nil;
        [self.marketSocket closeConnectSocket];
        
    }
}


#pragma mark -- ManagerSocketDelegate
-(void)socketDidReciveData:(id)data identifier:(NSString *)identifier
{
    
    NSDictionary *dic = [self dicWithData:data];
    if ([identifier isEqualToString:marketSocketIdentifier]){
        JB_Market_Index_Model *socketModel = [JB_Market_Index_Model mj_objectWithKeyValues:dic];
        
        for (int i = 0; i < self.dataSource.count; i++) {
            JB_Market_Index_Model *model = self.dataSource[i];
            if ([socketModel.code isEqualToString:model.code]) {
                model.price = socketModel.price;
                model.change = socketModel.change;
                model.changeRate = socketModel.changeRate;
                
                [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:i inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
                break;
            }
        }
        
        
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

- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    
    NSString *newJsonString = [NSString stringWithFormat:@"[%@]",jsonString];
    
    if ([newJsonString containsString:@"}{"]) {
        NSLog(@"");
    }
    newJsonString = [newJsonString stringByReplacingOccurrencesOfString:@"}{" withString:@"},{"];
    
    NSData *jsonData = [newJsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSArray *array = [NSJSONSerialization JSONObjectWithData:jsonData
                                                     options:NSJSONReadingMutableContainers
                                                       error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return array.firstObject;
}

#pragma mark - 侧边栏消失
-(void)sliderDismiss
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - 网络请求 请求行情列表
-(void)requestMarketListWithIndex:(NSInteger)index
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    
    
    NSDictionary *params = @{
                             @"qu":@(self.index + 1)
                             };
    
    WS(weakSelf);
    
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:ETF_BBTrade_MarketList_URL RequestType:RequestTypeGet Parameters:params Success:^(NSInteger statusCode, id responseObject)
     {
         [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
         [weakSelf.tableView.mj_header endRefreshing];
         WL_Network_Model *network_Model=[WL_Network_Model mj_objectWithKeyValues:responseObject];
         
         if (network_Model.status.integerValue == SUCCESSED)
         {
             [weakSelf handleMarketListWith:network_Model];
         }else{
             [MBProgressHUD showError:network_Model.msg];
         }
     } Failure:^(NSError *error, NSInteger statusCode, id responseObject)
     {
         [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
         [weakSelf.tableView.mj_header endRefreshing];
         //[MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
     }];
}


-(void)handleMarketListWith:(WL_Network_Model *)network_model
{
    NSArray *array = [JB_Market_Index_Model mj_objectArrayWithKeyValuesArray:network_model.data];
    [self.dataSource removeAllObjects];
    
    [self.dataSource addObjectsFromArray:array];
    
    [self.tableView reloadData];
    
    [self openSocket];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
