//
//  JB_GesturePWD_ViewController.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/5/28.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "JB_GesturePWD_ViewController.h"
#import "JB_Login_ViewController.h"

#import "AppDelegate.h"
@interface JB_GesturePWD_ViewController ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UITextField *pwdTextField;
@property (nonatomic, strong) UIButton *hideButton;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIButton *confirmButton;

@property (nonatomic, strong) UIButton *loginButton;
@end

@implementation JB_GesturePWD_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUI];

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

-(void)setUI
{
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.backView];
    [self.backView addSubview:self.hideButton];
    [self.backView addSubview:self.pwdTextField];
    [self.backView addSubview:self.lineView];
    [self.view addSubview:self.loginButton];
    [self.view addSubview:self.confirmButton];
}

-(UILabel *)titleLabel
{
    if (nil == _titleLabel) {
        _titleLabel = [WLTools allocLabel:SSKJLocalized(@"使用密码验证登录", nil) font:systemFont(ScaleW(16)) textColor: kMainTextColor frame:CGRectMake(0, ScaleW(35), ScreenWidth, ScaleW(16)) textAlignment:NSTextAlignmentCenter];
    }
    return _titleLabel;
}

-(UIView *)backView
{
    if (nil == _backView) {
        _backView = [[UIView alloc]initWithFrame:CGRectMake(0, self.titleLabel.bottom + ScaleW(58), ScreenWidth, ScaleW(56))];
        _backView.backgroundColor = kSubBackgroundColor;
    }
    return _backView;
}

-(UIButton *)hideButton
{
    if (nil == _hideButton) {
        _hideButton = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth - ScaleW(90), 0, ScaleW(60), self.backView.height)];
        [_hideButton  setImage:[UIImage imageNamed:@"psd_hidden"] forState:UIControlStateNormal];
        [_hideButton  setImage:[UIImage imageNamed:@"psd_show"] forState:UIControlStateSelected];
        [_hideButton addTarget:self action:@selector(showPwd) forControlEvents:UIControlEventTouchUpInside];
    }
    return _hideButton;
}


-(UITextField *)pwdTextField
{
    if (nil == _pwdTextField) {
        _pwdTextField = [[UITextField alloc]initWithFrame:CGRectMake(ScaleW(34), 0, self.hideButton.x - ScaleW(34), self.backView.height)];
        _pwdTextField.font = systemFont(ScaleW(13.5));
        _pwdTextField.textColor =  kMainTextColor;
        _pwdTextField.placeholder = SSKJLocalized(@"请输入登录密码", nil);
//        [_pwdTextField setValue:kTextDarkBlueColor forKeyPath:@"_placeholderLabel.textColor"];
        
        NSMutableAttributedString *placeholderString1 = [[NSMutableAttributedString alloc] initWithString: SSKJLocalized(@"请输入登录密码", nil) attributes:@{NSForegroundColorAttributeName : kTextDarkBlueColor}];
        
        _pwdTextField.attributedPlaceholder = placeholderString1;
        _pwdTextField.secureTextEntry = YES;
    }
    return _pwdTextField;
}

-(UIView *)lineView
{
    if (nil == _lineView) {
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(self.pwdTextField.x, self.backView.height - 0.5, self.hideButton.right - self.pwdTextField.x, 0.5)];
        _lineView.backgroundColor = kTextGrayBlueColor;
    }
    return _lineView;
}

-(UIButton *)loginButton
{
    if (nil == _loginButton) {
        _loginButton = [[UIButton alloc]initWithFrame:CGRectMake(0, self.backView.bottom + ScaleW(20), ScreenWidth, ScaleW(40))];
        [_loginButton setTitle:SSKJLocalized(@"其他账号登录", nil) forState:UIControlStateNormal];
        [_loginButton setTitleColor:kTextBlueColor forState:UIControlStateNormal];
        _loginButton.titleLabel.font = systemFont(ScaleW(13));
        [_loginButton addTarget:self action:@selector(loginEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginButton;
}

-(UIButton *)confirmButton
{
    if (nil == _confirmButton) {
        _confirmButton = [[UIButton alloc]initWithFrame:CGRectMake(ScaleW(25), ScreenHeight - ScaleW(170), ScreenWidth - ScaleW(50), ScaleW(45))];
        [_confirmButton setTitle:SSKJLocalized(@"确认", nil) forState:UIControlStateNormal];
        [_confirmButton setTitleColor:kMainWihteColor forState:UIControlStateNormal];
        _confirmButton.layer.masksToBounds = YES;
        _confirmButton.layer.cornerRadius = 4.0f;
        _confirmButton.titleLabel.font = systemBoldFont(ScaleW(15));
        [_confirmButton addTarget:self action:@selector(confirmEvent) forControlEvents:UIControlEventTouchUpInside];
        [_confirmButton addGradientColor];
    }
    return _confirmButton;
}

-(void)showPwd
{
    self.hideButton.selected = !self.hideButton.selected;
    self.pwdTextField.secureTextEntry = !self.hideButton.selected;
}

-(void)loginEvent
{
    JB_Login_ViewController *loginVc = [[JB_Login_ViewController alloc]init];
    loginVc.isPush = YES;
    [self.navigationController pushViewController:loginVc animated:YES];
}


-(void)confirmEvent
{
    if (self.pwdTextField.text.length == 0) {
        [MBProgressHUD showError:SSKJLocalized(@"请输入登录密码", nil)];
        return;
    }
    
    NSDictionary *params = @{
                             @"opwd":[WLTools md5:self.pwdTextField.text]
                             };
    WS(weakSelf);
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:JB_CheckPWD_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        WL_Network_Model *network_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if ([network_model.status integerValue] == SUCCESSED) {
            AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
            [delegate gotoMain];
        }else{
            [MBProgressHUD showError:network_model.msg];
        }
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        //[MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
