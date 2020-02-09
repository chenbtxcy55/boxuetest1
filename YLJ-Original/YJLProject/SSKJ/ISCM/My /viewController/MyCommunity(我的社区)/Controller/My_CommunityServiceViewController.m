//
//  My_CommunityServiceViewController.m
//  SSKJ
//
//  Created by zhao on 2019/10/8.
//  Copyright © 2019 刘小雨. All rights reserved.
//
/*
 服务费
 */
#import "My_CommunityServiceViewController.h"
#import "MyDirectPushBaseHeardView.h"


#import "MyTeamHeardView.h"
#import "MyTeamViewCell.h"
#define kPageSize 30
@interface My_CommunityServiceViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UIButton *rightBtn;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) MyDirectPushBaseHeardView *heardView;
@property (nonatomic, assign) NSInteger currentPage;

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) MBProgressHUD *hudView;

@end

@implementation My_CommunityServiceViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self tableView];
    
    //    [self setNavigationView];
    
    
}

-(MBProgressHUD *)hudView{
    if (!_hudView) {
        _hudView = [[MBProgressHUD alloc] initWithView:self.view];
    }
    return _hudView;
}
- (MyDirectPushBaseHeardView *)heardView{
    if (!_heardView) {
        _heardView = [[MyDirectPushBaseHeardView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleW(40))];
        [_heardView layoutFuWuFei];
    }
    return _heardView;
}

-(void)setNavigationView
{
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:self.rightBtn];
    self.navigationItem.rightBarButtonItem = item;
}

-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:(UITableViewStylePlain)];
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
        _tableView.sectionHeaderHeight = 0.01;
        _tableView.backgroundColor = kNavBGColor;
        _tableView.tableHeaderView = self.heardView;
        
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
            
            weakSelf.currentPage = 1;
            
            [weakSelf requstListrequset];
            
        }];
        _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            [weakSelf requstListrequset];
        }];
    }
    return _tableView;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyTeamViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyTeamViewCell"];
    if (!cell)
    {
        cell = [[MyTeamViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MyTeamViewCell"];
    }
    NSDictionary *dic = self.dataArray[indexPath.row];
    [cell layoutFuWuFei];
    cell.oneLab.text = dic[@"user_id"];
    cell.twoLab.text = dic[@"fee"];
     cell.threeLab.text = dic[@"fee_yongjin"];
     cell.fourLab.text = [WLTools convertTimestamp: [dic[@"add_time"] doubleValue] andFormat:@"yyyy-MM-dd"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ScaleW(35);
}

//#pragma mark --------------------头部信息
//
//-(void)myteamInformationRequest
//{
//    WS(weakSelf);
//    [self.hudView showAnimated:YES];
//    NSMutableDictionary *pamas = [NSMutableDictionary dictionary];
//    [[WLHttpManager shareManager]requestWithURL_HTTPCode:kIscm_team_jiBiecount_Api RequestType:RequestTypePost Parameters:pamas Success:^(NSInteger statusCode, id responseObject) {
//
//        NSLog(@"----%@----",responseObject);
//
//        WL_Network_Model *net_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
//
//        NSDictionary *count = net_model.data[0];
//
//
//
//
//
//    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
//        [self.hudView hideAnimated:YES];
//        [weakSelf.tableView.mj_header endRefreshing];
//    }];
//}

#pragma mark ----------列表请求

-(void)requstListrequset
{
    [self.tableView.mj_footer resetNoMoreData];
    WS(weakSelf);
    [self.hudView showAnimated:YES];
//    [self.dataArray removeAllObjects];
    [self.tableView reloadData];
    NSMutableDictionary *pamas = [NSMutableDictionary dictionary];
    //[pamas setObject:kuserUid forKey:@"iid"];
    NSString *page = [NSString stringWithFormat:@"%ld",_currentPage];
    [pamas setObject:@(4) forKey:@"order_type"];
    
    [pamas setObject:page forKey:@"p"];
    [pamas setObject:@(kPageSize) forKey:@"size"];
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:kIscm_community_detail_Api RequestType:RequestTypePost Parameters:pamas Success:^(NSInteger statusCode, id responseObject) {
        [weakSelf.tableView.mj_header endRefreshing];
        [self.hudView hideAnimated:YES];
        
        WL_Network_Model *net_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        
        NSArray *list = net_model.data[@"list"];
        
        
        
        
        if (net_model.status.integerValue == 200) {
            if (weakSelf.currentPage ==1) {
                [self.dataArray removeAllObjects];
                
            }
            for (NSDictionary * dic in list) {
                
                [self.dataArray addObject:dic];
            }
            [SSKJ_NoDataView showNoData:self.dataArray.count toView:self.tableView offY:0];
            
            [self.tableView reloadData];
        }else{
            [MBProgressHUD showError:net_model.msg];
        }
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [self.hudView hideAnimated:YES];
        [weakSelf.tableView.mj_header endRefreshing];
    }];
}

//-(void)requstListAddrequset
//{
//    self.currentPage ++;
//    WS(weakSelf);
//    // [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    [self.hudView showAnimated:YES];
//    NSMutableDictionary *pamas = [NSMutableDictionary dictionary];
//    //[pamas setObject:kuserUid forKey:@"iid"];
//    NSString *page = [NSString stringWithFormat:@"%ld",_currentPage];
//
//    [pamas setObject:page forKey:@"page"];
//    [pamas setObject:@(kPageSize) forKey:@"size"];
//    //    lerver    是    int    1 一级 2 二级 3 三级
//    //    page    否    int    第几页(默认第1页)
//    //    size    否    int    一页几条(默认一页10条)
//    [[WLHttpManager shareManager]requestWithURL_HTTPCode:kowner_get_temamy_tuandui RequestType:RequestTypePost Parameters:pamas Success:^(NSInteger statusCode, id responseObject) {
//        [weakSelf.tableView.mj_footer endRefreshing];
//        [self.hudView hideAnimated:YES];
//        WL_Network_Model *net_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
//
//        NSArray *list = net_model.data[@"list"];
//        if (net_model.status.integerValue == 200) {
//            for (NSDictionary * dic in list) {
//
//                [self.dataArray addObject:dic];
//            }
//            [self.tableView reloadData];
//        }else{
//            [MBProgressHUD showError:net_model.msg];
//        }
//
//    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
//        [self.hudView hideAnimated:YES];
//        [weakSelf.tableView.mj_footer endRefreshing];
//    }];
//}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
//    [self myteamInformationRequest];
    self.currentPage = 1;

    [self requstListrequset];
}
-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}





@end
