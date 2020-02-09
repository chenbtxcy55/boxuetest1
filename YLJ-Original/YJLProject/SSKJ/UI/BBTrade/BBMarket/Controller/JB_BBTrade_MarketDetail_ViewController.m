//
//  JB_BBTrade_MarketDetail_ViewController.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/5/14.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "JB_BBTrade_MarketDetail_ViewController.h"


// controller
#import "SSKJ_TabbarController.h"
#import "AppDelegate.h"
// view
#import "ETF_BBTrade_TableHeaderView.h"
#import "ETF_BBTrade_SegmentControl.h"
#import "LXY_KLineView.h"
#import "ETF_BBTrade_IntroductHeaderView.h"
#import "ETF_BBTrade_IntroductView.h"
#import "ETF_Kline_Zhibiao_View.h"
#import "JB_SocketDealOrder_Cell.h"
#import "JB_BBTrade_SocketDealOrder_View.h"
#import "ETF_BBTrade_MoreSegment_View.h"

// model
#import "ETF_BBTrade_Introduce_Model.h"

// tools
#import "ManagerSocket.h"
#import "LXY_KLinePositionTool.h"
#import "ETF_Default_ActionsheetView.h"

static NSString *klineSocketIdentifier = @"klineSocketIdentifier";
static NSString *orderSocketIdentifier = @"orderSocketIdentifier";


@interface JB_BBTrade_MarketDetail_ViewController ()<ManagerSocketDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) ETF_BBTrade_TableHeaderView *headerView;

@property (nonatomic, strong) ETF_BBTrade_SegmentControl *segmentControl;

@property (nonatomic, strong) LXY_KLineView *kLineView;
@property (nonatomic, strong) ETF_BBTrade_IntroductHeaderView *introductHeaderView;

@property (nonatomic, strong) JB_BBTrade_SocketDealOrder_View *socketOrderView;
@property (nonatomic, strong) ETF_BBTrade_IntroductView *introductView;

@property (nonatomic, strong) ETF_Kline_Zhibiao_View *zhibiaoView;
@property (nonatomic, strong) ETF_BBTrade_MoreSegment_View *moreView;



@property (nonatomic, strong) NSArray *kLineDataArray;

// k线图时间类型
@property (nonatomic, strong) NSString *typeString;


// 币币交易按钮
@property (nonatomic, strong) UIButton *bbTradebutton;


// 行情推送
@property (nonatomic, strong) ManagerSocket *klineSocket;


//// 盘口推送
//@property (nonatomic, strong) ManagerSocket *orderSocket;


// 币种简介model
@property (nonatomic, strong) ETF_BBTrade_Introduce_Model *introduceModel;

@property(nonatomic, strong)UILabel *leftLabel;

@property(nonatomic, strong)UILabel * coinTitlelB;

@end

@implementation JB_BBTrade_MarketDetail_ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //    self.title = SSKJLocalized(@"币币交易", nil);
    
    
//    UILabel *label = [WLTools allocLabel:self.coinModel.name font:systemScaleBoldFont(15) textColor:kTitleColor frame:CGRectMake(44, 0, 50, Height_NavBar - Height_StatusBar) textAlignment:NSTextAlignmentLeft];
//    label.tag = 1001;
//    [self.navigationController.navigationBar addSubview:label];

    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(applicationDidBecomeActive:) name:UIApplicationDidBecomeActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(applicationDidEnterBackground:) name:UIApplicationDidEnterBackgroundNotification object:nil];
    
    
