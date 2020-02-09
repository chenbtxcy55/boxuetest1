//
//  JB_Login_ViewController.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/5/10.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "JB_Login_ViewController.h"
#import "SSKJ_TabbarController.h"

//#import "Login_Google_AlertView.h"
#import "JB_Login_Google_ActionSheetView.h"

// controller
#import "JB_Register_ViewController.h"
#import "JB_ForgetPWD_ViewController.h"

// tools
#import "RegularExpression.h"
#import "AppDelegate.h"
//#import "HeBi_InputView.h"
#import "YLJ_InputView.h"



@interface JB_Login_ViewController ()
<UITextFieldDelegate>
@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic,strong) UIImageView *logoImgView;

@property (nonatomic, strong) UILabel *wellcomeLabel;
@property (nonatomic, strong) UIButton *registerButton;

@property (nonatomic, strong) YLJ_InputView *accountView;
@property (nonatomic, strong) YLJ_InputView *pwdView;
@property (nonatomic, strong) JB_Login_Google_ActionSheetView *googleAlertView;

@property (nonatomic, strong) UIButton *loginButton;

@property (nonatomic, strong) UIButton *forgetButton;

@end

@implementation JB_Login_ViewController

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
    [self.view addSubview:self.backButton];
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.logoImgView];
    [self.view addSubview:self.accountView];
    [self.view addSubview:self.pwdView];
    [self.view addSubview:self.loginButton];
    [self.view addSubview:self.wellcomeLabel];
    [self.view addSubview:self.registerButton];
    [self.view addSubview:self.forgetButton];
    self.view.backgroundColor = kMainColor;
   
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
        _titleLabel = [WLTools allocLabel:SSKJLocalized(@"登录", nil) font:systemBoldFont(ScaleW(23)) textColor:kMainTextColor frame:CGRectMake(ScaleW(15), self.backButton.bottom + ScaleW(20), ScreenWidth - ScaleW(60), ScaleW(26)) textAlignment:NSTextAlignmentLeft];
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
        
        NSString *text = SSKJLocalized(@"还没有油乐嘉账号,", nil);
        
//        _wellcomeLabel = [WLTools allocLabel:text font:systemFont(ScaleW(15)) textColor: kMainTextColor frame:CGRectMake(self.titleLabel.x, ScreenHeight - ScaleW(40) -ScaleW(14), self.titleLabel.width, ScaleW(14)) textAlignment:NSTextAlignmentLeft];
        _wellcomeLabel = [WLTools allocLabel:text font:systemFont(ScaleW(15)) textColor: kGrayTitleColor frame:CGRectMake(self.titleLabel.x, self.loginButton.bottom + ScaleW(25), self.titleLabel.width, ScaleW(14)) textAlignment:NSTextAlignmentLeft];

        
        
        CGFloat width = [WLTools getWidthWithText:text font:_wellcomeLabel.font];
        _wellcomeLabel.width = width;
    }
    return _wellcomeLabel;
}

