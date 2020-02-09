//
//  JB_Register_ViewController.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/5/10.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "JB_Register_ViewController.h"
#import "ISCMProtocolViewController.h"

#import "YLJ_InputView.h"

// controller
#import "JB_WebView_Controller.h"

// tools
#import "RegularExpression.h"
#import "GlobalProtocolViewController.h"


@interface JB_Register_ViewController ()
<UITextFieldDelegate>
@property (nonatomic, strong) UIScrollView *mainScrollView;
@property (nonatomic, strong) UIButton *backButton;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic,strong) UIImageView *logoImgView;

@property (nonatomic, strong) UILabel *wellcomeLabel;
@property (nonatomic, strong) UIButton *loginBtn;
@property (nonatomic, strong) YLJ_InputView *accountView;
@property (nonatomic, strong) YLJ_InputView *phoneView;

@property (nonatomic, strong) YLJ_InputView *imgVerCodeView;

//@property (nonatomic, strong) UIImageView *codeImg;


@property (nonatomic, strong) YLJ_InputView *smsCodeView;
@property (nonatomic, strong) UIButton *getSMSCodeButton;
@property (nonatomic, strong) YLJ_InputView *pwdView;
@property (nonatomic, strong) YLJ_InputView *surePwdView;

//@property (nonatomic, strong) YLJ_InputView *tpwdView;
//@property (nonatomic, strong) YLJ_InputView *sureTpwdView;

@property (nonatomic, strong) YLJ_InputView *invicateView;





@property (nonatomic, strong) UIButton *accepetBtn;

@property (nonatomic, strong) UILabel *accepetMessage;

@property (nonatomic, strong) UIButton *gotoWebBtn;

@property (nonatomic, strong) UIButton *registerButton;


@property (nonatomic, strong) NSString *verCodeString;

@end

@implementation JB_Register_ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUI];
    
   
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
}

#pragma mark - UI

-(void)setUI
{
    [self.view addSubview:self.mainScrollView];
    [self.mainScrollView addSubview:self.backButton];
    
    [self.mainScrollView addSubview:self.titleLabel];
    [self.mainScrollView addSubview:self.logoImgView];
    [self.mainScrollView addSubview:self.accountView];
    [self.mainScrollView addSubview:self.phoneView];
    [self.mainScrollView addSubview:self.smsCodeView];
    [self.mainScrollView addSubview:self.getSMSCodeButton];
    [self.mainScrollView addSubview:self.pwdView];
    [self.mainScrollView addSubview:self.surePwdView];

    
    [self.mainScrollView addSubview:self.invicateView];
    [self.mainScrollView addSubview:self.accepetBtn];
    [self.mainScrollView addSubview:self.accepetMessage];
    [self.mainScrollView addSubview:self.gotoWebBtn];
  
    [self.mainScrollView addSubview:self.registerButton];
    [self.mainScrollView addSubview:self.wellcomeLabel];
    [self.mainScrollView addSubview:self.loginBtn];

    self.mainScrollView.contentSize = CGSizeMake(ScreenWidth, self.wellcomeLabel.bottom+ScaleW(40));
    
    self.view.backgroundColor = kMainColor;
}

