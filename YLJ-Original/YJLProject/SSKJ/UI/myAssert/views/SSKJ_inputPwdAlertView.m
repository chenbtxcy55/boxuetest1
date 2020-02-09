//
//  My_BindGoogle_AlertView.m
//  ZYW_MIT
//
//  Created by 刘小雨 on 2019/3/28.
//  Copyright © 2019年 Wang. All rights reserved.
//

#import "SSKJ_inputPwdAlertView.h"

@interface SSKJ_inputPwdAlertView ()
@property (nonatomic, strong) UIView *alertView;
@property (nonatomic, strong) UILabel *titleLabel;
//@property (nonatomic, strong) UILabel *titleLabel2;
@property (nonatomic, strong) UIButton *cancleBtn;
@property (nonatomic, strong) UITextField *codeTextField;

@property (nonatomic, strong) UIButton *submiteButton;
@end
@implementation SSKJ_inputPwdAlertView
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hide)];
        [self addGestureRecognizer:tap];
        
        // 添加通知监听见键盘弹出/退出// 键盘出现的通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardDidShowNotification object:nil];
        // 键盘消失的通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHiden:) name:UIKeyboardWillHideNotification object:nil];
        
        [self addSubview:self.alertView];
        
        
        
        [self.alertView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.mas_bottom);
            make.right.left.mas_equalTo(self);
            make.height.mas_equalTo(ScaleW(250));
        }];
        [self layoutIfNeeded];
        [self addChildrenViews];
    }
    return self;
}




- (void) addChildrenViews{
    self.titleLabel = [UILabel new];
//    self.cancleBtn = [UIButton new];
    UIView *topLineView = [UIView new];
//    self.titleLabel2 = [UILabel new];
    self.codeTextField = [UITextField new];
    UIView *bottomLineView = [UIView new];
    UIView *meddileLineView = [UIView new];
    
    [_alertView addSubview:self.titleLabel];
    [_alertView addSubview:self.cancleBtn];
    [_alertView addSubview:topLineView];
//    [_alertView addSubview:self.titleLabel2];
    [_alertView addSubview:self.codeTextField];
    [_alertView addSubview:bottomLineView];
    [_alertView addSubview:meddileLineView];
    [_alertView addSubview:self.submiteButton];
//    [self.submiteButton setBackgroundImage:[UIImage imageNamed:@"login_Btn_bg"] forState:UIControlStateNormal];
    self.submiteButton.backgroundColor = kTheMeColor;
    
    
    self.titleLabel.text = SSKJLocalized(@"请输入安全密码", nil);
//    self.titleLabel2.text = SSKJLocalized(@"请输入安全密码", nil);
    
    NSMutableAttributedString *placeholderString1 = [[NSMutableAttributedString alloc] initWithString: SSKJLocalized(@"请输入安全密码", nil) attributes:@{NSForegroundColorAttributeName : UIColorFromRGB(0xd3d3d3)}];
    
    self.codeTextField.attributedPlaceholder = placeholderString1;
//    self.codeTextField.placeholder = SSKJLocalized(@"请输入安全密码", nil);
    
    self.titleLabel.font = systemBoldFont(ScaleW(17));
     self.titleLabel.textColor = kMainTextColor;
//    [self.cancleBtn setTitle:SSKJLocalized(@"取消", nil) forState:UIControlStateNormal];
//    [self.cancleBtn setTitleColor:kTextGrayColor forState:UIControlStateNormal];
    self.cancleBtn.titleLabel.font = systemFont(ScaleW(14));
    self.codeTextField.font = systemFont(14);
//    topLineView.backgroundColor = bottomLineView.backgroundColor =
    bottomLineView.backgroundColor = kLineGrayColor;
    [self.cancleBtn addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
    self.codeTextField.secureTextEntry = YES;
    self.codeTextField.keyboardType =  UIKeyboardTypeDefault;
    self.codeTextField.font = systemScaleFont(15);
    self.codeTextField.textColor = kMainTextColor;
    
    
    meddileLineView.hidden = YES;
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self->_alertView.mas_top).offset(ScaleW(23));
        make.left.mas_equalTo(_alertView.mas_left).offset(ScaleW(15));
        make.height.mas_equalTo(ScaleW(20));
    }];
