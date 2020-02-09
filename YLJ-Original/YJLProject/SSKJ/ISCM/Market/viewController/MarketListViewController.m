//
//  MarketListViewController.m
//  SSKJ
//
//  Created by zpz on 2019/7/19.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "MarketListViewController.h"
#import "Market_List_Cell.h"
#import "AutoScrollView.h"
#import "Market_Banner_Model.h"
#import "JB_Market_Index_Model.h"
#import "ManagerSocket.h"
#import "HKButtonView.h"
#import "SuperMarket_Root_ViewController.h"
#import "CJHYTimeHomeViewController.h"
#import "JB_BBTrade_MarketDetail_ViewController.h"

#import "Super_Notifacation_ViewController.h"
#import "UpdateViewViewController.h"

static NSString * CellID = @"Market_List_Cell";

@interface MarketListViewController ()<UITableViewDelegate, UITableViewDataSource,ManagerSocketDelegate>

@property(nonatomic, strong)UITableView *tableView;

@property(nonatomic, strong)NSArray *array;
@property(nonatomic, strong)NSArray *bannerArray;

@property(nonatomic, strong)AutoScrollView *autoView;

@property (nonatomic, strong) ManagerSocket *marketSocket;

@property (nonatomic, assign) BOOL isAppear;

@property (nonatomic, strong)HKButtonView *shopBt; //商城

@property (nonatomic, strong)HKButtonView *qiQuanBt;//期权
@property (nonatomic, strong) UIView* bgView;
@end

#define marketSocketIdentifier @"sliderMarket"

@implementation MarketListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(applicationDidBecomeActive:) name:UIApplicationDidBecomeActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(applicationDidEnterBackground:) name:UIApplicationDidEnterBackgroundNotification object:nil];
    
    [self autoView];
    
    [self tableView];
    [self requestCheckVersion];

}
#pragma mark - 通知（进入后台，进入后台）

-(void)applicationDidBecomeActive:(NSNotification *)notification
{
    if (self.isAppear) {
        [self openSocket];
    }
    
    
}

