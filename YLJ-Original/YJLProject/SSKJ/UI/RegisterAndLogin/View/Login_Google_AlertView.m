//
//  Login_Google_AlertView.m
//  ZYW_MIT
//
//  Created by 刘小雨 on 2019/4/2.
//  Copyright © 2019年 Wang. All rights reserved.
//

#import "Login_Google_AlertView.h"

@interface Login_Google_AlertView ()
@property (nonatomic, strong) UIView *alertView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIButton *cancleButton;

@property (nonatomic, strong) UILabel *codeTitleLabel;
@property (nonatomic, strong) UITextField *codeTextField;

@property (nonatomic, strong) UIButton *confirmButton;
@end

@implementation Login_Google_AlertView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
        [self setUI];
    }
    return self;
}


-(void)setUI
{
    [self addSubview:self.alertView];
    [self.alertView addSubview:self.titleLabel];
    [self.alertView addSubview:self.cancleButton];
    [self.alertView addSubview:self.codeTitleLabel];
    [self.alertView addSubview:self.codeTextField];
    [self.alertView addSubview:self.confirmButton];
    
    self.alertView.height = self.confirmButton.bottom + ScaleW(27);
    self.alertView.centerY = ScreenHeight / 2;
}

-(UIView *)alertView
{
    if (nil == _alertView) {
        _alertView = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(15), 0, ScreenWidth - ScaleW(30), 0)];
        _alertView.backgroundColor = kSubBackgroundColor;
        _alertView.layer.cornerRadius = 8.0f;
    }
    return _alertView;
}

-(UILabel *)titleLabel
{
    if (nil == _titleLabel) {
        _titleLabel = [WLTools allocLabel:SSKJLocalized(@"安全验证", nil) font:systemBoldFont(ScaleW(14)) textColor:kMainWihteColor frame:CGRectMake(ScaleW(15), ScaleW(28), ScaleW(100), ScaleW(14)) textAlignment:NSTextAlignmentLeft];
    }
    return _titleLabel;
}

-(UIButton *)cancleButton
{
    if (nil == _cancleButton) {
        _cancleButton = [[UIButton alloc]initWithFrame:CGRectMake(self.alertView.width - ScaleW(100), 0, ScaleW(100), ScaleW(40))];
        _cancleButton.centerY = self.titleLabel.centerY;
        [_cancleButton setTitle:SSKJLocalized(@"取消", nil) forState:UIControlStateNormal];
        [_cancleButton setTitleColor:kTextDarkBlueColor forState:UIControlStateNormal];
        _cancleButton.titleLabel.font = systemFont(ScaleW(14));
        [_cancleButton addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancleButton;
}

-(UILabel *)codeTitleLabel
{
    if (nil == _codeTitleLabel) {
        _codeTitleLabel = [WLTools allocLabel:SSKJLocalized(@"谷歌验证码", nil) font:systemFont(ScaleW(13)) textColor:kTextDarkBlueColor frame:CGRectMake(ScaleW(15), self.titleLabel.bottom + ScaleW(36), ScaleW(100), ScaleW(13)) textAlignment:NSTextAlignmentLeft];
    }
    return _codeTitleLabel;
}

-(UITextField *)codeTextField
{
    if (nil == _codeTextField) {
        _codeTextField = [[UITextField alloc]initWithFrame:CGRectMake(self.codeTitleLabel.x, self.codeTitleLabel.bottom + ScaleW(13), self.alertView.width - ScaleW(30), ScaleW(40))];
        _codeTextField.backgroundColor = kMainBackgroundColor;
        _codeTextField.textColor = kTextLightWhiteColor;
        _codeTextField.placeholder = SSKJLocalized(@"请输入谷歌验证码", nil);
        [_codeTextField setValue:kTextDarkBlueColor forKeyPath:@"_placeholderLabel.textColor"];
        _codeTextField.font = systemFont(ScaleW(14));

    }
    return _codeTextField;
}

-(UIButton *)confirmButton
{
    if (nil == _confirmButton) {
        _confirmButton = [[UIButton alloc]initWithFrame:CGRectMake(0, self.codeTextField.bottom + ScaleW(50), ScaleW(160), ScaleW(40))];
        _confirmButton.centerX = self.alertView.width / 2;
        _confirmButton.layer.cornerRadius = _confirmButton.height / 2;
        _confirmButton.backgroundColor = kTextBlueColor;
        [_confirmButton setTitle:SSKJLocalized(@"确认", nil) forState:UIControlStateNormal];
        [_confirmButton setTitleColor:kMainWihteColor forState:UIControlStateNormal];
        _confirmButton.titleLabel.font = systemFont(ScaleW(15));
        [_confirmButton addTarget:self action:@selector(confirmEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmButton;
}


-(void)confirmEvent
{
    if (self.confirmBlock) {
        self.confirmBlock(self.codeTextField.text);
    }
    
//    [self hide];
}

-(void)show
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
}

-(void)hide
{
    [self removeFromSuperview];
}

@end
