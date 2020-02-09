//
//  HeBi_Publish_AlertView.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/4/15.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "HeBi_Publish_AlertView.h"

@interface HeBi_Publish_AlertView ()
@property (nonatomic, strong) UIView *alertView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *priceTitleLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *moneyTitleLabel;
@property (nonatomic, strong) UILabel *moneyLabel;
@property (nonatomic, strong) UILabel *amountTitleLabel;
@property (nonatomic, strong) UILabel *amountLabel;
@property (nonatomic, strong) UIView *inputBackView;
@property (nonatomic, strong) UITextField *pwdTextField;
@property (nonatomic, strong) UIButton *cancleButton;
@property (nonatomic, strong) UIButton *confirmButton;
@end

@implementation HeBi_Publish_AlertView

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
        [self setUI];
        
        // 添加通知监听见键盘弹出/退出// 键盘出现的通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardDidShowNotification object:nil];
        // 键盘消失的通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHiden:) name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}

-(void)setUI
{
    [self addSubview:self.alertView];
    [self.alertView addSubview:self.titleLabel];
    [self.alertView addSubview:self.priceTitleLabel];
    [self.alertView addSubview:self.priceLabel];
    [self.alertView addSubview:self.moneyTitleLabel];
    [self.alertView addSubview:self.moneyLabel];
    [self.alertView addSubview:self.amountTitleLabel];
    [self.alertView addSubview:self.amountLabel];
    [self.alertView addSubview:self.inputBackView];
    [self.inputBackView addSubview:self.pwdTextField];
    [self.alertView addSubview:self.confirmButton];
    
    self.alertView.height = self.confirmButton.bottom;
    self.alertView.centerY = ScreenHeight / 2 - 20;
    [self addSubview:self.cancleButton];

}

-(UIView *)alertView
{
    if (nil == _alertView) {
        _alertView = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(26), 0, ScreenWidth - ScaleW(52), 0)];
        _alertView.layer.masksToBounds = YES;
        _alertView.layer.cornerRadius = 6.0f;
        _alertView.backgroundColor = kMainWihteColor;
    }
    return _alertView;
}

-(UILabel *)titleLabel
{
    if (nil == _titleLabel) {
        _titleLabel = [WLTools allocLabel:SSKJLocalized(@"下单确认", nil) font:systemScaleBoldFont(17) textColor: kTitleColor frame:CGRectMake(0, ScaleW(22), self.alertView.width, ScaleW(17)) textAlignment:NSTextAlignmentCenter];
    }
    return _titleLabel;
}

-(UILabel *)priceTitleLabel
{
    if (nil == _priceTitleLabel) {
        _priceTitleLabel = [WLTools allocLabel:SSKJLocalized(@"出售单价", nil) font:systemFont(ScaleW(15)) textColor: kTitleColor frame:CGRectMake(25, self.titleLabel.bottom + ScaleW(23), ScaleW(80), ScaleW(15)) textAlignment:NSTextAlignmentLeft];
    }
    return _priceTitleLabel;
}

-(UILabel *)priceLabel
{
    if (nil == _priceLabel) {
        _priceLabel = [WLTools allocLabel:@"" font:systemFont(ScaleW(15)) textColor: kSubTitleColor frame:CGRectMake(self.priceTitleLabel.right, 0, self.alertView.width - ScaleW(15) - self.priceTitleLabel.right, ScaleW(15)) textAlignment:NSTextAlignmentRight];
        _priceLabel.centerY = self.priceTitleLabel.centerY;
    }
    return _priceLabel;
}

-(UILabel *)moneyTitleLabel
{
    if (nil == _moneyTitleLabel) {
        _moneyTitleLabel = [WLTools allocLabel:SSKJLocalized(@"出售金额", nil) font:systemFont(ScaleW(15)) textColor: kTitleColor frame:CGRectMake(25, self.priceTitleLabel.bottom + ScaleW(23), ScaleW(80), ScaleW(15)) textAlignment:NSTextAlignmentLeft];
    }
    return _moneyTitleLabel;
}

-(UILabel *)moneyLabel
{
    if (nil == _moneyLabel) {
        _moneyLabel = [WLTools allocLabel:@"" font:systemFont(ScaleW(15)) textColor: kSubTitleColor frame:CGRectMake(self.moneyTitleLabel.right, 0, self.alertView.width - ScaleW(15) - self.moneyTitleLabel.right, ScaleW(15)) textAlignment:NSTextAlignmentRight];
        _moneyLabel.centerY = self.moneyTitleLabel.centerY;
    }
    return _moneyLabel;
}
    

-(UILabel *)amountTitleLabel
{
    if (nil == _amountTitleLabel) {
        _amountTitleLabel = [WLTools allocLabel:SSKJLocalized(@"出售数量", nil) font:systemFont(ScaleW(15)) textColor: kTitleColor frame:CGRectMake(25, self.moneyTitleLabel.bottom + ScaleW(23), ScaleW(80), ScaleW(15)) textAlignment:NSTextAlignmentLeft];
    }
    return _amountTitleLabel;
}

