//
//  JB_Account_Root_ViewController.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/5/10.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "JB_Account_Root_ViewController.h"
#import "JB_Mine_HeaderView.h"
#import "JB_Mine_ContentView.h"
#import "JB_UserInfo_ViewController.h"
#import "BLSafeCenterViewController.h"
#import "SSKJ_UserInfo_Model.h"
#import "My_Generalize_RootViewController.h"
#import "HeBi_Extract_ViewController.h"
#import "JB_PledgeBorrow_ViewController.h"
#import "JB_Account_Licai_Root_ViewController.h"
#import "JB_Account_Asset_ViewController.h"
#import "HeBi_AddressManager_ViewController.h"
#import "HeBi_Default_AlertView.h"
#import "AppDelegate.h"
#import "JB_Login_ViewController.h"
#import "SSKJ_BaseNavigationController.h"
#import "JB_Setting_ViewController.h"
@interface JB_Account_Root_ViewController ()
<JB_Mine_CellItemViewDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) NSArray *titlesArray;
@property (nonatomic, strong) NSArray *iconsArray;
@property (nonatomic, strong) JB_Mine_ContentView *buttonsView;

@property (nonatomic, strong) JB_Mine_HeaderView *headerView;
@property (nonatomic, strong) UIButton *logoutButton;
@end

@implementation JB_Account_Root_ViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.titlesArray = @[SSKJLocalized(@"个人中心", nil),
                             SSKJLocalized(@"账号安全", nil),
                             SSKJLocalized(@"提币地址", nil),
                             SSKJLocalized(@"我的推广", nil),
                             SSKJLocalized(@"我要理财", nil),
                             SSKJLocalized(@"抵押借款", nil),
                             SSKJLocalized(@"联系我们", nil)];
        self.iconsArray = @[@"grzx_icon",
                            @"aqzh_icon",
                            @"tbdz_icon",
                            @"wdtg_icon",
                            @"wylc_icon",
                            @"dyjk_icon",
                            @"contract_us"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kMainBackgroundColor;
    
    [self setupMasonry];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [self requestUserInfo];
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

#pragma mark -- ButtonClick
- (void)logoutEvent {
    WS(weakSelf);
    [HeBi_Default_AlertView showWithTitle:SSKJLocalized(@"提示", nil) message:SSKJLocalized(@"是否确定退出该账号", nil) cancleTitle:SSKJLocalized(@"取消", nil) confirmTitle:SSKJLocalized(@"确定", nil) confirmBlock:^{
        [weakSelf logout];
    }];

}
-(void)logout
{
    [SSKJ_User_Tool clearUserInfo];
    
    JB_Login_ViewController *loginVc = [[JB_Login_ViewController alloc]init];
    SSKJ_BaseNavigationController *loginNavc = [[SSKJ_BaseNavigationController alloc]initWithRootViewController:loginVc];
    loginNavc.modalPresentationStyle = UIModalPresentationFullScreen;

    [self presentViewController:loginNavc animated:YES completion:nil];

    
}

- (void)selectedItemWithIndex:(NSInteger)index {
    if (index == 0) {//个人中心
        JB_UserInfo_ViewController *vc = [[JB_UserInfo_ViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (index == 1) {//账号安全
        BLSafeCenterViewController *vc = [[BLSafeCenterViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (index == 2) {//提币地址

        HeBi_AddressManager_ViewController *vc = [[HeBi_AddressManager_ViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (index == 3) {//我的推广
        My_Generalize_RootViewController *vc = [[My_Generalize_RootViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (index == 4) {//我要理财
        if (![self judgeFristCertificate]) {
            return;
        }
        if (![self judgePayPassword]) {
            return;
        }
        JB_Account_Licai_Root_ViewController *vc = [[JB_Account_Licai_Root_ViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    if (index == 5) {//抵押借款
        if (![self judgeFristCertificate]) {
            return;
        }
        if (![self judgePayPassword]) {
            return;
        }
        JB_PledgeBorrow_ViewController *vc = [[JB_PledgeBorrow_ViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    
    if (index == 6) {//联系我们

        [self requestContractMethod];
        
    }
}

#pragma mark -- JB_Mine_CellItemViewDelegate
- (void)didSelectedItem:(JB_Mine_CellItemView *)item {
    //点击交易账户
    if ([item isEqual:self.headerView.TradeItem]) {
        JB_Account_Asset_ViewController *vc = [[JB_Account_Asset_ViewController alloc]init];
        vc.assetType = AssetTypeDeal;
        [self.navigationController pushViewController:vc animated:YES];
    }
    //点击理财账户
    if ([item isEqual:self.headerView.DealMoneyItem]) {
        JB_Account_Asset_ViewController *vc = [[JB_Account_Asset_ViewController alloc]init];
        vc.assetType = AssetTypeLicai;
        [self.navigationController pushViewController:vc animated:YES];
    }
}



#pragma mark -- Masonry

- (void)setupMasonry {
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.contentView];
    [self.contentView addSubview:self.headerView];
    [self.contentView addSubview:self.buttonsView];
    [self.contentView addSubview:self.logoutButton];
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.view).offset(-Height_StatusBar);
    }];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.scrollView);
        make.width.mas_equalTo(ScreenWidth);
    }];
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.contentView);
        
    }];
    [self.buttonsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(ScaleW(15));
        make.right.equalTo(self.contentView).offset(-ScaleW(15));
        make.top.equalTo(self.headerView.mas_bottom).offset(-ScaleW(25));
    }];
    [self.logoutButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(ScaleW(25));
        make.right.equalTo(self.contentView).offset(-ScaleW(25));
        make.top.equalTo(self.buttonsView.mas_bottom).offset(ScaleW(30));
        make.height.mas_equalTo(ScaleW(45));
        make.bottom.equalTo(self.contentView).offset(-ScaleW(10));
    }];
}


#pragma mark -- Getter
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectZero];
        _scrollView.backgroundColor = kMainBackgroundColor;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
    }
    return _scrollView;
}
- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc]init];
        _contentView.backgroundColor = kMainBackgroundColor;
    }
    return _contentView;
}