//    self.title = [self.coinModel.name stringByReplacingOccurrencesOfString:@"_" withString:@"/"];
    self.typeString = @"1min";
    [self setNaviItem];
    
    [self setUI];
    
    
}
- (void)setNaviItem{
    UIView *naviView = [[UIView alloc] init];
    UIImageView *downImgV = [[UIImageView alloc] init];
    downImgV.contentMode = UIViewContentModeScaleAspectFit;
    downImgV.image = [UIImage imageNamed:@"bc_bb_down"];
    UILabel *titleLb = [UILabel new];
    titleLb.textColor = kMainTextColor;
    titleLb.font = systemFont(ScaleW(18));
    self.coinTitlelB = titleLb;
    UIButton *downBtn = [UIButton new];
    [downBtn addTarget:self action:@selector(coinBtnAction) forControlEvents:UIControlEventTouchUpInside];
    //layout
    titleLb.text = [[self.coinModel.code uppercaseString] stringByReplacingOccurrencesOfString:@"_" withString:@"/"];
    self.navigationItem.titleView = naviView;
    [naviView addSubview:downImgV];
    [naviView addSubview:titleLb];
    [naviView addSubview:downBtn];
    
    [titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.mas_equalTo(naviView);
    }];
    [downImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.mas_equalTo(naviView);
        make.width.mas_equalTo(ScaleW(10));
        make.left.mas_equalTo(titleLb.mas_right).offset(ScaleW(5));
    }];
    [downBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(naviView).insets(UIEdgeInsetsZero);
    }];
    
    
}
#pragma mark - 获取币种列表

-(void)coinBtnAction
{
    
    NSMutableArray *nameArr = [NSMutableArray array];
   
    for (int i= 0; i<self.coinArr.count; i++) {
        NSString * nameStr = self.coinArr[i];
        
        [nameArr addObject:[[nameStr uppercaseString] componentsSeparatedByString:@"_"].firstObject];
        
    }
    
    
    [ETF_Default_ActionsheetView showWithItems:nameArr title:@"" selectedIndexBlock:^(NSInteger selectIndex) {
        self.coinModel.code = self.coinArr[selectIndex];
        
        self.coinTitlelB.text = [[self.coinArr[selectIndex] uppercaseString] stringByReplacingOccurrencesOfString:@"_" withString:@"/"];
        
        [self closeSocket];
        
        [self requestMarketList];
        
        [self requestKlineData];
        [self requstWithInstrolHttpRequst];
        [self openSocket];

        
    } cancleBlock:^{
        
    }];
    
    
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

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];

    [LXY_KLinePositionTool setDotNumber:[WLTools dotNumberOfCoinCode:self.coinModel.code]];
    
    [self requestKlineData];
    [self requstWithInstrolHttpRequst];
    [self openSocket];
    
}


-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self closeSocket];
    
    for (UIView *view in self.navigationController.navigationBar.subviews) {
        if ([view isKindOfClass:[UILabel class]]) {
            if (view.tag == 1001) {
                [view removeFromSuperview];
            }
        }
    }
}

-(ManagerSocket *)klineSocket
{
    if (nil == _klineSocket) {
        _klineSocket = [[ManagerSocket alloc]initWithUrl:BBMarketSocketUrl identifier:klineSocketIdentifier];
    }
    return _klineSocket;
}

//-(ManagerSocket *)orderSocket
//{
//    if (nil == _orderSocket) {
//        _orderSocket = [[ManagerSocket alloc]initWithUrl:BBDealRecordSocketUrl identifier:orderSocketIdentifier];
//    }
//    return _orderSocket;
//}


#pragma mark - UI
-(void)setUI
{
    
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.headerView];
    [self.scrollView addSubview:self.segmentControl];
    [self.scrollView addSubview:self.kLineView];
    [self.scrollView addSubview:self.introductHeaderView];
    [self.scrollView addSubview:self.introductView];
    self.scrollView.contentSize = CGSizeMake(ScreenWidth, self.introductView.bottom + ScaleW(20));
    [self.scrollView addSubview:self.socketOrderView];
//    [self.view addSubview:self.bbTradebutton];
    
}


-(UIScrollView *)scrollView
{
    if (nil == _scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, ScaleW(10), ScreenWidth, ScreenHeight - Height_NavBar)];
        _scrollView.backgroundColor = kMainColor;
    }
    return _scrollView;
}