-(UILabel *)amountLabel
{
    if (nil == _amountLabel) {
        _amountLabel = [WLTools allocLabel:@"" font:systemFont(ScaleW(15)) textColor: kSubTitleColor frame:CGRectMake(self.moneyTitleLabel.right, 0, self.alertView.width - ScaleW(15) - self.moneyTitleLabel.right, ScaleW(15)) textAlignment:NSTextAlignmentRight];
        _amountLabel.centerY = self.amountTitleLabel.centerY;
    }
    return _amountLabel;
}

-(UIView *)inputBackView
{
    if (nil == _inputBackView) {
        _inputBackView = [[UIView alloc]initWithFrame:CGRectMake(self.priceTitleLabel.x, self.amountTitleLabel.bottom + ScaleW(18), self.alertView.width - 2 * self.priceTitleLabel.x, ScaleW(45))];
        _inputBackView.layer.masksToBounds = YES;
        _inputBackView.layer.borderColor = kLineGrayColor.CGColor;
        _inputBackView.layer.borderWidth = 0.5;
        _inputBackView.layer.cornerRadius = 4.0f;
    }
    return _inputBackView;
}

-(UITextField *)pwdTextField
{
    if (nil == _pwdTextField) {
        _pwdTextField = [[UITextField alloc]initWithFrame:CGRectMake(ScaleW(12), 0, self.inputBackView.width - ScaleW(24), self.inputBackView.height)];
        _pwdTextField.textColor =  kSubTitleColor;
        _pwdTextField.font = systemFont(ScaleW(14));
        _pwdTextField.placeholder = SSKJLocalized(@"请输入安全密码", nil);
//        [_pwdTextField setValue:kGrayTitleColor forKeyPath:@"_placeholderLabel.textColor"];
        
        NSMutableAttributedString *placeholderString1 = [[NSMutableAttributedString alloc] initWithString: SSKJLocalized(@"请输入安全密码", nil) attributes:@{NSForegroundColorAttributeName : kGrayTitleColor}];
        
        _pwdTextField.attributedPlaceholder = placeholderString1;
        _pwdTextField.secureTextEntry = YES;
    }
    return _pwdTextField;
}

-(UIButton *)cancleButton
{
    if (nil == _cancleButton) {
        _cancleButton = [[UIButton alloc]initWithFrame:CGRectMake(0, self.alertView.bottom + ScaleW(30), ScaleW(35), ScaleW(35))];
        _cancleButton.centerX = self.centerX;
        _cancleButton.y = self.alertView.bottom + ScaleW(30);
        [_cancleButton setBackgroundImage:[UIImage imageNamed:@"otc_cancel"] forState:UIControlStateNormal];
        [_cancleButton addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancleButton;
}


-(UIButton *)confirmButton
{
    if (nil == _confirmButton) {
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, self.inputBackView.bottom + ScaleW(25), self.alertView.width, 0.5)];
        line.backgroundColor = kLineGrayColor;
        [self.alertView addSubview:line];
        
        _confirmButton = [[UIButton alloc]initWithFrame:CGRectMake(0, line.bottom, self.alertView.width, ScaleW(50))];
        [_confirmButton setTitle:SSKJLocalized(@"确定", nil) forState:UIControlStateNormal];
        [_confirmButton setTitleColor:kMainBlueColor forState:UIControlStateNormal];
        _confirmButton.titleLabel.font = systemBoldFont(ScaleW(16));
        [_confirmButton addTarget:self action:@selector(confirmEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmButton;
}


-(void)showWithPublishType:(PublishType)publishType price:(NSString *)price amount:(NSString *)amount
{
    self.pwdTextField.text = nil;
    
    if (publishType == PublishTypeBuy) {
        self.priceTitleLabel.text = SSKJLocalized(@"购买单价", nil);
        self.moneyTitleLabel.text = SSKJLocalized(@"购买金额", nil);
        self.amountTitleLabel.text = SSKJLocalized(@"购买数量", nil);
    }else{
        self.priceTitleLabel.text = SSKJLocalized(@"出售单价", nil);
        self.moneyTitleLabel.text = SSKJLocalized(@"出售金额", nil);
        self.amountTitleLabel.text = SSKJLocalized(@"出售数量", nil);
    }
    
    self.priceLabel.text = [NSString stringWithFormat:@"%@ETH",price];
    self.amountLabel.text = [NSString stringWithFormat:@"%@ISCM",amount];
    self.moneyLabel.text = [NSString stringWithFormat:@"%@ETH",[WLTools noroundingStringWith:price.doubleValue * amount.doubleValue afterPointNumber:4]];
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
}

-(void)hide
{
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
    }
}


#pragma mark -键盘监听方法
- (void)keyboardWasShown:(NSNotification *)notification
{
    // 获取键盘的高度
    CGRect frame = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    UIView *backView = self.inputBackView;

    CGFloat textFieldY = ScreenHeight - (ScreenHeight / 2 - self.alertView.height / 2 + backView.bottom);
    
    if (frame.size.height > textFieldY) {
        CGFloat yscale = frame.size.height - textFieldY;
        self.alertView.y = ScreenHeight / 2 - self.alertView.height / 2 - yscale;
    }
    
}


- (void)keyboardWillBeHiden:(NSNotification *)notification
{
    self.alertView.centerY = self.height / 2;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
