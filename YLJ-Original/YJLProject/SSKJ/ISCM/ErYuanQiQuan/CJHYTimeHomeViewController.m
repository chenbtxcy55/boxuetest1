


#import "CJHYTimeHomeViewController.h"
#import "CJHYTimeTradeViewController.h"
#import "SSKJ_BaseNavigationController.h"
#import "SystemRequstMethods.h"
#import "ETF_BBTrade_MoreSegment_View.h"

// controller
#import "SSKJ_TabbarController.h"
#import "CJHYTimeRecodViewController.h"
#import "JB_Login_ViewController.h"
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
#import "ETF_Default_ActionsheetView.h"
// model
#import "ETF_BBTrade_Introduce_Model.h"

// tools
#import "ManagerSocket.h"


static NSString *klineSocketIdentifier = @"klineSocketIdentifier";
static NSString *orderSocketIdentifier = @"orderSocketIdentifier";


@interface CJHYTimeHomeViewController ()<ManagerSocketDelegate>
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


// 买涨交易按钮
@property (nonatomic, strong) UIButton *buyUpbutton;

@property (nonatomic, strong) UIButton *buyDownbutton;


// 行情推送
@property (nonatomic, strong) ManagerSocket *klineSocket;


//// 盘口推送
@property (nonatomic, strong) ManagerSocket *orderSocket;


// 币种简介model
@property (nonatomic, strong) ETF_BBTrade_Introduce_Model *introduceModel;


@property (nonatomic, strong) CJHYTimeTradeViewController *tradeVc;

@property (nonatomic, strong) UIView *yingLiView;

@property (nonatomic, strong) UIButton *titleViewS;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIImageView *xialaImg;

@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, strong) NSMutableArray *drawArray;

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, assign) NSInteger num; //倍数
@property (nonatomic, assign) NSInteger maxNum; //输入最小值
@property (nonatomic, strong) NSString *rate; //费率

@property (nonatomic, strong) NSString *useableMoney; //可用余额

@property (nonatomic, strong) NSArray *selectMoneyArray; //可选金额

@property (nonatomic, strong) NSArray *selectTimeArray; //可选周期

@end

@implementation CJHYTimeHomeViewController


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self injected];
    
    [self setNavigationView];
    
    [self requestMarketList];
    
}
-(void)injected{
    
    self.typeString = @"1min";
    [self setUI];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(applicationDidBecomeActive:) name:UIApplicationDidBecomeActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(applicationDidEnterBackground:) name:UIApplicationDidEnterBackgroundNotification object:nil];
    
   
    [self repitAction];
    
}
-(void)getNewOrderList{
    
    if (!_coinModel) {
        
        
        return;
        
    }
    
    NSDictionary *pamas = @{@"code":_coinModel.code};
    
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:KNewOrdersList RequestType:RequestTypeGet Parameters:pamas Success:^(NSInteger statusCode, id responseObject) {
        
        WL_Network_Model * netWorkModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
   
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        if ([netWorkModel.status integerValue] == SUCCESSED) {
          
            NSArray *array = [JB_BBTrade_SocketDealOrder_Model mj_objectArrayWithKeyValuesArray:netWorkModel.data];
            
            self.socketOrderView.dataSource = array;

            
        }else{
            
            [self.timer invalidate];
            
            self.timer = nil;
            
        }
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
    }];
}
-(void)repitAction
{
    if (self.coinModel) {

        [self requestKlineData];
        
    }
    
  
}
-(void)dealloc
{
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
-(UIButton *)titleViewS
{
    if (!_titleViewS) {
        _titleViewS = [UIButton buttonWithType:UIButtonTypeCustom];
        _titleViewS.frame = CGRectMake(0, 0, ScaleW(130), ScaleW(40));
        [_titleViewS addSubview:self.titleLabel];
        [_titleViewS addSubview:self.xialaImg];
        [_titleViewS addTarget:self action:@selector(xialaAction:) forControlEvents:(UIControlEventTouchUpInside)];
        
    }
    return _titleViewS;
}

-(void)xialaAction:(UIButton *)sender
{
    
    NSMutableArray *array = [NSMutableArray array];
    
    for (JB_Market_Index_Model *model in self.dataSource) {
        [array addObject: [[model.code uppercaseString] stringByReplacingOccurrencesOfString:@"_" withString:@"/"]];
    }
    
    WS(weakSelf);
    
    [ETF_Default_ActionsheetView showWithItems:array title:@"" selectedIndexBlock:^(NSInteger selectIndex) {
        NSString *title = array[selectIndex];
        weakSelf.titleLabel.text = title;
        
        weakSelf.coinModel = self.dataSource[selectIndex];
        [self getNewOrderList];
        
        [self reloadDataWith];
        
        [self closeSocket];
        
        [self openSocket];
        
    } cancleBlock:^{
    }];
}

-(void)reloadDataWith
{
    [self requestKlineData];
//    [self closeSocrket];
    [self openSocket];
    _socketOrderView.coinModel = self.coinModel;
    _headerView.coinModel = self.coinModel;
//    [self.socketOrderView clearData];
//    [self requstdataWithDealReqist];
    self.titleLabel.text = [self.coinModel.code.uppercaseString stringByReplacingOccurrencesOfString:@"_" withString:@"/"];
    
}

-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [WLTools allocLabel:@"--/--" font:systemFont(ScaleW(14)) textColor:kTitleColor frame:CGRectMake(ScaleW(5), 0, ScaleW(96), ScaleW(40)) textAlignment:(NSTextAlignmentCenter)];
    }
    return _titleLabel;
}

