//
//  JB_Account_Licai_Root_ViewController.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/5/15.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "JB_Account_Licai_Root_ViewController.h"

// view
#import "JB_Account_Licai_Main_TitleView.h"
#import "ETF_Default_ActionsheetView.h"
#import "JB_Account_LicaiView.h"

// model
#import "JB_Account_Licai_CoinModel.h"
#import "JB_Account_LicaiDetail_Model.h"

// controller
#import "JB_Account_Licai_OrderList_ViewController.h"

#import "JB_Lend_AddActionSheet_View.h"
@interface JB_Account_Licai_Root_ViewController ()
@property (nonatomic, strong) JB_Account_Licai_Main_TitleView *mainTitleView;
@property (nonatomic, strong) JB_Account_LicaiView *licaiView;


@property (nonatomic, strong) JB_Account_Licai_CoinModel *coinModel;
@property (nonatomic, strong) JB_Account_LicaiDetail_Model *licaiDetailModel;

@property (nonatomic, strong) NSMutableArray *coinArray;
@end

@implementation JB_Account_Licai_Root_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.titleView = self.mainTitleView;
    [self addRightNavItemWithTitle:SSKJLocalized(@"理财列表", nil) color:kMainWihteColor font:systemFont(ScaleW(13.5))];
    
    [self.view addSubview:self.licaiView];
    
}



-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setNavgationBackgroundColor:kSubBackgroundColor alpha:0];
    if (self.coinArray.count == 0) {
        [self requestCoinList];
    }else if (self.licaiDetailModel){
        [self requestLiCaiDetail];
    }
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self setNavgationBackgroundColor:kNavBGColor alpha:0];

}

- (NSMutableArray *)coinArray
{
    if (nil == _coinArray) {
        _coinArray = [NSMutableArray arrayWithCapacity:10];
    }
    return _coinArray;
}

-(void)rigthBtnAction:(id)sender
{
    JB_Account_Licai_OrderList_ViewController *vc = [[JB_Account_Licai_OrderList_ViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UI

-(JB_Account_Licai_Main_TitleView *)mainTitleView
{
    if (nil == _mainTitleView) {
        _mainTitleView = [[JB_Account_Licai_Main_TitleView alloc]initWithFrame:CGRectMake(0, 0, 0, 40)];
        WS(weakSelf);
        _mainTitleView.tapBlock = ^{
            weakSelf.mainTitleView.selected = YES;
            __block NSMutableArray *array = [NSMutableArray array];
            for (JB_Account_Licai_CoinModel *model in weakSelf.coinArray) {
                [array addObject:model.pname];
            }
            
            [ETF_Default_ActionsheetView showWithItems:array title:@"" selectedIndexBlock:^(NSInteger selectIndex) {
                NSString *coinName = array[selectIndex];
                weakSelf.coinModel = weakSelf.coinArray[selectIndex];
                weakSelf.mainTitleView.title = [NSString stringWithFormat:@"%@%@",SSKJLocalized(@"我要理财", nil),coinName];
                weakSelf.mainTitleView.selected = NO;
            } cancleBlock:^{
                weakSelf.mainTitleView.selected = NO;
            }];
        };
    }
    return _mainTitleView;
}

-(JB_Account_LicaiView *)licaiView
{
    if (nil == _licaiView) {
        _licaiView = [[JB_Account_LicaiView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - Height_NavBar)];
        WS(weakSelf);
        _licaiView.confirmBlock = ^(NSString * _Nonnull amount, NSInteger day,BOOL isAuto,NSString *rate) {
            [JB_Lend_AddActionSheet_View showPayPwdWithConfirmBlock:^(NSString * _Nonnull pwd) {
                [weakSelf requestBuyLicaiWithAmount:amount day:day isAuto:isAuto rate:rate pwd:pwd?:@""];
            }];
            
        };
    }
    return _licaiView;
}

#pragma mark - 网络请求

#pragma mark 请求理财币种列表
-(void)requestCoinList
{
    WS(weakSelf);
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:JB_Account_LicaiCoinList_URL RequestType:RequestTypePost Parameters:nil Success:^(NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        WL_Network_Model *network_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if ([network_model.status integerValue] == SUCCESSED) {
            [weakSelf handleCoinListWithModel:network_model];
        }else{
            [MBProgressHUD showError:network_model.msg];
        }
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        //[MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
    }];
}


-(void)handleCoinListWithModel:(WL_Network_Model *)net_model
{
    NSArray *array = [JB_Account_Licai_CoinModel mj_objectArrayWithKeyValuesArray:net_model.data];
    [self.coinArray removeAllObjects];
    [self.coinArray addObjectsFromArray:array];
    
    self.coinModel = self.coinArray.firstObject;
    
}

-(void)setCoinModel:(JB_Account_Licai_CoinModel *)coinModel
{
    _coinModel = coinModel;
    
    self.mainTitleView.title = [NSString stringWithFormat:@"%@%@",SSKJLocalized(@"我要理财-", nil),self.coinModel.pname];
    
    [self requestLiCaiDetail];
}



#pragma mark 请求理财币种统计
-(void)requestLiCaiDetail
{
    
    
    NSDictionary *params = @{
                             @"code":self.coinModel.pname
                             };
    
    WS(weakSelf);
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:JB_Account_LicaiStatistics_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        WL_Network_Model *network_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if ([network_model.status integerValue] == SUCCESSED) {

            weakSelf.licaiDetailModel = [JB_Account_LicaiDetail_Model mj_objectWithKeyValues:network_model.data];
            
        }else{
            [MBProgressHUD showError:network_model.msg];
        }
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        //[MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
    }];
}

-(void)setLicaiDetailModel:(JB_Account_LicaiDetail_Model *)licaiDetailModel
{
    _licaiDetailModel = licaiDetailModel;
    
    [self.licaiView setViewWithCoinModel:self.coinModel detailModel:self.licaiDetailModel];
}

#pragma mark - 确认下单

-(void)requestBuyLicaiWithAmount:(NSString *)amount day:(NSInteger)day isAuto:(BOOL)isAuto rate:(NSString *)rate pwd:(NSString *)pwd
{
    
    NSString *autoString;
    if (isAuto) {
        autoString = @"1";
    }else{
        autoString = @"0";
    }
    
    NSDictionary *params = @{
                             @"code":self.coinModel.pname,
                             @"num":amount,
                             @"rate":rate,
                             @"days":@(day),
                             @"is_auto":autoString,
                             @"tpwd":[WLTools md5:pwd?:@""]
                             };
    
    WS(weakSelf);
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:JB_Account_LicaiConfirmBuy_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        WL_Network_Model *network_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if ([network_model.status integerValue] == SUCCESSED) {
            
            JB_Account_Licai_OrderList_ViewController *vc = [[JB_Account_Licai_OrderList_ViewController alloc]init];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }else{
            [MBProgressHUD showError:network_model.msg];
        }
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        
        //[MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
    }];
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
