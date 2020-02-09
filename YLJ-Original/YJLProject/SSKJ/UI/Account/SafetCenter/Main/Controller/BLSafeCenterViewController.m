//
//  BLSafeCenterViewController.m
//  BiLe
//
//  Created by 李赛 on 2017/02/14.
//  Copyright © 2018年 LS. All rights reserved.
//

#import "BLSafeCenterViewController.h"
#import "BFEXReChartWayTableViewCell.h"
#import "My_BindPhone_ViewController.h"
#import "My_ChangePWD_ViewController.h"
#import "My_SetTPWD_ViewController.h"
#import "HeBi_Mine_Certificate_ViewController.h"
#import "My_GoogleVerify_ViewController.h"
#import "My_BindGoogle_AlertView.h"
#import "BFEXSafeSelectViewController.h"
#import "BFEXShowChartView.h"
#import "JB_PayWayModel.h"
#import "BLUserModel.h"
#import "BLSafeCenterCell.h"
#import "HeBi_Default_AlertView.h"
#import "HeBi_ApplyShop_AlertView.h"
#import "JB_Default_AlertView.h"
#import "RegularExpression.h"
#import <LocalAuthentication/LocalAuthentication.h>
#import "Tools.h"

@interface BLSafeCenterViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *cellTitleArr;
@property (nonatomic, strong) UIView *sectionView;
@property (nonatomic, strong) UIView *footerView;
@property (nonatomic, strong) My_BindGoogle_AlertView *googleAlertView;
@property (nonatomic, strong) UIView *headerView;

@property (nonatomic, strong) MBProgressHUD *hud;
@property (nonatomic, strong) BFEXShowChartView *showView;
@property (nonatomic, strong) NSArray *payWaysArray;
@property (nonatomic, strong) HeBi_ApplyShop_AlertView *applyAlertView;

@property (nonatomic, strong) BLSafeCenterCell *zhiwenCell;

@property (nonatomic, copy) NSString *zhiwenOpenStatus;

@end

@implementation BLSafeCenterViewController

- (NSMutableArray *)cellTitleArr {
    if (!_cellTitleArr) {
        _cellTitleArr = [NSMutableArray array];
        [_cellTitleArr insertObject:@[SSKJLocalized(@"手机", nil),
                                      SSKJLocalized(@"邮箱", nil),
                                      SSKJLocalized(@"登录密码", nil),
                                      SSKJLocalized(@"安全密码", nil),
                                      SSKJLocalized(@"身份认证", nil),
                                      SSKJLocalized(@"商家认证", nil),
                                      SSKJLocalized(@"谷歌认证", nil),
                                      SSKJLocalized(@"指纹登录", nil),

                                      ] atIndex:0];
        
        
        [_cellTitleArr insertObject:@[] atIndex:1];
        
        [_cellTitleArr insertObject:@[] atIndex:2];
        
    }
    return _cellTitleArr;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = SSKJLocalized(@"安全中心", nil);
    self.userModel = [SSKJ_User_Tool sharedUserTool].userInfoModel;
    [self setupUI];
    self.view.backgroundColor = kMainBackgroundColor;
//    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([BLSafeCenterCell class]) bundle:nil] forCellReuseIdentifier:@"safeCell"];
    
    //[kNotifyCenter addObserver:self selector:@selector(showViewAlert) name:@"showAlertView" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadBankListNo) name:@"reloadBankListAction" object:nil];
//    [[UIApplication sharedApplication].keyWindow addSubview:self.unVerBussView];
    self.isShowPop = YES;
}

- (void)reloadBankListNo {
    [self reloadBankList];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = NO;
    [self loadUserData:kPhoneNumber];
    [self reloadBankList];
    
    
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.translucent = YES;
}


