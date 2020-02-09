//
//  My_ChangePWD_ViewController.m
//  ZYW_MIT
//
//  Created by 刘小雨 on 2019/3/28.
//  Copyright © 2019年 Wang. All rights reserved.
//

#import "My_ChangePWD_ViewController.h"
#import "My_InputView.h"
#import "RegularExpression.h"
#import "JB_Login_ViewController.h"
@interface My_ChangePWD_ViewController ()
@property (nonatomic, strong) My_InputView *oldPwdView;
@property (nonatomic, strong) My_InputView *pwdView;
@property (nonatomic, strong) My_InputView *surePwdView;

@property (nonatomic, strong) UIButton *submitButton;

@end

@implementation My_ChangePWD_ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = SSKJLocalized(@"修改登录密码", nil);
    
    self.view.backgroundColor = kMainBackgroundColor;
    
    [self setUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = NO;
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.translucent = YES;
}

#pragma mark - UI
-(void)setUI
{
    [self.view addSubview:self.oldPwdView];
    [self.view addSubview:self.pwdView];
    [self.view addSubview:self.surePwdView];
    
    [self.view addSubview:self.submitButton];
}

-(My_InputView *)oldPwdView
{
    if (nil == _oldPwdView) {
        _oldPwdView = [[My_InputView alloc]initWithFrame:CGRectMake(0, ScaleW(10), ScreenWidth, ScaleW(50)) placeHolder:SSKJLocalized(@"请输入登录密码", nil) keyboardType:UIKeyboardTypeASCIICapable isSecured:YES];
        _oldPwdView.titleLB.text = SSKJLocalized(@"原密码", nil);
    }
    return _oldPwdView;
}

-(My_InputView *)pwdView
{
    if (nil == _pwdView) {
        _pwdView = [[My_InputView alloc]initWithFrame:CGRectMake(0, self.oldPwdView.bottom, ScreenWidth, ScaleW(50)) placeHolder:SSKJLocalized(@"请输入8-20位字母和数字的组合", nil) keyboardType:UIKeyboardTypeASCIICapable isSecured:YES];
        _pwdView.titleLB.text = SSKJLocalized(@"新密码", nil);
    }
    return _pwdView;
}

-(My_InputView *)surePwdView
{
    if (nil == _surePwdView) {
        _surePwdView = [[My_InputView alloc]initWithFrame:CGRectMake(0, self.pwdView.bottom, ScreenWidth, ScaleW(50)) placeHolder:SSKJLocalized(@"请输入重复密码", nil) keyboardType:UIKeyboardTypeASCIICapable isSecured:YES];
        _surePwdView.titleLB.text = SSKJLocalized(@"确认密码", nil);
    }
    return _surePwdView;
}


-(UIButton *)submitButton
{
    if (nil == _submitButton) {
        _submitButton = [[UIButton alloc]initWithFrame:CGRectMake(ScaleW(25), self.surePwdView.bottom + ScaleW(45), ScreenWidth - ScaleW(50), ScaleW(45))];
        _submitButton.layer.cornerRadius = _submitButton.height / 2;
//        _submitButton.backgroundColor = kMainTextColor;
        [_submitButton setTitle:SSKJLocalized(@"提交", nil) forState:UIControlStateNormal];
        [_submitButton setTitleColor:kMainTextColor forState:UIControlStateNormal];
        _submitButton.titleLabel.font = systemFont(ScaleW(16));
        [_submitButton addTarget:self action:@selector(submitEvent) forControlEvents:UIControlEventTouchUpInside];
        [_submitButton addGradientColor];
        _submitButton.layer.masksToBounds = YES;
        _submitButton.layer.cornerRadius = ScaleW(5);
    }
    return _submitButton;
}

#pragma mark - 用户操作

-(void)submitEvent
{
    if (self.oldPwdView.valueString.length == 0) {
        [MBProgressHUD showError:SSKJLocalized(@"请输入原登录密码", nil)];
        return;
    }
    
    if (self.pwdView.valueString.length == 0) {
        [MBProgressHUD showError:SSKJLocalized(@"请输入新登录密码", nil)];
        return;
    }
    
    if (self.surePwdView.valueString.length == 0) {
        [MBProgressHUD showError:SSKJLocalized(@"请再次输入新登录密码", nil)];
        return;
    }
    
    if (![self.surePwdView.valueString isEqualToString:self.pwdView.valueString]) {
        [MBProgressHUD showError:SSKJLocalized(@"两次输入密码不一致", nil)];
        return;
    }
    
    if (![RegularExpression validatePassword:self.oldPwdView.valueString] || ![RegularExpression validatePassword:self.pwdView.valueString] || ![RegularExpression validatePassword:self.surePwdView.valueString]) {
        [MBProgressHUD showError:SSKJLocalized(@"密码提示", nil)];
        return;
    }
    [self requestResetPWD];
}




/**
 重置密码
 */
- (void)requestResetPWD {

    WS(weakSelf);
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSString *Account=[[SSKJ_User_Tool sharedUserTool] getAccount];
    
    params[@"mobile"] = kPhoneNumber;
    params[@"oldpwd"] = [WLTools md5:self.oldPwdView.valueString];
    params[@"opwd"] = [WLTools md5:self.pwdView.valueString];
    params[@"opwd1"] = [WLTools md5:self.surePwdView.valueString];
    params[@"account"] = Account;
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:JB_SetLoginPwdURL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        WL_Network_Model *network_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if ([network_model.status integerValue] == SUCCESSED) {
            [MBProgressHUD showError:network_model.msg];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"registerHiddenNotification" object:self];
            [SSKJ_User_Tool clearUserInfo];
            JB_Login_ViewController *vc = [[JB_Login_ViewController alloc]init];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }else{
            [MBProgressHUD showError:network_model.msg];
        }
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        //[MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
    }];

    
}


@end
