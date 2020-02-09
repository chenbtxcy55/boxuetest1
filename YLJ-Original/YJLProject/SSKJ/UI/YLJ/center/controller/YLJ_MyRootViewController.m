//
//  YLJ_MyRootViewController.m
//  SSKJ
//
//  Created by cy5566 on 2019/11/21.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "YLJ_MyRootViewController.h"
#import "YLJExchangeViewController.h"
#import "YLJ_SafeCenterViewController.h"

#import "MineTableCell.h"
#import "YLJ_MyRootHeaderView.h"
#import "MyLayout.h"
#import "HeBi_Default_AlertView.h"
#import "SSKJ_Service_AlertView.h"
#import "HeBi_Version_AlertView.h"
#import "HeBi_Version_Model.h"
#import "SSKJ_QR_AlertView.h"

@interface YLJ_MyRootViewController ()
<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *mainTableView;
@property (nonatomic,strong) YLJ_MyRootHeaderView *headerView;
@property (nonatomic, copy) NSArray *titleArray;
@property (nonatomic, copy) NSArray *iconArray;
@property (nonatomic,strong) UIButton *logoutBtn;
@property (nonatomic, strong) HeBi_Version_Model * versionModel;

@end

@implementation YLJ_MyRootViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.mainTableView];
    [self.view addSubview:self.logoutBtn];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    self.logoutBtn.hidden = !kLogin;
    if (kLogin) {
        [self requestUserInfo];
        self.headerView.height = ScaleW(355);
    } else {
        [self.headerView hiddenHorzLayout];
        self.headerView.height = ScaleW(313);
        self.mainTableView.tableHeaderView = self.headerView;
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];

}


- (UITableView *)mainTableView {
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - Height_TabBar) style:UITableViewStylePlain];
        _mainTableView.backgroundColor = kMainBackgroundColor;
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.estimatedRowHeight = ScaleW(50);
        _mainTableView.rowHeight = UITableViewAutomaticDimension;
        _mainTableView.estimatedSectionHeaderHeight = ScaleW(0);
        _mainTableView.estimatedSectionFooterHeight = ScaleW(0);
//        MyLinearLayout *contentLayout = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
//        contentLayout.myHorzMargin = 0;
//
//        [contentLayout addSubview:self.headerView];
        _mainTableView.tableHeaderView = self.headerView;
//        _mainTableView.tableHeaderView = contentLayout;
        
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        _mainTableView.showsVerticalScrollIndicator = NO;
        [_mainTableView registerClass:[MineTableCell class] forCellReuseIdentifier:@"MineTableCell"];
        if (@available(iOS 11.0, *)) {
            _mainTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        
    }
    return _mainTableView;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    MineTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineTableCell"];
    cell.rightImgView.hidden = YES;
//    NSArray *imgs = self.iconArray[indexPath.section];
//    NSString *img=imgs[indexPath.row];
//    NSArray *titles = self.titleArray[indexPath.section];
//    NSString *title= titles[indexPath.row];
    NSString *img = self.iconArray[indexPath.row];
    NSString *title = self.titleArray[indexPath.row];
    if (indexPath.row == 2) {
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
        [cell setDataWithDict:@{@"icon":img,@"title":title,@"version":app_Version}];
    } else {
        [cell setDataWithDict:@{@"icon":img,@"title":title}];
    }
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titleArray.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!kLogin) {
        [MBProgressHUD showError:@"请先登录"];
        [self presentLoginController];
        return;
    }
    if (indexPath.row == 0) {
        YLJ_SafeCenterViewController *sVC = [YLJ_SafeCenterViewController new];
        [self.navigationController pushViewController:sVC animated:YES];
    }
    if (indexPath.row == 1) {
        //联系客服
        [self requestService];
        
    }
    if (indexPath.row == 2) {
        //版本更新
        [self checkVersion];
        
    }
    
    if (indexPath.row == 3) {
        //二维码下载
        [self  QRrequest];
    }
}

- (void)QRrequest {
    {
        [SSKJ_QR_AlertView showWithUrl:@"xiazaiyingyong" confirmBlock:^{
            
        } cancleBlock:^{
            
        }];
        
        return;
        NSDictionary *dict=@{@"version":AppVersion,
                             @"type":@"2"
                             };
        
//        SsLog(@"\r版本->请求参数：%@",dict);
        
        WS(weakSelf);
        
        [[WLHttpManager shareManager]requestWithURL_HTTPCode:JB_CheckVersion_URL RequestType:RequestTypePost Parameters:dict Success:^(NSInteger statusCode, id responseObject) {
            WL_Network_Model *network_Model=[WL_Network_Model mj_objectWithKeyValues:responseObject];
            
            if (network_Model.status.integerValue == SUCCESSED)
            {
                HeBi_Version_Model * model = [HeBi_Version_Model mj_objectWithKeyValues:network_Model.data];
//                weakSelf.versionModel = model;
                
                [SSKJ_QR_AlertView showWithUrl:model.qrc confirmBlock:^{
                    
                } cancleBlock:^{
                    
                }];
                
            }else{
                [MBProgressHUD showError:network_Model.msg];
                
            }
            
        } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
            
        }];
        
    }
}

#pragma mark - 版本更新控制 立即更新 事件
-(void)upgrade_Button_Event
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.versionModel.addr]];
}
#pragma mark - 联系客服

