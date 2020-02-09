//
//  My_BindGoogle_AlertView.m
//  ZYW_MIT
//
//  Created by 刘小雨 on 2019/3/28.
//  Copyright © 2019年 Wang. All rights reserved.
//

#import "My_BindGoogle_AlertView.h"
#import "RegularExpression.h"
@interface My_BindGoogle_AlertView ()
@property (nonatomic, strong) UIView *alertView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *googleView;
@property (nonatomic, strong) UITextField *codeTextField;
@property (nonatomic, strong) UIView *phoneView;
@property (nonatomic, strong) UITextField *iphoneTextField;
@property (nonatomic, strong) UIButton *smsCodeButton;
@property (nonatomic, strong) UIButton *submiteButton;
@end
@implementation My_BindGoogle_AlertView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hide)];
        [self addGestureRecognizer:tap];
        [self setUI];
    }
    return self;
}

#pragma mark - UI
-(void)setUI
{
    [self addSubview:self.alertView];
    [self.alertView addSubview:self.titleLabel];
    
//    self.googleView = [self addInputViewWithFrame:CGRectMake(0, self.titleLabel.bottom + ScaleW(15), ScreenWidth, ScaleW(88)) title:SSKJLocalized(@"谷歌验证码", nil) placeHolder:SSKJLocalized(@"请输入谷歌验证码", nil) keyBoardType:UIKeyboardTypeASCIICapable];
//
//    [self.alertView addSubview:self.googleView];
    
//    NSString *title = SSKJLocalized(@"验证手机", nil);
    NSString *placeHolder = SSKJLocalized(@"请输入安全密码", nil);
//    if ([kauth_emailIndex integerValue] == 1) {
//        title = SSKJLocalized(@"验证邮箱", nil);
//        placeHolder = SSKJLocalized(@"请输入邮箱验证码", nil);
//    }
    
    UIImageView * lineImageView =[[UIImageView alloc] initWithFrame:CGRectMake(0, self.titleLabel.bottom + ScaleW(15) -1, ScreenWidth, 1)];
    lineImageView.backgroundColor = UIColorFromRGB(0x4c4e6b);
    
    [self.alertView addSubview:lineImageView];
    
    
    
    self.phoneView = [self addInputViewWithFrame:CGRectMake(0, self.titleLabel.bottom + ScaleW(15), ScreenWidth, ScaleW(93)) title:[NSString stringWithFormat:@"%@%@",SSKJLocalized(@"邮箱地址:", nil),[SSKJ_User_Tool sharedUserTool].userInfoModel.email] placeHolder:SSKJLocalized(@"请输入邮箱验证码", nil) keyBoardType:UIKeyboardTypeEmailAddress];
    
    [self.alertView addSubview:self.phoneView];
    
    
    
    UILabel *titleLabel = [WLTools allocLabel:SSKJLocalized(@"请输入安全密码", nil) font:systemFont(ScaleW(16)) textColor:kMainTextColor frame:CGRectMake(ScaleW(15),self.phoneView.bottom+ ScaleW(27), ScaleW(200), ScaleW(13)) textAlignment:NSTextAlignmentLeft];
    
    [self.alertView addSubview:titleLabel];
    
    
    UIView * bgView = [[UIView alloc] initWithFrame:CGRectMake(titleLabel.x, titleLabel.bottom + ScaleW(14),ScreenWidth - ScaleW(32), ScaleW(40))];
    bgView.layer.borderColor =UIColorFromRGB(0x58a471).CGColor;
    bgView.layer.borderWidth = ScaleW(1);
    bgView.layer.cornerRadius = ScaleW(5);
    bgView.layer.masksToBounds = YES;
    
    [self.alertView addSubview:bgView];
    
    
    UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(ScaleW(5), 0,ScreenWidth - ScaleW(42), ScaleW(40))];
    textField.textColor = kMainWihteColor;
    textField.font = systemFont(ScaleW(15));
    textField.placeholder = SSKJLocalized(@"请输入安全密码", nil);
    
    //    [textField setValue:kTextLightBlueColor forKeyPath:@"_placeholderLabel.textColor"];
    NSMutableAttributedString *placeholderString1 = [[NSMutableAttributedString alloc] initWithString: placeHolder attributes:@{NSForegroundColorAttributeName : UIColorFromRGB(0xb5b5b5)}];
    
    textField.secureTextEntry = YES;
    textField.attributedPlaceholder = placeholderString1;

    self.iphoneTextField = textField;
    
    [bgView addSubview:textField];
    
    
    
    UIButton * cancelButton = [[UIButton alloc]initWithFrame:CGRectMake(0, bgView.bottom + ScaleW(57), ScreenWidth/2, ScaleW(45))];
    //        _submiteButton.layer.cornerRadius = _submiteButton.height / 2;
    cancelButton.backgroundColor = kNavBGColor;
    [cancelButton setTitle:SSKJLocalized(@"确认", nil) forState:UIControlStateNormal];
    [cancelButton setTitleColor:kSubTxtColor forState:UIControlStateNormal];
    cancelButton.titleLabel.font = systemFont(ScaleW(16));
    [cancelButton addTarget:self action:@selector(cancelEvent) forControlEvents:UIControlEventTouchUpInside];
    
    [self.alertView addSubview:cancelButton];

    [self.alertView addSubview:self.submiteButton];
    self.submiteButton.top = bgView.bottom + ScaleW(57);
    
    self.alertView.height = self.submiteButton.bottom ;
    
}