- (UIScrollView *)mainScrollView {
    if (!_mainScrollView) {
        _mainScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        _mainScrollView.showsVerticalScrollIndicator = NO;
        _mainScrollView.showsHorizontalScrollIndicator = NO;
        _mainScrollView.contentSize = CGSizeMake(ScreenWidth, 0);
        if (@available(iOS 11.0, *)) {
            _mainScrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            // Fallback on earlier versions
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
    }
    return _mainScrollView;
}



-(UIButton *)backButton
{
    if (nil == _backButton) {
        _backButton = [[UIButton alloc]initWithFrame:CGRectMake(0, Height_StatusBar, ScaleW(44), ScaleW(48))];
        [_backButton setImage:[UIImage imageNamed:@"commentBlack"] forState:UIControlStateNormal];
        [_backButton addTarget:self action:@selector(backEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backButton;
}


-(UILabel *)titleLabel
{
    if (nil == _titleLabel) {
        _titleLabel = [WLTools allocLabel:SSKJLocalized(@"填写注册信息", nil) font:systemBoldFont(ScaleW(23)) textColor:kMainTextColor frame:CGRectMake(ScaleW(15), self.backButton.bottom +ScaleW(20), ScreenWidth - ScaleW(60), ScaleW(26)) textAlignment:NSTextAlignmentLeft];
        _titleLabel.hidden = YES;
    }
    return _titleLabel;
}

- (UIImageView *)logoImgView {
    if (!_logoImgView) {
        _logoImgView = [FactoryUI createImageViewWithFrame:CGRectMake(ScaleW(104), ScaleW(74), ScaleW(167), ScaleW(50)) imageName:@"img_logo"];
    }
    return _logoImgView;
}

-(UILabel *)wellcomeLabel
{
    if (nil == _wellcomeLabel) {
        
        NSString *text = SSKJLocalized(@"已有账号，立即 ", nil);
        
        _wellcomeLabel = [WLTools allocLabel:text font:systemFont(ScaleW(15)) textColor: kMainTextColor frame:CGRectMake(self.titleLabel.x, self.registerButton.bottom + ScaleW(40) , self.titleLabel.width, ScaleW(14)) textAlignment:NSTextAlignmentLeft];
        
        CGFloat width = [WLTools getWidthWithText:text font:_wellcomeLabel.font];
        _wellcomeLabel.width = width;
        _wellcomeLabel.hidden = YES;
    }
    return _wellcomeLabel;
}
-(UIButton *)loginBtn
{
    if (!_loginBtn) {
        _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        CGFloat width = [self.view returnWidth:SSKJLocalized(@"登录 >", nil) font:ScaleW(15)];
      _loginBtn.frame = CGRectMake(_wellcomeLabel.right , _wellcomeLabel.top, width + ScaleW(10), ScaleW(15));
        [_loginBtn btn:_loginBtn font:ScaleW(15) textColor:kGreenColor text:SSKJLocalized(@"登录 >", nil) image:nil sel:@selector(loginEvent) taget:self];
        _loginBtn.hidden = YES;
    }
    return _loginBtn;
}

- (YLJ_InputView *)accountView
{
    if (nil == _accountView) {
//        _accountView = [[AB_TitleTextInputView alloc]initWithFrame:CGRectMake(0, ScaleW(40) + _titleLabel.bottom, ScreenWidth, ScaleW(86)) leftGap:ScaleW(23) placeHolder:SSKJLocalized(@"请输入您的手机号", nil) font:systemFont(ScaleW(16)) keyBoardType:(UIKeyboardTypeNumberPad) titleText:SSKJLocalized(@"账号", nil) rightView:nil];
         _accountView = [[YLJ_InputView alloc] initWithFrame:CGRectMake(ScaleW(15), ScaleW(67) + _titleLabel.bottom, ScreenWidth-ScaleW(30), ScaleW(41)) titleWidth:ScaleW(95) gap:ScaleW(6)  titleName:SSKJLocalized(@"账 号", nil) placeHolder:SSKJLocalized(@"请输入用户名（不可包含特殊字符）", nil) keyboardType:UIKeyboardTypeDefault isSecured:NO];
        [_accountView.textField addTarget:self action:@selector(textFieldDidchange:) forControlEvents:UIControlEventEditingChanged];
        _accountView.textField.delegate = self;
    }
    return _accountView;
}

- (YLJ_InputView *)phoneView
{
    if (nil == _phoneView) {
        _phoneView = [[YLJ_InputView alloc] initWithFrame:CGRectMake(ScaleW(15),_accountView.bottom + ScaleW(20), ScreenWidth-ScaleW(30), ScaleW(41)) titleWidth:ScaleW(95) gap:ScaleW(6)  titleName:SSKJLocalized(@"账 号", nil) placeHolder:SSKJLocalized(@"请输入手机号", nil) keyboardType:UIKeyboardTypeNumberPad isSecured:NO];
    }
    return _phoneView;
}

- (YLJ_InputView *)smsCodeView {
    if (nil == _smsCodeView) {
        _smsCodeView = [[YLJ_InputView alloc] initWithFrame:CGRectMake(ScaleW(15),_phoneView.bottom + ScaleW(20), ScreenWidth-ScaleW(30), ScaleW(41)) titleWidth:ScaleW(95) gap:ScaleW(6)  titleName:SSKJLocalized(@"", nil) placeHolder:SSKJLocalized(@"请输入验证码", nil) keyboardType:UIKeyboardTypeNumberPad isSecured:NO];
    }
    return _smsCodeView;
}

-(UIButton *)getSMSCodeButton
{
    if (nil == _getSMSCodeButton) {
        _getSMSCodeButton = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth - ScaleW(134), 0, ScaleW(134), ScaleW(40))];
        _getSMSCodeButton.centerY = self.smsCodeView.centerY;
        [_getSMSCodeButton setTitle:SSKJLocalized(@"获取验证码", nil) forState:UIControlStateNormal];
        [_getSMSCodeButton setTitleColor:kTheMeColor forState:UIControlStateNormal];
        _getSMSCodeButton.titleLabel.font = systemFont(ScaleW(16));
        [_getSMSCodeButton addTarget:self action:@selector(getCode) forControlEvents:UIControlEventTouchUpInside];
    }
    return _getSMSCodeButton;
}


-(YLJ_InputView *)pwdView
{
    if (nil == _pwdView) {
//        _pwdView = [[AB_TitleTextInputView alloc]initWithFrame:CGRectMake(0, _smsCodeView.bottom, ScreenWidth, ScaleW(86)) leftGap:ScaleW(26) placeHolder:SSKJLocalized(@"请输入密码(8-20位数字+字母)", nil) font:systemFont(ScaleW(16)) keyBoardType:(UIKeyboardTypeDefault) titleText:SSKJLocalized(@"登录密码", nil)];
         _pwdView = [[YLJ_InputView alloc] initWithFrame:CGRectMake(ScaleW(15), ScaleW(20) + _smsCodeView.bottom, ScreenWidth-ScaleW(30), ScaleW(41)) titleWidth:ScaleW(95) gap:ScaleW(6)  titleName:SSKJLocalized(@"登录密码", nil) placeHolder:SSKJLocalized(@"请输入6-12位字母和数字密码", nil) keyboardType:UIKeyboardTypeDefault isSecured:YES];
    }
    return _pwdView;
}

-(YLJ_InputView *)surePwdView
{
    if (nil == _surePwdView) {
        //        _pwdView = [[AB_TitleTextInputView alloc]initWithFrame:CGRectMake(0, _smsCodeView.bottom, ScreenWidth, ScaleW(86)) leftGap:ScaleW(26) placeHolder:SSKJLocalized(@"请输入密码(8-20位数字+字母)", nil) font:systemFont(ScaleW(16)) keyBoardType:(UIKeyboardTypeDefault) titleText:SSKJLocalized(@"登录密码", nil)];
        _surePwdView = [[YLJ_InputView alloc] initWithFrame:CGRectMake(ScaleW(15), ScaleW(20) + _pwdView.bottom, ScreenWidth-ScaleW(30), ScaleW(41)) titleWidth:ScaleW(95) gap:ScaleW(6)  titleName:SSKJLocalized(@"确认登录密码", nil) placeHolder:SSKJLocalized(@"请再次确认密码", nil) keyboardType:UIKeyboardTypeDefault isSecured:YES];
    }
    return _surePwdView;
}

//-(YLJ_InputView *)tpwdView
//{
//    if (nil == _tpwdView) {
////        _tpwdView = [[AB_TitleTextInputView alloc]initWithFrame:CGRectMake(0, _pwdView.bottom, ScreenWidth, ScaleW(86)) leftGap:ScaleW(26) placeHolder:SSKJLocalized(@"请输入安全密码(8-20位数字+字母)", nil) font:systemFont(ScaleW(16)) keyBoardType:(UIKeyboardTypeDefault) titleText:SSKJLocalized(@"安全密码", nil)];
//         _tpwdView = [[YLJ_InputView alloc] initWithFrame:CGRectMake(ScaleW(15), ScaleW(20) + _surePwdView.bottom, ScreenWidth-ScaleW(30), ScaleW(41)) titleWidth:ScaleW(95) gap:ScaleW(6)  titleName:SSKJLocalized(@"安全密码", nil) placeHolder:SSKJLocalized(@"请输入6-12位字母和数字密码", nil) keyboardType:UIKeyboardTypeDefault isSecured:YES];
//    }
//    return _tpwdView;
//}
//
//-(YLJ_InputView *)sureTpwdView
//{
//    if (nil == _sureTpwdView) {
//        //        _tpwdView = [[AB_TitleTextInputView alloc]initWithFrame:CGRectMake(0, _pwdView.bottom, ScreenWidth, ScaleW(86)) leftGap:ScaleW(26) placeHolder:SSKJLocalized(@"请输入安全密码(8-20位数字+字母)", nil) font:systemFont(ScaleW(16)) keyBoardType:(UIKeyboardTypeDefault) titleText:SSKJLocalized(@"安全密码", nil)];
//        _sureTpwdView = [[YLJ_InputView alloc] initWithFrame:CGRectMake(ScaleW(15), ScaleW(20) + _tpwdView.bottom, ScreenWidth-ScaleW(30), ScaleW(41)) titleWidth:ScaleW(95) gap:ScaleW(6)  titleName:SSKJLocalized(@"确认安全密码", nil) placeHolder:SSKJLocalized(@"请输入6-12位字母和数字密码", nil) keyboardType:UIKeyboardTypeDefault isSecured:YES];
//    }
//    return _sureTpwdView;
//}

-(YLJ_InputView *)invicateView
{
    if (nil == _invicateView) {

        _invicateView = [[YLJ_InputView alloc] initWithFrame:CGRectMake(ScaleW(15), ScaleW(20) + _surePwdView.bottom, ScreenWidth-ScaleW(30), ScaleW(41)) titleWidth:ScaleW(95) gap:ScaleW(6)  titleName:SSKJLocalized(@"邀请码", nil) placeHolder:SSKJLocalized(@"请输入邀请码(必填)", nil) keyboardType:UIKeyboardTypeDefault isSecured:NO];
//        _invicateView.valueString = @"HiwRd6";
    }
    return _invicateView;
}

-(UIButton *)registerButton
{
    if (nil == _registerButton) {
        _registerButton = [[UIButton alloc]initWithFrame:CGRectMake(ScaleW(15), self.invicateView.bottom + ScaleW(83), ScreenWidth - ScaleW(30), ScaleW(45))];
        [_registerButton setTitle:SSKJLocalized(@"注册", nil) forState:UIControlStateNormal];
        [_registerButton setTitleColor:kMainWihteColor forState:UIControlStateNormal];
//        _registerButton.layer.masksToBounds = YES;
//        _registerButton.layer.cornerRadius = ScaleW(5.f);
        _registerButton.titleLabel.font = systemBoldFont(ScaleW(16));
//        [_registerButton setBackgroundImage:[UIImage imageNamed:@"login_Btn_bg"] forState:UIControlStateNormal];
//        [_registerButton setBackgroundImage:[UIImage imageNamed:@"login_Btn_bg"] forState:UIControlStateHighlighted];
        
        [_registerButton addTarget:self action:@selector(registerEvent) forControlEvents:UIControlEventTouchUpInside];
        [_registerButton setBackgroundColor:kTheMeColor];
        [_registerButton setCornerRadius:ScaleW(5)];
    }
    return _registerButton;
}


-(UIButton *)accepetBtn
{
    if (!_accepetBtn) {
        _accepetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _accepetBtn.frame = CGRectMake(ScaleW(25), ScaleW(20) + _invicateView.bottom, ScaleW(14), ScaleW(14));
        [_accepetBtn btn:_accepetBtn font:ScaleW(0) textColor:kTitleColor text:@"" image:[UIImage imageNamed:@"weixuanze"] sel:@selector(selectAction:) taget:self];
        //test
        [_accepetBtn setImage:[UIImage imageNamed:@"xuanze"] forState:(UIControlStateSelected)];
        //_accepetBtn.backgroundColor = kMainBlueColor;
    }
    return _accepetBtn;
}

-(UILabel *)accepetMessage
{
    if (!_accepetMessage) {
        CGFloat width = [self.view returnWidth:SSKJLocalized(@"我已阅读并同意", nil) font:ScaleW(14)];
        _accepetMessage = [WLTools allocLabel:SSKJLocalized(@"我已阅读并同意", nil) font:systemFont(ScaleW(14)) textColor:kSubTxtColor frame:CGRectMake(_accepetBtn.right + ScaleW(10), _accepetBtn.top, width + ScaleW(2), ScaleW(14)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _accepetMessage;
}

-(UIButton *)gotoWebBtn
{
    if (!_gotoWebBtn) {
        _gotoWebBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
           CGFloat width = [self.view returnWidth:SSKJLocalized(@"《用户服务协议》", nil) font:ScaleW(14)];
        _gotoWebBtn.frame = CGRectMake(_accepetMessage.right, _accepetMessage.top, width + ScaleW(10), ScaleW(14));
        [_gotoWebBtn btn:_gotoWebBtn font:ScaleW(14) textColor:kTheMeColor text:SSKJLocalized(@"《用户服务协议》", nil) image:nil sel:@selector(gotoWebBtnAction:) taget:self];
    }
    return _gotoWebBtn;
    
}

#pragma mark - 用户操作
-(void)selectAction:(UIButton *)sender
{
    sender.selected = !sender.selected;
}
-(void)gotoWebBtnAction:(UIButton *)sender
{
    GlobalProtocolViewController *gVC = [GlobalProtocolViewController new];
    gVC.type = 1;
    [self.navigationController pushViewController:gVC animated:YES];
}
-(void)backEvent
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)registerEvent
{
    

//    if (![RegularExpression deptNumInputShouldNumber:self.accountView.valueString]||self.accountView.valueString.length !=11 /*&& ![RegularExpression validateEmail:self.accountView.valueString]*/) {
//        [MBProgressHUD showError:SSKJLocalized(@"请输入11位数字作为您的账号", nil)];
//        return;
//    }
    
    if (self.self.accountView.valueString.length == 0) {
        [MBProgressHUD showError:SSKJLocalized(@"请输账户名", nil)];
        return;
    }
    if (![RegularExpression judgeAccount:self.accountView.valueString]) {
        [MBProgressHUD showError:SSKJLocalized(@"用户名不可包含特殊字符", nil)];
        return;
    }

    if (self.pwdView.valueString.length == 0) {
        [MBProgressHUD showError:SSKJLocalized(@"请输入登录密码", nil)];
        return;
    }
    

    if (self.surePwdView.valueString.length == 0) {
        [MBProgressHUD showError:SSKJLocalized(@"请输入确认登录密码", nil)];
        return;
    }
    
//    if (self.tpwdView.valueString.length == 0) {
//        [MBProgressHUD showError:SSKJLocalized(@"请输入安全密码", nil)];
//        return;
//    }
//
//
//    if (self.sureTpwdView.valueString.length == 0) {
//        [MBProgressHUD showError:SSKJLocalized(@"请输入确认安全密码", nil)];
//        return;
//    }
    
    if (self.invicateView.valueString.length == 0) {
        [MBProgressHUD showError:SSKJLocalized(@"请输入邀请码", nil)];
        return;
    }
    
   
    if (![self.pwdView.valueString isEqualToString:self.surePwdView.valueString]) {
        [MBProgressHUD showError:SSKJLocalized(@"两次登录密码不一致", nil)];
        return;
    }
    
//    if (![self.tpwdView.valueString isEqualToString:self.sureTpwdView.valueString]) {
//        [MBProgressHUD showError:SSKJLocalized(@"两次安全密码不一致", nil)];
//        return;
//    }
    if (![RegularExpression validatePassword:self.pwdView.valueString]) {
        [MBProgressHUD showError:SSKJLocalized(@"密码格式不正确", nil)];
        return;
    }
//    if (![RegularExpression validatePassword:self.tpwdView.valueString]) {
//        [MBProgressHUD showError:SSKJLocalized(@"安全密码格式不正确", nil)];
//        return;
//    }
    
    
    if (!self.accepetBtn.selected) {
        [MBProgressHUD showError:SSKJLocalized(@"请同意用户服务协议", nil)];
        return;
    }
    
//    if (self.invicateView.valueString.length == 0) {
//        [MBProgressHUD showError:SSKJLocalized(@"请输入邀请码", nil)];
//        return;
//    }
    
    
    
    [self requestRegister];

}
- (BOOL) judgeIsNumberByRegularExpressionWith:(NSString *)str
{
    if (str.length == 0) {
        return NO;
    }
    NSString *regex = @"[0-9]*";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    if ([pred evaluateWithObject:str]) {
        return YES;
    }
    return NO;
}
-(void)loginEvent
{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)forgetEvent
{
    
}




-(void)protocolEvent
{
    JB_WebView_Controller *webVc = [[JB_WebView_Controller alloc]init];
    webVc.protocolType = PROTOCOLTYPEREGISTER;
    webVc.title = SSKJLocalized(@"用户服务协议",nil);
    [self.navigationController pushViewController:webVc animated:YES];
}


#pragma mark - 网络请求

-(void)getCode
{
    //self.accountView.valueString
    if (![RegularExpression validateMobile:self.phoneView.valueString] /*&& ![RegularExpression validateEmail:self.accountView.valueString]*/) {
        [MBProgressHUD showError:SSKJLocalized(@"请输入正确的手机号", nil)];
        return;
    }


    //[self varCodeRequst];



    [self requestSmsCode];

}



// 倒计时
-(void)countDown
{
    [WLTools countDownWithButton:self.getSMSCodeButton];
}

////kowner_get_get_tuxing
//-(void)requestSmsCodeImgData
//{
//
//    NSDictionary *params = @{
//
//                             };
//
//    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    WS(weakSelf);
//    [[WLHttpManager shareManager]requestWithURL:kowner_get_get_tuxing RequestType:RequestTypeGet Parameters:params Success:^(id responseObject) {
//        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
//        WL_Network_Model *network_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
//        if ([network_model.status integerValue] == SUCCESSED) {
//            [weakSelf countDown];
//        }else{
//            [MBProgressHUD showError:network_model.msg];
//        }
//
//    } Failure:^(NSError *error, id responseObject) {
//        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
//        //[MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
//    }];
//}
//#pragma mark - 请求手机验证码

-(void)requestSmsCode
{

    NSDictionary *params = @{
                             @"mobile":self.phoneView.valueString,
                             @"type":@"1"/*,
                             @"validate":self.verCodeString*/
                             };

    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    WS(weakSelf);
    [[WLHttpManager shareManager]requestWithURL:kIscm_user_send_smsApi RequestType:RequestTypePost Parameters:params Success:^(id responseObject) {
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

//#pragma mark - 请求邮箱验证码
//-(void)requestEmailCode
//{
//    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    WS(weakSelf);
//    [[WLHttpManager shareManager]requestWithURL:JB_GetEmailCode_URL RequestType:RequestTypePost Parameters:@{@"email":self.accountView.valueString} Success:^(id responseObject) {
//        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
//        WL_Network_Model *network_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
//        if ([network_model.status integerValue] == SUCCESSED) {
//            [weakSelf countDown];
//        }else{
//            [MBProgressHUD showError:network_model.msg];
//        }
//
//    } Failure:^(NSError *error, id responseObject) {
//        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
//        //[MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
//    }];
//
//}

#pragma mark - 注册

-(void)requestRegister
{
    NSDictionary *params = @{
                             @"mobile":self.phoneView.valueString,
                             @"opwd":[WLTools md5num5:self.pwdView.valueString] ,
                             @"opwd1":[WLTools md5num5:self.pwdView.valueString],
//                             @"tpwd":[WLTools md5num5:self.tpwdView.valueString],
//                             @"tpwd1":[WLTools md5num5:self.tpwdView.valueString],
                             @"tjuser":self.invicateView.valueString,
                             @"account":self.accountView.valueString,
                             @"code":self.smsCodeView.valueString
                             };
    
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    WS(weakSelf);
    [[WLHttpManager shareManager]requestWithURL:kIscm_user_registerApi RequestType:RequestTypePost Parameters:params Success:^(id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        WL_Network_Model *network_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if ([network_model.status integerValue] == SUCCESSED) {
            if (weakSelf.confirmBlock) {
                weakSelf.confirmBlock(weakSelf.accountView.valueString?:@"");
            }
            [MBProgressHUD showSuccess:SSKJLocalized(@"注册成功", nil)];
            [weakSelf.navigationController popViewControllerAnimated:YES];
            
        }else{
            [MBProgressHUD showError:network_model.msg];
        }
        
    } Failure:^(NSError *error, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        //[MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
    }];
}


//#pragma mark - NTESVerifyCodeManagerDelegate
///**
// * 验证码组件初始化完成
// */
//- (void)verifyCodeInitFinish{
//    // App添加自己的处理逻辑
//}
//
///**
// * 验证码组件初始化出错
// * @param error 错误信息
// */
//- (void)verifyCodeInitFailed:(NSArray *)error{
//    // App添加自己的处理逻辑
//}
//
///**
// * 完成验证之后的回调
// * @param result 验证结果 BOOL:YES/NO
// * @param validate 二次校验数据，如果验证结果为false，validate返回空
// * @param message 结果描述信息
// */
//- (void)verifyCodeValidateFinish:(BOOL)result
//                        validate:(NSString *)validate
//                         message:(NSString *)message{
//    // App添加自己的处理逻辑
//    self.verCodeString = @"";
//    if (result) {
//
//       self.verCodeString = validate;
//        [self requestSmsCode];
//    }
//
//    [MBProgressHUD showError:message];
//}
//
//
///**
// * 关闭验证码窗口后的回调
// */
//- (void)verifyCodeCloseWindow{
//    //App添加自己的处理逻辑
//}
//


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField == self.accountView.textField) {
        // 这里的if时候为了获取删除操作,如果没有次if会造成当达到字数限制后删除键也不能使用的后果.
        if (range.length == 1 && string.length == 0) {
            return YES;
        }
        //        else if (self.self.accountView.textField.text.length >= 10) {
        //            self.accountView.textField.text = [textField.text substringToIndex:10];
        //            return NO;
        //        }
        
        if ( [RegularExpression isNineKeyBoard:string]) {
            return YES;
        }
        if (![RegularExpression judgeAccount:string]) {
            return NO;
        }
    }
    return YES;
}

- (void)textFieldDidchange:(UITextField *)textField {
    UITextRange *selectedRange = [textField markedTextRange];
    NSString *newText = [textField textInRange:selectedRange];
    if (!newText.length) {
        if (self.accountView.textField.text.length > 1000) {
            self.accountView.textField.text = [self.accountView.textField.text substringToIndex:10];
        }
    }
    
}
@end