-(My_BindGoogle_AlertView *)googleAlertView
{
    if (nil == _googleAlertView) {
        _googleAlertView = [[My_BindGoogle_AlertView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        WS(weakSelf);
        _googleAlertView.submitBlock = ^(NSString * _Nonnull googleCode, NSString * _Nonnull smsCode) {
            [weakSelf requestDeleteGoogleWithCode:smsCode googleCode:googleCode];
        };
    }
    return _googleAlertView;
}

/**
 加载用户数据
 */
- (void)loadUserData:(NSString *)phoneNumber {

    NSDictionary *params = @{};
    WS(weakSelf);
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:JB_Account_UserInfo_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        WL_Network_Model *network_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if ([network_model.status integerValue] == SUCCESSED) {
            SSKJ_UserInfo_Model *model = [SSKJ_UserInfo_Model mj_objectWithKeyValues:network_model.data];
            [SSKJ_User_Tool sharedUserTool].userInfoModel = model;
            weakSelf.userModel = model;
            [weakSelf.tableView reloadData];
        }else{
            [MBProgressHUD showError:network_model.msg];
        }
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        //[MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
    }];
}

-(void)reloadBankList
{
    WS(weakSelf);   
//    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:JB_Account_PayList_URL RequestType:RequestTypePost Parameters:nil Success:^(NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        WL_Network_Model *network_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if ([network_model.status integerValue] == SUCCESSED) {
            weakSelf.payWaysArray = [JB_PayWayModel mj_objectArrayWithKeyValuesArray:network_model.data];
            [weakSelf.tableView reloadData];
            [weakSelf.tableView.mj_header endRefreshing];
//            [MBProgressHUD showError:network_model.msg];
        }else{
            [MBProgressHUD showError:network_model.msg];
        }
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        //[MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
        [weakSelf.tableView.mj_header endRefreshing];

    }];
}

- (void)setupUI {
    UITableView *tableView = [[UITableView alloc] initWithFrame:(CGRectZero) style:(UITableViewStyleGrouped)];
    tableView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight - Height_NavBar);
    tableView.delegate = self;
    tableView.separatorColor = kLineGrayColor;
    tableView.backgroundColor  = [UIColor clearColor];
    tableView.dataSource = self;
    tableView.bounces = YES;
    [self.view addSubview:tableView];
    _tableView = tableView;
    _tableView.tableFooterView = self.footerView;
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleW(10))];
    headerView.backgroundColor = kMainBackgroundColor;
    _tableView.tableHeaderView = headerView;
    WS(weakSelf);
    _tableView.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
        [weakSelf reloadBankList];
    }];

}


#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 2) {
        return self.payWaysArray.count;
    }
    NSArray *array = self.cellTitleArr[section];
    return array.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.cellTitleArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0 || indexPath.section == 1) {
        BLSafeCenterCell *cell = [tableView dequeueReusableCellWithIdentifier:@"safeCell"];
        if (cell == nil) {
            cell = [[NSBundle mainBundle]loadNibNamed:@"BLSafeCenterCell" owner:nil options:nil].firstObject;
        }
        NSArray *array = self.cellTitleArr[indexPath.section];
        cell.cellTitle.text = array[indexPath.row];
        NSString *status = [self statusWithModel:_userModel indexPath:indexPath];
        cell.status.text = status;
        
        if ([status containsString:SSKJLocalized(@"已开启", nil)] || [status containsString:SSKJLocalized(@"初级已认证", nil)] || [status isEqualToString:SSKJLocalized(@"修改", nil)]|| [status containsString:SSKJLocalized(@"高级已认证", nil)]) {
            cell.status.textColor = kTextLightBlueColor;
        }else{
            cell.status.textColor = kTextLightBlueColor;
        }
        
        NSArray *array1 = self.cellTitleArr.firstObject;
        if (indexPath.row == array1.count - 1) {
            cell.swithImageView.hidden = NO;
            BOOL saveTouch = [Tools getPlistWithName:@"Gestrue" key: kPhoneNumber];
            cell.zhiwenSelected = saveTouch;
            self.zhiwenCell = cell;
            
            if (saveTouch) {
                self.zhiwenOpenStatus = @"1";
            }else{
                self.zhiwenOpenStatus = @"0";
            }
        }else{
            cell.swithImageView.hidden = YES;
        }
        
        return cell;
    }
    
    
    if(indexPath.section == 2){//支付方式
        BFEXReChartWayTableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"%@%ld",NSStringFromClass([self class]),indexPath.row]];
            if (!cell)
            {
                cell = [[BFEXReChartWayTableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:[NSString stringWithFormat:@"%@%ld",NSStringFromClass([self class]),indexPath.row]];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                WS(weakSelf);
                cell.edtingBlock = ^(JB_PayWayModel *dic) {//修改点击方法
                    [weakSelf showViewAlert:dic];
                };
            }
        JB_PayWayModel *model = self.payWaysArray[indexPath.row];
        [cell setValueData:model];
        return cell;
    }
    return nil;
}

