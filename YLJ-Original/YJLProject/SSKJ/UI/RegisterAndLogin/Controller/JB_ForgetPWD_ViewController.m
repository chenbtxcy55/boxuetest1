//
//  JB_ForgetPWD_ViewController.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/5/10.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "JB_ForgetPWD_ViewController.h"

// view
//#import "YLJ_InputView.h"
#import "YLJ_InputView.h"

// tools
#import "RegularExpression.h"

#import "WYVerifyTool.h"

@interface JB_ForgetPWD_ViewController ()
<UITextFieldDelegate>
@property (nonatomic, strong) UIScrollView *mainScrollView;
@property (nonatomic, strong) UILabel *wellcomeLabel;
@property (nonatomic, strong) UIButton *registerButton;
@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic,strong) UIImageView *logoImgView;
//@property (nonatomic, strong) UILabel *wellcomeLabel;
//@property (nonatomic, strong) UIButton *registerButton;

@property (nonatomic, strong) YLJ_InputView *accountView;

@property (nonatomic, strong) YLJ_InputView *emailView;

@property (nonatomic, strong) UIImageView *codeImg;
@property (nonatomic, strong) YLJ_InputView *smsCodeView;
@property (nonatomic, strong) UIButton *getSMSCodeButton;

@property (nonatomic, strong) YLJ_InputView *pwdView;
@property (nonatomic, strong) YLJ_InputView *surePWDView;


@property (nonatomic, strong) UIButton *submitButton;
@end

@implementation JB_ForgetPWD_ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self setUI];
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
   [self.navigationController setNavigationBarHidden:YES animated:NO];

}

#pragma mark - UI

-(void)setUI
{
    [self.view addSubview:self.mainScrollView];
    [self.mainScrollView addSubview:self.backButton];
    [self.mainScrollView addSubview:self.titleLabel];
//    [self.mainScrollView addSubview:self.logoImgView];
    [self.mainScrollView addSubview:self.accountView];
    [self.mainScrollView addSubview:self.emailView];
//    [self.mainScrollView addSubview:self.codeImg];
    [self.mainScrollView addSubview:self.smsCodeView];
    [self.mainScrollView addSubview:self.getSMSCodeButton];
    [self.mainScrollView addSubview:self.pwdView];
    [self.mainScrollView addSubview:self.surePWDView];

    
    [self.mainScrollView addSubview:self.submitButton];
    [self.mainScrollView addSubview:self.wellcomeLabel];
    [self.mainScrollView addSubview:self.registerButton];
    self.mainScrollView.contentSize = CGSizeMake(ScreenWidth, self.wellcomeLabel.bottom+ScaleW(30));
    
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
        _titleLabel = [WLTools allocLabel:SSKJLocalized(@"忘记密码？", nil) font:systemBoldFont(ScaleW(23)) textColor:kMainTextColor frame:CGRectMake(ScaleW(15), self.backButton.bottom + ScaleW(20), ScreenWidth - ScaleW(60), ScaleW(26)) textAlignment:NSTextAlignmentLeft];
//        _titleLabel.hidden = YES;
    }
    return _titleLabel;
}

- (UIImageView *)logoImgView {
    if (!_logoImgView) {
        _logoImgView = [FactoryUI createImageViewWithFrame:CGRectMake(ScaleW(104), ScaleW(74), ScaleW(167), ScaleW(50)) imageName:@"img_logo"];
    }
    return _logoImgView;
}

