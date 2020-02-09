//
//  ZSJ_BindPhone_ViewController.m
//  SSKJ
//
//  Created by zhao on 2019/10/7.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "ZSJ_BindPhone_ViewController.h"
#import "My_TitleAndInput_View.h"

@interface ZSJ_BindPhone_ViewController ()
@property (nonatomic, strong) My_TitleAndInput_View *phoneView;
@property (nonatomic, strong) My_TitleAndInput_View *pwView;

@property (nonatomic, strong) UILabel *codeTitle;
@property (nonatomic, strong) UIView *codeBackView;
@property (nonatomic, strong) UITextField *codeTextField;
@property (nonatomic, strong) UIButton *smsCodeButton;

@property (nonatomic, strong) UIButton *submitButton;
@end
@implementation ZSJ_BindPhone_ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self setUI];
    self.view.backgroundColor = kNavBGColor;
    self.title = SSKJLocalized(@"绑定邮箱账户", nil);
    self.phoneView.textField.keyboardType = UIKeyboardTypeDefault;
    
}
#pragma mark - UI

-(void)setUI
{
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleW(5))];
    topView.backgroundColor = kMainColor;
    [self.view addSubview:topView];
    
    
    [self.view addSubview:self.phoneView];
    [self.view addSubview:self.codeBackView];
    [self.codeBackView addSubview:self.codeTitle];
    [self.codeBackView addSubview:self.codeTextField];
    [self.codeBackView addSubview:self.smsCodeButton];
    [self.view addSubview:self.pwView];
    [self.view addSubview:self.submitButton];
}

-(My_TitleAndInput_View *)phoneView
{
    if (nil == _phoneView) {
        
        NSString *title;
        NSString *placeHolder;
        
            title = SSKJLocalized(@"邮箱地址", nil);
            placeHolder = SSKJLocalized(@"请输入您的邮箱地址", nil);
        
        
        _phoneView = [[My_TitleAndInput_View alloc]initWithFrame:CGRectMake(0, ScaleW(5), ScreenWidth, ScaleW(88)) title:title placeHolder:placeHolder keyBoardType:UIKeyboardTypeNumberPad];
    }
    return _phoneView;
    
}
-(My_TitleAndInput_View *)pwView
{
    if (nil == _pwView) {
        
        NSString *title;
        NSString *placeHolder;
        
        title = SSKJLocalized(@"安全密码", nil);
        placeHolder = SSKJLocalized(@"请输入安全密码", nil);
        
        
        _pwView = [[My_TitleAndInput_View alloc]initWithFrame:CGRectMake(0, _codeBackView.bottom, ScreenWidth, ScaleW(88)) title:title placeHolder:placeHolder keyBoardType:UIKeyboardTypeDefault];
        _pwView.textField.secureTextEntry = YES;
    }
    return _pwView;
    
}
-(UIView *)codeBackView
{
    if (nil == _codeBackView) {
        _codeBackView =[[UIView alloc]initWithFrame:CGRectMake(0, self.phoneView.bottom, ScreenWidth, ScaleW(88))];
        _codeBackView.backgroundColor = kNavBGColor;
    }
    return _codeBackView;
}

- (UILabel *)codeTitle{
    if (_codeTitle == nil) {
        _codeTitle = [FactoryUI createLabelWithFrame:CGRectMake(ScaleW(12), ScaleW(20), ScreenWidth - ScaleW(24), ScaleW(15)) text:SSKJLocalized(@"验证码", nil) textColor:kMainWihteColor font:systemFont(16)];
    }
    return _codeTitle;
}

-(UITextField *)codeTextField
{
    if (nil == _codeTextField) {
        _codeTextField = [[UITextField alloc]initWithFrame:CGRectMake(ScaleW(12), self.codeTitle.bottom + ScaleW(10), ScaleW(200), ScaleW(40))];
        _codeTextField.textColor = kMainWihteColor;
        _codeTextField.font = systemFont(ScaleW(16));
        _codeTextField.keyboardType = UIKeyboardTypeASCIICapable;
        NSMutableAttributedString *placeholderString1 = [[NSMutableAttributedString alloc] initWithString: SSKJLocalized(@"请输入验证码", nil) attributes:@{NSForegroundColorAttributeName : UIColorFromRGB(0xb5b8c2)}];
        
        
        _codeTextField.attributedPlaceholder = placeholderString1;
        
//        _codeTextField.placeholder = SSKJLocalized(@"请输入验证码", nil);
//
//        [_codeTextField setValue:UIColorFromRGB(0xb5b8c2) forKeyPath:@"_placeholderLabel.textColor"];
    }
    return _codeTextField;
}