-(void)applicationDidEnterBackground:(NSNotification *)notification
{
    
    [self closeSocket];
}
-(void)closeSocket
{
    
    if (![self.marketSocket socketIsConnected]) {
        self.marketSocket.delegate = nil;
        [self.marketSocket closeConnectSocket];
        
    }
}
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
#pragma mark -- ManagerSocketDelegate
-(void)socketDidReciveData:(id)data identifier:(NSString *)identifier
{
    
    NSDictionary *dic = [self dicWithData:data];
    if ([identifier isEqualToString:marketSocketIdentifier]){
        JB_Market_Index_Model *socketModel = [JB_Market_Index_Model mj_objectWithKeyValues:dic];
        
        for (int i = 0; i < self.array.count; i++) {
            JB_Market_Index_Model *model = self.array[i];
            if ([socketModel.code isEqualToString:model.code]) {
                model.price = socketModel.price;
                model.change = socketModel.change;
                model.changeRate = socketModel.changeRate;
                model.cnyPrice = socketModel.cnyPrice;
                [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:i inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
                
               // [self.headerView didGetSocketModel:model];
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

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    [self loadInfo];
    
    
    self.isAppear = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [self closeSocket];
    self.isAppear = NO;
}

#pragma mark - 加载信息
- (void)loadInfo{
    
    
    NSDictionary *params = @{
                             };
    
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:kIscm_Market_Banner RequestType:RequestTypeGet Parameters:params Success:^(NSInteger statusCode, id responseObject)
     {
         
         WL_Network_Model *network_Model=[WL_Network_Model mj_objectWithKeyValues:responseObject];
         
         if ([network_Model.status isEqualToString:SUCCEED])
         {
             [self addBannerModel:network_Model];
             
         }else{
//             [CMRemind error:network_Model.msg];
         }
         
     } Failure:^(NSError *error, NSInteger statusCode, id responseObject)
     {
//         [CMRemind error:SSKJLanguage(@"网络异常")];
     }];
    
    
    
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:kIscm_Market_List RequestType:RequestTypeGet Parameters:params Success:^(NSInteger statusCode, id responseObject)
     {
         
         WL_Network_Model *network_Model=[WL_Network_Model mj_objectWithKeyValues:responseObject];
         
         if ([network_Model.status isEqualToString:SUCCEED])
         {
             [self addModel:network_Model];
             
         }else{
             //             [CMRemind error:network_Model.msg];
         }
         
         [self endRefresh];
         
     } Failure:^(NSError *error, NSInteger statusCode, id responseObject)
     {
         //         [CMRemind error:SSKJLanguage(@"网络异常")];
         [self endRefresh];

     }];
}

- (void)addBannerModel:(WL_Network_Model *)data{
    
    NSArray *array = [Market_Banner_Model mj_objectArrayWithKeyValuesArray:data.data[@"banner"]];
    NSMutableArray *imags = [NSMutableArray array];
    for (Market_Banner_Model *model in array) {
        [imags addObject:model.banner_url];
    }
    self.bannerArray = array;
    [self.autoView setImages:[imags copy]];
}

- (void)addModel:(WL_Network_Model *)data{
    
    NSArray *array = [JB_Market_Index_Model mj_objectArrayWithKeyValuesArray:data.data];
    
    self.array = array;

    [self.tableView reloadData];
    
     [self openSocket];
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

#pragma mark - tableView delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.array.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return ScaleW(66);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    Market_List_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellID forIndexPath:indexPath];
    JB_Market_Index_Model *model = self.array[indexPath.row];
    cell.titleLabel.text = model.name;
    cell.iconImageView.image = [UIImage imageNamed:model.name];
    
    UIColor *textColor;
    if (model.change.doubleValue >= 0) {
        textColor = kGreenColor;
        [cell.marketBtn setTitle:[NSString stringWithFormat:@"+%@", model.changeRate] forState:UIControlStateNormal];
    }else{
        textColor = kRedColor;
        [cell.marketBtn setTitle:model.changeRate forState:UIControlStateNormal];
    }
    
    cell.moneyLabel.text = [WLTools roundingStringWith:[model.price floatValue] afterPointNumber:[WLTools pointCount:model.code]];
    
    
    cell.moneyLabel.textColor = textColor;
    
    cell.subMoneyLabel.text = [NSString stringWithFormat:@"¥%.2f", [model.cnyPrice doubleValue]];
    
    cell.marketBtn.backgroundColor = textColor;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    JB_BBTrade_MarketDetail_ViewController *vc = [JB_BBTrade_MarketDetail_ViewController new];
    JB_Market_Index_Model *model = self.array[indexPath.row];
    vc.coinModel = model;
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor clearColor];
        [_tableView setSeparatorColor:kLineGrayColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        [_tableView registerClass:[Market_List_Cell class] forCellReuseIdentifier:CellID];
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
            make.left.right.bottom.equalTo(@0);
            make.top.equalTo(@0);
        }];
        
        UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleW(205+110+30+35))];
        header.backgroundColor=kMainBackgroundColor;
        UIView *backView=[UIView new];
        [header addSubview:backView];
        
        backView.backgroundColor=RGBCOLOR(235, 238, 246);
        
        [backView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(@0);
            make.bottom.equalTo(header).offset(-ScaleW(35));
        }];
        
        [header addSubview:self.autoView];
      
        backView.userInteractionEnabled=YES;
        
        header.userInteractionEnabled=YES;
        
        [header addSubview:self.shopBt];
        [header addSubview:self.qiQuanBt];

        UIView *titleView = [UIView new];
        titleView.backgroundColor=[UIColor whiteColor];
        
        [header addSubview:titleView];
        [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.shopBt.mas_bottom).offset(ScaleW(20));
            make.left.bottom.right.equalTo(@0);
        }];
        
        UILabel *coin = [WLTools allocLabel:@"币种" font:systemScaleFont(13) textColor:kGrayTitleColor frame:CGRectZero textAlignment:NSTextAlignmentLeft];
        [titleView addSubview:coin];
        [coin mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(ScaleW(18)));
            make.centerY.equalTo(@0);
        }];
        
        UILabel *price = [WLTools allocLabel:@"最新价格" font:systemScaleFont(13) textColor:kGrayTitleColor frame:CGRectZero textAlignment:NSTextAlignmentCenter];
        [titleView addSubview:price];
        [price mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(@0);
            make.centerY.equalTo(@0);
        }];
        
        UILabel *right = [WLTools allocLabel:@"涨跌幅" font:systemScaleFont(13) textColor:kGrayTitleColor frame:CGRectZero textAlignment:NSTextAlignmentLeft];
        [titleView addSubview:right];
        [right mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@(ScaleW(-18)));
            make.centerY.equalTo(@0);
        }];
        
        _tableView.tableHeaderView = header;
        
        WS(weakSelf);
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weakSelf loadInfo];
        }];
        
    }
    return _tableView;
}