- (YLJ_InputView *)accountView
{
    if (nil == _accountView) {
//        _accountView = [[AB_TitleTextInputView alloc]initWithFrame:CGRectMake(0, ScaleW(40) + _titleLabel.bottom, ScreenWidth, ScaleW(86)) leftGap:ScaleW(23) placeHolder:SSKJLocalized(@"请输入您的手机号", nil) font:systemFont(ScaleW(16)) keyBoardType:(UIKeyboardTypeNumberPad) titleText:SSKJLocalized(@"账号", nil) rightView:nil];
          _accountView = [[YLJ_InputView alloc] initWithFrame:CGRectMake(ScaleW(15), ScaleW(67) + self.titleLabel.bottom, ScreenWidth-ScaleW(30), ScaleW(41)) titleWidth:ScaleW(60) gap:ScaleW(15)  titleName:SSKJLocalized(@"账   号", nil) placeHolder:SSKJLocalized(@"请输入用户名（不可包含特殊字符）", nil) keyboardType:UIKeyboardTypeDefault isSecured:NO];
        _accountView.textField.delegate = self;
        [_accountView.textField addTarget:self action:@selector(textFieldDidchange:) forControlEvents:UIControlEventEditingChanged];

    }
    return _accountView;
}
- (YLJ_InputView *)emailView
{
    if (nil == _emailView) {
         _emailView = [[YLJ_InputView alloc] initWithFrame:CGRectMake(ScaleW(15), ScaleW(20) + _accountView.bottom, ScreenWidth-ScaleW(30), ScaleW(41)) titleWidth:ScaleW(60) gap:ScaleW(15)  titleName:SSKJLocalized(@"邮   箱", nil) placeHolder:SSKJLocalized(@"请输入手机号", nil) keyboardType:UIKeyboardTypeNumberPad isSecured:NO];
//        _emailView.valueString = @"670035475@qq.com";
    }
    return _emailView;
}
//
//-(UIImageView *)codeImg
//{
//    if (!_codeImg) {
//        _codeImg = [[UIImageView alloc]initWithFrame:CGRectMake(ScaleW(248), 0, ScaleW(98), ScaleW(25))];
//        _codeImg.backgroundColor = [UIColor purpleColor];
//
//        _codeImg.centerY = _imgVerCodeView.centerY;
//        _codeImg.userInteractionEnabled = YES;
//
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapChangedImg:)];
//
//        [_codeImg addGestureRecognizer:tap];
//    }
//    return _codeImg;
//}
//
//-(void)tapChangedImg:(UITapGestureRecognizer *)tap
//{
//    [MBProgressHUD showError:@"点击了"];
//}




- (YLJ_InputView *)smsCodeView
{
    if (nil == _smsCodeView) {
//        _smsCodeView =  [[AB_TitleTextInputView alloc]initWithFrame:CGRectMake(0, _accountView.bottom, ScreenWidth, ScaleW(86)) leftGap:ScaleW(26) placeHolder:SSKJLocalized(@"请输入验证码", nil) font:systemFont(ScaleW(16)) keyBoardType:(UIKeyboardTypeNumberPad) titleText:SSKJLocalized(@"验证码", nil) rightView:self.getSMSCodeButton];
         _smsCodeView = [[YLJ_InputView alloc] initWithFrame:CGRectMake(ScaleW(15), ScaleW(20) + _emailView.bottom, ScaleW(200), ScaleW(41)) titleWidth:ScaleW(60) gap:ScaleW(15)  titleName:SSKJLocalized(@"验证码", nil) placeHolder:SSKJLocalized(@"请输入验证码", nil) keyboardType:UIKeyboardTypeDefault isSecured:NO];
        
    }
    return _smsCodeView;
}

-(UIButton *)getSMSCodeButton
{
    if (nil == _getSMSCodeButton) {
        _getSMSCodeButton = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth - ScaleW(93)-ScaleW(15), _smsCodeView.top, ScaleW(93), ScaleW(34))];
        _getSMSCodeButton.centerY = self.smsCodeView.centerY;
        [_getSMSCodeButton setTitle:SSKJLocalized(@"获取验证码", nil) forState:UIControlStateNormal];
        [_getSMSCodeButton setTitleColor:kTheMeColor forState:UIControlStateNormal];
        _getSMSCodeButton.titleLabel.font = systemFont(ScaleW(16));
      
        _getSMSCodeButton.layer.masksToBounds = YES;
        _getSMSCodeButton.layer.cornerRadius = ScaleW(5);
        
//        _getSMSCodeButton.layer.borderColor = kGreenTextColor.CGColor;
//        _getSMSCodeButton.layer.borderWidth = 1;
        [_getSMSCodeButton addTarget:self action:@selector(getCode) forControlEvents:UIControlEventTouchUpInside];
    }
    return _getSMSCodeButton;
}