// 设置不同状态
- (NSString *)statusWithModel:(SSKJ_UserInfo_Model *)model indexPath:(NSIndexPath *)indexPath {
    NSString *status;
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0){
            NSString *mobile = [self setupTitle:model.mobile?:@""];
            status = (model.mobile && ![model.mobile isEqualToString:@""]) ? mobile  : SSKJLocalized(@"未绑定", nil);
        }else if (indexPath.row == 1){
            NSString *email = [self setupTitle:model.email?:@""];
            status = (model.email && ![model.email isEqualToString:@""]) ? email   : SSKJLocalized(@"未绑定", nil);
        }else if (indexPath.row == 2){
            status = SSKJLocalized(@"修改", nil);
        }else if (indexPath.row == 3){
            if (model.tpwd.length > 0) {
                status = SSKJLocalized(@"修改", nil);
            }else{
                status = SSKJLocalized(@"未设置", nil);
            }

        }else if (indexPath.row == 4) {
            if ([model.status integerValue] == 1) {  // 未认证
                status = SSKJLocalized(@"初级未认证", nil);
            } else if ([model.status integerValue] == 2) {
                status = SSKJLocalized(@"初级审核中", nil);
            } else if ([model.status integerValue] == 3) {
                if (model.auth_status.integerValue == 1) {
                    status = SSKJLocalized(@"初级已认证", nil);
                }else if (model.auth_status.integerValue == 2){
                    status = SSKJLocalized(@"高级审核中", nil);
                }
                else if (model.auth_status.integerValue == 3){
                    status = SSKJLocalized(@"高级已认证", nil);
                }
                else if (model.auth_status.integerValue == 4){
                    status = SSKJLocalized(@"高级已拒绝", nil);
                }
            } else if ([model.status integerValue] == 4) {
                status = SSKJLocalized(@"初级已拒绝", nil);
            }
        }else if (indexPath.row == 5) {
            if (model.is_shop.integerValue == 1) {//已认证
                status = SSKJLocalized(@"解除商家认证", nil);
            }else if (model.is_shop.integerValue == 0) {//未认证
                status = SSKJLocalized(@"未认证", nil);
            }else if (model.is_shop.integerValue == 2) {
                status = SSKJLocalized(@"待审核", nil);
            }else if (model.is_shop.integerValue == 3) {
                status = SSKJLocalized(@"已拒绝", nil);
            }
        }else if (indexPath.row == 6) {
            if (model.command.integerValue == 0) {//未认证
                status = SSKJLocalized(@"未认证", nil);
            }else{
                if (model.is_start_google.integerValue == 1) {  // 已认证
                    status = SSKJLocalized(@"已开启", nil);
                } else{
                    status = SSKJLocalized(@"未开启", nil);
                }
            }
        }
    }
    
    return status;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0 || indexPath.section == 1){
       return ScaleW(56);
    }else{
        return ScaleW(122);
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if(section == 0 || section == 1){
        return 0.01;
    }
    if(section == 2){
        return self.sectionView.height;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    if(section == 2)
    {
        return self.sectionView;
    }
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
  return [[UIView alloc] initWithFrame:CGRectZero];
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return .1f;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    WS(weakSelf);
    if (indexPath.section == 0) {
        BLSafeCenterCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        if (indexPath.row == 0) {
            if (self.userModel.mobile.length != 0) {
                [MBProgressHUD showError:SSKJLocalized(@"手机号已绑定", nil)];
            }else{
                if (![self judgePayPassword]) {
                    return;
                }
                My_BindPhone_ViewController *vc = [[My_BindPhone_ViewController alloc]init];
                vc.bindType = BindTypePhone;
                vc.successBlock = ^(NSString * _Nonnull account) {
                    cell.status.text = account;
                    weakSelf.userModel.mobile = account;
                };
                [self.navigationController pushViewController:vc animated:YES];
            }
        }else if (indexPath.row == 1) {
            if (self.userModel.email.length != 0) {
                [MBProgressHUD showError:SSKJLocalized(@"邮箱已绑定", nil)];
            } else {
                if (![self judgePayPassword]) {
                    return;
                }
                My_BindPhone_ViewController *bindEmailVC = [[My_BindPhone_ViewController alloc] init];
                bindEmailVC.bindType = BindTypeEmail;
                bindEmailVC.successBlock = ^(NSString * _Nonnull account) {
                    cell.status.text = account;
                    weakSelf.userModel.email = account;
                };
                [self.navigationController pushViewController:bindEmailVC animated:YES];
            }
        }else if (indexPath.row == 2) {
            My_ChangePWD_ViewController *resetPwdVC = [[My_ChangePWD_ViewController alloc] init];
            [self.navigationController pushViewController:resetPwdVC animated:YES];
        }else if (indexPath.row == 3) {
            My_SetTPWD_ViewController *vc = [[My_SetTPWD_ViewController alloc]init];
            vc.phoneNumber = kPhoneNumber;
            vc.statusBlock = ^{
                cell.status.text = @"已设置";
            };
            if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"emailIndex"] isEqualToString:@"1"]) {
                vc.phoneNumber = self.userModel.email;
            }else{
                vc.phoneNumber = self.userModel.mobile;
            }
            [self.navigationController pushViewController:vc animated:YES];
        }else if (indexPath.row == 4) {
            HeBi_Mine_Certificate_ViewController *vc = [[HeBi_Mine_Certificate_ViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }else if (indexPath.row == 5){
            if (![self judgeSecondCertificate]) {
                return;
            }
            [self judgeBusinessCertificate];
        }else if (indexPath.row == 6) {

            if (weakSelf.userModel.command.integerValue == 0) {//未认证
                My_GoogleVerify_ViewController *vc = [[My_GoogleVerify_ViewController alloc]init];
                WS(weakSelf);
                vc.addGoogleBlock = ^{
                    
                };
                [weakSelf.navigationController pushViewController:vc animated:YES];
            }else{
                if (weakSelf.userModel.is_start_google.integerValue == 1) {  // 已认证 已开启
                    [self.googleAlertView showWithType:GOOGLETYPEDELETE];//解绑
                } else{
                    [self.googleAlertView showWithType:GOOGLETYPEADD];//开启
                }
            }
      
        }else if (indexPath.row == 7){
            [self judgeFaceID];
        }
    }

}
    
