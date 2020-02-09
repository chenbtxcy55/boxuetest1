//
//  YLJ_SetPwdViewController.m
//  SSKJ
//
//  Created by cy5566 on 2019/11/22.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "YLJ_SetPwdViewController.h"
#import "HeBi_InputView.h"
@interface YLJ_SetPwdViewController ()

//1注册 2 （重置/修改） 3 安全验证 4 安全密码设置 5 提币
@property (nonatomic,copy) NSString *smsType;

@property (nonatomic,strong) HeBi_InputView *accountView;
@property (nonatomic,strong) HeBi_InputView *phoneView;
@property (nonatomic,strong) HeBi_InputView *smsCodeView;
@property (nonatomic, strong) UIButton *getSMSCodeButton;
@property (nonatomic,strong) HeBi_InputView *pwdView;
@property (nonatomic,strong) HeBi_InputView *pwd2View;
@property (nonatomic,strong) UIButton *submitBtn;
@end

@implementation YLJ_SetPwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    [self.view addSubview:self.accountView];
    [self.view addSubview:self.phoneView];
    [self.view addSubview:self.smsCodeView];
    [self.view addSubview:self.getSMSCodeButton];
    [self.view addSubview:self.pwdView];
    [self.view addSubview:self.pwd2View];
    [self.view addSubview:self.submitBtn];
    self.accountView.valueString = [SSKJ_User_Tool sharedUserTool].userInfoModel.account;
    self.accountView.textField.enabled = NO;
    self.phoneView.valueString = [SSKJ_User_Tool sharedUserTool].userInfoModel.mobile;
    self.phoneView.textField.enabled = NO;

    if (self.type == SetPWDTypeDefault) {
        self.title = SSKJLocalized(@"登录密码", nil);
        self.smsType = @"2";
    } else if (self.type == SetPWDTypeSafeAdd) {
        self.title = SSKJLocalized(@"设置安全密码", nil);
        self.pwdView.titleLab.text = SSKJLocalized(@"安全密码", nil);
        self.smsType = @"4";
        if ([SSKJ_User_Tool sharedUserTool].userInfoModel.tpwd.intValue == 1) {
            self.title = SSKJLocalized(@"修改安全密码", nil);
        }
        
    } else if (self.type == SetPWDTypeSafeEdit) {
//        self.pwdView.titleLab.text = SSKJLocalized(@"安全密码", nil);
//        self.smsType = @"4";
    }
    
}

- (void)submitEvent {
    
    if (self.smsCodeView.valueString.length == 0) {
        [MBProgressHUD showError:@"请输入验证码"];
        return;
    }
    if (self.pwdView.valueString.length == 0) {
        [MBProgressHUD showError:SSKJLocalized(@"请输入登录密码", nil)];
        return;
    }
    if (self.pwd2View.valueString.length == 0) {
        [MBProgressHUD showError:SSKJLocalized(@"请输入确认登录密码", nil)];
        return;
    }


    [self requstData];
}
- (void)requstData {
    NSString *url;
    NSDictionary *params;
    if (self.type == SetPWDTypeDefault) {
//        self.title = SSKJLocalized(@"登录密码", nil);
        url = kIscm_user_reset_opwd_Api;
        params = @{
                   @"mobile":self.phoneView.valueString,
                   @"code":self.smsCodeView.valueString,
                   @"opwd":[WLTools md5:self.pwdView.valueString],
                   @"opwd1":[WLTools md5:self.pwd2View.valueString],
                   @"account":self.accountView.valueString
                   };
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        WS(weakSelf);
        [[WLHttpManager shareManager]requestWithURL_HTTPCode:url RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
            [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
            WL_Network_Model *network_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
            if ([network_model.status integerValue] == SUCCESSED) {
                [MBProgressHUD showError:network_model.msg];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"registerHiddenNotification" object:self];
                [SSKJ_User_Tool clearUserInfo];
                JB_Login_ViewController *vc = [[JB_Login_ViewController alloc]init];
                [weakSelf.navigationController pushViewController:vc animated:YES];
                SSKJUserDefaultsSET(@"0", @"kLogin");
            }else{
                [MBProgressHUD showError:network_model.msg];
            }
            
        } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
            [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
            //[MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
        }];
    } else {
        url = JB_SetPayPwdURL;
        params = @{
                   @"mobile":self.phoneView.valueString,
                   @"code":self.smsCodeView.valueString,
                   @"tpwd":[WLTools md5:self.pwdView.valueString],
                   @"tpwd1":[WLTools md5:self.pwd2View.valueString],
                   @"account":self.accountView.valueString
                   };
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        WS(weakSelf);
        [[WLHttpManager shareManager]requestWithURL_HTTPCode:url RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
            [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
            WL_Network_Model *network_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
            if ([network_model.status integerValue] == SUCCESSED) {
                [self.navigationController popViewControllerAnimated:YES];
            }else{
            }
            [MBProgressHUD showError:network_model.msg];

        } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
            [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
            //[MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
        }];
    }
    
    
    

}

- (HeBi_InputView *)accountView
{
    if (nil == _accountView) {
        _accountView = [[HeBi_InputView alloc] initWithFrame:CGRectMake(ScaleW(15), ScaleW(10), ScreenWidth-ScaleW(30), ScaleW(41)) titleWidth:ScaleW(95) gap:ScaleW(16)  titleName:SSKJLocalized(@"用户名", nil) placeHolder:SSKJLocalized(@"请输入用户名", nil) keyboardType:UIKeyboardTypeDefault isSecured:NO];
    }
    return _accountView;
}

