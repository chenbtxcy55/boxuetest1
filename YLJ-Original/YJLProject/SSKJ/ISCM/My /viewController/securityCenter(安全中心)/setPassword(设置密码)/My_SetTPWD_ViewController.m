//
//  My_SetTPWD_ViewController.m
//  ZYW_MIT
//
//  Created by 刘小雨 on 2019/4/1.
//  Copyright © 2019年 Wang. All rights reserved.
//

#import "My_SetTPWD_ViewController.h"
#import "My_TitleAndInput_View.h"
#import "RegularExpression.h"
#import "JB_Login_ViewController.h"
@interface My_SetTPWD_ViewController ()

@property (nonatomic, strong) My_TitleAndInput_View *oldPwdView;
@property (nonatomic, strong) My_TitleAndInput_View *pwdView;
@property (nonatomic, strong) My_TitleAndInput_View *surePwdView;

@property (nonatomic, strong) UILabel *phoneLabel;
@property (nonatomic, strong) UIView *codeBackView;
@property (nonatomic, strong) UITextField *codeTextField;
@property (nonatomic, strong) UIButton *smsCodeButton;

@property (nonatomic, strong) UIView *phoneView;

@property (nonatomic, strong) UIButton *submitButton;

@end

@implementation My_SetTPWD_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.title = SSKJLocalized(@"修改安全密码", nil);

    if ([SSKJ_User_Tool sharedUserTool].userInfoModel.tpwd == 0 ||
        [[SSKJ_User_Tool sharedUserTool].userInfoModel.tpwd isEqual:[NSNull null]] ||
        [SSKJ_User_Tool sharedUserTool].userInfoModel.tpwd.length == 0) {
        self.title = SSKJLocalized(@"设置安全密码", nil);
    }


    [self setUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = NO;
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}


#pragma mark - UI
-(void)setUI
{
    
    
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleW(5))];
    topView.backgroundColor = kMainColor;
    [self.view addSubview:topView];
    
    
    
    [self.view addSubview:self.oldPwdView];
    [self.view addSubview:self.pwdView];
    [self.view addSubview:self.surePwdView];
    
    [self.view addSubview:self.phoneView];
    [self.phoneView addSubview:self.phoneLabel];
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, self.phoneView.bottom-1, ScreenWidth, 1)];
    line.backgroundColor = kLineGrayColor;
    [self.view addSubview:line];
    
    [self.view addSubview:self.codeBackView];
    [self.codeBackView addSubview:self.codeTextField];
    [self.codeBackView addSubview:self.smsCodeButton];
    
    UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(0, self.codeBackView.bottom-1, ScreenWidth, 1)];
    line1.backgroundColor = kLineGrayColor;
    [self.view addSubview:line1];
    
    
    [self.view addSubview:self.submitButton];
}

-(My_TitleAndInput_View *)oldPwdView
{
    if (nil == _oldPwdView) {
        _oldPwdView = [[My_TitleAndInput_View alloc]initWithFrame:CGRectMake(0, ScaleW(5), ScreenWidth, ScaleW(95)) title:SSKJLocalized(@"原安全密码", nil) placeHolder:SSKJLocalized(@"请输入原安全密码", nil) keyBoardType:UIKeyboardTypeDefault];
        _oldPwdView.textField.secureTextEntry = YES;
        _oldPwdView.secureButton.hidden = NO;
    }
    return _oldPwdView;
}

-(My_TitleAndInput_View *)pwdView
{
    if (nil == _pwdView) {
        _pwdView = [[My_TitleAndInput_View alloc]initWithFrame:CGRectMake(0,self.oldPwdView.bottom, ScreenWidth, ScaleW(95)) title:SSKJLocalized(@"新安全密码", nil) placeHolder:SSKJLocalized(@"请输入6-20位字母与数字组合", nil) keyBoardType:UIKeyboardTypeDefault];
        _pwdView.textField.secureTextEntry = YES;
        _pwdView.secureButton.hidden = NO;
    }
    return _pwdView;
}