-(UIView *)sectionView{
    if (!_sectionView) {
        _sectionView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, ScaleW(98))];
        _sectionView.backgroundColor = kSubBackgroundColor;
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, 10.f)];
        view.backgroundColor = kMainBackgroundColor;
        
        [_sectionView addSubview:view];
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(17, 25, 0, 14);
        label.font = [UIFont systemFontOfSize:14];
        label.text = SSKJLocalized(@"支付方式", nil);
        [label sizeToFit];
        label.textColor = kTextLightBlueColor;
        label.textAlignment = NSTextAlignmentCenter;  label.backgroundColor = [UIColor clearColor];
        [_sectionView addSubview:label];
        UILabel *labelcontent = [[UILabel alloc] init];
        labelcontent.font = [UIFont systemFontOfSize:12.f];
        labelcontent.frame = CGRectMake(17, label.bottom + 13, Screen_Width - 34, 0);
        labelcontent.text = SSKJLocalized(@"请务必使用您本人的实名账户，被激活的支付方式将在交易时向买方展示，最多激活3种", nil);
        NSString *string = SSKJLocalized(@"请务必使用您本人的实名账户，被激活的支付方式将在交易时向买方展示，最多激活3种", nil);
        CGFloat height = [string boundingRectWithSize:CGSizeMake(ScreenWidth - 34, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:systemFont(12)} context:nil].size.height;
        labelcontent.height = height;
        _sectionView.height = height + 65;
        labelcontent.numberOfLines = 0;
        [labelcontent sizeToFit];
        labelcontent.textColor = [UIColor colorWithHexStringToColor:@"8d93bc"];
       
        [_sectionView addSubview:labelcontent];
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, _sectionView.height - 1, Screen_Width, 1.f)];
        line.backgroundColor = kLineGrayColor;
         [_sectionView addSubview:line];

    }
    return _sectionView;
}