- (void)requestService {
    
    
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:JB_CustomerService_URL RequestType:RequestTypeGet Parameters:nil Success:^(NSInteger statusCode, id responseObject) {
        WL_Network_Model *network_Model=[WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if (network_Model.status.integerValue == SUCCESSED)
        {
                [SSKJ_Service_AlertView showWithModel:network_Model.data[@"phone"] confirmBlock:^{
//                    NSString *tel = [NSString stringWithFormat:@"telprompt://%@",network_Model.data[@"phone"]];
//                    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:tel]];
                } cancleBlock:^{
                    
                }];
        }else{
            [MBProgressHUD showError:network_Model.msg];
        }
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
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
                HeBi_Version_Model * model = [HeBi_Version_Model mj_objectWithKeyValues:network_Model.data];
                weakSelf.versionModel = model;
                
                [HeBi_Version_AlertView showWithModel:model confirmBlock:^{
                    [weakSelf upgrade_Button_Event];
                    
                } cancleBlock:^{
                    
                }];

        }else{
            [MBProgressHUD showError:network_Model.msg];
            
        }
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        
    }];
    
}
#pragma mark - Event

- (void)logoutEvent {
    WS(weakSelf);


    
    [HeBi_Default_AlertView showWithTitle:SSKJLocalized(@"退出登录", nil) message:SSKJLocalized(@"是否确定退出该账户？", nil) cancleTitle:SSKJLocalized(@"取消", nil) confirmTitle:SSKJLocalized(@"退出", nil) confirmBlock:^{
        [SSKJ_User_Tool clearUserInfo];
        [weakSelf presentLoginController];
        [self.headerView hiddenHorzLayout];
        self.headerView.height = ScaleW(313);
        self.mainTableView.tableHeaderView = self.headerView;
        SSKJUserDefaultsSET(@"0", @"kLogin");

    }];
}


#pragma mark - lazyLoad
- (YLJ_MyRootHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [YLJ_MyRootHeaderView new];
//        _headerView.height = ScaleW(355);
        WS(weakSelf);
        _headerView.signBlock = ^{
            if (!kLogin) {
                [MBProgressHUD showError:@"请先登录"];
                [weakSelf presentLoginController];
                return;
            }
            [weakSelf requestSign];
            
        };
        _headerView.exchangeBlock = ^{
            if (!kLogin) {
                [MBProgressHUD showError:@"请先登录"];
                [weakSelf presentLoginController];
                return;
            }
            if ([[SSKJ_User_Tool sharedUserTool].userInfoModel.state intValue] == 0 ) {
                [MBProgressHUD showError:@"请先激活用户"];
                return;
            }
            if ([[SSKJ_User_Tool sharedUserTool].userInfoModel.tpwd intValue] == 0) {
                [MBProgressHUD showError:@"请设置安全密码后再试"];
                return;
            }
            
            YLJExchangeViewController *eVC = [YLJExchangeViewController new];
            [weakSelf.navigationController pushViewController:eVC animated:YES];
        };
        _headerView.loginBlock = ^{
            if (!kLogin) {
//                [MBProgressHUD showError:@"请先登录"];
                [weakSelf presentLoginController];
                return;
            }
        };
    }
    return _headerView;
}

- (NSArray *)titleArray {
    if (!_titleArray) {
        _titleArray = @[@"安全中心",@"联系客服",@"版本更新",@"APP下载"];
    }
    return _titleArray;
}

- (NSArray *)iconArray {
    if (!_iconArray) {
        _iconArray = @[@"wd_icon_safe",@"wd_icon_contact",@"wd_icon_version",@"wd_icon_xiazai"];
    }
    return _iconArray;
}

- (UIButton *)logoutBtn {
    if (!_logoutBtn) {
        _logoutBtn = [WLTools allocButton:SSKJLocalized(@"退出登录", nil) textColor:kMainWihteColor nom_bg:nil hei_bg:nil frame:CGRectMake(ScaleW(15), ScaleW(550), ScaleW(345), ScaleW(50))];
        [_logoutBtn addTarget:self action:@selector(logoutEvent) forControlEvents:UIControlEventTouchUpInside];
        _logoutBtn.titleLabel.font = systemFont(16);
        _logoutBtn.backgroundColor = kTheMeColor;
        
        [_logoutBtn setCornerRadius:ScaleW(3)];
    }
    return _logoutBtn;
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

-(void)requestUserInfo
{
    NSDictionary *params = @{
                             
                             };
    WS(weakSelf);
    //    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:kIscm_get_user_info_Api RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        WL_Network_Model *network_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if ([network_model.status integerValue] == SUCCESSED) {
            
            [SSKJ_User_Tool sharedUserTool].userInfoModel = [SSKJ_UserInfo_Model mj_objectWithKeyValues:network_model.data];
//            weakSelf.uidLab.text = [NSString stringWithFormat:@"UID：%@",[SSKJ_User_Tool sharedUserTool].userInfoModel.uid];
//            weakSelf.phoneLab.text = [SSKJ_User_Tool sharedUserTool].userInfoModel.mobile;
//            weakSelf.headerImageView.image = [UIImage imageNamed:@"default_header_login"];
//            [weakSelf changeUI];
            [self.headerView reloadData];
        }else{
            [MBProgressHUD showError:network_model.msg];
        }
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        [MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
        [self.headerView hiddenHorzLayout];
        self.headerView.height = ScaleW(313);
        self.mainTableView.tableHeaderView = self.headerView;
    }];
    
}
@end
