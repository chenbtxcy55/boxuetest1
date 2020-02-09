//
//  MyTeamViewController.m
//  SSKJ
//
//  Created by 张本超 on 2019/6/20.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "MyTeamViewController.h"
#import "AccountSectionView.h"

#import "MyTeamHeardView.h"
#import "MyTeamViewCell.h"

#define kPageSize 30
@interface MyTeamViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) AccountSectionView *sectionView;
@property (nonatomic, strong) MyTeamHeardView *heardView;
@property (nonatomic, assign) NSInteger currentPage;
//1 一代 2二代 3三代
@property (nonatomic, assign) NSInteger currentType;
//
@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) MBProgressHUD *hudView;

@end

@implementation MyTeamViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.currentType = 1;
    [self.view addSubview:self.tableView];
    self.title = SSKJLocalized(@"团队列表", nil);
    
    
    
    
}
-(MBProgressHUD *)hudView{
    if (!_hudView) {
        _hudView = [[MBProgressHUD alloc] initWithView:self.view];
    }
    return _hudView;
}
- (MyTeamHeardView *)heardView{
    if (!_heardView) {
        _heardView = [[MyTeamHeardView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleW(60))];
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
    MyTeamViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyTeamViewCell"];
    if (!cell)
    {
        cell = [[MyTeamViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MyTeamViewCell"];
    }
    NSDictionary *dic = self.dataArray[indexPath.row];
     [cell layoutPingfendViews];
    
    cell.oneLab.text = dic[@"account"];
    NSString *lerver;
    if ([dic[@"lerver"] intValue] == 1) {
        lerver = @"一级";
    }
    if ([dic[@"lerver"] intValue] == 2) {
        lerver = @"二级";
    }
    if ([dic[@"lerver"] intValue] == 3) {
        lerver = @"三级";
    }

    if ([dic[@"reg_time"] length] > 0) {
        cell.threeLab.text= [WLTools convertTimestamp:[dic[@"reg_time"] intValue] andFormat:@"yyyy/MM/dd"];
    }
    
    cell.twoLab.text = lerver;
    NSString *state;
    if ([dic[@"state"] intValue] == 1) {
       state = @"已激活";
    } else {
        state = @"未激活";
    }
    cell.fourLab.text = state;
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
//    [[WLHttpManager shareManager]requestWithURL_HTTPCode:kIscm_team_jiBiecount_Api RequestType:RequestTypePost Parameters:pamas Success:^(NSInteger statusCode, id responseObject) {
//
//        NSLog(@"----%@----",responseObject);
//
//        WL_Network_Model *net_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
//
//        NSDictionary *count = net_model.data[0];
//
//        NSString *string= [NSString stringWithFormat:@"一级（%d人）",[[NSString stringWithFormat:@"%@",count[@"one"]] intValue]];
//        [self.sectionView.oneLabel setTitle:string forState:(UIControlStateNormal)];
//        NSString *string1= [NSString stringWithFormat:@"二级（%d人）",[[NSString stringWithFormat:@"%@",count[@"two"]] intValue]];
//        [self.sectionView.twoLabel setTitle:string1 forState:(UIControlStateNormal)];
//        NSString *string2= [NSString stringWithFormat:@"三级（%d人）",[[NSString stringWithFormat:@"%@",count[@"three"]] intValue]];
//        [self.sectionView.threeLabel setTitle:string2 forState:(UIControlStateNormal)];
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
    [self.dataArray removeAllObjects];
    [self.tableView reloadData];
    NSMutableDictionary *pamas = [NSMutableDictionary dictionary];
    //[pamas setObject:kuserUid forKey:@"iid"];
    NSString *page = [NSString stringWithFormat:@"%ld",_currentPage];
    
//    [pamas setObject:@(self.currentType) forKey:@"lv"];
    [pamas setObject:page forKey:@"p"];
    [pamas setObject:@(kPageSize) forKey:@"size"];
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:kIscm_team_list_Api RequestType:RequestTypePost Parameters:pamas Success:^(NSInteger statusCode, id responseObject) {
        [weakSelf.tableView.mj_header endRefreshing];
        [self.hudView hideAnimated:YES];
        
        
        
        WL_Network_Model *net_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        
      
        NSArray *list = net_model.data[@"list"];
        
       
        
    
      if (net_model.status.integerValue == 200) {
          
          weakSelf.heardView.leftLab.text = [NSString stringWithFormat:@"%@",net_model.data[@"now_team_num"]];
          weakSelf.heardView.rightLab.text = [NSString stringWithFormat:@"%@",net_model.data[@"count"]];

          
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

//-(void)requstListAddrequset
//{
//    self.currentPage ++;
//    WS(weakSelf);
//    // [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    [self.hudView showAnimated:YES];
//    NSMutableDictionary *pamas = [NSMutableDictionary dictionary];
//    //[pamas setObject:kuserUid forKey:@"iid"];
//    NSString *type = [NSString stringWithFormat:@"%ld",_currentType];
//    NSString *page = [NSString stringWithFormat:@"%ld",_currentPage];
//
//    [pamas setObject:type forKey:@"lerver"];
//    [pamas setObject:page forKey:@"page"];
//    [pamas setObject:@(kPageSize) forKey:@"size"];
////    lerver    是    int    1 一级 2 二级 3 三级
////    page    否    int    第几页(默认第1页)
////    size    否    int    一页几条(默认一页10条)
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
//    [self requstListrequset:1];
//    [self requstListrequset:2];
//    [self requstListrequset:3];
    self.currentPage = 1;

    [self requstListrequset];
}
-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
-(void)requstListrequset:(NSInteger)index
{
    self.currentPage = 1;
    [self.tableView.mj_footer resetNoMoreData];
    WS(weakSelf);
    [self.hudView showAnimated:YES];
    [self.dataArray removeAllObjects];
    [self.tableView reloadData];
    NSMutableDictionary *pamas = [NSMutableDictionary dictionary];
    //[pamas setObject:kuserUid forKey:@"iid"];
    NSString *page = [NSString stringWithFormat:@"%ld",_currentPage];
    
    [pamas setObject:@(index) forKey:@"lerver"];
    [pamas setObject:page forKey:@"page"];
    [pamas setObject:@(kPageSize) forKey:@"size"];
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:kowner_get_temamy_tuandui RequestType:RequestTypePost Parameters:pamas Success:^(NSInteger statusCode, id responseObject) {
        [weakSelf.tableView.mj_header endRefreshing];
        [self.hudView hideAnimated:YES];
        
        WL_Network_Model *net_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        NSString *count = net_model.data[@"count"];
        
        if (index == 1) {
            NSString *string= [NSString stringWithFormat:@"一级（%@人）",count];
            [self.sectionView.oneLabel setTitle:string forState:(UIControlStateNormal)];
            
        }else if(index == 2)
        {
            NSString *string= [NSString stringWithFormat:@"二级（%@人）",count];
            [self.sectionView.twoLabel setTitle:string forState:(UIControlStateNormal)];
        }else if(index == 3)
        {
            NSString *string= [NSString stringWithFormat:@"三级（%@人）",count];
            [self.sectionView.threeLabel setTitle:string forState:(UIControlStateNormal)];
        }
        
        
        if (net_model.status.integerValue == 200) {
            
        }else{
            [MBProgressHUD showError:net_model.msg];
        }
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [self.hudView hideAnimated:YES];
        [weakSelf.tableView.mj_header endRefreshing];
    }];
}

@end
