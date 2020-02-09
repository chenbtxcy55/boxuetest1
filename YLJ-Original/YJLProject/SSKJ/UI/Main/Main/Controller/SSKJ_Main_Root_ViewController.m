//
//  JB_Main_Root_ViewController.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/5/10.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "SSKJ_Main_Root_ViewController.h"
#import "MarketCoinCell.h"
#import "HomepageHeaderView.h"
#import "SSKJ_Market_Index_Model.h"
#import "ManagerSocket.h"
#import "SSKJ_Main_BannerModel.h"
#import "SSKJ_NoticeList_ViewController.h"
#import "JB_BBTrade_MarketDetail_ViewController.h"
#import "SSKJ_TabbarController.h"

#import "SSKJ_NoticeIndex_Model.h"
#import "SSKJ_Notice_AlertView.h"
#import "SSKJ_Version_AlertView.h"
#import "Mine_Spertor_ViewController.h"
#import "SKNewExchangeVC.h"
#import "CILanguageSelectViewController.h"
#import "HeBi_Version_AlertView.h"
#import "HeBi_Version_Model.h"
//#import "SSKJ_NewsDetail_ViewController.h"
//#import "SSKJ_Default_AlertView.h"
//#import "PDK_ViewController.h"

//#import "SSKJ_NoticeList_ViewController.h"
//#import "SSKJ_Notice_Model.h"
#import "GlobalProtocolViewController.h"
#import "YLJWebViewTableViewCell.h"

#import "ProtocolModel.h"

#define marketSocketIdentifier @"sliderMarket"

static NSString *cellid = @"YLJWebViewTableViewCell";

@interface SSKJ_Main_Root_ViewController ()<UITableViewDelegate,UITableViewDataSource,ManagerSocketDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;//币种数据

@property (nonatomic, strong) NSArray *hotCoinArray;
@property (nonatomic, strong) NSArray *noticeArray;
@property (nonatomic, strong) UIView *sectionView;
@property (nonatomic, strong) HomepageHeaderView *headerView;
@property (nonatomic, strong) ManagerSocket *marketSocket;


@property (nonatomic, assign) BOOL isFirstPost; // 是否是第一次发送通知

//@property (nonatomic, assign) int mySelectedItem;

@property (nonatomic, copy) NSString * allCoinStr; // 是否是第一次发送通知

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) NSArray *bannerArray;

//@property (nonatomic, strong) SSKJ_Version_Model * versionModel;
@property (nonatomic, strong) HeBi_Version_Model * versionModel;
@property (nonatomic, assign) NSInteger webViewHeight;
@property (nonatomic, assign) NSInteger webViewHeight2;

@property (nonatomic,strong) YLJWebViewTableViewCell *htmlCell;

@property (nonatomic, assign) NSInteger currentType;

@end

@implementation SSKJ_Main_Root_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self setNavigationView];
//    self.title = SSKJLocalized(@"行情", nik);
    self.view.backgroundColor = kGrayWhiteColor;

    [self.view addSubview:self.tableView];
    
//    [self addLeftNavItemWithImage:[UIImage imageNamed:@"left_logo"]];

//    self.isFirstPost = YES;
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
//    UIImageView *imgView = [FactoryUI createImageViewWithFrame:CGRectMake(0, 0, ScaleW(62), ScaleW(19)) imageName:@"MONICOIN1"];
        UIImageView *imgView = [FactoryUI createImageViewWithFrame:CGRectMake(0, 0, ScaleW(166.5), ScaleW(49.5)) imageName:@"img_logo"];
//    img_logo
    self.navigationItem.titleView = imgView;

//    if (kLogin) {
        [self checkVersion];
        
//    }
    [self requestWebViewDataWithType:5];
//    [self requestWebViewDataWithType:6];

}


//- (UIStatusBarStyle)preferredStatusBarStyle {
//    return UIStatusBarStyleDefault;
//}