- (HeBi_InputView *)phoneView
{
    if (nil == _phoneView) {
        _phoneView = [[HeBi_InputView alloc] initWithFrame:CGRectMake(ScaleW(15), self.accountView.bottom + ScaleW(10), ScreenWidth-ScaleW(30), ScaleW(41)) titleWidth:ScaleW(95) gap:ScaleW(16)  titleName:SSKJLocalized(@"手机号", nil) placeHolder:SSKJLocalized(@"请输入手机号", nil) keyboardType:UIKeyboardTypeNumberPad isSecured:NO];
    }
    return _phoneView;
}

- (HeBi_InputView *)smsCodeView {
    if (nil == _smsCodeView) {
        _smsCodeView = [[HeBi_InputView alloc] initWithFrame:CGRectMake(ScaleW(15),_phoneView.bottom + ScaleW(10), ScreenWidth-ScaleW(30), ScaleW(41)) titleWidth:ScaleW(95) gap:ScaleW(16)  titleName:SSKJLocalized(@"短信验证码", nil) placeHolder:SSKJLocalized(@"请输入验证码", nil) keyboardType:UIKeyboardTypeNumberPad isSecured:NO];
    }
    return _smsCodeView;
}

-(UIButton *)getSMSCodeButton
{
    if (nil == _getSMSCodeButton) {
        _getSMSCodeButton = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth - ScaleW(134) - ScaleW(15), 0, ScaleW(134), ScaleW(40))];
        _getSMSCodeButton.centerY = self.smsCodeView.centerY;
        [_getSMSCodeButton setTitle:SSKJLocalized(@"获取验证码", nil) forState:UIControlStateNormal];
        [_getSMSCodeButton setTitleColor:kTheMeColor forState:UIControlStateNormal];
        _getSMSCodeButton.titleLabel.font = systemFont(ScaleW(16));
        [_getSMSCodeButton addTarget:self action:@selector(getSmsCodeEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _getSMSCodeButton;
}

- (HeBi_InputView *)pwdView {
    if (nil == _pwdView) {
        _pwdView = [[HeBi_InputView alloc] initWithFrame:CGRectMake(ScaleW(15),self.smsCodeView.bottom + ScaleW(10), ScreenWidth-ScaleW(30), ScaleW(41)) titleWidth:ScaleW(95) gap:ScaleW(16)  titleName:SSKJLocalized(@"新密码", nil) placeHolder:SSKJLocalized(@"密码为6-12位字母和数字组合", nil) keyboardType:UIKeyboardTypeDefault isSecured:YES];
        _pwdView.secureButotn.hidden = YES;
    }
    return _pwdView;
}

- (HeBi_InputView *)pwd2View {
    if (nil == _pwd2View) {
        _pwd2View = [[HeBi_InputView alloc] initWithFrame:CGRectMake(ScaleW(15),self.pwdView.bottom + ScaleW(10), ScreenWidth-ScaleW(30), ScaleW(41)) titleWidth:ScaleW(95) gap:ScaleW(16)  titleName:SSKJLocalized(@"确认密码", nil) placeHolder:SSKJLocalized(@"请确认密码", nil) keyboardType:UIKeyboardTypeDefault isSecured:YES];
        _pwd2View.secureButotn.hidden = YES;
    }
    return _pwd2View;
}

-(UIButton *)submitBtn
{
    if (nil == _submitBtn) {
        _submitBtn = [[UIButton alloc]initWithFrame:CGRectMake(ScaleW(15), self.pwd2View.bottom + ScaleW(83), ScreenWidth - ScaleW(30), ScaleW(45))];
        [_submitBtn setTitle:SSKJLocalized(@"确认", nil) forState:UIControlStateNormal];
        [_submitBtn setTitleColor:kMainWihteColor forState:UIControlStateNormal];
        _submitBtn.titleLabel.font = systemBoldFont(ScaleW(16));
        
        [_submitBtn addTarget:self action:@selector(submitEvent) forControlEvents:UIControlEventTouchUpInside];
        [_submitBtn setBackgroundColor:kTheMeColor];
        [_submitBtn setCornerRadius:ScaleW(5)];
    }
    return _submitBtn;
}

-(void)getSmsCodeEvent
{
    
//    NSString * mobileStr =  [SSKJ_User_Tool sharedUserTool].userInfoModel.email;
//
//    if (mobileStr.length==0 /*&& ![RegularExpression validateEmail:self.accountView.valueString]*/) {
//        return;
//    }
    [self requestSmsCode];
    
}
#pragma mark - 请求手机验证码

-(void)requestSmsCode
{
    
    NSDictionary *params = @{
                             @"mobile":[SSKJ_User_Tool sharedUserTool].userInfoModel.mobile,
                             @"type":self.smsType
                             };
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    WS(weakSelf);
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:kIscm_user_send_smsApi RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        WL_Network_Model *network_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if ([network_model.status integerValue] == SUCCESSED) {
            [weakSelf countDown];
        }else{
            [MBProgressHUD showError:network_model.msg];
        }
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        //[MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
    }];
}

// 倒计时
-(void)countDown
{
    [WLTools countDownWithButton:self.getSMSCodeButton];
}
@end