-(UIView *)footerView{
    if (!_footerView) {
        _footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, 55)];
        _footerView.backgroundColor = kSubBackgroundColor;
        UIButton *button = [[UIButton alloc] init];
        button.frame = CGRectMake(0, 0, Screen_Width, 55);
        button.titleLabel.font = [UIFont systemFontOfSize:13.f];
        [button setTitle:SSKJLocalized(@"添加支付方式", nil) forState:UIControlStateNormal];
        [button setTitleColor:kTextLightBlueColor forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [_footerView addSubview:button];
        
        
    }
    return _footerView;
}
#pragma mark -- 添加支付方式 --
-(void)buttonClicked:(UIButton *)sender
{
    if (![self judgeFristCertificate]) {
        return;
    }
    if (![self judgePayPassword]) {
        return;
    }
    
    [self showViewAlert:@"add"];
}
-(void)showViewAlert:(id)type{
    BFEXSafeSelectViewController *vc = [[BFEXSafeSelectViewController alloc]init];
    vc.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [vc showViewAlert:type];
    vc.modalPresentationStyle = UIModalPresentationFullScreen;

    [self.navigationController presentViewController:vc animated:YES completion:^{

    }];

    
}


#pragma mark - 取消谷歌绑定

-(void)requestDeleteGoogleWithCode:(NSString *)smsCode googleCode:(NSString *)googleCode
{
    NSString *isOpen = self.userModel.is_start_google;
    if (isOpen.integerValue == 0) {
        isOpen = @"1";
    }else{
        isOpen = @"0";
    }
    NSDictionary *params = @{
                             @"act":isOpen,
                             @"code":smsCode,
                             @"dyGoodleCommand":googleCode?:@"",
                             @"mobile":kPhoneNumber
                             };
    WS(weakSelf);
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:JB_SetGoogle_State_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        WL_Network_Model *network_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if ([network_model.status integerValue] == SUCCESSED) {
            if (isOpen.integerValue == 0) {
                weakSelf.userModel.is_start_google = @"1";
            }else{
                weakSelf.userModel.is_start_google = @"0";
            }
            [weakSelf.tableView reloadData];
            
        }else{
            [MBProgressHUD showError:network_model.msg];
        }
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        //[MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
    }];
}

#pragma mark - 申请商家认证

-(void)requestApplyShop
{
    NSString *Account=[[SSKJ_User_Tool sharedUserTool] getAccount];

    NSDictionary *params = @{
                             @"account":Account
                             };
    WS(weakSelf);
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:JB_ApplyShop_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        WL_Network_Model *network_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if ([network_model.status integerValue] == SUCCESSED) {
            [MBProgressHUD showSuccess:@"提交成功"];
            [weakSelf.applyAlertView hide];
            [SSKJ_User_Tool sharedUserTool].userInfoModel.is_shop = @"2";
            [weakSelf.tableView reloadData];
            [weakSelf.applyAlertView hide];
            [weakSelf loadUserData:kPhoneNumber];
        }else{
            [MBProgressHUD showError:network_model.msg];
        }
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        //[MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
        
    }];
}

-(HeBi_ApplyShop_AlertView *)applyAlertView
{
    if (nil == _applyAlertView) {
        _applyAlertView = [[HeBi_ApplyShop_AlertView alloc]init];
        WS(weakSelf);
        _applyAlertView.confirmBlock = ^{
            [weakSelf requestApplyShop];
        };
    }
    return _applyAlertView;
}

#pragma mark - 解除商家认证
-(void)requestCancleShop
{
    [self.applyAlertView hide];
    NSString *Account=[[SSKJ_User_Tool sharedUserTool] getAccount];
    NSDictionary *params = @{
                             @"account":Account
                             };
    WS(weakSelf);
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:JB_CancleShop_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        WL_Network_Model *network_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if ([network_model.status integerValue] == SUCCESSED) {
            
            [MBProgressHUD showSuccess:@"操作成功"];
            [weakSelf.applyAlertView hide];
            [SSKJ_User_Tool sharedUserTool].userInfoModel.is_shop = @"0";
            [weakSelf.tableView reloadData];
            [weakSelf loadUserData:kPhoneNumber];
        }else{
            [MBProgressHUD showError:network_model.msg];
        }
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        //[MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
        
    }];
}