-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO];
    self.navigationController.navigationBar.barTintColor = kMainWihteColor;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;

    
    
   
    
    if ([[[SSKJLocalized sharedInstance] currentLanguage] isEqualToString:@"en"]) {
        
//        [self addRightNavgationItemWithImage:[UIImage imageNamed:@"lange_EN"]];

    }
    else
    {

//        [self addRightNavgationItemWithImage:[UIImage imageNamed:@"lange_CN"]];

    }
    [self headerRefresh];
    [self requestNoticeList];
//    [self openSocket];

    if (kLogin && ![SSKJ_User_Tool sharedUserTool].userInfoModel) {
        [self requestUserInfo];
    }
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    self.navigationController.navigationBar.barTintColor = kTheMeColor;
//    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
//    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
//    statusBar.backgroundColor = [UIColor clearColor];
    
    [self closeSocket];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;

  
}



- (void)requestWebViewDataWithType:(NSInteger) type {
    self.currentType = type;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"type"] = [NSString stringWithFormat:@"%ld",(long)type];
    NSLog(@"params : %@",params);
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    WS(weakSelf);
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:kIscm_agree_Api RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        WL_Network_Model *model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        if (model.status.integerValue == 200) {
            ProtocolModel *pModel = [ProtocolModel mj_objectWithKeyValues:model.data];
            dispatch_async(dispatch_get_main_queue(), ^{
                NSString *str = [NSString stringWithFormat:@"<head><style>img{width:%f !important;height:auto}</style></head>%@",weakSelf.view.width -ScaleW(30),pModel.content];
                [weakSelf reloadWebView:str andType:type];

            });
        } else {
            [MBProgressHUD showError:responseObject[@"msg"]];
        }
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        [MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
    }];
}
- (void)reloadWebView:(NSString *)str andType:(NSInteger )type {
    
        self.webViewHeight = -1;
        
        self.htmlCell.htmlString = str;
        WS(weakSelf);
        self.htmlCell.changeHeightBlock = ^(NSInteger height) {
            BOOL needReload=NO;
            if(weakSelf.webViewHeight<0) needReload=YES;
            weakSelf.webViewHeight = height;
            NSLog(@"callback --------webViewheight  %ld",(long)height);
            //此处needReload有点不严谨，根据需求可以考虑暂时去掉，因为要考虑到多次加载还未获取到最终高度，所以只能多刷新几次tableView
//            if (needReload) {
                [weakSelf.tableView reloadData];
//            }
        };
    
    

}

- (void)rigthBtnAction:(id)sender
{
    
//    if ([[[SSKJLocalized sharedInstance] currentLanguage] isEqualToString:@"en"]) {
//
//        [[SSKJLocalized sharedInstance]setLanguage:@"zh-Hans"];
//    }
//    else
//    {
//        [[SSKJLocalized sharedInstance]setLanguage:@"en"];
//
//
//    }

    //    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    //    [delegate goToMain];
    
//    SSKJ_TabbarController *tabVc = [[SSKJ_TabbarController alloc]init];
//
//    [UIApplication sharedApplication].keyWindow.rootViewController = tabVc;
    
    
    CILanguageSelectViewController *controller = [[CILanguageSelectViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];}

-(NSTimer *)timer
{
    if (nil == _timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:20 target:self selector:@selector(sendMsg) userInfo:nil repeats:YES];
    }
    return _timer;
}

