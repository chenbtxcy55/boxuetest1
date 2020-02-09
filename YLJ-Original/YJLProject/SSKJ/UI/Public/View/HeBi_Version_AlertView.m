//
//  HeBi_Version_AlertView.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/4/19.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "HeBi_Version_AlertView.h"

@interface HeBi_Version_AlertView ()
@property (nonatomic, strong) UIView *alertView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *versionLabel;


@property (nonatomic, strong) UILabel *contengLabel;    // 更新内容
@property (nonatomic, strong) UIButton *confirmButton;
@property (nonatomic, strong) UIButton *cancleButton;

@property (nonatomic, copy) void (^confirmBlock)(void);
@property (nonatomic, copy) void (^cancleBlock)(void);

@end

@implementation HeBi_Version_AlertView

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
    [self.alertView addSubview:self.imageView];
    [self.alertView addSubview:self.titleLabel];
    [self.alertView addSubview:self.versionLabel];
    [self.alertView addSubview:self.contengLabel];
    [self.alertView addSubview:self.confirmButton];
    [self addSubview:self.cancleButton];
}

-(UIView *)alertView
{
    if (nil == _alertView) {
        _alertView = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(35), 0, ScaleW(345), 0)];
        _alertView.centerX = ScreenWidth / 2;
        _alertView.backgroundColor = kMainWihteColor;
        _alertView.layer.cornerRadius = ScaleW(8);
    }
    return _alertView;
}

-(UIImageView *)imageView
{
    if (nil == _imageView) {
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.alertView.width, ScaleW(141))];
        _imageView.image = [UIImage imageNamed:SSKJLocalized(@"wd-bg-img-version", nil)];
    }
    return _imageView;
}

-(UILabel *)titleLabel
{
    if (nil == _titleLabel) {
        _titleLabel = [WLTools allocLabel:SSKJLocalized(@"发现新版本",nil) font:systemFont(ScaleW(18)) textColor:kMainTextColor frame:CGRectMake(ScaleW(25), self.imageView.bottom + ScaleW(40), ScaleW(270), ScaleW(19)) textAlignment:NSTextAlignmentCenter];
    }
    return _titleLabel;
}

-(UILabel *)versionLabel
{
    if (nil == _versionLabel) {
        _versionLabel = [WLTools allocLabel:SSKJLocalized(@"版本号：1.1.25",nil) font:systemFont(ScaleW(14)) textColor:kGrayVersionColor frame:CGRectMake(ScaleW(25), self.titleLabel.bottom + ScaleW(15), ScaleW(270), ScaleW(14)) textAlignment:NSTextAlignmentCenter];
    }
    return _versionLabel;
}

-(UILabel *)contengLabel
{
    if (nil == _contengLabel) {
        _contengLabel = [WLTools allocLabel:@"" font:systemFont(ScaleW(13.5)) textColor:UIColorFromRGB(0x333333) frame:CGRectMake(ScaleW(25), self.versionLabel.bottom + ScaleW(27), self.alertView.width - ScaleW(50), 0) textAlignment:NSTextAlignmentLeft];
    }
    return _contengLabel;
}

-(UIButton *)confirmButton
{
    if (nil == _confirmButton) {
        
        _confirmButton = [[UIButton alloc]initWithFrame:CGRectMake(ScaleW(15), self.contengLabel.bottom + ScaleW(32), self.alertView.width - ScaleW(30), ScaleW(44))];
        _confirmButton.centerX = self.alertView.width / 2;
//        [_confirmButton setImage:[UIImage imageNamed:SSKJLocalized(@"version_update",nil)] forState:UIControlStateNormal];
        _confirmButton.backgroundColor = kTheMeColor;
        [_confirmButton setTitle:SSKJLocalized(@"立即更新", nil) forState:UIControlStateNormal];
        [_confirmButton setTitleColor:kMainWihteColor forState:UIControlStateNormal];
//        _confirmButton.titleLabel.font = systemBoldFont(ScaleW(15));
//        _confirmButton.layer.cornerRadius = _confirmButton.height / 2;
        [_confirmButton setCornerRadius:ScaleW(5)];
        [_confirmButton addTarget:self action:@selector(confirmEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmButton;
}


-(UIButton *)cancleButton
{
    if (nil == _cancleButton) {
        _cancleButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, ScaleW(40), ScaleW(40))];
        [_cancleButton setImage:[UIImage imageNamed:@"bbgx-gb"] forState:UIControlStateNormal];
        _cancleButton.centerX = self.alertView.centerX;
        [_cancleButton addTarget:self action:@selector(cancleEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancleButton;
}

-(void)confirmEvent
{
    if (self.confirmBlock) {
        self.confirmBlock();
    }
}


+(void)showWithModel:(HeBi_Version_Model *)model confirmBlock:(void(^)(void))confirmblock cancleBlock:(void(^)(void))cancleBlock
{
    
    HeBi_Version_AlertView *versionAlertView = [[HeBi_Version_AlertView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    versionAlertView.confirmBlock = confirmblock;
    versionAlertView.cancleBlock = cancleBlock;
    versionAlertView.titleLabel.text = model.title;
    versionAlertView.versionLabel.text = [NSString stringWithFormat:@"版本号：%@",model.version];
    versionAlertView.contengLabel.text = model.content;
    CGFloat height = [model.content boundingRectWithSize:CGSizeMake(versionAlertView.contengLabel.width, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:systemFont(ScaleW(13.5))} context:nil].size.height;
    versionAlertView.contengLabel.height = height;
    versionAlertView.confirmButton.y = versionAlertView.contengLabel.bottom + ScaleW(32);
    versionAlertView.alertView.height = versionAlertView.confirmButton.bottom + ScaleW(11);
    versionAlertView.alertView.centerY = ScreenHeight / 2;
    versionAlertView.cancleButton.y = versionAlertView.alertView.bottom + ScaleW(22);
    if ([model.uptype intValue] == 1) {
        versionAlertView.cancleButton.hidden = YES;
    }
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:versionAlertView];
}

-(void)cancleEvent
{
    if (self.cancleBlock) {
        self.cancleBlock();
    }
    [self hide];
}

-(void)hide
{
    [self removeFromSuperview];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
