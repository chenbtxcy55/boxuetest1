//
//  My_BindPhone_ViewController.m
//  ZYW_MIT
//
//  Created by 刘小雨 on 2019/3/28.
//  Copyright © 2019年 Wang. All rights reserved.
//

#import "My_BindPhone_ViewController.h"
#import "RegularExpression.h"
@interface My_BindPhone_ViewController ()


@property (nonatomic, strong) UIView *accountBackView;
@property (nonatomic, strong) UITextField *accountTextField;

@property (nonatomic, strong) UIView *codeBackView;
@property (nonatomic, strong) UITextField *codeTextField;
@property (nonatomic, strong) UIButton *smsCodeButton;


@property (nonatomic, strong) UIView *pwdBackView;
@property (nonatomic, strong) UITextField *pwdTextField;

@property (nonatomic, strong) UIButton *submitButton;
@end


@implementation My_BindPhone_ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    
    self.view.backgroundColor = kMainBackgroundColor;
    
    [self setUI];
    
    if (self.bindType == BindTypePhone) {
        self.title = SSKJLocalized(@"绑定手机", nil);
        self.accountTextField.keyboardType = UIKeyboardTypeNumberPad;
    }else{
        self.title = SSKJLocalized(@"绑定邮箱账户", nil);
        self.accountTextField.keyboardType = UIKeyboardTypeDefault;
    }
}

#pragma mark - UI

-(void)setUI
{
    [self.view addSubview:self.accountBackView];
    [self.accountBackView addSubview:self.accountTextField];
    
    UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(17), ScaleW(54), ScreenWidth, ScaleW(1))];
    line1.backgroundColor = kLineGrayColor;
    [self.accountBackView addSubview:line1];
    
    [self.view addSubview:self.codeBackView];
    [self.codeBackView addSubview:self.codeTextField];
    [self.codeBackView addSubview:self.smsCodeButton];
    
    UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(17), ScaleW(54), ScreenWidth, ScaleW(1))];
    line2.backgroundColor = kLineGrayColor;
    [self.codeBackView addSubview:line2];
    
    [self.view addSubview:self.pwdBackView];
    [self.pwdBackView addSubview:self.pwdTextField];
    
    
    [self.view addSubview:self.submitButton];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.translucent = YES;
}

-(UIView *)accountBackView
{
    if (nil == _accountBackView) {
        _accountBackView =[[UIView alloc]initWithFrame:CGRectMake(0, ScaleW(12), ScreenWidth, ScaleW(55))];
        _accountBackView.backgroundColor = kSubBackgroundColor;
       
    }
    return _accountBackView;
}

-(UITextField *)accountTextField
{
    if (nil == _accountTextField) {
        _accountTextField = [[UITextField alloc]initWithFrame:CGRectMake(ScaleW(17), 0, ScaleW(200), self.codeBackView.height)];
        _accountTextField.textColor = kMainWihteColor;
        _accountTextField.font = systemFont(ScaleW(15));
        
        NSString *string = SSKJLocalized(@"请输入邮箱地址", nil);
        if (self.bindType == BindTypePhone) {
            string = SSKJLocalized(@"请输入手机号码", nil);
        }
        _accountTextField.placeholder = string;
        _accountTextField.keyboardType = UIKeyboardTypeASCIICapable;
//        [_accountTextField setValue:kTextLightBlueColor forKeyPath:@"_placeholderLabel.textColor"];
        NSMutableAttributedString *placeholderString1 = [[NSMutableAttributedString alloc] initWithString: string attributes:@{NSForegroundColorAttributeName : kTextLightBlueColor}];
        
        _accountTextField.attributedPlaceholder = placeholderString1;
        
    }
    return _accountTextField;
}



-(UIView *)codeBackView
{
    if (nil == _codeBackView) {
        _codeBackView =[[UIView alloc]initWithFrame:CGRectMake(0, self.accountBackView.bottom, ScreenWidth, ScaleW(55))];
        _codeBackView.backgroundColor = kSubBackgroundColor;
    }
    return _codeBackView;
}

-(UITextField *)codeTextField
{
    if (nil == _codeTextField) {
        _codeTextField = [[UITextField alloc]initWithFrame:CGRectMake(ScaleW(17), 0, ScaleW(200), self.codeBackView.height)];
        _codeTextField.textColor = kMainWihteColor;
        _codeTextField.font = systemFont(ScaleW(15));
        
        NSString *string = SSKJLocalized(@"请输入邮箱验证码", nil);
        if (self.bindType == BindTypePhone) {
            string = SSKJLocalized(@"请输入手机验证码", nil);
        }
        _codeTextField.placeholder = string;
        _codeTextField.keyboardType = UIKeyboardTypeASCIICapable;
//        [_codeTextField setValue:kTextLightBlueColor forKeyPath:@"_placeholderLabel.textColor"];
        
        NSMutableAttributedString *placeholderString1 = [[NSMutableAttributedString alloc] initWithString: string attributes:@{NSForegroundColorAttributeName : kTextLightBlueColor}];
        
        _codeTextField.attributedPlaceholder = placeholderString1;
    }
    return _codeTextField;
}


