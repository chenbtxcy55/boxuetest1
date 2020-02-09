//
//  Mine_Promotion_ViewController.m
//  SSKJ
//
//  Created by zhao on 2019/10/8.
//  Copyright © 2019 刘小雨. All rights reserved.
//
/*
 推广业绩
 */
#import "Mine_Promotion_ViewController.h"
#import "Mine_Promotion_HeardView.h"

#import "Mine_PromotionCell.h"

#define kPageSize 30

@interface Mine_Promotion_ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) Mine_Promotion_HeardView *heardView;
@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) MBProgressHUD *hudView;
@property (nonatomic, assign) NSInteger currentType;

@end

@implementation Mine_Promotion_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = SSKJLocalized(@"返佣明细", nil);
    [self.view addSubview:self.tableView];
}
-(MBProgressHUD *)hudView{
    if (!_hudView) {
        _hudView = [[MBProgressHUD alloc] initWithView:self.view];
    }
    return _hudView;
}
- (Mine_Promotion_HeardView *)heardView{
    if (!_heardView) {
        _heardView = [[Mine_Promotion_HeardView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleW(60))];
    }
    return _heardView;
}
-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - Height_NavBar) style:(UITableViewStylePlain)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
        _tableView.sectionHeaderHeight = 0.01;
        _tableView.backgroundColor = kMainWihteColor;
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
    Mine_PromotionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Mine_PromotionCell"];
    if (!cell)
    {
        cell = [[Mine_PromotionCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Mine_PromotionCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
   

    NSDictionary *dic = self.dataArray[indexPath.row];

    NSString *priceTitle;
//      3 ,5,6为金额  4为购物劵 8为油乐劵
    if ([dic[@"type"] intValue] == 3||  [dic[@"type"] intValue] == 5  || [dic[@"type"] intValue] == 6) {
        priceTitle = @"金额";
    }
    if ([dic[@"type"] intValue] == 4) {
        priceTitle = @"购物券";
    }

    if ([dic[@"type"] intValue] == 8) {
        priceTitle = @"油乐劵";
    }
    cell.oneLab.text = [NSString stringWithFormat:@"%@%@",[WLTools noroundingStringWith:[dic[@"price"] doubleValue] afterPointNumber:2],priceTitle];

    
     //    3,4,5为推广返佣 6,8为福利返佣
    NSString *state;
    if ([dic[@"type"] intValue] == 3|| [dic[@"type"] intValue] == 4 || [dic[@"type"] intValue] == 5) {
        state = @"推广返佣";
    }
    if ([dic[@"type"] intValue] == 6|| [dic[@"type"] intValue] == 8) {
        state = @"福利返佣";
    }
    cell.twoLab.text = state;
    
//    cell.twoLab.text =dic[@"uptime"];
    cell.threeLab.text =[WLTools convertTimestamp:[dic[@"addtime"] doubleValue] andFormat:@"yyyy/MM/dd"];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ScaleW(60);
}
//#pragma mark --------------------头部信息
//
//-(void)myteamInformationRequest
//{
//    WS(weakSelf);
//    [self.hudView showAnimated:YES];
//    NSMutableDictionary *pamas = [NSMutableDictionary dictionary];
//    [[WLHttpManager shareManager]requestWithURL_HTTPCode:kIscm_team_achievement_Api RequestType:RequestTypePost Parameters:pamas Success:^(NSInteger statusCode, id responseObject) {
//        
//        NSLog(@"----%@----",responseObject);
//        
//        WL_Network_Model *net_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
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
    
//    [pamas setObject:@(self.currentType) forKey:@"lv"];
    [pamas setObject:@(_currentPage) forKey:@"p"];
    [pamas setObject:@(kPageSize) forKey:@"size"];
    
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:kIscm_team_achievement_Api RequestType:RequestTypePost Parameters:pamas Success:^(NSInteger statusCode, id responseObject) {
        [weakSelf.tableView.mj_header endRefreshing];
        [self.hudView hideAnimated:YES];
        
        WL_Network_Model *net_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        
        NSArray *list = net_model.data[@"res"];
        
        
        
        
        if (net_model.status.integerValue == 200) {
            
            weakSelf.heardView.leftLab.text = [WLTools noroundingStringWith:[net_model.data[@"now_team_achievement"] doubleValue] afterPointNumber:8];
            weakSelf.heardView.rightLab.text =[WLTools noroundingStringWith:[net_model.data[@"team_achievement"] doubleValue] afterPointNumber:8];

            
            if (weakSelf.currentPage ==1) {
                [self.dataArray removeAllObjects];
                
            }
            for (NSDictionary * dic in list) {
                
                [self.dataArray addObject:dic];
            }
            [SSKJ_NoDataView showNoData:self.dataArray.count toView:self.tableView offY:self.heardView.height];

            [self.tableView reloadData];
        }else{
            [MBProgressHUD showError:net_model.msg];
        }
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [self.hudView hideAnimated:YES];
        [weakSelf.tableView.mj_header endRefreshing];
    }];
}
-(void)requstListAddrequset
{
    self.currentPage ++;
    WS(weakSelf);
    // [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self.hudView showAnimated:YES];
    NSMutableDictionary *pamas = [NSMutableDictionary dictionary];
    //[pamas setObject:kuserUid forKey:@"iid"];
    NSString *type = [NSString stringWithFormat:@"%ld",_currentType];
    NSString *page = [NSString stringWithFormat:@"%ld",_currentPage];
    
    [pamas setObject:type forKey:@"lerver"];
    [pamas setObject:page forKey:@"page"];
    [pamas setObject:@(kPageSize) forKey:@"size"];
    //    lerver    是    int    1 一级 2 二级 3 三级
    //    page    否    int    第几页(默认第1页)
    //    size    否    int    一页几条(默认一页10条)
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:kowner_get_temamy_tuandui RequestType:RequestTypePost Parameters:pamas Success:^(NSInteger statusCode, id responseObject) {
        [weakSelf.tableView.mj_footer endRefreshing];
        [self.hudView hideAnimated:YES];
        WL_Network_Model *net_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        NSArray *list = net_model.data[@"list"];
        if (net_model.status.integerValue == 200) {
            for (NSDictionary * dic in list) {
                
                [self.dataArray addObject:dic];
            }
            [self.tableView reloadData];
        }else{
            [MBProgressHUD showError:net_model.msg];
        }
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [self.hudView hideAnimated:YES];
        [weakSelf.tableView.mj_footer endRefreshing];
    }];
}

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