-(YLJ_InputView *)pwdView
{
    if (nil == _pwdView) {
//        _pwdView = [[YLJ_InputView alloc]initWithFrame:CGRectMake(0, _smsCodeView.bottom, ScreenWidth, ScaleW(86)) leftGap:ScaleW(26) placeHolder:SSKJLocalized(@"请输入密码(8-20位数字+字母)", nil) font:systemFont(ScaleW(16)) keyBoardType:(UIKeyboardTypeDefault) titleText:SSKJLocalized(@"登录密码", nil)];
        
          _pwdView = [[YLJ_InputView alloc] initWithFrame:CGRectMake(ScaleW(15), ScaleW(20) + _smsCodeView.bottom, ScreenWidth-ScaleW(30), ScaleW(41)) titleWidth:ScaleW(60) gap:ScaleW(15)  titleName:SSKJLocalized(@"新密码", nil) placeHolder:SSKJLocalized(@"请输入6-12位字母和数字密码", nil) keyboardType:UIKeyboardTypeDefault isSecured:YES];
    }
    return _pwdView;
}
-(YLJ_InputView *)surePWDView
{
    if (nil == _surePWDView) {
//        _surePWDView = [[AB_TitleTextInputView alloc]initWithFrame:CGRectMake(0, _pwdView.bottom, ScreenWidth, ScaleW(86)) leftGap:ScaleW(26) placeHolder:SSKJLocalized(@"请再次输入新登录密码", nil) font:systemFont(ScaleW(16)) keyBoardType:(UIKeyboardTypeDefault) titleText:SSKJLocalized(@"确认密码", nil)];
        _surePWDView = [[YLJ_InputView alloc] initWithFrame:CGRectMake(ScaleW(15), ScaleW(20) + _pwdView.bottom, ScreenWidth-ScaleW(30), ScaleW(41)) titleWidth:ScaleW(65) gap:ScaleW(10)  titleName:SSKJLocalized(@"确认密码", nil) placeHolder:SSKJLocalized(@"请再次确认密码", nil) keyboardType:UIKeyboardTypeDefault isSecured:YES];
    }
    return _surePWDView;
}


-(UIButton *)submitButton
{
    if (nil == _submitButton) {
        _submitButton = [[UIButton alloc]initWithFrame:CGRectMake(ScaleW(30), self.surePWDView.bottom + ScaleW(50), ScreenWidth - ScaleW(60), ScaleW(45))];
        [_submitButton setTitle:SSKJLocalized(@"提交", nil) forState:UIControlStateNormal];
        [_submitButton setTitleColor:kMainWihteColor forState:UIControlStateNormal];
//        _submitButton.layer.masksToBounds = YES;
//        _submitButton.layer.cornerRadius = ScaleW(5);
        
//        [_submitButton setBackgroundImage:[UIImage imageNamed:@"login_Btn_bg"] forState:UIControlStateNormal];
//        [_submitButton setBackgroundImage:[UIImage imageNamed:@"login_Btn_bg"] forState:UIControlStateHighlighted];
        
        _submitButton.titleLabel.font = systemBoldFont(ScaleW(16));
        [_submitButton addTarget:self action:@selector(submitEvent) forControlEvents:UIControlEventTouchUpInside];
        _submitButton.backgroundColor = kTheMeColor;
        [_submitButton setCornerRadius:ScaleW(5)];
    }
    return _submitButton;
}
-(UILabel *)wellcomeLabel
{
    if (nil == _wellcomeLabel) {
        
        NSString *text = SSKJLocalized(@"已有账号，立即 ", nil);
        
        _wellcomeLabel = [WLTools allocLabel:text font:systemFont(ScaleW(15)) textColor: kMainTextColor frame:CGRectMake(self.titleLabel.x, ScreenHeight - ScaleW(40) -ScaleW(14), self.titleLabel.width, ScaleW(14)) textAlignment:NSTextAlignmentLeft];
        
        CGFloat width = [WLTools getWidthWithText:text font:_wellcomeLabel.font];
        _wellcomeLabel.width = width;
        _wellcomeLabel.hidden = YES;
    }
    return _wellcomeLabel;
}