-(ETF_BBTrade_TableHeaderView *)headerView
{
    if (nil == _headerView) {
        _headerView = [[ETF_BBTrade_TableHeaderView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleW(110))];
        _headerView.coinModel = self.coinModel;
    }
    return _headerView;
}

-(ETF_BBTrade_SegmentControl *)segmentControl
{
    if (nil == _segmentControl) {
        _segmentControl = [[ETF_BBTrade_SegmentControl alloc]initWithFrame:CGRectMake(0, self.headerView.bottom + ScaleW(5), ScreenWidth, ScaleW(53)) titles:@[SSKJLocalized(@"分时",nil),[NSString stringWithFormat:@"1%@",SSKJLocalized(@"M", nil)],[NSString stringWithFormat:@"15%@",SSKJLocalized(@"M", nil)],[NSString stringWithFormat:@"1%@",SSKJLocalized(@"H", nil)], [NSString stringWithFormat:@"%@",SSKJLocalized(@"日线", nil)],SSKJLocalized(@"更多", nil),SSKJLocalized(@"指标", nil)] normalColor:kSubTxtColor selectedColor:kMainTextColor fontSize:ScaleW(13)];
        _segmentControl.backgroundColor = kNavBGColor;
        WS(weakSelf);
        _segmentControl.selectedIndexBlock = ^(NSInteger index) {
            [weakSelf segmentSelectIndex:index];
        };
        _segmentControl.zhibiaoBlock = ^{
            if (weakSelf.zhibiaoView.superview) {
                [weakSelf.zhibiaoView removeFromSuperview];
            }else{
                [weakSelf.scrollView addSubview:weakSelf.zhibiaoView];
            }
            
            if (weakSelf.moreView.superview) {
                [weakSelf.moreView removeFromSuperview];
            }
            
        };
        
        _segmentControl.moreBlock = ^{
            if (weakSelf.moreView.superview) {
                [weakSelf.moreView removeFromSuperview];
            }else{
                [weakSelf.scrollView addSubview:weakSelf.moreView];
            }
            if (weakSelf.zhibiaoView.superview) {
                [weakSelf.zhibiaoView removeFromSuperview];
            }
        };
        
    }
    return _segmentControl;
}

-(LXY_KLineView *)kLineView
{
    if (nil == _kLineView) {
        _kLineView = [[LXY_KLineView alloc]initWithFrame:CGRectMake(0, self.segmentControl.bottom, ScreenWidth, ScaleW(328)) accessoryType:LXY_ACCESSORYTYPENONE mainAccessoryType:LXY_KMAINACCESSORYTYPEMA];
    }
    return _kLineView;
}

-(ETF_BBTrade_IntroductHeaderView *)introductHeaderView
{
    if (nil == _introductHeaderView) {
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, self.kLineView.bottom, ScreenWidth, 5)];
        line.backgroundColor = kNavBGColor;
        [self.scrollView addSubview:line];
        
        
        _introductHeaderView = [[ETF_BBTrade_IntroductHeaderView alloc]initWithFrame:CGRectMake(0, line.bottom, ScreenWidth, ScaleW(40))];
        _introductHeaderView.backgroundColor = UIColorFromRGB(0x353750);
//        WS(weakSelf);
//        _introductHeaderView.segmentSelectBlock = ^(NSInteger index) {
//            if (index == 0) {
//                weakSelf.socketOrderView.hidden = NO;
//                weakSelf.introductView.hidden = YES;
//                weakSelf.scrollView.contentSize = CGSizeMake(ScreenWidth, weakSelf.socketOrderView.bottom + ScaleW(50));
//            }else{
                self.socketOrderView.hidden = YES;
                self.introductView.hidden = NO;
                self.scrollView.contentSize = CGSizeMake(ScreenWidth, self.introductView.bottom + ScaleW(20));
//
//            }
//        };
    }
    return _introductHeaderView;
}

