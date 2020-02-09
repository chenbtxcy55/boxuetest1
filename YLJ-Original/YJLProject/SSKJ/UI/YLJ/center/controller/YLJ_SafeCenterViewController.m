//
//  YLJ_SafeCenterViewController.m
//  SSKJ
//
//  Created by cy5566 on 2019/11/22.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "YLJ_SafeCenterViewController.h"
#import "MineSafeTableCell.h"
#import "GoCoin_Login_NavView.h"
#import "YLJ_SetPwdViewController.h"

@interface YLJ_SafeCenterViewController ()
<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *mainTableView;
@property (nonatomic,strong) UIImageView *headerView;
@property (nonatomic,strong) GoCoin_Login_NavView *navView;
@property (nonatomic, copy) NSArray *titleArray;

@end

@implementation YLJ_SafeCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.mainTableView];
    [self navView];
    self.navView.titleLabel.text = SSKJLocalized(@"安全中心", nil);
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

- (UIImageView *)headerView {
    if (!_headerView) {
        _headerView = [FactoryUI createImageViewWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleW(280)) imageName:@"wd-bg-img-safe"];
    }
    return _headerView;
}

- (UITableView *)mainTableView {
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - Height_NavBar - Height_TabBar) style:UITableViewStylePlain];
        _mainTableView.backgroundColor = kMainBackgroundColor;
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.estimatedRowHeight = ScaleW(50);
        _mainTableView.rowHeight = UITableViewAutomaticDimension;
        _mainTableView.estimatedSectionHeaderHeight = ScaleW(0);
        _mainTableView.estimatedSectionFooterHeight = ScaleW(0);
        _mainTableView.tableHeaderView = self.headerView;
        
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        _mainTableView.showsVerticalScrollIndicator = NO;
        [_mainTableView registerClass:[MineSafeTableCell class] forCellReuseIdentifier:@"MineSafeTableCell"];
        if (@available(iOS 11.0, *)) {
            _mainTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        
    }
    return _mainTableView;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    MineSafeTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineSafeTableCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSString *title = self.titleArray[indexPath.row];
    
    [cell setDataWithDict:@{@"title":title}];
    
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    YLJ_SetPwdViewController *vc = [YLJ_SetPwdViewController new];
    if (indexPath.row == 0) {
        vc.type = SetPWDTypeDefault;
    }
    if (indexPath.row == 1) {
        vc.type = SetPWDTypeSafeAdd;
    }
    
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark -- 导航 ---
- (GoCoin_Login_NavView *)navView
{
    if (_navView == nil) {
        
        _navView = [[GoCoin_Login_NavView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, Height_NavBar)];
        
        _navView.rightBtn.hidden = YES;
        
        WS(weakSelf);
        
        _navView.BackBtnBlock = ^{
            
//            if (weakSelf.fromVC == 1 || weakSelf.fromVC == 2) {
//                AppDelegate *appDelegate =  (AppDelegate *)[UIApplication sharedApplication].delegate;
//                [appDelegate goToMain];
//            }else{
                if (!weakSelf.presentingViewController) {
                    
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                } else {
                    [weakSelf dismissViewControllerAnimated:YES completion:nil];
                }
                
                
//            }
        };
        
        [self.view addSubview:_navView];
    }
    return _navView;
}

- (NSArray *)titleArray {
    if (!_titleArray) {
        _titleArray = @[@"登录密码",@"安全密码"];
    }
    return _titleArray;
}


-(void)requestUserInfo
{

    WS(weakSelf);
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:kIscm_get_user_info_Api RequestType:RequestTypePost Parameters:nil Success:^(NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        WL_Network_Model *network_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if ([network_model.status integerValue] == SUCCESSED) {
            
            [SSKJ_User_Tool sharedUserTool].userInfoModel = [SSKJ_UserInfo_Model mj_objectWithKeyValues:network_model.data];

        }else{
            [MBProgressHUD showError:network_model.msg];
        }
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        [MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
    }];
    
}
@end