-(UIImageView *)xialaImg
{
    if (!_xialaImg) {
        _xialaImg = [[UIImageView alloc]initWithFrame:CGRectMake(_titleLabel.right, 0, ScaleW(10), ScaleW(5))];
        _xialaImg.centerY = ScaleW(20);
        _xialaImg.image = [UIImage imageNamed:@"xiala"];
        
    }
    return _xialaImg;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    [self setNavigationView];
    
    [self getSetting];
    
    
    
//    [_timer setFireDate:[NSDate date]];
    
    WS(weakSelf);
    if (@available(iOS 10.0, *)) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:4.f repeats:YES block:^(NSTimer * _Nonnull timer) {
            
            [weakSelf getNewOrderList];
        }];
    } else {
        // Fallback on earlier versions
    }
    CGPoint newOffset = self.scrollView.contentOffset;
    
    newOffset.y = 0;
    
    [self.scrollView setContentOffset:newOffset animated:YES];
    
    if (self.coinModel) {
        
        [self openSocket];
    }
    
}

-(void)setNavigationView
{
    [self addRightNavgationItemWithImage:[UIImage imageNamed:@"historyIcon"]];
    
    self.navigationItem.titleView = self.titleViewS;
}
#pragma mark 进入历史订单
-(void)rigthBtnAction:(id)sender
{
   
    
    if (!kLogin) {
        JB_Login_ViewController *vc = [[JB_Login_ViewController alloc]init];
        
        SSKJ_BaseNavigationController *naviVC = [[SSKJ_BaseNavigationController alloc] initWithRootViewController:vc];
        naviVC.modalPresentationStyle = UIModalPresentationFullScreen;

        [self.navigationController presentViewController:naviVC animated:YES completion:^{
            
        }];
        return;
    }
   CJHYTimeRecodViewController *vc = [[CJHYTimeRecodViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}


-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [_timer setFireDate:[NSDate distantFuture]];
    
    [_timer invalidate];
    
    [self closeSocket];
}

-(ManagerSocket *)klineSocket
{
    if (nil == _klineSocket) {
        _klineSocket = [[ManagerSocket alloc]initWithUrl:BBMarketSocketUrl identifier:klineSocketIdentifier];
    }
    return _klineSocket;
}

-(ManagerSocket *)orderSocket
{
    if (nil == _orderSocket) {
        _orderSocket = [[ManagerSocket alloc]initWithUrl:BBDealRecordSocketUrl identifier:orderSocketIdentifier];
    }
    return _orderSocket;
}


#pragma mark - UI
-(void)setUI
{
    
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.headerView];
    [self.scrollView addSubview:self.segmentControl];
    [self.scrollView addSubview:self.kLineView];
//    [self.scrollView addSubview:self.introductHeaderView];
    [self.scrollView addSubview:self.socketOrderView];
//    [self.scrollView addSubview:self.introductView];
    self.scrollView.contentSize = CGSizeMake(ScreenWidth, self.socketOrderView.bottom + Height_TabBar);
    [self.scrollView addSubview:self.socketOrderView];
    [self.view addSubview:self.buyUpbutton];
    [self.view addSubview:self.buyDownbutton];
    
    
}