-(ETF_BBTrade_IntroductView *)introductView
{
    if (nil == _introductView) {
        _introductView = [[ETF_BBTrade_IntroductView alloc]initWithFrame:CGRectMake(0, self.introductHeaderView.bottom, ScreenWidth, ScaleW(200))];
        _introductView.backgroundColor = kNavBGColor;
        _introductView.hidden = YES;
    }
    return _introductView;
}

-(JB_BBTrade_SocketDealOrder_View *)socketOrderView
{
    if (nil == _socketOrderView) {
        _socketOrderView = [[JB_BBTrade_SocketDealOrder_View alloc]initWithFrame:CGRectMake(0, self.introductHeaderView.bottom, ScreenWidth, 0)];
        _socketOrderView.coinModel = self.coinModel;
    }
    return _socketOrderView;
}

-(ETF_Kline_Zhibiao_View *)zhibiaoView
{
    if (nil == _zhibiaoView) {
        _zhibiaoView = [[ETF_Kline_Zhibiao_View alloc]initWithFrame:CGRectMake(ScaleW(5), self.segmentControl.bottom, ScreenWidth - ScaleW(10), ScaleW(100))];
        WS(weakSelf);
        _zhibiaoView.selectMainAccessoryBlock = ^(LXY_KMAINACCESSORYTYPE mainAccessoryType) {
            weakSelf.kLineView.mainAccessoryType = mainAccessoryType;
        };
        
        
        _zhibiaoView.selectSubAccessoryBlock = ^(LXY_ACCESSORYTYPE accessoryType) {
            weakSelf.kLineView.accessoryType = accessoryType;
        };
        _zhibiaoView.backgroundColor = kBgColor353750;
    }
    return _zhibiaoView;
}


-(ETF_BBTrade_MoreSegment_View *)moreView
{
    if (nil == _moreView) {
        _moreView = [[ETF_BBTrade_MoreSegment_View alloc]initWithFrame:CGRectMake(0, self.segmentControl.bottom, ScreenWidth, ScaleW(40))];
        WS(weakSelf);
        _moreView.selectBlock = ^(NSInteger index, NSString * _Nonnull title) {
            [weakSelf.moreView removeFromSuperview];
            [weakSelf.segmentControl setMoreWithTitle:title];
            [weakSelf moreSegmentSelectIndex:index];
        };
        _moreView.backgroundColor = kBgColor353750;

    }
    return _moreView;
}

-(UIButton *)bbTradebutton
{
    if (nil == _bbTradebutton) {
        _bbTradebutton = [[UIButton alloc]initWithFrame:CGRectMake(ScaleW(15), ScreenHeight - ScaleW(20) - ScaleW(50) - Height_NavBar, ScreenWidth - ScaleW(30), ScaleW(50))];
        [_bbTradebutton setTitle:SSKJLocalized(@"币币交易", nil) forState:UIControlStateNormal];
        [_bbTradebutton setTitleColor:kMainWihteColor forState:UIControlStateNormal];
        _bbTradebutton.titleLabel.font = systemFont(ScaleW(15));
        _bbTradebutton.layer.masksToBounds = YES;
        _bbTradebutton.layer.cornerRadius = _bbTradebutton.height / 2;
//        _bbTradebutton.backgroundColor = GREEN_HEX_COLOR;
        [_bbTradebutton addTarget:self action:@selector(toBBTradeEvent) forControlEvents:UIControlEventTouchUpInside];
        [_bbTradebutton addGradientColor];
    }
    return _bbTradebutton;
}

#pragma mark - socket

-(void)openSocket
{
    WS(weakSelf);
    if (!self.klineSocket.socketIsConnected) {
        self.klineSocket.delegate = self;
        [self.klineSocket openConnectSocketWithConnectSuccess:^{
            NSString *type = [WLTools wlDictionaryToJson:@{@"code":self.coinModel.code}];
            
            [weakSelf.klineSocket socketSendMsg:type];
        }];
    }
    
//    if (!self.orderSocket.socketIsConnected) {
//        self.orderSocket.delegate = self;
//        [self.orderSocket openConnectSocketWithConnectSuccess:^{
//            NSString *type = [WLTools wlDictionaryToJson:@{@"code":self.coinModel.code}];
//            [weakSelf.orderSocket socketSendMsg:type];
//        }];
//    }
}