-(HomepageHeaderView *)headerView
{
    if (!_headerView) {
        _headerView = [[HomepageHeaderView alloc]init];
        WS(weakSelf);

        
        _headerView.bannerClickBlock = ^(NSInteger subIndex) {
          
            
            
           NSDictionary * dic = weakSelf.bannerArray[subIndex];
            
            NSLog(@"--%@---",dic);
            
            
            if ([dic[@"url"] length]>0) {
              
            }
        
            
        };
        _headerView.newListBlock = ^{
            
 
            SSKJ_NoticeList_ViewController *vc = [[SSKJ_NoticeList_ViewController alloc]init];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
        
        _headerView.newsIndexBlock = ^(NSInteger index) {
            SSKJ_NoticeIndex_Model *model = weakSelf.noticeArray[index];
           
            SSKJ_NewsDetail_ViewController *vc = [[SSKJ_NewsDetail_ViewController alloc]init];
            vc.detailType = DetailTypeNotice;
            vc.noticeModel = model;
            [weakSelf.navigationController pushViewController:vc animated:YES];
            
        };
        
        _headerView.shopBlock = ^{
            //公司介绍
            [weakSelf requestWebViewDataWithType:5];
//            GlobalProtocolViewController *gVC = [GlobalProtocolViewController new];
//            gVC.type = 6;
//            [weakSelf.navigationController pushViewController:gVC animated:YES];
//            if (!kLogin) {
//
//                [weakSelf presentLoginController];
//
//                return;
//            }
//            SKNewExchangeVC * myNewExchangeVC = [SKNewExchangeVC new];
//            [weakSelf.navigationController pushViewController:myNewExchangeVC animated:YES];
            
        };
        
        _headerView.inviteBlock = ^{
            //产品介绍
            [weakSelf requestWebViewDataWithType:6];
//            GlobalProtocolViewController *gVC = [GlobalProtocolViewController new];
//            gVC.type = 5;
//            [weakSelf.navigationController pushViewController:gVC animated:YES];
//            if (!kLogin) {
//
//                [weakSelf presentLoginController];
//
//                return;
//            }
//            Mine_Spertor_ViewController *  mine_SpertorVC =[Mine_Spertor_ViewController new];
//
//            [weakSelf.navigationController pushViewController:mine_SpertorVC animated:YES];
            
        };

        _headerView.HelpCenterBlock = ^{
            
            
            if (!kLogin) {
                [MBProgressHUD showError:@"请先登录"];
                [weakSelf presentLoginController];
                return ;
            }
          
            
        };
        _headerView.lookMoreBlock = ^{
          
            SSKJ_NoticeList_ViewController *vc = [[SSKJ_NoticeList_ViewController alloc]init];
            [weakSelf.navigationController pushViewController:vc animated:YES];

        
        };
        _headerView.signBlock = ^{
            if (!kLogin) {
                [MBProgressHUD showError:@"请登录"];
                [weakSelf presentLoginController];
                return;
            }
            [weakSelf signEvent];
        };
        
    }
    return _headerView;
}

-(NSMutableArray *)dataSource
{
    if (nil == _dataSource) {
        _dataSource = [NSMutableArray arrayWithCapacity:10];
    }
    return _dataSource;
}




-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - Height_NavBar - Height_TabBar) style:(UITableViewStylePlain)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
//        _tableView.layer.cornerRadius = ScaleW(8);
//        _tableView.layer.masksToBounds = YES;
        
//        [_tableView registerClass:[YLJWebViewTableViewCell class] forCellReuseIdentifier:cellid];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
        _tableView.sectionHeaderHeight = 0.01;
        _tableView.backgroundColor = [UIColor clearColor];
        //_tableView.tableHeaderView = self.headerView;
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
        _tableView.mj_header  = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weakSelf headerRefresh];
        }];
        
    }
    
    return _tableView;
}



-(void)headerRefresh
{
//    [self requestMarketList];
//    [self requestHotCoinList];
    [self requestBanner];
}

-(void)endRefresh
{
    [self.tableView.mj_header endRefreshing];
}

- (void)signEvent {
    [self requestSign];
}
- (void)requestSign {
    WS(weakSelf);
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:kYLJ_center_sign RequestType:RequestTypePost Parameters:nil Success:^(NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        WL_Network_Model *network_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if ([network_model.status integerValue] == SUCCESSED) {
            //            [self.headerView reloadData];
        }else{
        }
        [MBProgressHUD showError:network_model.msg];
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        [MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
    }];
    
}
#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  
//    return self.dataSource.count;
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    YLJWebViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
//    SSKJ_Market_Index_Model *model = self.dataSource[indexPath.row];
//    [cell setCellWithModel:model];
//    if (indexPath.row == self.dataSource.count -1) {
//
//
//        UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:cell.bgView.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:(CGSize){ScaleW(8)}];
//        // 绘制4个角，指定角半径
//        // bezierPath = [UIBezierPath bezierPathWithRoundedRect:imageView2.bounds cornerRadius:20.0];
//        // 绘制圆
//        // bezierPath = [UIBezierPath bezierPathWithOvalInRect:imageView2.bounds];
//        // 初始化shapeLayer
//        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
//        // 设置绘制路径
//        shapeLayer.path = bezierPath.CGPath;
//        // 将shapeLayer设置为imageView2的layer的mask(遮罩)
//        cell.bgView.layer.mask = shapeLayer;
//
//    }
//
//    if (self.currentType == 5) {
        return self.htmlCell;
