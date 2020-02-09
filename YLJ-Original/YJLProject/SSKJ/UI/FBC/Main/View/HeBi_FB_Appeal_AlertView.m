//
//  HeBi_FB_Appeal_AlertView.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/4/18.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "HeBi_FB_Appeal_AlertView.h"
@interface HeBi_FB_Appeal_AlertView ()<UITextViewDelegate>
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIImageView *showView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *reasonTitleLabel;

@property (nonatomic, strong) UIView *reasonBackView;
@property (nonatomic, strong) UILabel *placeHolderLabel;
@property (nonatomic, strong) UITextView *reasonTextView;
@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) UIButton *cancleButton;
@property (nonatomic, strong) UIButton *confirmButton;
@end

@implementation HeBi_FB_Appeal_AlertView

-(instancetype)init
{
    if (self = [super initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)]) {
        
        
        [self addSubview:self.backView];
        [self addSubview:self.showView];
        [self.showView addSubview:self.titleLabel];
//        [self.showView addSubview:self.reasonTitleLabel];
        [self.showView addSubview:self.reasonBackView];
        [self.reasonBackView addSubview:self.reasonTextView];
        [self.reasonBackView addSubview:self.placeHolderLabel];
        [self.showView addSubview:self.lineView];
        [self.showView addSubview:self.confirmButton];
        
        self.showView.height = self.confirmButton.bottom;
        self.showView.centerY = ScreenHeight / 2;
        [self addSubview:self.cancleButton];

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
        _titleLabel = [WLTools allocLabel:@"提交申诉" font:systemScaleBoldFont(17) textColor: kTitleColor frame:CGRectMake(ScaleW(22), ScaleW(23), self.showView.width - ScaleW(44), ScaleW(17)) textAlignment:NSTextAlignmentCenter];
    }
    return _titleLabel;
}

-(UILabel *)reasonTitleLabel
{
    if (nil == _reasonTitleLabel) {
        _reasonTitleLabel = [WLTools allocLabel:@"申诉理由" font:systemFont(ScaleW(14)) textColor: kMainTextColor frame:CGRectMake(ScaleW(22), self.titleLabel.bottom + ScaleW(61), self.showView.width - ScaleW(44), ScaleW(14)) textAlignment:NSTextAlignmentLeft];
    }
    return _reasonTitleLabel;
}

-(UIView *)reasonBackView
{
    if (nil == _reasonBackView) {
        _reasonBackView = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(22), self.titleLabel.bottom + ScaleW(25), self.showView.width - ScaleW(44), ScaleW(133))];
        _reasonBackView.layer.cornerRadius = 4;
        _reasonBackView.layer.borderWidth = 0.5;
        _reasonBackView.layer.borderColor = kGrayTitleColor.CGColor;
    }
    return _reasonBackView;
}

-(UILabel *)placeHolderLabel
{
    if (nil == _placeHolderLabel) {
        _placeHolderLabel = [WLTools allocLabel:SSKJLocalized(@"请输入申诉理由", nil) font:systemFont(ScaleW(14)) textColor:kGrayTitleColor frame:CGRectMake(ScaleW(10), ScaleW(10), self.reasonBackView.width - ScaleW(20), ScaleW(14)) textAlignment:NSTextAlignmentLeft];
    }
    return _placeHolderLabel;
}

-(UITextView *)reasonTextView
{
    if (nil == _reasonTextView) {
        _reasonTextView = [[UITextView alloc]initWithFrame:CGRectMake(ScaleW(8), 0, self.reasonBackView.width - ScaleW(16), self.reasonBackView.height)];
        _reasonTextView.font = systemFont(ScaleW(14));
        _reasonTextView.textColor = kSubTitleColor;
        _reasonTextView.delegate = self;
        _reasonTextView.backgroundColor = [UIColor clearColor];
    }
    return _reasonTextView;
}

-(UIView *)lineView
{
    if (nil == _lineView) {
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(0, self.reasonBackView.bottom + ScaleW(25), self.showView.width, 1)];
        _lineView.backgroundColor = kLineGrayColor;
    }
    return _lineView;
}


-(UIButton *)cancleButton
{
    if (nil == _cancleButton) {
        
        _cancleButton = [[UIButton alloc]initWithFrame:CGRectMake(0, self.showView.bottom + ScaleW(30), ScaleW(35), ScaleW(35))];
        _cancleButton.centerX = self.centerX;
        _cancleButton.y = self.showView.bottom + ScaleW(30);
        [_cancleButton setBackgroundImage:[UIImage imageNamed:@"otc_cancel"] forState:UIControlStateNormal];
        [_cancleButton addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancleButton;
}

-(UIButton *)confirmButton
{
    if (nil == _confirmButton) {
        
//        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, self.reasonBackView.bottom + ScaleW(25), self.showView.width, 0.5)];
//        line.backgroundColor = kLineGrayColor;
//        [self.showView addSubview:line];
        
        _confirmButton = [[UIButton alloc]initWithFrame:CGRectMake(0, self.lineView.bottom, self.showView.width, ScaleW(50))];
        [_confirmButton setTitle:SSKJLocalized(@"确定", nil) forState:UIControlStateNormal];
        [_confirmButton setTitleColor:kMainBlueColor forState:UIControlStateNormal];
        _confirmButton.titleLabel.font = systemBoldFont(ScaleW(16));
        [_confirmButton addTarget:self action:@selector(confirmEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmButton;
}

-(void)showWithTitle:(NSString *)title cancleTitle:(NSString *)cancleTitle confirmTitle:(NSString *)confirmTitle
{
    self.titleLabel.text = title;
    [self.cancleButton setTitle:cancleTitle forState:UIControlStateNormal];
    [self.confirmButton setTitle:confirmTitle forState:UIControlStateNormal];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
}

-(void)hide
{
    self.reasonTextView.text = @"";
    [self removeFromSuperview];
}


-(void)confirmEvent
{
    
    if (self.reasonTextView.text.length == 0) {
        [MBProgressHUD showError:SSKJLocalized(@"请描述您申诉的原因", nil)];
        return;
    }
    
    if (self.appeallock) {
        self.appeallock(self.reasonTextView.text);
        [self hide];
    }
}

#pragma mark - UITextViewDelegate

-(void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length == 0) {
        self.placeHolderLabel.hidden = NO;
    }else{
        self.placeHolderLabel.hidden = YES;
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