-(void)closeSocket
{
    if (self.klineSocket.socketIsConnected) {
        self.klineSocket.delegate = nil;
        [self.klineSocket closeConnectSocket];
    }
    
//    if (self.orderSocket.socketIsConnected) {
//        self.orderSocket.delegate = nil;
//        [self.orderSocket closeConnectSocket];
//    }
    
}

#pragma mark - 用户操作

-(void)segmentSelectIndex:(NSInteger)index
{
    if (self.zhibiaoView.superview) {
        [self.zhibiaoView removeFromSuperview];
    }
    
    if (self.moreView.superview) {
        [self.moreView removeFromSuperview];
    }
    
    switch (index) {
//        case 0:
//            self.typeString = @"minute";
//            break;
        case 0:
            self.typeString = @"1min";
            break;
        case 1:
            self.typeString = @"minute";
            break;
        case 2:
            self.typeString = @"minute15";
            break;
        case 3:
            self.typeString = @"hour";
            break;
        case 4:
            self.typeString = @"day";
            break;
     
        default:
            break;
    }
    
    [self requestKlineData];
}



-(void)moreSegmentSelectIndex:(NSInteger)index
{

    switch (index) {
        case 0:
            self.typeString = @"minute5";
            break;
        
        case 1:
            self.typeString = @"minute30";
            break;
        case 2:
            self.typeString = @"week";
            break;
        case 3:
            self.typeString = @"month";
            break;

        default:
            break;
    }
    
    [self requestKlineData];
}