//    } else if (self.currentType == 6){
//        return self.html2Cell;
//    }
//    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    JB_BBTrade_MarketDetail_ViewController *vc = [[JB_BBTrade_MarketDetail_ViewController alloc]init];
//    vc.coinModel = self.dataSource[indexPath.row];
//
//    vc.coinArr = self.hotCoinArray;
//    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    return ScaleW(56);
//    if (self.currentType == 5) {
//        return self.webViewHeight;
//    } else if (self.currentType == 6){
//        return self.webViewHeight2;
//    }
    return self.webViewHeight;
}
//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    UIView * bgView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleW(100))];
//
//    bgView.backgroundColor = kMainColor;
//
//    UIView * subBgView =[[UIView alloc]initWithFrame:CGRectMake(ScaleW(15), 0, ScreenWidth -ScaleW(30), ScaleW(100))];
//
//    subBgView.backgroundColor = kBgColor353750;
//
//    [bgView addSubview:subBgView];
//
//
//    UILabel * subTitleLabel = [WLTools allocLabel:SSKJLocalized(@"行情", nil) font:systemBoldFont(ScaleW(16)) textColor:kMainTextColor frame:CGRectMake(ScaleW(0), ScaleW(0),bgView.width - ScaleW(30), ScaleW(50)) textAlignment:NSTextAlignmentCenter];
//    subTitleLabel.numberOfLines = 1;
//    subTitleLabel.backgroundColor  = kBgColor353750;
//    [subBgView addSubview:subTitleLabel];
//
//
//    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:subBgView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:(CGSize){ScaleW(8)}];
//    // 绘制4个角，指定角半径
//    // bezierPath = [UIBezierPath bezierPathWithRoundedRect:imageView2.bounds cornerRadius:20.0];
//    // 绘制圆
//    // bezierPath = [UIBezierPath bezierPathWithOvalInRect:imageView2.bounds];
//    // 初始化shapeLayer
//    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
//    // 设置绘制路径
//    shapeLayer.path = bezierPath.CGPath;
//    // 将shapeLayer设置为imageView2的layer的mask(遮罩)
//    subBgView.layer.mask = shapeLayer;
//
//    UIImageView * lineImageView =[[UIImageView alloc] initWithFrame:CGRectMake(ScaleW(0), ScaleW(49), subTitleLabel.width , ScaleW(1))];
//    lineImageView.backgroundColor = UIColorFromRGB(0x1ea8ac);
//    [subBgView addSubview:lineImageView];
//
//
//    UILabel * titleLabel = [WLTools allocLabel:SSKJLocalized(@"名称", nil) font:systemFont(ScaleW(10)) textColor:UIColorFromARGB(0xffffff, 0.75) frame:CGRectMake(ScaleW(15), ScaleW(50)+ ScaleW(26),ScaleW(50), ScaleW(10)) textAlignment:NSTextAlignmentLeft];
//
//    titleLabel.backgroundColor  = kBgColor353750;
//    [subBgView addSubview:titleLabel];
//
//
//    UILabel * titleLabel1 = [WLTools allocLabel:SSKJLocalized(@"最新价", nil) font:systemFont(ScaleW(10)) textColor:UIColorFromARGB(0xffffff, 0.75) frame:CGRectMake(ScaleW(155), ScaleW(50)+ ScaleW(26),ScaleW(60), ScaleW(10)) textAlignment:NSTextAlignmentLeft];
//
//    titleLabel1.backgroundColor  = kBgColor353750;
//    [subBgView addSubview:titleLabel1];
//
//    UILabel * titleLabel2 = [WLTools allocLabel:SSKJLocalized(@"涨跌幅", nil) font:systemFont(ScaleW(10)) textColor:UIColorFromARGB(0xffffff, 0.75) frame:CGRectMake(ScaleW(283), ScaleW(50)+ ScaleW(26),ScaleW(50), ScaleW(10)) textAlignment:NSTextAlignmentLeft];
//
//    titleLabel2.backgroundColor  = kBgColor353750;
//    [subBgView addSubview:titleLabel2];
//
//
//    return bgView;
//}
//-(CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return ScaleW(50+50);
//}