- (NSString *)setupTitle:(NSString *)title {
    NSMutableString* str1 = [[NSMutableString alloc]initWithString:title];
    NSString *mobileStr;
    if ([RegularExpression validateMobile:title] ) {
        mobileStr = [title stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    }else{
        NSRange range = [title rangeOfString:@"@"];
        
        if (range.location == 0) {
            [str1 insertString:@"*" atIndex:1];
            mobileStr = [NSString stringWithFormat:@"%@",str1];
        }else if (range.location == 1){
            mobileStr = [title stringByReplacingCharactersInRange:NSMakeRange(1, 1) withString:@"*"];
        }else if (range.location == 2){
            mobileStr = [title stringByReplacingCharactersInRange:NSMakeRange(1, 1) withString:@"****"];
        }else if (range.location == 3){
            mobileStr = [title stringByReplacingCharactersInRange:NSMakeRange(1, 2) withString:@"****"];
        }else if (range.location == 4){
            mobileStr = [title stringByReplacingCharactersInRange:NSMakeRange(2, 2) withString:@"****"];
        }else if (range.location == 5){
            mobileStr = [title stringByReplacingCharactersInRange:NSMakeRange(2, 3) withString:@"****"];
        }else{
            mobileStr = [title stringByReplacingCharactersInRange:NSMakeRange(2, 4) withString:@"****"];
        }
    }
    return mobileStr;
}

#pragma mark - 指纹解锁

-(void)judgeFaceID
{
    LAContext *context = [[LAContext alloc] init];
    NSError *error = nil;
    
    // 判断设置是否支持指纹识别(iPhone5s+、iOS8+支持)
    BOOL support = [context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error];
    
    if (support) {
//        return AllRight;
        if (self.zhiwenOpenStatus.integerValue == 0) {
            self.zhiwenOpenStatus = @"1";
        }else{
            self.zhiwenOpenStatus = @"0";
        }
        
        NSDictionary *param = @{
                                kPhoneNumber:self.zhiwenOpenStatus
                                };
        [Tools savePlistWithName:@"Gestrue" Param:param];
        [self.zhiwenCell setZhiwenSelected:self.zhiwenOpenStatus.integerValue];
        
    }else{
        switch (error.code) {
                //        没有设置指纹（没有设置密码也会走到这），但是支持指纹识别
            case LAErrorTouchIDNotEnrolled:{
                showAlert(SSKJLocalized(@"请先设置指纹", nil));
            }
                break;
                //        理论上是没有设置密码,至今没有尝试出什么情况下走这个,希望有试出来场景的兄弟告知一下我
//            case LAErrorPasscodeNotSet:{
//                return TouchOK;
//            }
//                break;
                //       在使用touchID的场景中,错误太多次（根据策略不同为5次到6次）而导致touchID被锁不可用
            case LAErrorTouchIDLockout:{
                showAlert(SSKJLocalized(@"错误次数太多，touchID不可用", nil));

            }
                //        设备不支持指纹识别
            default:{
                showAlert(SSKJLocalized(@"不支持指纹识别", nil));
            }
                break;
        }
    }
}


// 弹出解锁框
- (void)changeSwitchStateWithSwitch
{
    //首先判断版本
    if (NSFoundationVersionNumber < NSFoundationVersionNumber_iOS_8_0) {
        NSLog(@"系统版本不支持TouchID");
        return;
    }
    
    LAContext *context = [[LAContext alloc] init];
    context.localizedFallbackTitle = @"";
    if (@available(iOS 10.0, *)) {
        //        context.localizedCancelTitle = @"22222";
    } else {
        // Fallback on earlier versions
    }
    NSError *error = nil;
    
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
        WS(weakSelf);
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:@"通过Home键验证已有手机指纹" reply:^(BOOL success, NSError * _Nullable error) {
            
            if (success) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    showAlert(@"TouchID 验证成功");
                    if (kPhoneNumber)
                    {
                        if (weakSelf.zhiwenOpenStatus.integerValue == 0) {
                            weakSelf.zhiwenOpenStatus = @"1";
                        }else{
                            weakSelf.zhiwenOpenStatus = @"0";
                        }
                        
                        NSDictionary *param = @{
                                                kPhoneNumber:weakSelf.zhiwenOpenStatus
                                                };
                        [Tools savePlistWithName:@"Gestrue" Param:param];
                        [weakSelf.zhiwenCell setZhiwenSelected:weakSelf.zhiwenOpenStatus.integerValue];
                    }
                });
            }else if(error){
                
                switch (error.code) {
                    case LAErrorAuthenticationFailed:{
                        dispatch_async(dispatch_get_main_queue(), ^{
                            showAlert(@"TouchID 验证失败");
                            BOOL saveTouch = [Tools getPlistWithName:@"Gestrue" key: kPhoneNumber];
                            weakSelf.zhiwenCell.zhiwenSelected = saveTouch;
                            //                            if (kPhoneNumber)
                            //                            {
                            //                                NSDictionary *param = @{
                            //                                                        kPhoneNumber:@(self.switchButton.selected)
                            //                                                        };
                            //                                [Tools savePlistWithName:@"Gestrue" Param:param];
                            //                            }
                        });
                        break;
                    }
                    case LAErrorUserCancel:{
                        dispatch_async(dispatch_get_main_queue(), ^{
                            showAlert(@"TouchID 被用户手动取消");
                            //                            self.switchButton.selected = NO;
                            BOOL saveTouch = [Tools getPlistWithName:@"Gestrue" key: kPhoneNumber];
                            weakSelf.zhiwenCell.zhiwenSelected = saveTouch;
                            if (kPhoneNumber)
                            {
                                NSDictionary *param = @{
                                                        kPhoneNumber:@(self.zhiwenCell.zhiwenSelected)
                                                        };
                                [Tools savePlistWithName:@"Gestrue" Param:param];
                            }
                        });
                    }
                        break;
                    case LAErrorUserFallback:{
                        dispatch_async(dispatch_get_main_queue(), ^{
                            showAlert(@"用户不使用指纹解锁,选择手动输入密码");
                            self.zhiwenCell.zhiwenSelected = NO;
                            if (kPhoneNumber)
                            {
                                NSDictionary *param = @{
                                                        kPhoneNumber:@(self.zhiwenCell.zhiwenSelected)
                                                        };
                                [Tools savePlistWithName:@"Gestrue" Param:param];
                            }
                        });
                    }
                        break;
                    case LAErrorSystemCancel:{
                        dispatch_async(dispatch_get_main_queue(), ^{
                            showAlert(@"指纹解锁被系统取消 (如遇到来电,锁屏,按了Home键等)");
                            BOOL saveTouch = [Tools getPlistWithName:@"Gestrue" key: kPhoneNumber];
                            weakSelf.zhiwenCell.zhiwenSelected = saveTouch;
                            //                            self.switchButton.selected = NO;
                            //                            if (kPhoneNumber)
                            //                            {
                            //                                NSDictionary *param = @{
                            //                                                        kPhoneNumber:@(self.switchButton.selected)
                            //                                                        };
                            //                                [Tools savePlistWithName:@"Gestrue" Param:param];
                            //                            }
                        });
                    }
                        break;
                    case LAErrorPasscodeNotSet:{
                        dispatch_async(dispatch_get_main_queue(), ^{
                            showAlert(@"指纹解锁无法启动,因为用户没有设置密码");
                            BOOL saveTouch = [Tools getPlistWithName:@"Gestrue" key: kPhoneNumber];
                            weakSelf.zhiwenCell.zhiwenSelected = saveTouch;
                            //                            self.switchButton.selected = NO;
                            //                            if (kPhoneNumber)
                            //                            {
                            //                                NSDictionary *param = @{
                            //                                                        kPhoneNumber:@(self.switchButton.selected)
                            //                                                        };
                            //                                [Tools savePlistWithName:@"Gestrue" Param:param];
                            //                            }
                        });
                    }
                        break;
                    case LAErrorTouchIDNotEnrolled:{
                        dispatch_async(dispatch_get_main_queue(), ^{
                            showAlert(@"指纹解锁无法启动,因为用户没有设置TouchID");
                            BOOL saveTouch = [Tools getPlistWithName:@"Gestrue" key: kPhoneNumber];
                            weakSelf.zhiwenCell.zhiwenSelected = saveTouch;
                            //                            self.switchButton.selected = NO;
                            //                            if (kPhoneNumber)
                            //                            {
                            //                                NSDictionary *param = @{
                            //                                                        kPhoneNumber:@(self.switchButton.selected)
                            //                                                        };
                            //                                [Tools savePlistWithName:@"Gestrue" Param:param];
                            //                            }
                        });
                    }
                        break;
                    case LAErrorTouchIDNotAvailable:{
                        dispatch_async(dispatch_get_main_queue(), ^{
                            showAlert(@"指纹解锁无效");
                            BOOL saveTouch = [Tools getPlistWithName:@"Gestrue" key: kPhoneNumber];
                            weakSelf.zhiwenCell.zhiwenSelected = saveTouch;
                            //                            self.switchButton.selected = NO;
                            //                            if (kPhoneNumber)
                            //                            {
                            //                                NSDictionary *param = @{
                            //                                                        kPhoneNumber:@(self.switchButton.selected)
                            //                                                        };
                            //                                [Tools savePlistWithName:@"Gestrue" Param:param];
                            //                            }
                        });
                    }
                        break;
                    case LAErrorTouchIDLockout:{
                        dispatch_async(dispatch_get_main_queue(), ^{
                            showAlert(@"指纹解锁被锁定(连续多次验证TouchID失败,系统需要用户手动输入密码)");
                            BOOL saveTouch = [Tools getPlistWithName:@"Gestrue" key: kPhoneNumber];
                            weakSelf.zhiwenCell.zhiwenSelected = saveTouch;
                            //                            self.switchButton.selected = NO;
                            //                            if (kPhoneNumber)
                            //                            {
                            //                                NSDictionary *param = @{
                            //                                                        kPhoneNumber:@(self.switchButton.selected)
                            //                                                        };
                            //                                [Tools savePlistWithName:@"Gestrue" Param:param];
                            //                            }
                        });
                    }
                        break;
                    case LAErrorAppCancel:{
                        dispatch_async(dispatch_get_main_queue(), ^{
                            showAlert(@"当前软件被挂起并取消了授权 (如App进入了后台等)");
                            BOOL saveTouch = [Tools getPlistWithName:@"Gestrue" key: kPhoneNumber];
                            weakSelf.zhiwenCell.zhiwenSelected = saveTouch;
                            //                            self.switchButton.selected = NO;
                            //                            if (kPhoneNumber)
                            //                            {
                            //                                NSDictionary *param = @{
                            //                                                        kPhoneNumber:@(self.switchButton.selected)
                            //                                                        };
                            //                                [Tools savePlistWithName:@"Gestrue" Param:param];
                            //                            }
                        });
                    }
                        break;
                    case LAErrorInvalidContext:{
                        dispatch_async(dispatch_get_main_queue(), ^{
                            showAlert(@"当前软件被挂起并取消了授权 (LAContext对象无效)");
                            BOOL saveTouch = [Tools getPlistWithName:@"Gestrue" key: kPhoneNumber];
                            weakSelf.zhiwenCell.zhiwenSelected = saveTouch;
                            //                            self.switchButton.selected = NO;
                            //                            if (kPhoneNumber)
                            //                            {
                            //                                NSDictionary *param = @{
                            //                                                        kPhoneNumber:@(self.switchButton.selected)
                            //                                                        };
                            //                                [Tools savePlistWithName:@"Gestrue" Param:param];
                            //                            }
                        });
                    }
                        break;
                    default:
                        break;
                }
            }
        }];
        
    }else{
        showAlert(@"请前往设置开启指纹解锁");
        BOOL saveTouch = [Tools getPlistWithName:@"Gestrue" key: kPhoneNumber];
        self.zhiwenCell.zhiwenSelected = saveTouch;
        //        self.switchButton.selected = NO;
        //        if (kPhoneNumber)
        //        {
        //            NSDictionary *param = @{
        //                                    kPhoneNumber:@(self.switchButton.selected)
        //                                    };
        //            [Tools savePlistWithName:@"Gestrue" Param:param];
        //        }
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end