-(UIButton *)smsCodeButton
{
    if (nil == _smsCodeButton) {
        _smsCodeButton = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth - ScaleW(12) - ScaleW(100), 0, ScaleW(100), ScaleW(30))];
        _smsCodeButton.centerY = self.codeTextField.centerY;
        [_smsCodeButton setTitle:SSKJLocalized(@"获取验证码", nil) forState:UIControlStateNormal];
        _smsCodeButton.backgroundColor = kMainTextColor;
        [_smsCodeButton setTitleColor:kMainTextColor forState:UIControlStateNormal];
        _smsCodeButton.titleLabel.font = systemFont(ScaleW(12.5));
        _smsCodeButton.layer.masksToBounds = YES;
        _smsCodeButton.layer.cornerRadius = _smsCodeButton.height / 2;
//        _smsCodeButton.layer.borderColor = kBGBlueColor.CGColor;
//        _smsCodeButton.layer.borderWidth = 1;
        [_smsCodeButton addTarget:self action:@selector(getSmsCodeEvent) forControlEvents:UIControlEventTouchUpInside];
        [_smsCodeButton addGradientColor];
    }
    return _smsCodeButton;
}


-(UIView *)pwdBackView
{
    if (nil == _pwdBackView) {
        _pwdBackView =[[UIView alloc]initWithFrame:CGRectMake(0, self.codeBackView.bottom, ScreenWidth, ScaleW(55))];
        _pwdBackView.backgroundColor = kSubBackgroundColor;
    }
    return _pwdBackView;
}

-(UITextField *)pwdTextField
{
    if (nil == _pwdTextField) {
        _pwdTextField = [[UITextField alloc]initWithFrame:CGRectMake(ScaleW(17), 0, ScaleW(250), self.codeBackView.height)];
        _pwdTextField.textColor = kMainWihteColor;
        _pwdTextField.font = systemFont(ScaleW(15));
        _pwdTextField.placeholder = SSKJLocalized(@"请输入安全密码", nil);
        _pwdTextField.keyboardType = UIKeyboardTypeASCIICapable;
//        [_pwdTextField setValue:kTextLightBlueColor forKeyPath:@"_placeholderLabel.textColor"];
        
        NSMutableAttributedString *placeholderString1 = [[NSMutableAttributedString alloc] initWithString: SSKJLocalized(@"请输入安全密码", nil) attributes:@{NSForegroundColorAttributeName : kTextLightBlueColor}];
        
        
        _pwdTextField.attributedPlaceholder = placeholderString1;

        _pwdTextField.secureTextEntry = YES;
    }
    return _pwdTextField;
}

-(UIButton *)submitButton
{
    if (nil == _submitButton) {
        _submitButton = [[UIButton alloc]initWithFrame:CGRectMake(ScaleW(25), self.pwdBackView.bottom + ScaleW(45), ScreenWidth - ScaleW(25*2), ScaleW(45))];
        _submitButton.layer.cornerRadius = _submitButton.height / 2;
        _submitButton.backgroundColor = kMainTextColor;
        [_submitButton setTitle:SSKJLocalized(@"确定", nil)  forState:UIControlStateNormal];
        [_submitButton setTitleColor:kMainTextColor forState:UIControlStateNormal];
        _submitButton.titleLabel.font = systemFont(ScaleW(16));
        [_submitButton addTarget:self action:@selector(submitEvent) forControlEvents:UIControlEventTouchUpInside];
        [_submitButton addGradientColor];
        _submitButton.layer.cornerRadius = ScaleW(5);
        _submitButton.layer.masksToBounds = YES;
    }
    return _submitButton;
}

#pragma mark - 用户操作
-(void)getSmsCodeEvent
{

    if (self.bindType == BindTypePhone) {
        if (self.accountTextField.text.length == 0) {
            [MBProgressHUD showError:SSKJLocalized(@"请输入手机号码", nil)];
            return;
        }
        if (self.accountTextField.text.length != 11) {
            [MBProgressHUD showError:SSKJLocalized(@"请输入正确的手机号码", nil)];
            return;
        }
        
        [self requestSmsCode];

    }else{
        if (self.accountTextField.text.length == 0) {
            [MBProgressHUD showError:SSKJLocalized(@"请输入邮箱地址", nil)];
            return;
        }
        if (![RegularExpression validateEmail:self.accountTextField.text]) {
            [MBProgressHUD showError:SSKJLocalized(@"请输入正确的邮箱地址", nil)];
            return;
        }
        
        [self requestEmailCode];
    }
    
    
}

#pragma mark - 提交