-(UIScrollView *)scrollView
{
    if (nil == _scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, ScaleW(5), ScreenWidth, ScreenHeight - Height_NavBar - ScaleW(5))];
        // _scrollView.backgroundColor = [UIColor blackColor];
    }
    return _scrollView;
}

-(ETF_BBTrade_TableHeaderView *)headerView
{
    if (nil == _headerView) {
        _headerView = [[ETF_BBTrade_TableHeaderView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleW(90))];
        //_headerView.coinModel = self.coinModel;
    }
    return _headerView;
}

-(ETF_BBTrade_SegmentControl *)segmentControl
{
    if (nil == _segmentControl) {
        _segmentControl = [[ETF_BBTrade_SegmentControl alloc]initWithFrame:CGRectMake(0, self.headerView.bottom, ScreenWidth, ScaleW(45)) titles:@[SSKJLocalized(@"分时",nil),SSKJLocalized(@"1M",nil),SSKJLocalized(@"5M",nil),SSKJLocalized(@"15M",nil),SSKJLocalized(@"30M",nil),SSKJLocalized(@"日线",nil),SSKJLocalized(@"更多",nil),SSKJLocalized(@"指标",nil)] normalColor:kTitleColor selectedColor:kBtnBgColor fontSize:ScaleW(13)];
        _segmentControl.backgroundColor = kMBBgColor;
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(15), 0, _segmentControl.width -ScaleW(30), 1)];
        lineView.backgroundColor = kLineColor;
        [_segmentControl addSubview:lineView];
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
-(void)moreSegmentSelectIndex:(NSInteger)index
{
    
    switch (index) {
        case 0:
            self.typeString = @"minute60";
            break;
            
        case 1:
            self.typeString = @"minute60";
            break;
        case 2:
            self.typeString = @"minute30";
            break;
        case 3:
            self.typeString = @"week";
            break;
//        case 4:
//            self.typeString = @"month";
//            break;
            
        default:
            break;
    }
    
    [self requestKlineData];
}

-(LXY_KLineView *)kLineView
{
    if (nil == _kLineView) {
        _kLineView = [[LXY_KLineView alloc]initWithFrame:CGRectMake(0, self.segmentControl.bottom, ScreenWidth, ScaleW(300)) accessoryType:LXY_ACCESSORYTYPENONE mainAccessoryType:LXY_KMAINACCESSORYTYPEMA];
        
    }
    return _kLineView;
}

