//
//  ActivateWarmAlertView.m
//  SSKJ
//
//  Created by zhao on 2019/10/9.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "ActivateWarmAlertView.h"
@interface ActivateWarmAlertView ()

@property (nonatomic, strong) UIView *alertView;

@end

@implementation ActivateWarmAlertView
-(instancetype)init
{
    if (self = [super initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)]) {
        self.backgroundColor = [WLTools stringToColor:@"#000000" andAlpha:0.7];
        
        
        [self addSubview:self.alertView];
        [self.alertView addSubview:self.titlelab];
        [self.alertView addSubview:self.detailLab];
        [self.alertView addSubview:self.cancleButton];
        [self.alertView addSubview:self.confirmButton];

        [self.alertView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY);
            make.centerX.equalTo(self.mas_centerX);
            make.size.mas_equalTo(CGSizeMake(ScaleW(330), ScaleW(253)));
        }];
        self.alertView.clipsToBounds = YES;
        self.alertView.layer.cornerRadius = ScaleW(10);
        
        [self.titlelab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.alertView.mas_centerX);
            make.top.equalTo(self.alertView.mas_top).offset(ScaleW(32));
            make.width.equalTo(@(ScaleW(300)));
        }];
        [self.detailLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.alertView.mas_centerX);
            make.top.equalTo(self.alertView.mas_top).offset(ScaleW(91));
            make.width.equalTo(@(ScaleW(300)));
        }];
        [self.cancleButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(ScaleW(125), ScaleW(40)));
            make.bottom.equalTo(self.alertView.mas_bottom).offset(ScaleW(-40));
            make.right.equalTo(self.alertView.mas_centerX).offset(ScaleW(-10));
        }];
        [self.confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(ScaleW(125), ScaleW(40)));
            make.bottom.equalTo(self.alertView.mas_bottom).offset(ScaleW(-40));
            make.left.equalTo(self.alertView.mas_centerX).offset(ScaleW(10));
        }];
        
    }
    return self;
}


-(UIView *)alertView
{
    if (nil == _alertView) {
        _alertView = [[UIView alloc]initWithFrame:CGRectZero];
        _alertView.backgroundColor = kNavBGColor;
        
    }
    return _alertView;
}
- (UILabel *)titlelab{
    if (!_titlelab) {
        _titlelab = [WLTools allocLabel:SSKJLocalized(@"预约成功", nil) font:systemFont(ScaleW(16)) textColor:kMainWihteColor frame:CGRectZero textAlignment:NSTextAlignmentCenter];
        _titlelab.numberOfLines = 1;
    }
    return _titlelab;
}

- (UILabel *)detailLab{
    if (!_detailLab) {
        _detailLab = [WLTools allocLabel:SSKJLocalized(@"预约成功，请及时去付款！", nil) font:systemFont(ScaleW(15)) textColor:TextGrayb5b5b5 frame:CGRectZero textAlignment:NSTextAlignmentCenter];
        _detailLab.numberOfLines = 2;

    }
    return _detailLab;
}
-(UIButton *)cancleButton
{
    if (nil == _cancleButton) {
        
        _cancleButton = [[UIButton alloc]initWithFrame:CGRectZero];
        
        [_cancleButton setTitle:SSKJLocalized(@"取消", nil) forState:UIControlStateNormal];
        [_cancleButton setTitleColor:CodeBtnColor forState:UIControlStateNormal];
        _cancleButton.titleLabel.font = systemFont(ScaleW(15));
        _cancleButton.layer.masksToBounds = YES;
        _cancleButton.layer.cornerRadius = ScaleW(5);
        _cancleButton.layer.borderColor = CodeBtnColor.CGColor;
        _cancleButton.layer.borderWidth = 1;
        [_cancleButton addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancleButton;
}

-(UIButton *)confirmButton
{
    if (nil == _confirmButton) {
        
        _confirmButton = [[UIButton alloc]initWithFrame:CGRectZero];
        [_confirmButton setTitle:SSKJLocalized(@"确定", nil) forState:UIControlStateNormal];
//        [_confirmButton setBackgroundImage:[UIImage imageNamed:@"login_Btn_bg"] forState:UIControlStateNormal];
//        [_confirmButton setBackgroundImage:[UIImage imageNamed:@"login_Btn_bg"] forState:UIControlStateHighlighted];
        _confirmButton.backgroundColor = kTheMeColor;
        [_confirmButton setTitleColor:kMainWihteColor forState:UIControlStateNormal];
        _confirmButton.titleLabel.font = systemBoldFont(ScaleW(15));
        [_confirmButton addTarget:self action:@selector(confirmEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmButton;
}
- (void)hide{
    
    if (self.cancelClickBlock) {
        self.cancelClickBlock();
    }
    [self removeFromSuperview];
}
- (void)confirmEvent{
    if (self.confirmBlock) {
        self.confirmBlock();
    }
    [self removeFromSuperview];
    
}
-(void)show
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
}
@end
