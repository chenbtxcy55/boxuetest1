//
//  HeBi_InputPWD_AlertView.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/4/18.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "HeBi_InputPWD_AlertView.h"

@interface HeBi_InputPWD_AlertView ()
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIImageView *showView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *pwdBackView;
@property (nonatomic, strong) UITextField *pwdTextField;
@property (nonatomic, strong) UIButton *cancleButton;
@property (nonatomic, strong) UIButton *confirmButton;
@end

@implementation HeBi_InputPWD_AlertView


-(instancetype)init
{
    if (self = [super initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)]) {
        
        
        [self addSubview:self.backView];
        [self addSubview:self.showView];
        [self.showView addSubview:self.titleLabel];
        [self.showView addSubview:self.pwdBackView];
        [self.pwdBackView addSubview:self.pwdTextField];
        [self.showView addSubview:self.cancleButton];
        [self.showView addSubview:self.confirmButton];
        
        self.showView.height = self.cancleButton.bottom + ScaleW(20);
        self.showView.centerY = ScreenHeight / 2 - 20;
    }
    return self;
}

-(UIView *)backView
{
    if (nil == _backView) {
        _backView = [[UIView alloc]initWithFrame:self.bounds];
        _backView.backgroundColor = [UIColor blackColor];
        _backView.alpha = 0.7;
        
    }
    return _backView;
}

-(UIImageView *)showView
{
    if (nil == _showView) {
        _showView = [[UIImageView alloc]initWithFrame:CGRectMake(ScaleW(32), 0, self.width - ScaleW(64), ScaleW(190))];
        _showView.backgroundColor = kSubBackgroundColor;
        _showView.center = CGPointMake(ScreenWidth / 2, ScreenHeight / 2);
        _showView.layer.masksToBounds = YES;
        _showView.layer.cornerRadius = 6.0f;
        _showView.userInteractionEnabled = YES;
    }
    return _showView;
}

-(UILabel *)titleLabel
{
    if (nil == _titleLabel) {
        _titleLabel = [WLTools allocLabel:SSKJLocalized(@"退出登录", nil) font:systemFont(ScaleW(15)) textColor: kMainTextColor frame:CGRectMake(ScaleW(15), ScaleW(37), self.showView.width - ScaleW(30), ScaleW(15)) textAlignment:NSTextAlignmentCenter];
    }
    return _titleLabel;
}

-(UIView *)pwdBackView
{
    if (nil == _pwdBackView) {
        _pwdBackView = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(37), self.titleLabel.bottom + ScaleW(20), self.showView.width - ScaleW(74), ScaleW(45))];
        _pwdBackView.layer.borderWidth = 0.5;
        _pwdBackView.layer.borderColor = UIColorFromRGB(0x9493b0).CGColor;
    }
    return _pwdBackView;
}

-(UITextField *)pwdTextField
{
    if (nil == _pwdTextField) {
        _pwdTextField = [[UITextField alloc]initWithFrame:CGRectMake(ScaleW(18), 0, self.pwdBackView.width - ScaleW(18), self.pwdBackView.height)];
        _pwdTextField.font = systemFont(ScaleW(13));
        _pwdTextField.placeholder = SSKJLocalized(@"请输入安全密码", nil);
        _pwdTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString: SSKJLocalized(@"请输入安全密码", nil) attributes:@{NSForegroundColorAttributeName:kGrayTitleColor}];

        _pwdTextField.textColor =  kTitleColor;
//        [_pwdTextField setValue:kSubTitleColor forKeyPath:@"_placeholderLabel.textColor"];
        NSMutableAttributedString *placeholderString1 = [[NSMutableAttributedString alloc] initWithString: SSKJLocalized(@"请输入安全密码", nil) attributes:@{NSForegroundColorAttributeName : kSubTitleColor}];
        
        
        _pwdTextField.attributedPlaceholder = placeholderString1;
        
        _pwdTextField.secureTextEntry = YES;
    }
    return _pwdTextField;
}


-(UIButton *)cancleButton
{
    if (nil == _cancleButton) {
        
        _cancleButton = [[UIButton alloc]initWithFrame:CGRectMake(ScaleW(37), self.pwdBackView.bottom + ScaleW(20), ScaleW(105), ScaleW(35))];
        _cancleButton.layer.masksToBounds = YES;
        _cancleButton.layer.cornerRadius = _cancleButton.height / 2;
        _cancleButton.layer.borderColor = kMainBlueColor.CGColor;
        _cancleButton.layer.borderWidth = 0.5;
        [_cancleButton setTitle:SSKJLocalized(@"取消", nil) forState:UIControlStateNormal];
        [_cancleButton setTitleColor: kMainBlueColor forState:UIControlStateNormal];
        _cancleButton.titleLabel.font = systemFont(ScaleW(15));
        [_cancleButton addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancleButton;
}

-(UIButton *)confirmButton
{
    if (nil == _confirmButton) {
        
        _confirmButton = [[UIButton alloc]initWithFrame:CGRectMake(self.showView.width - ScaleW(37) - ScaleW(105), self.cancleButton.y, ScaleW(105), ScaleW(35))];
        _confirmButton.backgroundColor = kMainBlueColor;
        _confirmButton.layer.cornerRadius = _confirmButton.height / 2;
        [_confirmButton setTitle:@"确定" forState:UIControlStateNormal];
        [_confirmButton setTitleColor:kMainWihteColor forState:UIControlStateNormal];
        _confirmButton.titleLabel.font = systemFont(ScaleW(15));
        [_confirmButton addTarget:self action:@selector(confirmEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmButton;
}

-(void)showWithTitle:(NSString *)title cancleTitle:(NSString *)cancleTitle confirmTitle:(NSString *)confirmTitle
{
    self.isShow = YES;
    self.titleLabel.text = title;
    [self.cancleButton setTitle:cancleTitle forState:UIControlStateNormal];
    [self.confirmButton setTitle:confirmTitle forState:UIControlStateNormal];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
}

-(void)hide
{
    self.isShow = NO;
    self.pwdTextField.text = @"";
    [self removeFromSuperview];
}


-(void)confirmEvent
{
    
    if (self.pwdTextField.text.length == 0) {
        [MBProgressHUD showError:SSKJLocalized(@"请输入安全密码", nil)];
        return;
    }
    
    if (self.confirmBlock) {
        self.confirmBlock(self.pwdTextField.text);
        [self hide];
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