-(My_TitleAndInput_View *)surePwdView
{
    if (nil == _surePwdView) {
        _surePwdView = [[My_TitleAndInput_View alloc]initWithFrame:CGRectMake(0, self.pwdView.bottom, ScreenWidth, ScaleW(95)) title:SSKJLocalized(@"确认安全密码", nil) placeHolder:SSKJLocalized(@"确认安全密码", nil) keyBoardType:UIKeyboardTypeDefault];
        _surePwdView.textField.secureTextEntry = YES;
        _surePwdView.secureButton.hidden = NO;
    }
    return _surePwdView;
}


-(UIButton *)submitButton
{
    if (nil == _submitButton) {
        _submitButton = [[UIButton alloc]initWithFrame:CGRectMake(ScaleW(25), self.codeBackView.bottom + ScaleW(45), ScreenWidth - ScaleW(50), ScaleW(45))];
        _submitButton.layer.cornerRadius = _submitButton.height / 2;
        [_submitButton setTitle:SSKJLocalized(@"提交", nil) forState:UIControlStateNormal];
        [_submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _submitButton.titleLabel.font = systemFont(ScaleW(16));
        [_submitButton addTarget:self action:@selector(submitEvent) forControlEvents:UIControlEventTouchUpInside];
        //        [_submitButton addGradientColor];
        _submitButton.backgroundColor = kMainBlueColor;
//        [_submitButton setBackgroundImage:[UIImage imageNamed:@"login_Btn_bg"] forState:UIControlStateNormal];
//        [_submitButton setBackgroundImage:[UIImage imageNamed:@"login_Btn_bg"] forState:UIControlStateHighlighted];
        _submitButton.backgroundColor = kTheMeColor;
        _submitButton.layer.masksToBounds = YES;
        _submitButton.layer.cornerRadius = ScaleW(5);
    }
    return _submitButton;
}

//- (ZSJGradientBtnView *)submitButton{
//    if (_submitButton == nil) {
//        _submitButton = [[ZSJGradientBtnView alloc] initWithFrame:CGRectMake(ScaleW(25), self.codeBackView.bottom + ScaleW(45), ScreenWidth - ScaleW(50), ScaleW(45))];
//        _submitButton.layer.masksToBounds = YES;
//        _submitButton.layer.cornerRadius = ScaleW(5);
//        _submitButton.titleLab.font = systemFont(17);
//        _submitButton.titleLab.text = SSKJLocalized(@"提交", nil);
//        WS(weakSelf);
//        _submitButton.confirmBlock = ^{
//            [weakSelf submitEvent];
//        };
//    }
//    return _submitButton;
//}



- (UIView *)phoneView {
    if (!_phoneView) {
        _phoneView = [[UIView alloc]initWithFrame:CGRectMake(0,  _surePwdView.bottom, ScreenWidth, ScaleW(55))];
        _phoneView.backgroundColor = kNavBGColor;
    }
    return _phoneView;
}

-(UILabel *)phoneLabel
{
    
    if (nil == _phoneLabel) {
        NSString *string;
        
        string = [NSString stringWithFormat:@"%@：%@",SSKJLocalized(@"邮箱地址", nil),[self setupTitle:[SSKJ_User_Tool sharedUserTool].userInfoModel.email]];
        
        
        _phoneLabel = [WLTools allocLabel:string font:systemFont(ScaleW(17)) textColor:kMainWihteColor frame:CGRectMake(ScaleW(15), 0 , ScreenWidth - ScaleW(30), self.phoneView.height) textAlignment:NSTextAlignmentLeft];
        //        _phoneLabel.backgroundColor = kSubBackgroundColor;
    }
    return _phoneLabel;
}


- (NSString *)setupTitle:(NSString *)title {
    if (title.length < 1) {
        return @"";
    }
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


-(UIView *)codeBackView
{
    if (nil == _codeBackView) {
        _codeBackView = [[UIView alloc]initWithFrame:CGRectMake(0, self.phoneView.bottom, ScreenWidth, ScaleW(55))];
        _codeBackView.backgroundColor = kNavBGColor;
    }
    return _codeBackView;
}

-(UITextField *)codeTextField
{
    if (nil == _codeTextField) {
        _codeTextField = [[UITextField alloc]initWithFrame:CGRectMake(ScaleW(15), 0, ScaleW(200), ScaleW(55))];
        _codeTextField.textColor = kMainWihteColor;
        _codeTextField.placeholder = SSKJLocalized(@"请输入邮箱验证码", nil);
        //        [_codeTextField setValue:kTitleGrayColor forKeyPath:@"_placeholderLabel.textColor"];
        
        NSMutableAttributedString *placeholderString = [[NSMutableAttributedString alloc] initWithString:SSKJLocalized(@"请输入邮箱验证码", nil) attributes:@{NSForegroundColorAttributeName : kSubTxtColor}];
        
        self.codeTextField.attributedPlaceholder = placeholderString;
        
        _codeTextField.font = systemFont(ScaleW(14));
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
        _smsCodeButton.layer.cornerRadius = ScaleW(5);
        _smsCodeButton.layer.borderColor = CodeBtnColor.CGColor;
        _smsCodeButton.layer.borderWidth = 1;
        [_smsCodeButton addTarget:self action:@selector(getSmsCodeEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _smsCodeButton;
}
// 倒计时
-(void)countDown
{
    [WLTools countDownWithButton:self.smsCodeButton];
}

-(void)getSmsCodeEvent
{
    
    NSString * mobileStr =  [SSKJ_User_Tool sharedUserTool].userInfoModel.email;
    
    if (mobileStr.length==0 /*&& ![RegularExpression validateEmail:self.accountView.valueString]*/) {
        return;
    }
    [self requestSmsCode];
    
}
#pragma mark - 请求手机验证码

-(void)requestSmsCode
{
    
    NSDictionary *params = @{
                             @"email":[SSKJ_User_Tool sharedUserTool].userInfoModel.email,
                             @"type":@"4"/*,
                                          @"validate":self.verCodeString*/
                             };
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    WS(weakSelf);
    [[WLHttpManager shareManager]requestWithURL:JB_GetEmailCode_URL RequestType:RequestTypePost Parameters:params Success:^(id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        WL_Network_Model *network_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if ([network_model.status integerValue] == SUCCESSED) {
            [weakSelf countDown];
        }else{
            [MBProgressHUD showError:network_model.msg];
        }
        
    } Failure:^(NSError *error, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        //[MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
    }];
}

#pragma mark - 用户操作

-(void)submitEvent
{
    
    
    
    if (self.oldPwdView.valueString.length == 0) {
        [MBProgressHUD showError:SSKJLocalized(@"请输入原安全密码", nil)];
        return;
    }
    
    if (self.pwdView.valueString.length == 0) {
        [MBProgressHUD showError:SSKJLocalized(@"请输入新安全密码", nil)];
        return;
    }
    
    if (self.surePwdView.valueString.length == 0) {
        [MBProgressHUD showError:SSKJLocalized(@"请再次输入新安全密码", nil)];
        return;
    }
    
    if (![self.surePwdView.valueString isEqualToString:self.pwdView.valueString]) {
        [MBProgressHUD showError:SSKJLocalized(@"两次输入密码不一致", nil)];
        return;
    }
    
    if (![RegularExpression validatePassword:self.oldPwdView.valueString] || ![RegularExpression validatePassword:self.pwdView.valueString] || ![RegularExpression validatePassword:self.surePwdView.valueString]) {
        [MBProgressHUD showError:SSKJLocalized(@"请校验密码长度，8-20位数字字母组合", nil)];
        return;
    }
    if (self.codeTextField.text.length == 0) {
        [MBProgressHUD showError:SSKJLocalized(@"请输入邮箱验证码", nil)];
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
    
    
    params[@"oldtpwd"] = [WLTools md5:self.oldPwdView.valueString];
    params[@"tpwd"] = [WLTools md5:self.pwdView.valueString];
    params[@"tpwd1"] = [WLTools md5:self.surePwdView.valueString];
    
    params[@"code"] = self.codeTextField.text;
    
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:JB_SetPayPwdURL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
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