#pragma mark 商城

-(HKButtonView *)shopBt{
    
    if (nil == _shopBt) {
        
       
        _shopBt=[[HKButtonView alloc]initWithTitle:@"超级商场" subTitle:@"超级热卖商品" andImg:@"market" andFrame:CGRectMake(0, ScaleW(205), ScreenWidth/2.0, ScaleW(110)) isLeft:NO];
        
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(shop)];
        
        [_shopBt addGestureRecognizer:tap];
        
    }
    return _shopBt;
    
}
-(void)shop{
    SuperMarket_Root_ViewController *vc=[SuperMarket_Root_ViewController new];
    
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark 期权

-(HKButtonView *)qiQuanBt{
    
    if (nil == _qiQuanBt) {

        _qiQuanBt=[[HKButtonView alloc]initWithTitle:@"二期期权" subTitle:@"买涨买跌都是赢" andImg:@"qiQuan" andFrame:CGRectMake(ScreenWidth/2.0, ScaleW(205), ScreenWidth/2.0, ScaleW(110)) isLeft:YES];
        
      
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(qiQuan)];
        
        [_qiQuanBt addGestureRecognizer:tap];
    }
    return _qiQuanBt;
    
}
-(void)qiQuan{
    CJHYTimeHomeViewController *vc=[CJHYTimeHomeViewController new];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}