-(void)submitEvent
{
    if (self.bindType == BindTypePhone) {

        if (self.accountTextField.text.length == 0) {
            [MBProgressHUD showError:SSKJLocalized(@"请输入手机号码", nil)];
            return;
        }
        
        if (self.accountTextField.text.length != 11) {
            [MBProgressHUD showError:SSKJLocalized(@"请输入正确的手机号码", nil)];
            return;
        }
        
        if (self.codeTextField.text.length == 0) {
            [MBProgressHUD showError:SSKJLocalized(@"请输入手机验证码", nil)];
            return;
        }
        
        if (self.pwdTextField.text.length == 0) {
            [MBProgressHUD showError:SSKJLocalized(@"请输入安全密码", nil)];
            return;
        }
        
        [self requestBindPhoneNumber];

    }else{
        if (self.accountTextField.text.length == 0) {
            [MBProgressHUD showError:SSKJLocalized(@"请输入邮箱地址", nil)];
            return;
        }
        
        if (![RegularExpression validateEmail:self.accountTextField.text]) {
            [MBProgressHUD showError:SSKJLocalized(@"请输入正确的邮箱地址", nil)];
            return;
        }
        
        if (self.codeTextField.text.length == 0) {
            [MBProgressHUD showError:SSKJLocalized(@"请输入邮箱验证码", nil)];
            return;
        }
        if (self.pwdTextField.text.length == 0) {
            [MBProgressHUD showError:SSKJLocalized(@"请输入安全密码", nil)];
            return;
        }
        [self requestBindEmail];

    }
    
}

// 倒计时
- (void)changeCheckcodeButtonState {
    self.smsCodeButton.enabled = NO;
    __block int timeout=60; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    
    dispatch_source_set_timer(timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    WS(weakSelf);
    dispatch_source_set_event_handler(timer, ^{
        
        if(timeout<=0){ //倒计时结束，关闭
            
            dispatch_source_cancel(timer);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置界面的按钮显示 根据自己需求设置
                
                [weakSelf.smsCodeButton setTitle:SSKJLocalized(@"重新发送", nil) forState:UIControlStateNormal];
                
                weakSelf.smsCodeButton.enabled = YES;
                
            });
            
        }else{
            int seconds = timeout % 61;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [weakSelf.smsCodeButton setTitle:[NSString stringWithFormat:@"%@s%@",strTime,SSKJLocalized(@"重新获取", nil)] forState:UIControlStateDisabled];
                
                //标记第一次点击的时候，当在此启用倒计时的时候 可点击
                
                // sender.userInteractionEnabled =!_isGetPawd;
                
            });
            timeout--;
        }
    });
    dispatch_resume(timer);
}

#pragma mark - 网络请求
#pragma mark - 请求手机验证码

-(void)requestSmsCode
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"mobile"] = self.accountTextField.text;
    params[@"type"] = @"3";
    WS(weakSelf);
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:JB_GetSMSCode_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        WL_Network_Model *network_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if ([network_model.status integerValue] == SUCCESSED) {
            [MBProgressHUD showError:network_model.msg];
            [weakSelf changeCheckcodeButtonState];
        }else{
            [MBProgressHUD showError:network_model.msg];
        }
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        //[MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
    }];
}

#pragma mark - 获取邮箱验证码
- (void)requestEmailCode{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"email"] = self.accountTextField.text;
    
    WS(weakSelf);
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:JB_GetEmailCode_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        WL_Network_Model *network_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if ([network_model.status integerValue] == SUCCESSED) {
            [MBProgressHUD showError:network_model.msg];
            [weakSelf changeCheckcodeButtonState];
        }else{
            [MBProgressHUD showError:network_model.msg];
        }
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        //[MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
    }];
}

#pragma mark - 绑定手机号请求
-(void)requestBindPhoneNumber
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"mobile"] = self.accountTextField.text;
    params[@"code"] = self.codeTextField.text;
    params[@"tpwd"] = self.pwdTextField.text;

    WS(weakSelf);
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:JB_Bind_Mobile_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        WL_Network_Model *network_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if ([network_model.status integerValue] == SUCCESSED) {
            [MBProgressHUD showError:network_model.msg];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [MBProgressHUD showError:network_model.msg];
        }
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        //[MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
    }];

}


#pragma mark - 绑定邮箱请求
- (void)requestBindEmail {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"email"] = self.accountTextField.text;
    params[@"code"] = self.codeTextField.text;
    params[@"tpwd"] = [WLTools md5:self.pwdTextField.text?:@""];

    WS(weakSelf);
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:JB_Bind_Email_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        WL_Network_Model *network_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if ([network_model.status integerValue] == SUCCESSED) {
            [MBProgressHUD showError:network_model.msg];
            dispatch_async(dispatch_get_main_queue(), ^{
                weakSelf.successBlock(weakSelf.accountTextField.text);
                [weakSelf.navigationController popViewControllerAnimated:YES];
            });
        }else{
            [MBProgressHUD showError:network_model.msg];
        }
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        //[MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
    }];
}

@end