-(UIButton *)registerButton
{
    if (nil == _registerButton) {
        NSString *text = SSKJLocalized(@"登录 >", nil);
        _registerButton = [[UIButton alloc]initWithFrame:CGRectMake(_wellcomeLabel.right + ScaleW(5), 0, ScaleW(80), ScaleW(16))];
        _registerButton.centerY = self.wellcomeLabel.centerY;
        [_registerButton setTitleColor:kGreenTextColor forState:UIControlStateNormal];
        [_registerButton setTitle:text forState:UIControlStateNormal];
        _registerButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _registerButton.titleLabel.font = systemFont(ScaleW(15));
        [_registerButton addTarget:self action:@selector(backEvent) forControlEvents:UIControlEventTouchUpInside];
        _registerButton.hidden = YES;
    }
    return _registerButton;
}
#pragma mark - 用户操作
-(void)backEvent
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)submitEvent
{
//    if (![RegularExpression deptNumInputShouldNumber:self.accountView.valueString]||self.accountView.valueString.length !=11 /*&& ![RegularExpression validateEmail:self.accountView.valueString]*/) {
//        [MBProgressHUD showError:SSKJLocalized(@"请输入您的账号", nil)];
//        return;
//    }
    if (self.self.accountView.valueString.length == 0) {
        [MBProgressHUD showError:SSKJLocalized(@"请输账户名", nil)];
        return;
    }
    
    if (self.emailView.valueString.length == 0) {
        [MBProgressHUD showError:SSKJLocalized(@"请输入您绑定的手机号", nil)];
        return;
    }
//    if (![RegularExpression validateEmail:self.emailView.valueString]) {
//        [MBProgressHUD showError:SSKJLocalized(@"请输入正确的邮箱", nil)];
//        return;
//    }
    
    if (self.smsCodeView.valueString.length == 0) {
        [MBProgressHUD showError:SSKJLocalized(@"请输入验证码", nil)];
        return;
    }
    
    if (self.pwdView.valueString.length == 0) {
        [MBProgressHUD showError:SSKJLocalized(@"请输入登录密码", nil)];
        return;
    }
    
    if (self.surePWDView.valueString.length == 0) {
        [MBProgressHUD showError:SSKJLocalized(@"请输入确认登录密码", nil)];
        return;
    }
    
    if (![RegularExpression validatePassword:self.pwdView.valueString]) {
        [MBProgressHUD showError:SSKJLocalized(@"密码格式不正确", nil)];
        return;
    }
    
    [self requestForget];
    
}



#pragma mark - 网络请求

-(void)getCode
{
//    [[WYVerifyTool sharedInstance]startVerifyCompletion:^(BOOL result, NSString * _Nullable validate, NSString * _Nonnull message) {
//
//        if (result) {
//            [self requestSmsCode:validate];
//
//        }
//        [MBProgressHUD showError:message];
//    }];
//    if (![RegularExpression validateEmail:self.emailView.valueString]) {
//        [MBProgressHUD showError:SSKJLocalized(@"请输入正确的邮箱", nil)];
//        return;
//    }
//    [self requestEmailCode];

    [self requestSmsCode];

}

-(void)requestSmsCode
{
    
    NSDictionary *params = @{
                             @"mobile":self.emailView.valueString,
                             @"type":@"2"/*,
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


// 倒计时
-(void)countDown
{
    [WLTools countDownWithButton:self.getSMSCodeButton];
}



#pragma mark - 请求邮箱验证码
-(void)requestEmailCode
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    WS(weakSelf);
    [[WLHttpManager shareManager]requestWithURL:JB_GetEmailCode_URL RequestType:RequestTypePost Parameters:@{@"email":self.emailView.valueString,@"type":@"1"} Success:^(id responseObject) {
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


#pragma mark - 请求
-(void)requestForget
{
    
    NSDictionary *params = @{
                             @"mobile":self.emailView.valueString,
                             @"code":self.smsCodeView.valueString,
                             @"opwd":[WLTools md5:self.pwdView.valueString],
                             @"opwd1":[WLTools md5:self.surePWDView.valueString],
                             @"account":self.accountView.valueString
                             };
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    WS(weakSelf);
    [[WLHttpManager shareManager]requestWithURL:kIscm_user_reset_opwd_Api RequestType:RequestTypePost Parameters:params Success:^(id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        WL_Network_Model *network_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if ([network_model.status integerValue] == SUCCESSED) {
            
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }else{
            [MBProgressHUD showError:network_model.msg];
        }
        
    } Failure:^(NSError *error, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        //[MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
    }];
    
}


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