#pragma mark 跳转币币交易
-(void)toBBTradeEvent
{
    if (self.isFromBBTrade) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        
        SSKJ_TabbarController *tabbVc = (SSKJ_TabbarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
        [[NSNotificationCenter defaultCenter]postNotificationName:@"didGetCoinModel" object:self.coinModel];
        tabbVc.selectedIndex = 1;
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

#pragma mark 请求k线数据
-(void)requestKlineData
{
    NSDictionary *dict=@{@"goodsType":self.typeString,
                         @"code":self.coinModel.code,
                         @"pageSize":@(500),
                         };
    
    
    WS(weakSelf);
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:kIscm_Market_KLine RequestType:RequestTypeGet Parameters:dict Success:^(NSInteger statusCode, id responseObject)
     {
         
         WL_Network_Model *network_Model=[WL_Network_Model mj_objectWithKeyValues:responseObject];
         [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        
         if ( [network_Model.code isEqualToString: SUCCEED] ) {
             
             NSLog(@"data::%@",network_Model.data);
             
             weakSelf.kLineDataArray=network_Model.data;
             
             if (weakSelf.kLineDataArray.count) {
                 
                 [weakSelf setKlineView];

             }
         }
         else{
             [MBProgressHUD showSuccess:network_Model.msg];
             
         }
         
     } Failure:^(NSError *error, NSInteger statusCode, id responseObject)
     {
         [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
         //[MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
     }];
    
}

-(void)setKlineView
{
    LXY_KLINETYPE type;
    if (self.segmentControl.selectedIndex == 0) {
        type = LXY_KLINETYPETIME;
    }else{
        type = LXY_KLINETYPEKLINE;
    }
    
    NSString *timeFormatter = @"HH:mm";
    if (self.segmentControl.selectedIndex == 5) {
        timeFormatter = @"MM-dd";
    }else if(self.segmentControl.selectedIndex == 6){
        if (self.moreView.selectedIndex == 2) {
            timeFormatter = @"MM-dd";
        }else if (self.moreView.selectedIndex == 3){
            timeFormatter = @"yy-MM";
        }
    }
    
    
    [self.kLineView setData:self.kLineDataArray klineType:type timeFormatter:timeFormatter];
    
}

#pragma mark - 长连接收到推送数据
-(void)socketDidReciveData:(id)data identifier:(NSString *)identifier
{
    
    NSInteger minute = 1;
    switch (self.segmentControl.selectedIndex) {
        case 0:
            minute = 1;
            break;
        case 1:
            minute = 1;
            break;
        case 2:
            minute = 5;
            break;
        case 3:
            minute = 15;
            break;
        case 4:
            minute = 30;
            break;
        case 5:
            minute = 24 * 60;
            break;
        case 6:
            {
                if (self.moreView.selectedIndex == 0) {
                    minute = 60;
                }else if (self.moreView.selectedIndex == 1){
                    minute = 4 * 60;
                }else if (self.moreView.selectedIndex == 2){
                    minute = 1000;
                }else if (self.moreView.selectedIndex == 3){
                    minute = 1000;
                }
            }
            break;
            
        default:
            break;
    }
    
    NSDictionary *dic = [self dicWithData:data];
    
    if ([identifier isEqualToString:klineSocketIdentifier]) {
        
        if ([dic[@"code"] isEqualToString:self.coinModel.code]) {
            LXY_KLine_DataModel *model = [LXY_KLine_DataModel mj_objectWithKeyValues:dic];
            [self.kLineView refreshWithSocketData:model minuteInvital:minute];
            
            SSKJ_Market_Index_Model *socketModel = [SSKJ_Market_Index_Model mj_objectWithKeyValues:dic];
            self.headerView.coinModel = socketModel;
            
        }
        
        
    }else if ([identifier isEqualToString:orderSocketIdentifier]){
        NSArray *array = [JB_BBTrade_SocketDealOrder_Model mj_objectArrayWithKeyValuesArray:dic[@"data"]];
        self.socketOrderView.dataSource = array;
        
        if (self.introductHeaderView.selectedIndex == 0) {
            self.scrollView.contentSize = CGSizeMake(ScreenWidth, self.socketOrderView.bottom + ScaleW(20));
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





#pragma mark -  当前币种简介
-(void)requstWithInstrolHttpRequst
{
    NSMutableDictionary *pamaDic = [NSMutableDictionary dictionary];
    [pamaDic setObject:self.coinModel.code forKey:@"code"];
    WS(weakSelf);
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:kIscm_Market_CoinInfo RequestType:(RequestTypePost) Parameters:pamaDic Success:^(NSInteger statusCode, id responseObject) {
        WL_Network_Model *network_Model=[WL_Network_Model mj_objectWithKeyValues:responseObject];
        if (network_Model.status.integerValue == 200) {
            
            NSDictionary *dataDic = network_Model.data;
            
            ETF_BBTrade_Introduce_Model *currentModel = [ETF_BBTrade_Introduce_Model mj_objectWithKeyValues:dataDic];
            weakSelf.introduceModel = currentModel;
            //            weakSelf.introduceModel.name = _model.name;
            [weakSelf.introductView setViewWithModel:currentModel];
                        
        }else{
            [MBProgressHUD showError:network_Model.msg];
        }
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        //[MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
    }];
}

#pragma mark - 网络请求 请求行情列表
-(void)requestMarketList
{
//    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    
    WS(weakSelf);
    
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:ETF_BBTrade_MarketList_URL RequestType:RequestTypeGet Parameters:nil Success:^(NSInteger statusCode, id responseObject)
     {
//         [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
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
         [MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
     }];
}


-(void)handleMarketListWith:(WL_Network_Model *)network_model
{
    NSArray *array = [SSKJ_Market_Index_Model mj_objectArrayWithKeyValuesArray:network_model.data];
    
    for (int i = 0; i< array.count; i++) {
        
        SSKJ_Market_Index_Model * model = array[i];
        
        if ([self.coinModel.code isEqualToString:model.code]) {
            
            self.coinModel = model;
            
            break;
        }
        
    }
    
   self.headerView.coinModel = self.coinModel;
    
    
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