-(UIButton *)registerButton
{
    if (nil == _registerButton) {
        NSString *text = SSKJLocalized(@"注册", nil);
        _registerButton = [[UIButton alloc]initWithFrame:CGRectMake(_wellcomeLabel.right + ScaleW(2), 0, ScaleW(50), ScaleW(16))];
        _registerButton.centerY = self.wellcomeLabel.centerY;
        [_registerButton setTitleColor:kTheMeColor forState:UIControlStateNormal];
        [_registerButton setTitle:text forState:UIControlStateNormal];
        _registerButton.titleLabel.font = systemFont(ScaleW(15));
        [_registerButton addTarget:self action:@selector(registerEvent) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _registerButton;
}
- (YLJ_InputView *)accountView
{
    if (nil == _accountView) {
//        _accountView = [[AB_TitleTextInputView alloc] initWithFrame:CGRectMake(0, ScaleW(107) + _titleLabel.bottom, ScreenWidth, ScaleW(86)) leftGap:ScaleW(23) placeHolder:SSKJLocalized(@"请输入您的账号", nil) font:systemFont(ScaleW(16)) keyBoardType:(UIKeyboardTypeNumberPad) titleText:SSKJLocalized(@"账号", nil) rightView:nil];
        _accountView = [[YLJ_InputView alloc] initWithFrame:CGRectMake(ScaleW(15), ScaleW(186) + _titleLabel.bottom, ScreenWidth-ScaleW(30), ScaleW(41)) titleWidth:ScaleW(35) gap:ScaleW(30)  titleName:SSKJLocalized(@"", nil) placeHolder:SSKJLocalized(@"请输入用户名", nil) keyboardType:UIKeyboardTypeDefault isSecured:NO];
        _accountView.textField.delegate = self;
        [_accountView.textField addTarget:self action:@selector(textFieldDidchange:) forControlEvents:UIControlEventEditingChanged];
        if ([KName length] > 0) {
            _accountView.valueString = KName;
        }
    }
    return _accountView;
}


-(YLJ_InputView *)pwdView
{
    if (nil == _pwdView) {
//        _pwdView = [[AB_TitleTextInputView alloc]initWithFrame:CGRectMake(0, ScaleW(0) + _accountView.bottom, ScreenWidth, ScaleW(86)) leftGap:ScaleW(23) placeHolder:SSKJLocalized(@"请输入6-12位字母和数字密码", nil) font:systemFont(ScaleW(16)) keyBoardType:(UIKeyboardTypeDefault) titleText:SSKJLocalized(@"密码", nil)];
         _pwdView = [[YLJ_InputView alloc] initWithFrame:CGRectMake(ScaleW(15), ScaleW(30) + _accountView.bottom, ScreenWidth-ScaleW(30), ScaleW(41))  titleWidth:ScaleW(35) gap:ScaleW(30)   titleName:SSKJLocalized(@"", nil) placeHolder:SSKJLocalized(@"请输入6-12位字母和数字密码", nil) keyboardType:UIKeyboardTypeDefault isSecured:YES];
//        _pwdView.valueString = @"";
        if ([kPWD length] > 0) {
            _pwdView.valueString = kPWD;
        }
    }
    return _pwdView;
}


-(UIButton *)loginButton
{
    if (nil == _loginButton) {
        _loginButton = [[UIButton alloc]initWithFrame:CGRectMake(ScaleW(15), self.pwdView.bottom + ScaleW(58), ScreenWidth - ScaleW(30), ScaleW(45))];
        [_loginButton setTitle:SSKJLocalized(@"登录", nil) forState:UIControlStateNormal];
        [_loginButton setTitleColor:kMainWihteColor forState:UIControlStateNormal];
//        _loginButton.layer.masksToBounds = YES;
//        _loginButton.layer.cornerRadius = ScaleW(10.f);
//        _loginButton.backgroundColor = kMainBlueColor;
        _loginButton.titleLabel.font = systemBoldFont(ScaleW(16));
//        [_loginButton setBackgroundImage:[UIImage imageNamed:@"login_Btn_bg"] forState:UIControlStateNormal];
//        [_loginButton setBackgroundImage:[UIImage imageNamed:@"login_Btn_bg"] forState:UIControlStateHighlighted];
        _loginButton.backgroundColor = kTheMeColor;
        [_loginButton setCornerRadius:ScaleW(5)];
        [_loginButton addTarget:self action:@selector(loginEvent) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _loginButton;
}
-(UIButton *)forgetButton
{
    if (nil == _forgetButton) {
        _forgetButton = [[UIButton alloc]initWithFrame:CGRectMake(ScaleW(30), self.loginButton.bottom + ScaleW(18), ScreenWidth - ScaleW(60), ScaleW(14))];
        [_forgetButton setTitle:SSKJLocalized(@"忘记密码?", nil) forState:UIControlStateNormal];
        [_forgetButton setTitleColor:kTheMeColor forState:UIControlStateNormal];
        _forgetButton.titleLabel.font = systemFont(ScaleW(13));
        [_forgetButton addTarget:self action:@selector(forgetEvent) forControlEvents:UIControlEventTouchUpInside];
        [_forgetButton setAttributedTitle:[WLTools setUnderLine:@"忘记密码?"] forState:UIControlStateNormal];

        [_forgetButton sizeToFit];
        _forgetButton.x = ScreenWidth - _forgetButton.width - ScaleW(15);
    }
    return _forgetButton;
}


-(void)backEvent
{
//    [[NSNotificationCenter defaultCenter]postNotificationName:@"gotoMainView" object:nil];
    if (self.isPush) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }
}

-(void)registerEvent
{
    JB_Register_ViewController *vc = [[JB_Register_ViewController alloc]init];
    WS(weakSelf);
    vc.confirmBlock = ^(NSString * _Nonnull accountString) {
        weakSelf.accountView.textField.text = accountString?:@"";
    };
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)loginEvent
{
//    if (![RegularExpression deptNumInputShouldNumber:self.accountView.valueString]||self.accountView.valueString.length !=11 /*&& ![RegularExpression validateEmail:self.accountView.valueString]*/) {
//        [MBProgressHUD showError:SSKJLocalized(@"请输入11位数字作为您的账号", nil)];
//        return;
//    }
    if (self.self.accountView.valueString.length == 0) {
        [MBProgressHUD showError:SSKJLocalized(@"请输账户名", nil)];
        return;
    }
    
    if (self.pwdView.valueString.length == 0) {
        [MBProgressHUD showError:SSKJLocalized(@"请输入登录密码", nil)];
        return;
    }
    
    if (![RegularExpression validatePassword:self.pwdView.valueString]) {
        [MBProgressHUD showError:SSKJLocalized(@"密码格式不正确", nil)];
        return;
    }
    
    
    [self requestLogin];
}


-(void)forgetEvent
{
    JB_ForgetPWD_ViewController *vc = [[JB_ForgetPWD_ViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - 登录

-(void)requestLogin
{
    NSDictionary *params = @{
                             @"account":self.accountView.valueString,
                             @"opwd": [WLTools md5num5:self.pwdView.valueString],
                             };
    
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    WS(weakSelf);
    [[WLHttpManager shareManager]requestWithURL:kIscm_user_login_Api RequestType:RequestTypePost Parameters:params Success:^(id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        WL_Network_Model *network_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if ([network_model.status integerValue] == SUCCESSED) {
            
            SSKJUserDefaultsSET(@"1", @"kLogin");
            SSKJUserDefaultsSET(self.pwdView.valueString, @"kPWD");
            SSKJUserDefaultsSET(self.accountView.valueString, @"KName");
//            SSKJUserDefaultsSynchronize;
            SSKJ_Login_Model *loginModel = [SSKJ_Login_Model mj_objectWithKeyValues:network_model.data];
            [SSKJ_User_Tool sharedUserTool].userInfoModel.account = loginModel.account;
            [SSKJ_User_Tool sharedUserTool].userInfoModel.mobile = weakSelf.accountView.valueString;
            [[SSKJ_User_Tool sharedUserTool]saveLoginInfoWithLoginModel:loginModel];
            
            [[NSUserDefaults standardUserDefaults]setObject:weakSelf.accountView.valueString forKey:@"kPhoneNumber"];
//            if ([RegularExpression validateMobile:weakSelf.accountView.valueString]) {
//                [[NSUserDefaults standardUserDefaults]setObject:@"0" forKey:@"kauth_emailIndex"];
//            }else{
//                [[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:@"kauth_emailIndex"];
//            }
            [kUserDefaults setObject:self.accountView.valueString forKey:@"mobile"];
            
            SSKJ_TabbarController *tabVc = [[SSKJ_TabbarController alloc]init];
            AppDelegate *appDelegate =  (AppDelegate *)[UIApplication sharedApplication].delegate;
            appDelegate.window.rootViewController = tabVc;
            
        }else{
            [MBProgressHUD showError:network_model.msg];
        }
        
    } Failure:^(NSError *error, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        //[MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
    }];
}


-(JB_Login_Google_ActionSheetView *)googleAlertView
{
    if (nil == _googleAlertView) {
        _googleAlertView = [[JB_Login_Google_ActionSheetView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        WS(weakSelf);
        _googleAlertView.confirmBlock = ^(NSString * _Nonnull code) {
            [weakSelf requestGoogleWith:code];
        };
    }
    return _googleAlertView;
}



#pragma mark - 谷歌验证

-(void)requestGoogleWith:(NSString *)code
{
    
    NSDictionary *prams = @{
                            @"dyGoodleCommand":code
                            };
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    WS(weakSelf);
    
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:JB_CheckGoogle_URL RequestType:RequestTypePost Parameters:prams Success:^(NSInteger statusCode, id responseObject) {
        WL_Network_Model *net_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        if (net_model.status.integerValue == SUCCESSED) {
            [weakSelf.googleAlertView hide];
            [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"kLogin"];
            [weakSelf dismissViewControllerAnimated:YES completion:nil];
        }else{
            [MBProgressHUD showError:net_model.msg];
        }
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
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