-(UIView *)alertView
{
    if (nil == _alertView) {
        _alertView = [[UIView alloc]initWithFrame:CGRectMake(0, self.height, ScreenWidth, 0)];
        _alertView.backgroundColor = kBgColor353750;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:nil];
        [_alertView addGestureRecognizer:tap];
    }
    return _alertView;
}

- (UILabel *)titleLabel
{
    if (nil == _titleLabel) {
        _titleLabel = [WLTools allocLabel:@"获取邮箱验证码" font:systemBoldFont(ScaleW(15)) textColor:kMainTextColor frame:CGRectMake(ScaleW(15), ScaleW(24), ScreenWidth, ScaleW(15)) textAlignment:NSTextAlignmentLeft];
    }
    return _titleLabel;
}

-(UIView *)addInputViewWithFrame:(CGRect )frame title:(NSString *)title placeHolder:(NSString *)placeHolder keyBoardType:(UIKeyboardType)keyBoardType
{
    UIView *view = [[UIView alloc]initWithFrame:frame];
    view.backgroundColor = kBgColor353750;
    UILabel *titleLabel = [WLTools allocLabel:title font:systemFont(ScaleW(13)) textColor:kSubTxtColor frame:CGRectMake(ScaleW(15), ScaleW(20), ScaleW(200), ScaleW(13)) textAlignment:NSTextAlignmentLeft];
    [view addSubview:titleLabel];
    
    UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(titleLabel.x, titleLabel.bottom + ScaleW(14), ScaleW(200), ScaleW(40))];
    textField.textColor = kMainWihteColor;
    textField.font = systemFont(ScaleW(15));
    textField.placeholder = placeHolder;
    textField.keyboardType = keyBoardType;
//    [textField setValue:kTextLightBlueColor forKeyPath:@"_placeholderLabel.textColor"];
    
    NSMutableAttributedString *placeholderString1 = [[NSMutableAttributedString alloc] initWithString: placeHolder attributes:@{NSForegroundColorAttributeName : kMainTextColor}];
    
    textField.attributedPlaceholder = placeholderString1;

    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(15), textField.bottom, ScreenWidth, 1)];
//    line.backgroundColor = kLineGrayColor;
    [view addSubview:line];
    
    [view addSubview:textField];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, textField.bottom+ScaleW(10), view.width , 5)];
    lineView.backgroundColor = UIColorFromRGB(0x4c4e6b);
    [view addSubview:lineView];
    
//    if (![title isEqualToString:SSKJLocalized(@"谷歌验证码", nil)]) {
//        self.codeTextField = textField;
//        textField.width = ScreenWidth - ScaleW(24);
//    }else
//
    {
        self.codeTextField = textField;
        self.smsCodeButton = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth - ScaleW(12) - ScaleW(100), 0, ScaleW(100), ScaleW(30))];
        self.smsCodeButton.centerY = textField.centerY;
        [self.smsCodeButton setTitle:SSKJLocalized(@"获取验证码", nil) forState:UIControlStateNormal];
        [self.smsCodeButton setTitleColor:UIColorFromRGB(0x58a471) forState:UIControlStateNormal];
        self.smsCodeButton.titleLabel.font = systemFont(ScaleW(12.5));
        self.smsCodeButton.layer.masksToBounds = YES;
        self.smsCodeButton.layer.cornerRadius = ScaleW(5);
        self.smsCodeButton.layer.borderColor = UIColorFromRGB(0x58a471).CGColor;
        self.smsCodeButton.layer.borderWidth = 1;
        [self.smsCodeButton addTarget:self action:@selector(getSmsCodeEvent) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:self.smsCodeButton];
    }
    return view;

}