#pragma mark - 网络请求 请求行情列表
-(void)requestMarketList
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    
    WS(weakSelf);
    
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:ETF_BBTrade_MarketList_URL RequestType:RequestTypeGet Parameters:nil Success:^(NSInteger statusCode, id responseObject)
     {
         [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
         [weakSelf.tableView.mj_header endRefreshing];
         WL_Network_Model *network_Model=[WL_Network_Model mj_objectWithKeyValues:responseObject];
         [weakSelf endRefresh];
         if (network_Model.status.integerValue == SUCCESSED)
         {
             [weakSelf handleMarketListWith:network_Model];
         }else{
             [MBProgressHUD showError:network_Model.msg];
         }
     } Failure:^(NSError *error, NSInteger statusCode, id responseObject)
     {
         [weakSelf endRefresh];
         [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
         [weakSelf.tableView.mj_header endRefreshing];
         [MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
     }];
}


-(void)handleMarketListWith:(WL_Network_Model *)network_model
{
    NSArray *array = [SSKJ_Market_Index_Model mj_objectArrayWithKeyValuesArray:network_model.data];
    
    

    NSMutableArray *coinArray = [NSMutableArray array];
    
    for (int i = 0; i< array.count; i++) {
        
        SSKJ_Market_Index_Model * model = array[i];
        
        [coinArray addObject:model.code];
        
    }
    
    self.hotCoinArray = coinArray;
    
    self.allCoinStr = [coinArray componentsJoinedByString:@"|"];
    


    [self.dataSource removeAllObjects];
    
    [self.dataSource addObjectsFromArray:array];
    

    for (int i = 0; i < self.dataSource.count; i++) {
        SSKJ_Market_Index_Model *model = self.dataSource[i];
        if ([model.code isEqualToString:@"btc_usdt"]||[model.code isEqualToString:@"eth_usdt"]||[model.code isEqualToString:@"eos_usdt"]) {
//            [self.headerView didGetSocketModel:model];

        }
        
    }




    
    [self.tableView reloadData];
    

    
    
}


//-(void)requestHotCoinList
//{
//
//    WS(weakSelf);
//
//    [[WLHttpManager shareManager] requestWithURL_HTTPCode:ETF_BBTrade_HotList_URL RequestType:RequestTypeGet Parameters:nil Success:^(NSInteger statusCode, id responseObject)
//     {
//         WL_Network_Model *network_Model=[WL_Network_Model mj_objectWithKeyValues:responseObject];
//         if (network_Model.status.integerValue == SUCCESSED)
//         {
//             weakSelf.hotCoinArray = [SSKJ_Market_Index_Model mj_objectArrayWithKeyValuesArray:network_Model.data];
//             weakSelf.headerView.coinArray = weakSelf.hotCoinArray;
//
//             [weakSelf sendMsg];
//         }else{
//             [MBProgressHUD showError:network_Model.msg];
//         }
//     } Failure:^(NSError *error, NSInteger statusCode, id responseObject)
//     {
//         [MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
//     }];
//}

#pragma mark - Banner
-(void)requestBanner
{
    
    WS(weakSelf);
    
//    NSString *language = [[SSKJLocalized sharedInstance]currentLanguage];
//    NSString *type;
//    if ([language isEqualToString:@"en"]) {
//        type = @"2";
//    }else{
//        type = @"1";
//    }
    
    NSDictionary *params = @{
                             @"size":@(10)
                             };
//    ETF_bannerfind_URL
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:ETF_Main_GetBanner_URL RequestType:RequestTypeGet Parameters:params Success:^(NSInteger statusCode, id responseObject)
     {
         [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
         WL_Network_Model *network_Model=[WL_Network_Model mj_objectWithKeyValues:responseObject];
         
         if (network_Model.status.integerValue == SUCCESSED)
         {
             [weakSelf handleBannerListWithModel:network_Model];
         }else{
             [MBProgressHUD showError:network_Model.msg];
         }
         [weakSelf endRefresh];
     } Failure:^(NSError *error, NSInteger statusCode, id responseObject)
     {
         [MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
         [weakSelf endRefresh];
     }];
}


-(void)handleBannerListWithModel:(WL_Network_Model *)net_model
{
    NSArray *bannerArray = net_model.data[@"banner"];
    
    self.bannerArray = bannerArray;
    
    self.headerView.bannerArray = bannerArray;
    
}


#pragma mark - socket
-(void)openSocket
{
//    WS(weakSelf);
    if (![self.marketSocket socketIsConnected]) {
        self.marketSocket.delegate = self;
        WS(weakSelf);
        [self.marketSocket openConnectSocketWithConnectSuccess:^{
            NSString *type = [WLTools wlDictionaryToJson:@{@"code":@"all"}];

//            [weakSelf.timer fire];
            [weakSelf.marketSocket socketSendMsg:type];

        }];
    }
    
}



-(void)sendMsg
{
//    NSMutableString *string = [[NSMutableString alloc]initWithString:[NSString stringWithFormat:@"ticker@%@",self.allCoinStr]];
    
//    for (SSKJ_Market_Index_Model *model in self.dataSource) {
//
//        if ([string hasSuffix:@"@"]) {
//
//            [string appendString:model.code ? model.code : @""];
//        }else{
//            [string appendFormat:@"|%@",model.code];
//        }
//    }
//
//    for (SSKJ_Market_Index_Model *model in self.hotCoinArray) {
//
//        if ([string hasSuffix:@"@"]) {
//            [string appendString:model.code ? model.code : @""];
//        }else{
//            [string appendFormat:@"|%@",model.code];
//        }
//    }
    
//    NSString *type = [WLTools wlDictionaryToJson:@{@"code":@"all"}];
//    
//    [self.marketSocket socketSendMsg:type];
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
    
    if ([self.marketSocket socketIsConnected]) {
        self.marketSocket.delegate = nil;
        [self.marketSocket closeConnectSocket];
        
    }
    
    
    [self.timer invalidate];
    self.timer = nil;
}


#pragma mark -- ManagerSocketDelegate
-(void)socketDidReciveData:(id)data identifier:(NSString *)identifier
{
    
    NSDictionary *dic = [self dicWithData:data];
    if ([identifier isEqualToString:marketSocketIdentifier]){
        SSKJ_Market_Index_Model *socketModel = [SSKJ_Market_Index_Model mj_objectWithKeyValues:dic];

        for (int i = 0; i < self.dataSource.count; i++) {
            SSKJ_Market_Index_Model *model = self.dataSource[i];
            if ([socketModel.code isEqualToString:model.code]) {
                model.price = socketModel.price;
                model.change = socketModel.change;
                model.changeRate = socketModel.changeRate;
                model.cnyPrice = socketModel.cnyPrice;
                
                MarketCoinCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
//                [self.headerView didGetSocketModel:model];

                [cell setCellWithModel:model];

                
                break;
            }
        }
        
       
      
        
        [self.tableView reloadData];

        
        
        
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

#pragma mark 请求个人中心



-(void)requestUserInfo
{

    [[WLHttpManager shareManager]requestWithURL_HTTPCode:JB_Account_UserInfo_URL RequestType:RequestTypeGet Parameters:nil Success:^(NSInteger statusCode, id responseObject) {
//        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        WL_Network_Model *network_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if ([network_model.status integerValue] == SUCCESSED) {
            SSKJ_UserInfo_Model *model = [SSKJ_UserInfo_Model mj_objectWithKeyValues:network_model.data];
            [SSKJ_User_Tool sharedUserTool].userInfoModel = model;
            
        }else{
            [MBProgressHUD showError:network_model.msg];
        }
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
//        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        [MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
    }];
    
}



#pragma mark - 获取公告列表

-(void)requestNoticeList
{
//
    NSString *language = [[SSKJLocalized sharedInstance]currentLanguage];

    NSString *lanType;
    if ([language isEqualToString:@"en"]) {
        lanType = @"en";
    }
    else {
        lanType = @"zh";
    }

    NSDictionary *params = @{
//                             @"lang":lanType,
                             @"p":@(1),
                             @"size":@(10)
                             };
    WS(weakSelf);
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:KShopNoticeUrl RequestType:RequestTypeGet Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        WL_Network_Model *network_Model=[WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if (network_Model.status.integerValue == SUCCESSED)
        {
            weakSelf.noticeArray = [SSKJ_NoticeIndex_Model mj_objectArrayWithKeyValuesArray:network_Model.data[@"notices"]];
            
            NSMutableArray *array = [NSMutableArray arrayWithCapacity:1];
            for (SSKJ_NoticeIndex_Model *model in self.noticeArray) {
                [array addObject:model.title];
            }
            
            weakSelf.headerView.noticeArray = array;
            
        }else{
            [MBProgressHUD showError:network_Model.msg];
        }
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
    }];
}

#pragma mark - 检测版本更新
-(void)checkVersion
{
    NSDictionary *dict=@{@"version":AppVersion,
                         @"type":@"2"
                         };
    
    SsLog(@"\r版本->请求参数：%@",dict);
    
    WS(weakSelf);
    
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:JB_CheckVersion_URL RequestType:RequestTypePost Parameters:dict Success:^(NSInteger statusCode, id responseObject) {
        WL_Network_Model *network_Model=[WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if (network_Model.status.integerValue == SUCCESSED)
        {

            if (self.versionModel==nil) {
//                SSKJ_Version_Model * model = [SSKJ_Version_Model mj_objectWithKeyValues:network_Model.data];
                HeBi_Version_Model * model = [HeBi_Version_Model mj_objectWithKeyValues:network_Model.data];
                weakSelf.versionModel = model;
                
                [HeBi_Version_AlertView showWithModel:model confirmBlock:^{
                    [weakSelf upgrade_Button_Event];

                } cancleBlock:^{
                    [weakSelf requestAlertNotice];

                }];
//                [SSKJ_Version_AlertView showWithModel:model confirmBlock:^{
//
//
//                    [weakSelf upgrade_Button_Event];
//
//
//                } cancleBlock:^{
//                    [weakSelf requestAlertNotice];
//
//                }];
            }
 

     
            
            
            
        }else{
            [weakSelf requestAlertNotice];
            
        }
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [weakSelf requestAlertNotice];
    }];
    
}
#pragma mark - 版本更新控制 立即更新 事件
-(void)upgrade_Button_Event
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.versionModel.addr]];
}

#pragma mark - 获取弹窗公告
-(void)requestAlertNotice
{
//    NSString *language = [[SSKJLocalized sharedInstance]currentLanguage];
//
//    NSString *lanType;
//    if ([language isEqualToString:@"en"]) {
//        lanType = @"en";
//    }
//    else {
//        lanType = @"zh";
//    }
    
    NSDictionary *params = @{
                             @"type":@"7"
                             };
   
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:kIscm_agree_Api RequestType:RequestTypeGet Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        WL_Network_Model *network_Model=[WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if (network_Model.status.integerValue == SUCCESSED)
        {

//            [SSKJ_Notice_AlertView show:network_Model.data[@"content"] confirmBlock:^{
//
//            } cancleBlock:^{
//
//
//            }];
            [SSKJ_Notice_AlertView showWithContent:network_Model.data[@"content"] andTitle:network_Model.data[@"title"] confirmBlock:^{
                
            } cancleBlock:^{
                
            }];
            
        }else{
        }
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {

    }];
}

- (YLJWebViewTableViewCell *)htmlCell {
    if (!_htmlCell) {
        _htmlCell = [[YLJWebViewTableViewCell alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleW(50))];
    }
    return _htmlCell;
}


@end