-(ETF_BBTrade_IntroductHeaderView *)introductHeaderView
{
    if (nil == _introductHeaderView) {
        _introductHeaderView = [[ETF_BBTrade_IntroductHeaderView alloc]initWithFrame:CGRectMake(0, self.kLineView.bottom + ScaleW(5), ScreenWidth, ScaleW(40))];
        WS(weakSelf);
        _introductHeaderView.segmentSelectBlock = ^(NSInteger index) {
            if (index == 0) {
                weakSelf.socketOrderView.hidden = NO;
                weakSelf.introductView.hidden = YES;
                weakSelf.scrollView.contentSize = CGSizeMake(ScreenWidth, weakSelf.socketOrderView.bottom + ScaleW(20));
            }else{
                weakSelf.socketOrderView.hidden = YES;
                weakSelf.introductView.hidden = NO;
                weakSelf.scrollView.contentSize = CGSizeMake(ScreenWidth, weakSelf.introductView.bottom + ScaleW(20));
                
            }
        };
    }
    return _introductHeaderView;
}

-(ETF_BBTrade_IntroductView *)introductView
{
    if (nil == _introductView) {
        _introductView = [[ETF_BBTrade_IntroductView alloc]initWithFrame:CGRectMake(0, self.introductHeaderView.bottom, ScreenWidth, ScaleW(200))];
        _introductView.hidden = YES;
    }
    return _introductView;
}

-(JB_BBTrade_SocketDealOrder_View *)socketOrderView
{
    if (nil == _socketOrderView) {
        _socketOrderView = [[JB_BBTrade_SocketDealOrder_View alloc]initWithFrame:CGRectMake(0, self.kLineView.bottom, ScreenWidth,  ScaleW(37) * 20 + ScaleW(40))];
        _socketOrderView.backgroundColor = kMBBgColor;
        // _socketOrderView.coinModel = self.coinModel;
        
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
    }
    
    return _zhibiaoView;
}