- (JB_Mine_HeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[JB_Mine_HeaderView alloc]init];
        _headerView.TradeItem.delegate = self;
        _headerView.DealMoneyItem.delegate = self;
        WS(weakSelf);
        _headerView.settingBlock = ^{
            JB_Setting_ViewController *vc = [[JB_Setting_ViewController alloc]init];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
    }
    return _headerView;
}

- (JB_Mine_ContentView *)buttonsView {
    if (!_buttonsView) {
        _buttonsView = [[JB_Mine_ContentView alloc]initWithFrame:CGRectZero titles:self.titlesArray icons:self.iconsArray];
        WS(weakSelf);
        _buttonsView.selectedIndexBlock = ^(NSInteger index) {
            [weakSelf selectedItemWithIndex:index];
        };
    }
    return _buttonsView;
}

-(UIButton *)logoutButton {
    if (!_logoutButton) {
        _logoutButton = [[UIButton alloc]initWithFrame:CGRectMake(0 ,0, ScreenWidth - ScaleW(50), ScaleW(45))];
        [_logoutButton setTitle:SSKJLocalized(@"退出", nil) forState:UIControlStateNormal];
        [_logoutButton setTitleColor:kMainWihteColor forState:UIControlStateNormal];
        _logoutButton.layer.masksToBounds = YES;
        _logoutButton.layer.cornerRadius = ScaleW(4);
        _logoutButton.titleLabel.font = systemBoldFont(ScaleW(15));
        [_logoutButton addTarget:self action:@selector(logoutEvent) forControlEvents:UIControlEventTouchUpInside];
        [_logoutButton addGradientColor];
    }
    return _logoutButton;
}


#pragma mark - 网络请求
#pragma mark 请求个人中心



-(void)requestUserInfo
{
    NSDictionary *params = @{
                            
                             };
    WS(weakSelf);
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:JB_Account_UserInfo_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        WL_Network_Model *network_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if ([network_model.status integerValue] == SUCCESSED) {
            SSKJ_UserInfo_Model *model = [SSKJ_UserInfo_Model mj_objectWithKeyValues:network_model.data];
            [SSKJ_User_Tool sharedUserTool].userInfoModel = model;
            [weakSelf.headerView configureUserInfoWithModel:model];
            weakSelf.headerView.tradeModel = [JB_AccountItemModel mj_objectWithKeyValues:network_model.data[@"zc_total"]];
            weakSelf.headerView.dealModel = [JB_AccountItemModel mj_objectWithKeyValues:network_model.data[@"lc_total"]];
        }else{
            [MBProgressHUD showError:network_model.msg];
        }
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        //[MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
    }];
    
}

-(void)requestContractMethod
{

    WS(weakSelf);
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:JB_GetEmail_URL RequestType:RequestTypeGet Parameters:nil Success:^(NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        WL_Network_Model *network_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if ([network_model.status integerValue] == SUCCESSED) {
            
            NSString *email = network_model.data[@"email"];
            
            [HeBi_Default_AlertView showWithTitle:SSKJLocalized(@"邮箱", nil) message:email cancleTitle:SSKJLocalized(@"取消", nil) confirmTitle:SSKJLocalized(@"复制", nil) confirmBlock:^{
                
                [MBProgressHUD showSuccess:SSKJLocalized(@"复制成功", nil)];
                UIPasteboard*pasteboard = [UIPasteboard generalPasteboard];
                pasteboard.string=email;
            }];
        }else{
            [MBProgressHUD showError:network_model.msg];
        }
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        //[MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
    }];
}

@end