//    [self.cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_equalTo(_alertView.mas_right).offset(-ScaleW(15));
//        make.centerY.mas_equalTo(self.titleLabel.mas_centerY);
//    }];
    [topLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(ScaleW(0.5));
        make.right.left.mas_equalTo(_alertView);
        make.top.mas_equalTo(self.titleLabel.mas_bottom);
    }];
    
//    [self.titleLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.leading.mas_equalTo(self.titleLabel.mas_leading);
//        make.top.mas_equalTo(topLineView.mas_bottom);
//        make.height.mas_equalTo(ScaleW(40));
//    }];
//    [meddileLineView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.mas_equalTo(_alertView);
//        make.top.mas_equalTo(self.titleLabel2.mas_bottom);
//        make.height.mas_equalTo(0.5);
//    }];
    [self.codeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.titleLabel.mas_leading);
        make.right.mas_equalTo(_alertView.mas_right).offset(-ScaleW(15));

        make.height.mas_equalTo(ScaleW(50));
        make.top.mas_equalTo(_alertView.mas_top).offset(ScaleW(68));
    }];
    [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.codeTextField.mas_bottom);
        make.left.mas_equalTo(_alertView.mas_left).offset(ScaleW(15));
        make.right.mas_equalTo(_alertView.mas_right).offset(-ScaleW(15));

        make.height.mas_equalTo(ScaleW(1));
    }];
    
    [self.submiteButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(bottomLineView.mas_bottom).offset(ScaleW(30));
        make.height.mas_equalTo(ScaleW(46));
        make.left.mas_equalTo(_alertView.mas_left).offset(ScaleW(15));
        make.right.mas_equalTo(_alertView.mas_right).offset(ScaleW(-15));
        make.bottom.mas_equalTo(_alertView.mas_bottom).offset(ScaleW(-20));
    }];
}




-(UIView *)alertView
{
    if (nil == _alertView) {
        _alertView = [[UIView alloc]init];
        _alertView.backgroundColor = kBgColor353750;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:nil];
        [_alertView addGestureRecognizer:tap];

        
    }
    return _alertView;
}

- (UILabel *)titleLabel
{
    if (nil == _titleLabel) {
        _titleLabel = [FactoryUI createLabelWithFrame:CGRectMake(ScaleW(10), ScaleW(24), ScreenWidth, ScaleW(15)) text:@"" textColor:kMainTextColor font:systemFont(ScaleW(15.0))];
    }
    return _titleLabel;
}



-(UIButton *)submiteButton
{
    if (nil == _submiteButton) {
        _submiteButton = [[UIButton alloc]init];
        _submiteButton.layer.cornerRadius = ScaleW(5);
//        _submiteButton.backgroundColor = kTextBlueColor;
        [_submiteButton setTitle:SSKJLocalized(@"确定", nil) forState:UIControlStateNormal];
        [_submiteButton setTitleColor:kMainTextColor forState:UIControlStateNormal];
        _submiteButton.titleLabel.font = systemFont(ScaleW(16));
        [_submiteButton addTarget:self action:@selector(submitEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submiteButton;
}




-(void)showAlert
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
    WS(weakSelf);
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.alertView.y = weakSelf.height - weakSelf.alertView.height;
    }];
}

-(void)endEdit
{
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
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

-(void)submitEvent
{
    if (self.codeTextField.text.length == 0) {
        [MBProgressHUD showError:SSKJLocalized(@"请输入安全密码", nil)];
        return;
    }
    
    
    if (self.submitBlock) {
        self.submitBlock(self.codeTextField.text);
    }
    [self hide];
}


#pragma mark -键盘监听方法
- (void)keyboardWasShown:(NSNotification *)notification
{
    UIView *backView = self.alertView;
    
    // 获取键盘的高度
    CGRect frame = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
//    CGFloat textFieldY = ScreenHeight - (ScreenHeight - self.alertView.height / 2 + backView.bottom);
    
//    if (frame.size.height > textFieldY) {
//        CGFloat yscale = frame.size.height - textFieldY;
//        self.alertView.y = ScreenHeight - self.alertView.height / 2 - yscale;
//    }
    
    
    self.alertView.y = ScreenHeight - self.alertView.height - frame.size.height;
    
    
    
    
}
- (void)keyboardWillBeHiden:(NSNotification *)notification
{
    self.alertView.y = self.height - self.alertView.height;
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