- (AutoScrollView *)autoView{
    if (!_autoView) {
        //@"http://pic31.nipic.com/20130801/11604791_100539834000_2.jpg",@"http://pic38.nipic.com/20140211/17882171_143443301183_2.jpg",@"http://photocdn.sohu.com/20111207/Img328215620.jpg",@"http://pic51.nipic.com/file/20141025/8649940_220505558734_2.jpg"
        _autoView = [[AutoScrollView alloc] initWithImages:@[@"http://pic31.nipic.com/20130801/11604791_100539834000_2.jpg",@"http://pic38.nipic.com/20140211/17882171_143443301183_2.jpg"] timeInterval:2];
        _autoView.selectedBlock = ^(NSInteger index) {
            NSLog(@"%zd", index);
        };
    }
    return _autoView;
}
#pragma mark -- 检查版本更新
-(void)requestCheckVersion
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:kIscm_check_version_Api RequestType:RequestTypePost Parameters:@{@"version":AppVersion,@"type":@"2"} Success:^(NSInteger statusCode, id responseObject) {
        WL_Network_Model * netWorkModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (statusCode ==200) {
            if ([netWorkModel.data isEqualToString:@""] || [netWorkModel.data[@"version"] compare:AppVersion] == kCFCompareLessThan) {
                
                [self requestTanKuang];
                
                
            }else{
                
                UpdateViewViewController *vc = [[UpdateViewViewController alloc]init];
                
                vc.dataDic = responseObject;
                
                vc.modalPresentationStyle = UIModalPresentationOverFullScreen;
                
                [self.navigationController presentViewController:vc animated:YES completion:^{
                    //
                    vc.view.superview.backgroundColor = [UIColor clearColor];
                    [self requestTanKuang];
                    
                }];
            }
            
        }
        else
        {
            [self requestTanKuang];
        }
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [self requestTanKuang];
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
    
    
    
}
#pragma mark --  弹框公告
-(void)requestTanKuang
{
    
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:kIscm_sign_huoqugg_Api RequestType:RequestTypeGet Parameters:@{} Success:^(NSInteger statusCode, id responseObject) {
        WL_Network_Model * netWorkModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (statusCode ==200 &&[netWorkModel.data[@"value"] length]>0) {
            UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
            
            UIView* bgView = [[UIView alloc] initWithFrame:keyWindow.bounds];
            
            
            bgView.backgroundColor = RGBACOLOR(0, 0, 0, 0.5);
            
            self.bgView  = bgView;
            
            UIView * bgWhiteView =[[UIView alloc] init];
            
            bgWhiteView.frame = CGRectMake(ScaleW(25), 0, ScreenWidth - ScaleW(25)*2, 0);
            
            bgWhiteView.backgroundColor = [UIColor whiteColor];
            
            bgWhiteView.layer.cornerRadius = ScaleW(10);
            bgWhiteView.layer.masksToBounds = YES;
            
            
            [bgView addSubview:bgWhiteView];
            
            
            UILabel * titleLab =[[UILabel alloc] initWithFrame:CGRectMake(0, 0, bgWhiteView.width, ScaleW(68))];
            
            titleLab.text = @"公告";
            
            titleLab.font = systemBoldFont(ScaleW(16));
            
            titleLab.textAlignment= NSTextAlignmentCenter;
            
            titleLab.textColor = RGBACOLOR(50, 50, 50, 1);
            
            [bgWhiteView addSubview:titleLab];
            
            UILabel * contentLab =[[UILabel alloc] initWithFrame:CGRectMake(ScaleW(26), titleLab.bottom, bgWhiteView.width -ScaleW(26)*2 , 0)];
            
            contentLab.font = systemScaleFont(14);
            
            contentLab.numberOfLines = 0;
            
            contentLab.textColor = RGBACOLOR(100, 100, 100, 1);
            
            CGFloat height = [self.view returnHeight:netWorkModel.data[@"value"] font:ScaleW(15) width:contentLab.width-ScaleW(10)];
            
            contentLab.text = netWorkModel.data[@"value"];
            
            contentLab.height = height;
            
            [bgWhiteView addSubview:contentLab];
            
            UIImageView * lineImageView =[[UIImageView alloc] init];
            lineImageView.frame = CGRectMake(0, contentLab.bottom + ScaleW(29), bgWhiteView.width,1);
            
            lineImageView.backgroundColor = kLineGrayColor;
            
            [bgWhiteView addSubview:lineImageView];
            
            
            
            
            //
            UIButton* cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            cancelBtn.frame = CGRectMake(0, lineImageView.bottom, bgWhiteView.width/2, ScaleW(50));
            [self.view btn:cancelBtn font:ScaleW(16) textColor:RGBACOLOR(100, 100, 100, 1) text:SSKJLocalized(@"取消", nil) image:nil];
            
            cancelBtn.backgroundColor = [UIColor clearColor];
            [bgWhiteView addSubview:cancelBtn];
            [cancelBtn addTarget:self action:@selector(cancleAction:) forControlEvents:(UIControlEventTouchUpInside)];
            
            
            
            UIButton* sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            sureBtn.frame = CGRectMake(bgWhiteView.width/2, lineImageView.bottom, bgWhiteView.width/2, ScaleW(50));
            [self.view btn:sureBtn font:ScaleW(16) textColor:RGBACOLOR(80,113,210, 1) text:SSKJLocalized(@"确定", nil) image:nil];
            sureBtn.backgroundColor = [UIColor clearColor];
            [sureBtn addTarget:self action:@selector(sureAction:) forControlEvents:(UIControlEventTouchUpInside)];
            [bgWhiteView addSubview:sureBtn];
            
            
            bgWhiteView.height = sureBtn.bottom;
            
            bgWhiteView.centerY = bgView.centerY;
            
            
            [keyWindow addSubview:bgView];
            
            UIImageView * shuLineImageView =[[UIImageView alloc] init];
            shuLineImageView.frame = CGRectMake(bgWhiteView.width/2, contentLab.bottom + ScaleW(29), 1,ScaleW(50));
            
            shuLineImageView.backgroundColor = kLineGrayColor;
            
            [bgWhiteView addSubview:shuLineImageView];
            
            
            
            
            
        }
        else
        {
            
        }
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
    
    
    
}

-(void)cancleAction:(UIButton*)sender
{
    
    [self.bgView removeFromSuperview];
    
}
-(void)sureAction:(UIButton*)sender
{
    
    [self.bgView removeFromSuperview];
    
    
}
@end
