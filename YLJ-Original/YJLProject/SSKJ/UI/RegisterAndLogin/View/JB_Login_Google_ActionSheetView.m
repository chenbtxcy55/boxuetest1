//
//  JB_Login_Google_ActionSheetView.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/5/28.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "JB_Login_Google_ActionSheetView.h"
#import "JB_VTitleAndInputView.h"
@interface JB_Login_Google_ActionSheetView ()
@property (nonatomic, strong) UIView *showView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) JB_VTitleAndInputView *codeView;
@property (nonatomic, strong) UIButton *confirmButton;
@end

@implementation JB_Login_Google_ActionSheetView

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
        [self addSubview:self.showView];
        [self.showView addSubview:self.titleLabel];
        [self.showView addSubview:self.codeView];
        [self.showView addSubview:self.confirmButton];
        
        self.showView.height = self.confirmButton.bottom + ScaleW(10);
        
        // 添加通知监听见键盘弹出/退出// 键盘出现的通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardDidShowNotification object:nil];
        // 键盘消失的通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHiden:) name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}

-(UIView *)showView
{
    if (nil == _showView) {
        _showView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 0)];
        _showView.backgroundColor = kSubBackgroundColor;
    }
    return _showView;
}

-(UILabel *)titleLabel
{
    if (nil == _titleLabel) {
        _titleLabel = [WLTools allocLabel:SSKJLocalized(@"安全验证", nil) font:systemFont(ScaleW(13)) textColor:kMainWihteColor frame:CGRectMake(ScaleW(15), ScaleW(20), ScaleW(200), ScaleW(14)) textAlignment:NSTextAlignmentLeft];
    }
    return _titleLabel;
}


- (JB_VTitleAndInputView *)codeView
{
    if (nil == _codeView) {
        _codeView = [[JB_VTitleAndInputView alloc]initWithFrame:CGRectMake(0, self.titleLabel.bottom + ScaleW(10), ScreenWidth, ScaleW(79)) leftGap:ScaleW(15) title:SSKJLocalized(@"谷歌验证码", nil) placeHolder:SSKJLocalized(@"请输入谷歌验证码", nil) font:systemFont(ScaleW(13)) keyBoardType:UIKeyboardTypeNumberPad isShowSecured:NO];
    }
    return _codeView;
}

-(UIButton *)confirmButton
{
    if (nil == _confirmButton) {
        _confirmButton = [[UIButton alloc]initWithFrame:CGRectMake(ScaleW(25), self.codeView.bottom + ScaleW(20), ScreenWidth - ScaleW(50), ScaleW(45))];
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


-(void)show
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
    self.showView.y = self.height;
    WS(weakSelf);
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.showView.y = ScreenHeight - weakSelf.showView.height;
    }];
}

-(void)hide
{
    WS(weakSelf);
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.showView.y = ScreenHeight;
    } completion:^(BOOL finished) {
        [weakSelf removeFromSuperview];
    }];
}

-(void)confirmEvent
{
    if (self.codeView.valueString.length == 0) {
        [MBProgressHUD showError:SSKJLocalized(@"请输入谷歌验证码", nil)];
        return;
    }
    
    if (self.confirmBlock) {
        self.confirmBlock(self.codeView.valueString);
    }
}


#pragma mark -键盘监听方法
- (void)keyboardWasShown:(NSNotification *)notification
{
    UIView *backView = self.codeView;
    
    // 获取键盘的高度
    CGRect frame = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    CGFloat textFieldY = ScreenHeight - (ScreenHeight - self.showView.height / 2 + backView.bottom);
    
    if (frame.size.height > textFieldY) {
        CGFloat yscale = frame.size.height - textFieldY;
        self.showView.y = ScreenHeight - self.showView.height / 2 - yscale;
    }
    
}


- (void)keyboardWillBeHiden:(NSNotification *)notification
{
    self.showView.y = self.height - self.showView.height;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