-(UIButton *)smsCodeButton
{
    if (nil == _smsCodeButton) {
        _smsCodeButton = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth - ScaleW(12) - ScaleW(100), 0, ScaleW(100), ScaleW(30))];
        _smsCodeButton.centerY = self.codeTextField.centerY;
        [_smsCodeButton setTitle:SSKJLocalized(@"获取验证码", nil) forState:UIControlStateNormal];
        [_smsCodeButton setTitleColor:CodeBtnColor forState:UIControlStateNormal];
        _smsCodeButton.titleLabel.font = systemFont(ScaleW(12.5));
        _smsCodeButton.layer.masksToBounds = YES;
        _smsCodeButton.layer.cornerRadius = _smsCodeButton.height / 2;
        _smsCodeButton.layer.borderColor = CodeBtnColor.CGColor;
        _smsCodeButton.layer.borderWidth = 1;
        [_smsCodeButton addTarget:self action:@selector(getSmsCodeEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _smsCodeButton;
}

-(UIButton *)submitButton
{
    if (nil == _submitButton) {
        _submitButton = [[UIButton alloc]initWithFrame:CGRectMake(ScaleW(12), _pwView.bottom + ScaleW(126), ScreenWidth - ScaleW(24), ScaleW(45))];
        _submitButton.layer.cornerRadius = 4.0f;
        [_submitButton setTitle:SSKJLocalized(@"绑定", nil)  forState:UIControlStateNormal];
        [_submitButton setTitleColor:kMainWihteColor forState:UIControlStateNormal];
        _submitButton.titleLabel.font = systemFont(ScaleW(16));
        [_submitButton addTarget:self action:@selector(submitEvent) forControlEvents:UIControlEventTouchUpInside];
//        [_submitButton setBackgroundImage:[UIImage imageNamed:@"login_Btn_bg"] forState:UIControlStateNormal];
//        [_submitButton setBackgroundImage:[UIImage imageNamed:@"login_Btn_bg"] forState:UIControlStateHighlighted];
        _submitButton.backgroundColor = kTheMeColor;
    }
    return _submitButton;
}

#pragma mark - 用户操作
-(void)getSmsCodeEvent
{
    
    
    if (self.phoneView.valueString.length == 0) {
        [MBProgressHUD showError:SSKJLocalized(@"请输入邮箱地址", nil)];
        return;
    }
    if (![RegularExpression validateEmail:self.phoneView.valueString]) {
        [MBProgressHUD showError:SSKJLocalized(@"请输入正确的邮箱地址", nil)];
        return;
    }
    
    [self requestEmailCode];
    
    
    
}

#pragma mark - 提交

-(void)submitEvent
{
    
    if (self.phoneView.valueString.length == 0) {
        [MBProgressHUD showError:SSKJLocalized(@"请输入邮箱地址", nil)];
        return;
    }
    
    if (![RegularExpression validateEmail:self.phoneView.valueString]) {
        [MBProgressHUD showError:SSKJLocalized(@"请输入正确的邮箱地址", nil)];
        return;
    }
    
    if (self.codeTextField.text.length == 0) {
        [MBProgressHUD showError:SSKJLocalized(@"请输入邮箱验证码", nil)];
        return;
    }
    if (self.pwView.valueString.length == 0) {
        [MBProgressHUD showError:SSKJLocalized(@"请输入安全密码", nil)];
        return;
    }
    [self requestBindEmail];
    
    
}

// 倒计时
- (void)changeCheckcodeButtonState {
    __block int timeout= 59; //倒计时时间
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
        
        if(timeout<=0){ //倒计时结束，关闭
            
            dispatch_source_cancel(_timer);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self.smsCodeButton setTitle:SSKJLocalized(@"重新发送", nil) forState:UIControlStateNormal];
                self.smsCodeButton.enabled = YES;
                
            });
            
        }else{
            
            int seconds = timeout % 60;
            
            NSString *strTime = [NSString stringWithFormat:SSKJLocalized(@"%ld秒后重新发送", nil), seconds];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self.smsCodeButton setTitle:[NSString stringWithFormat:@"%@",strTime] forState:UIControlStateDisabled];
                self.smsCodeButton.enabled = NO;
                
            });
            
            timeout--;
            
        }
        
    });
    
    dispatch_resume(_timer);
}

#pragma mark - 网络请求
#pragma mark - 获取邮箱验证码

-(void)requestEmailCode
{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"email"] = self.phoneView.valueString;
    params[@"type"] = @"1";
//    1 忘记密码，绑定邮箱 2（重置/修改）密码 3 安全验证 4 安全密码重置/修改 5 提币
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    WS(weakSelf);
    [[WLHttpManager shareManager]requestWithURL:JB_GetEmailCode_URL RequestType:RequestTypePost Parameters:params Success:^(id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        WL_Network_Model *network_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if ([network_model.status integerValue] == SUCCESSED) {
            [MBProgressHUD showError:network_model.msg];
            [weakSelf changeCheckcodeButtonState];
        }else{
            [MBProgressHUD showError:network_model.msg];
        }
        
    } Failure:^(NSError *error, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        //[MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
    }];
}






#pragma mark - 绑定邮箱请求
- (void)requestBindEmail {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"email"] = self.phoneView.valueString;
    params[@"code"] = self.codeTextField.text;
    params[@"tpwd"] = [WLTools md5num5:self.pwView.valueString];

    //    1 忘记密码，绑定邮箱 2（重置/修改）密码 3 安全验证 4 安全密码重置/修改 5 提币
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    WS(weakSelf);
    
    
    
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:JB_Bind_Email_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        WL_Network_Model *network_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if ([network_model.status integerValue] == SUCCESSED) {
            [MBProgressHUD showError:network_model.msg];
            [weakSelf.navigationController popViewControllerAnimated:true];
            [SSKJ_User_Tool sharedUserTool].userInfoModel.email = weakSelf.phoneView.valueString;
        }else{
            [MBProgressHUD showError:network_model.msg];
        }
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        [MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
    }];
    
}

@end