-(UIButton *)submiteButton
{
    if (nil == _submiteButton) {
        _submiteButton = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth/2, 0, ScreenWidth/2, ScaleW(45))];
//        _submiteButton.layer.cornerRadius = _submiteButton.height / 2;
//        _submiteButton.backgroundColor = kMainTextColor;
        [_submiteButton setTitle:SSKJLocalized(@"确认", nil) forState:UIControlStateNormal];
        [_submiteButton setTitleColor:kMainWihteColor forState:UIControlStateNormal];
        _submiteButton.titleLabel.font = systemFont(ScaleW(16));
        [_submiteButton addTarget:self action:@selector(submitEvent) forControlEvents:UIControlEventTouchUpInside];
//        [_submiteButton setBackgroundImage:[UIImage imageNamed:@"login_Btn_bg"] forState:UIControlStateNormal];
        _submiteButton.backgroundColor = kTheMeColor;
//        [_submiteButton addGradientColor];
//        _submiteButton.layer.masksToBounds = YES;
//        _submiteButton.layer.cornerRadius = ScaleW(5);
    }
    return _submiteButton;
}




-(void)showWithType:(GOOGLETYPE)googleType
{
    NSString *string = SSKJLocalized(@"获取邮箱验证码", nil);
//    if (googleType == GOOGLETYPEDELETE) {
//        string = SSKJLocalized(@"关闭谷歌验证", nil);
//    }
    self.titleLabel.text = string;
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
    WS(weakSelf);
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.alertView.y = weakSelf.height -weakSelf.alertView.height;
    }];
}

-(void)hide
{
    
    WS(weakSelf);
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.alertView.y = weakSelf.height;
    } completion:^(BOOL finished) {
        [weakSelf removeFromSuperview];
    }];
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self hide];
}

#pragma mark - 用户操作
-(void)getSmsCodeEvent
{
    
    [self requestEmailCode];

//    if ([RegularExpression validateMobile:kPhoneNumber]) {
//        [self requestSmsCode];
//    }else{
//        [self requestEmailCode];
//    }
}

-(void)cancelEvent
{
    [self hide];
    
}


-(void)submitEvent
{
    [self endEditing:YES];
    if (self.codeTextField.text.length == 0) {
        [MBProgressHUD showError:SSKJLocalized(@"请输入邮箱验证码", nil)];
        return;
    }
//
    if (self.iphoneTextField.text.length == 0) {
        [MBProgressHUD showError:SSKJLocalized(@"请输入安全密码", nil)];
        return;
    }
    
    if (self.submitBlock) {
        self.submitBlock(self.codeTextField.text, self.iphoneTextField.text);
    }
    [self hide];
}

#pragma mark - 请求验证码

-(void)requestEmailCode
{

    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    NSDictionary *params = @{
                             @"email":[SSKJ_User_Tool sharedUserTool].userInfoModel.email,
                             @"type":@"5"/*,
                                          @"validate":self.verCodeString*/
                             };
    
    WS(weakSelf);
    [MBProgressHUD showHUDAddedTo:window animated:YES];
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:JB_GetEmailCode_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:window animated:YES];
        WL_Network_Model *network_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if ([network_model.status integerValue] == SUCCESSED) {
            [MBProgressHUD showError:network_model.msg];
            [weakSelf changeCheckcodeButtonState];
        }else{
            [MBProgressHUD showError:network_model.msg];
        }
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:window animated:YES];
        //[MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
    }];
}

//-(void)requestEmailCode
//{
//    UIWindow *window = [UIApplication sharedApplication].keyWindow;
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    params[@"email"] = kPhoneNumber;
//    WS(weakSelf);
//    [MBProgressHUD showHUDAddedTo:window animated:YES];
//    [[WLHttpManager shareManager]requestWithURL_HTTPCode:JB_GetEmailCode_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
//        [MBProgressHUD hideHUDForView:window animated:YES];
//        WL_Network_Model *network_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
//        if ([network_model.status integerValue] == SUCCESSED) {
//            [MBProgressHUD showError:network_model.msg];
//            [weakSelf changeCheckcodeButtonState];
//        }else{
//            [MBProgressHUD showError:network_model.msg];
//        }
//    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
//        [MBProgressHUD hideHUDForView:window animated:YES];
//        //[MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
//    }];
//}

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


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