-(UIButton *)buyUpbutton
{
    if (nil == _buyUpbutton) {
        _buyUpbutton = [[UIButton alloc]initWithFrame:CGRectMake(ScaleW(15), ScreenHeight  - ScaleW(45) - Height_NavBar - Height_TabBar, ScaleW(160), ScaleW(45))];
        [_buyUpbutton setTitle:SSKJLocalized(@"买涨", nil) forState:UIControlStateNormal];
        [_buyUpbutton setTitleColor:kMainWihteColor forState:UIControlStateNormal];
        _buyUpbutton.titleLabel.font = systemFont(ScaleW(15));
        _buyUpbutton.layer.masksToBounds = YES;
        _buyUpbutton.layer.cornerRadius = _buyUpbutton.height / 2;
        _buyUpbutton.backgroundColor = GREEN_HEX_COLOR;
        [_buyUpbutton addTarget:self action:@selector(toBBTradeEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _buyUpbutton;
}
-(UIButton *)buyDownbutton
{
    if (nil == _buyDownbutton) {
        _buyDownbutton = [[UIButton alloc]initWithFrame:CGRectMake(_buyUpbutton.right + ScaleW(25), ScreenHeight  - ScaleW(45) - Height_NavBar - Height_TabBar, ScaleW(160), ScaleW(45))];
        [_buyDownbutton setTitle:SSKJLocalized(@"买跌", nil) forState:UIControlStateNormal];
        [_buyDownbutton setTitleColor:kMainWihteColor forState:UIControlStateNormal];
        _buyDownbutton.titleLabel.font = systemFont(ScaleW(15));
        _buyDownbutton.layer.masksToBounds = YES;
        _buyDownbutton.layer.cornerRadius = _buyUpbutton.height / 2;
        _buyDownbutton.backgroundColor = RED_HEX_COLOR;
        [_buyDownbutton addTarget:self action:@selector(toBBTradeEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _buyDownbutton;
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
    
    if (!self.orderSocket.socketIsConnected) {
        self.orderSocket.delegate = self;
        [self.orderSocket openConnectSocketWithConnectSuccess:^{
            NSString *type = [WLTools wlDictionaryToJson:@{@"code":self.coinModel.code}];
            [weakSelf.orderSocket socketSendMsg:type];
        }];
    }
}

-(void)closeSocket
{
    if (self.klineSocket.socketIsConnected) {
        self.klineSocket.delegate = nil;
        [self.klineSocket closeConnectSocket];
    }
    
    if (self.orderSocket.socketIsConnected) {
        self.orderSocket.delegate = nil;
        [self.orderSocket closeConnectSocket];
    }
    
}

#pragma mark - 用户操作

-(void)segmentSelectIndex:(NSInteger)index
{
    if (self.zhibiaoView.superview) {
        [self.zhibiaoView removeFromSuperview];
    }
    switch (index) {
        case 0:
            self.typeString = @"1min";
            break;
        case 1:
            self.typeString = @"minute";
            break;
        case 2:
            self.typeString = @"minute5";
            break;
        case 3:
            self.typeString = @"minute15";
            break;
        case 4:
            self.typeString = @"minute60";
            break;
        case 5:
            self.typeString = @"hour4";
            break;
        case 6:
            self.typeString = @"day";
            break;
            
        default:
            break;
    }
    
    [self requestKlineData];
}

#pragma mark 买涨买跌
-(void)toBBTradeEvent:(UIButton *)sender
{
    if (!kLogin) {
        JB_Login_ViewController *vc = [[JB_Login_ViewController alloc]init];
        
        SSKJ_BaseNavigationController *naviVC = [[SSKJ_BaseNavigationController alloc] initWithRootViewController:vc];
        naviVC.modalPresentationStyle = UIModalPresentationFullScreen;

        [self.navigationController presentViewController:naviVC animated:YES completion:^{
            
        }];
        return;
    }
    //1 买涨 2 买跌
    NSInteger type = 0;
    if (sender == _buyUpbutton) {
        type = 1;
    }
    if (sender == _buyDownbutton) {
        type = 2;
    }
    
    _tradeVc = [[CJHYTimeTradeViewController alloc]init];
    _tradeVc.tradeDerection = type;
    _tradeVc.currentModel = self.coinModel;
    _tradeVc.modalPresentationStyle = UIModalPresentationOverFullScreen;
    WS(weakSelf);
    _tradeVc.num=_num;
    _tradeVc.maxnum=_maxNum;

    _tradeVc.buySucessBlock = ^{
        [weakSelf requestKlineData];
    };
    
    [self.navigationController presentViewController:_tradeVc animated:YES completion:^{
        //
        weakSelf.tradeVc.view.superview.backgroundColor = [UIColor clearColor];
    }];
    
}

#pragma mark 请求k线数据
-(void)requestKlineData
{
  
    NSDictionary *dict=@{@"goodsType":self.typeString,
                         @"code":self.coinModel.code,
                         @"pageSize":@(500),
                         };
    
    
    WS(weakSelf);
//    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:kIscm_Market_KLine RequestType:RequestTypeGet Parameters:dict Success:^(NSInteger statusCode, id responseObject)
     {
         
         WL_Network_Model *network_Model=[WL_Network_Model mj_objectWithKeyValues:responseObject];
         [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
         if ( [network_Model.code isEqualToString: SUCCEED] ) {
             weakSelf.kLineDataArray=network_Model.data;
             
             [weakSelf setKlineView];
         }
         else{
             [MBProgressHUD showSuccess:network_Model.msg];
             
         }
        
      
         
     } Failure:^(NSError *error, NSInteger statusCode, id responseObject)
     {
         [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
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
    if (self.segmentControl.selectedIndex == 6) {
        timeFormatter = @"MM-dd";
    }
    
    NSLog(@"count:::%ld",self.kLineDataArray.count);
    
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
            minute = 60;
            break;
        case 5:
            minute = 4 * 60;
            break;
        case 6:
            minute = 24 * 60;
            break;
            
        default:
            break;
    }
    
    NSDictionary *dic = [self dicWithData:data];
    
    if ([identifier isEqualToString:klineSocketIdentifier]) {
        
        if ([dic[@"code"] isEqualToString:self.coinModel.code]) {
            LXY_KLine_DataModel *model = [LXY_KLine_DataModel mj_objectWithKeyValues:dic];
            [self.kLineView refreshWithSocketData:model minuteInvital:minute];
            
            JB_Market_Index_Model *socketModel = [JB_Market_Index_Model mj_objectWithKeyValues:dic];
            self.headerView.coinModel = socketModel;
            self.tradeVc.currentModel = socketModel;
            
        }
        
        
    }else if ([identifier isEqualToString:orderSocketIdentifier]){
        NSArray *array = [JB_BBTrade_SocketDealOrder_Model mj_objectArrayWithKeyValuesArray:dic[@"recs"]];
        self.socketOrderView.dataSource = array;
        
        
        if (self.introductHeaderView.selectedIndex == 0) {
           self.scrollView.contentSize = CGSizeMake(ScreenWidth, self.socketOrderView.bottom + Height_TabBar);
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




#pragma mark - 请求币种简介


#pragma mark -  当前币种简介
-(void)requstWithInstrolHttpRequst
{
    return;
    NSMutableDictionary *pamaDic = [NSMutableDictionary new];
    [pamaDic setObject:self.coinModel.code forKey:@"code"];
    WS(weakSelf);
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:ETF_BBTrade_CoinIntroduce_URL RequestType:(RequestTypePost) Parameters:pamaDic Success:^(NSInteger statusCode, id responseObject) {
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
        [MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
    }];
}




#pragma mark - 网络请求 请求行情列表
-(void)requestMarketList
{
    
    NSDictionary *params = @{
                             @"qu":@(1)
                             };
    
    WS(weakSelf);
    
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:ETF_BBTrade_MarketList_URL RequestType:RequestTypeGet Parameters:params Success:^(NSInteger statusCode, id responseObject)
     {
         //[MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
         
         WL_Network_Model *network_Model=[WL_Network_Model mj_objectWithKeyValues:responseObject];
         
         if (network_Model.status.integerValue == SUCCESSED)
         {
             [weakSelf handleMarketListWith:network_Model];
             
             
           
             
         }else{
             [MBProgressHUD showError:network_Model.msg];
         }
     } Failure:^(NSError *error, NSInteger statusCode, id responseObject)
     {
         //[MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
         
         [MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
     }];
}


-(void)handleMarketListWith:(WL_Network_Model *)network_model
{
    NSArray *array = [JB_Market_Index_Model mj_objectArrayWithKeyValuesArray:network_model.data];
    [self.dataSource removeAllObjects];
    
    for (JB_Market_Index_Model *model in array) {
        
        if (![model.name hasPrefix:@"YEC"]) {
            
            [self.dataSource addObject:model];
            
        }
    }
//    [self.dataSource addObjectsFromArray:array];
    //第一次初始化赋值
    self.coinModel = self.dataSource.firstObject;
    
    [self reloadDataWith];
    
    [self requestKlineData];
    
    
//    [self requestRecordListWithCoinCodeStatus:@"1"];
    
}


-(NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}
//交易金额Property_income_record_URL

-(void)requstdataWithDealReqist
{
    NSDictionary *params = @{
                             @"pid":_coinModel.pid
                             };
    
    WS(weakSelf);
    NSString *string  = Property_income_record_URL;
    
    [SystemRequstMethods postWithUrlString:string parameters:params success:^(NSDictionary *data) {
        WL_Network_Model *network_Model=[WL_Network_Model mj_objectWithKeyValues:data];
        
        if (network_Model.status.integerValue == SUCCESSED)
        {
           
            NSArray *array = [JB_BBTrade_SocketDealOrder_Model mj_objectArrayWithKeyValuesArray:network_Model.data[@"res"]];
            self.socketOrderView.dataSource = array;
            self.scrollView.contentSize = CGSizeMake(ScreenWidth, self.socketOrderView.bottom + Height_TabBar);
        }else{
            [MBProgressHUD showError:network_Model.msg];
        }
    } failure:^(NSError *error) {
        
    }];
    //    [[WLHttpManager shareManager] requestWithURL_HTTPCode:string RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject)
    //     {
    //         [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
    //
    //         WL_Network_Model *network_Model=[WL_Network_Model mj_objectWithKeyValues:responseObject];
    //
    //         if (network_Model.status.integerValue == SUCCESSED)
    //         {
    //             //[weakSelf handleMarketListWith:network_Model];
    //             NSArray *array = [JB_BBTrade_SocketDealOrder_Model mj_objectArrayWithKeyValuesArray:network_Model.data[@"res"]];
    //             self.socketOrderView.dataSource = array;
    //         }else{
    //             [MBProgressHUD showError:network_Model.msg];
    //         }
    //     } Failure:^(NSError *error, NSInteger statusCode, id responseObject)
    //     {
    //         [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
    //
    //         [MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
    //     }];
    
    
}
#pragma mark 请求k线数据


-(NSInteger)pointCount:(NSString *)code
{
    /*币种
     btc/usdt  2位
     ltc/usdt 2位
     eth/usdt 2位
     etc/usdt 4位
     zec/usdt 2位
     eos/usdt 4位
     xrp/usdt 4位
     trx/usdt 6位
     dash/usdt  2位
     bch/usdt 2位*/
    if ([code.lowercaseString isEqualToString:@"btc/usdt"]) {
        return 2;
    }
    if ([code.lowercaseString isEqualToString:@"ltc/usdt"]) {
        return 2;
    }
    if ([code.lowercaseString isEqualToString:@"eth/usdt"]) {
        return 2;
    }
    if ([code.lowercaseString isEqualToString:@"etc/usdt"]) {
        return 4;
    }
    if ([code.lowercaseString isEqualToString:@"zec/usdt"]) {
        return 2;
    }
    if ([code.lowercaseString isEqualToString:@"eos/usdt"]) {
        return 4;
    }
    if ([code.lowercaseString isEqualToString:@"xrp/usdt"]) {
        return 4;
    }
    if ([code.lowercaseString isEqualToString:@"trx/usdt"]) {
        return 6;
    }
    if ([code.lowercaseString isEqualToString:@"dash/usdt"]) {
        return 2;
    }
    if ([code.lowercaseString isEqualToString:@"bch/usdt"]) {
        return 2;
    }
    return 4;
    
}

-(NSDate *) timeStampWithOffsetTime:(NSInteger) offsetTime {
    NSDate* date = [NSDate dateWithTimeIntervalSinceNow:offsetTime];//获取当前时间 offsetTime 秒后的时间
    return date;
    
}

-(NSMutableArray *)drawArray
{
    if (!_drawArray) {
        _drawArray = [NSMutableArray array];
        
    }
    return _drawArray;
}

-(void)setCoinModel:(JB_Market_Index_Model *)coinModel
{
    _coinModel = coinModel;
    
}
#pragma mark 获取配置信息

-(void)getSetting{
    
    
    NSDictionary *pamas = @{};
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:KQiQuanSettting RequestType:RequestTypePost Parameters:pamas Success:^(NSInteger statusCode, id responseObject) {
        WL_Network_Model * netWorkModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([netWorkModel.status integerValue] == SUCCESSED) {
           
            self.rate= [netWorkModel.data objectForKey:@"trans_fee"];
            self.useableMoney= [netWorkModel.data objectForKey:@"wallfour"];
            self.selectMoneyArray= [netWorkModel.data objectForKey:@"order_price"];
            self.num=[[NSString stringWithFormat:@"%@",[netWorkModel.data objectForKey:@"order_num_multiple"]] integerValue];
            self.maxNum=[[NSString stringWithFormat:@"%@",[netWorkModel.data objectForKey:@"order_min_num"]] integerValue];

            
        }else{
            
            [MBProgressHUD showError:netWorkModel.msg];
            
        }
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
    
}
@end
