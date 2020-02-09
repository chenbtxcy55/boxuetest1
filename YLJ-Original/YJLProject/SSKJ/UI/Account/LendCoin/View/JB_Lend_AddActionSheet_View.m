//
//  JB_Lend_AddActionSheet_View.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/5/21.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "JB_Lend_AddActionSheet_View.h"
#import "JB_VTitleAndInputView.h"
@interface JB_Lend_AddActionSheet_View ()

@property (nonatomic, strong) UIView *showView;
@property (nonatomic, strong) UILabel *usableLabel;
@property (nonatomic, strong) JB_VTitleAndInputView *amountView;
@property (nonatomic, strong) JB_VTitleAndInputView *pwdView;
@property (nonatomic, strong) UIButton *confirmButton;

@property (nonatomic, copy) void (^confirmBlock)(NSString *number,NSString *pwd);
@property (nonatomic, copy) void (^confirmPwdblock)(NSString *pwd);
@property (nonatomic, assign) BOOL onlyShowPwd;

@end

@implementation JB_Lend_AddActionSheet_View

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (instancetype)initWithFrame:(CGRect)frame onlyShowPwd:(BOOL)onlyShowPwd
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
        self.onlyShowPwd = onlyShowPwd;
        [self addSubview:self.showView];
        if (onlyShowPwd) {
            
            [self.showView addSubview:self.pwdView];
            [self.showView addSubview:self.confirmButton];
            self.pwdView.top = 0;
            self.confirmButton.top = self.pwdView.bottom+ScaleW(20);
            self.showView.height = self.confirmButton.bottom + ScaleW(30);
        }else {
            [self.showView addSubview:self.usableLabel];
            [self.showView addSubview:self.amountView];
            [self.showView addSubview:self.pwdView];
            [self.showView addSubview:self.confirmButton];
            self.showView.height = self.confirmButton.bottom + ScaleW(10);
        }

        
        // 添加通知监听见键盘弹出/退出// 键盘出现的通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardDidShowNotification object:nil];
        // 键盘消失的通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHiden:) name:UIKeyboardWillHideNotification object:nil];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hide)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

-(UIView *)showView
{
    if (nil == _showView) {
        _showView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 0)];
        _showView.backgroundColor = kSubBackgroundColor;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(endEditing)];
        [_showView addGestureRecognizer:tap];
    }
    return _showView;
}
-(UILabel *)usableLabel
{
    if (nil == _usableLabel) {
        _usableLabel = [WLTools allocLabel:@"" font:systemFont(ScaleW(13)) textColor: kMainTextColor frame:CGRectMake(ScaleW(15), ScaleW(20), self.width - ScaleW(30), ScaleW(15)) textAlignment:NSTextAlignmentLeft];
    }
    return _usableLabel;
}

-(JB_VTitleAndInputView *)amountView
{
    if (nil == _amountView) {
        _amountView = [[JB_VTitleAndInputView alloc]initWithFrame:CGRectMake(0, self.usableLabel.bottom, ScreenWidth, ScaleW(80)) leftGap:ScaleW(15) title:SSKJLocalized(@"补仓数量", nil) placeHolder:SSKJLocalized(@"请输入补仓数量", nil) font:systemFont(ScaleW(14)) keyBoardType:UIKeyboardTypeDecimalPad isShowSecured:NO];
    }
    return _amountView;
}

-(JB_VTitleAndInputView *)pwdView
{
    if (nil == _pwdView) {
        _pwdView = [[JB_VTitleAndInputView alloc]initWithFrame:CGRectMake(0, self.amountView.bottom, ScreenWidth, ScaleW(80)) leftGap:ScaleW(15) title:SSKJLocalized(@"安全密码", nil) placeHolder:SSKJLocalized(@"请输入安全密码", nil) font:systemFont(ScaleW(14)) keyBoardType:UIKeyboardTypeASCIICapable isShowSecured:YES];
        _pwdView.securedButton.hidden = YES;
    }
    return _pwdView;
}


-(UIButton *)confirmButton
{
    if (nil == _confirmButton) {
        _confirmButton = [[UIButton alloc]initWithFrame:CGRectMake(ScaleW(25), self.pwdView.bottom + ScaleW(30), ScreenWidth - ScaleW(50), ScaleW(45))];
        [_confirmButton setTitle:SSKJLocalized(@"确定", nil) forState:UIControlStateNormal];
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
    self.showView.y = self.height;
    [window addSubview:self];
    WS(weakSelf);
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.showView.y = weakSelf.height - weakSelf.showView.height;
    }];
}

-(void)endEditing
{
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
}

-(void)hide
{
    WS(weakSelf);
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.showView.y = weakSelf.height;

    } completion:^(BOOL finished) {
        [weakSelf removeFromSuperview];
    }];
}

-(void)confirmEvent
{
    
    if (!self.onlyShowPwd) {
        if (self.amountView.valueString.length == 0) {
            [MBProgressHUD showError:SSKJLocalized(@"请输入补仓金额", nil)];
            return;
        }
        
        if (self.amountView.valueString.doubleValue == 0) {
            [MBProgressHUD showError:SSKJLocalized(@"补仓金额不能为0", nil)];
            return;
        }
    }

    
    if (self.pwdView.valueString.length == 0) {
        [MBProgressHUD showError:SSKJLocalized(@"请输入安全密码", nil)];
        return;
    }
    
    if (self.onlyShowPwd) {
        if (self.confirmPwdblock) {
            self.confirmPwdblock(self.pwdView.valueString?:@"");
        }
    }else{
        if (self.confirmBlock) {
            self.confirmBlock(self.amountView.valueString, self.pwdView.valueString);
        }
    }
    
    [self hide];
}


+(void)showWithModel:(JB_Account_Asset_Index_Model *)model confirmBlock:(void(^)(NSString *number,NSString *pwd))confirmblock
{
    JB_Lend_AddActionSheet_View *actionSheet = [[JB_Lend_AddActionSheet_View alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) onlyShowPwd:NO];
    actionSheet.confirmBlock = confirmblock;
    actionSheet.usableLabel.text = [NSString stringWithFormat:@"%@%@：%@",SSKJLocalized(@"可用", nil),model.mark,[WLTools noroundingStringWith:model.usable.doubleValue afterPointNumber:[WLTools dotNumberOfCoinName:model.mark]]];
    
    
    [actionSheet show];
}

+(void)showPayPwdWithConfirmBlock:(void(^)(NSString *pwd))confirmPwdblock
{
    JB_Lend_AddActionSheet_View *actionSheet = [[JB_Lend_AddActionSheet_View alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) onlyShowPwd:YES];
    actionSheet.amountView.hidden = YES;
    actionSheet.usableLabel.hidden = YES;
    actionSheet.confirmPwdblock = confirmPwdblock;

    [actionSheet show];
    
}



#pragma mark -键盘监听方法
- (void)keyboardWasShown:(NSNotification *)notification
{
    UIView *backView;
    
    if (self.amountView.textField.isFirstResponder) {
        backView = self.amountView;
    }else{
        backView = self.pwdView;
    }
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
