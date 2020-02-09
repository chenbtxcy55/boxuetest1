//
//  HeBi_Charge_ViewController.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/4/12.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "HeBi_Charge_ViewController.h"

// view
#import "HeBi_Charge_HeaderView.h"
#import "HeBi_Charge_BottomView.h"

// model
#import "HeBi_Charge_Model.h"

#import "ETF_AssestRecordHeaderView.h"
#import "JB_Account_Asset_CoinModel.h"
#import "ETF_Default_ActionsheetView.h"
#import "JB_CoinAssets_DoorViewController.h"
@interface HeBi_Charge_ViewController ()
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) HeBi_Charge_HeaderView *headerView;
@property (nonatomic, strong) ETF_AssestRecordHeaderView *recordView;
@property (nonatomic, strong) NSMutableArray *coinArray;
@property (nonatomic, strong) JB_Account_Asset_Index_Model *selectedModel;
@end

@implementation HeBi_Charge_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.coinArray = [[NSMutableArray alloc]init];
    self.title = SSKJLocalized(@"充币", nil);
    [self addRightNavgationItemWithImage:[UIImage imageNamed:@"mine_jiaoyijilu"]];

    [self setUI];
    [self requestLicaiCoinList];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [self requestChargeAddress];
}


-(void)rigthBtnAction:(id)sender
{
    JB_CoinAssets_DoorViewController *vc = [[JB_CoinAssets_DoorViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - UI

-(void)setUI
{
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.recordView];
    [self.scrollView addSubview:self.headerView];
    
    self.scrollView.contentSize = CGSizeMake(ScreenWidth, self.headerView.bottom);
}


-(UIScrollView *)scrollView
{
    if (nil == _scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    }
    return _scrollView;
}
-(HeBi_Charge_HeaderView *)headerView
{
    if (nil == _headerView) {
        _headerView = [[HeBi_Charge_HeaderView alloc]initWithFrame:CGRectMake(0, self.recordView.bottom+ ScaleW(20), ScreenWidth, 0)];
    }
    return _headerView;
}

- (ETF_AssestRecordHeaderView *)recordView {
    if (!_recordView) {
        _recordView = [[ETF_AssestRecordHeaderView alloc]initWithFrame:CGRectMake(0, ScaleW(10), ScreenWidth, ScaleW(50))];
        _recordView.typeItem.hidden = YES;
        _recordView.coinItem.titleLB.text = SSKJLocalized(@"币种", nil);
        _recordView.coinItem.contentLB.text = @"BTC";
        _recordView.backgroundColor = kSubBackgroundColor;
        WS(weakSelf);
        _recordView.coinBlock = ^{
            NSArray *titles = [weakSelf.coinArray valueForKeyPath:@"pname"];
            [ETF_Default_ActionsheetView showWithItems:titles title:@"" selectedIndexBlock:^(NSInteger selectIndex) {
                weakSelf.selectedModel = weakSelf.coinArray[selectIndex];
                [weakSelf requestChargeAddress];
            } cancleBlock:^{
                
            }];
        };
        
    }
    return _recordView;
}

#pragma mark - 网络请求



#pragma mark 请求充值地址

-(void)requestChargeAddress
{
    
    NSDictionary *params = @{
                             @"pid":self.selectedModel.pid?:@""
                             };
    
    WS(weakSelf);
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:JB_Account_Charge_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        WL_Network_Model *net_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if (net_model.status.integerValue == SUCCESSED) {
            [weakSelf handleChargeWithModel:net_model];
            weakSelf.recordView.coinItem.contentLB.text = weakSelf.selectedModel.pname?:@"";
        }else{
            [MBProgressHUD showError:net_model.msg];
        }
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        //[MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
    }];
}

-(void)handleChargeWithModel:(WL_Network_Model *)net_model
{
    HeBi_Charge_Model *model = [HeBi_Charge_Model mj_objectWithKeyValues:net_model.data];
    [self.headerView setViewWithModel:model];
}

// 请求币种列表
-(void)requestLicaiCoinList
{
    WS(weakSelf);
    
    NSString *url = JB_Account_DealAsset_URL;
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:url RequestType:RequestTypePost Parameters:nil Success:^(NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        WL_Network_Model *network_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if ([network_model.status integerValue] == SUCCESSED) {
            [weakSelf handleExchangeListWithModel:network_model];
        }else{
            [MBProgressHUD showError:network_model.msg];
        }
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        
        //[MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
    }];
    
}

-(void)handleExchangeListWithModel:(WL_Network_Model *)net_model
{
    
    JB_Account_Asset_CoinModel *assetModel = [JB_Account_Asset_CoinModel mj_objectWithKeyValues:net_model.data[@"res"]];
    [self.coinArray removeAllObjects];
    
    for (JB_Account_Asset_Index_Model *model in assetModel.asset) {
        if (model.is_act.integerValue == 1) {
            [self.coinArray addObject:model];
        }
    }
    self.selectedModel = self.coinArray.firstObject;
    self.recordView.coinItem.contentLB.text = self.selectedModel.pname?:@"";
}


-(void)setSelectedModel:(JB_Account_Asset_Index_Model *)selectedModel
{
    _selectedModel = selectedModel;
    [self.headerView setViewWithCoinName:selectedModel.mark];
    self.scrollView.contentSize = CGSizeMake(self.scrollView.width, self.headerView.bottom);
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
