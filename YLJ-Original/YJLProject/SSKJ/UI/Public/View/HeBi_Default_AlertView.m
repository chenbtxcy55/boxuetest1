//
//  HeBi_Default_AlertView.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/4/16.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "HeBi_Default_AlertView.h"

@interface HeBi_Default_AlertView ()
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIImageView *showView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *messageLabel;

@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIView *lineView2;

@property (nonatomic, strong) UIButton *cancleButton;
@property (nonatomic, strong) UIButton *confirmButton;

@property (nonatomic, copy) void (^confirmBlock)(void);

@end

@implementation HeBi_Default_AlertView


-(instancetype)init
{
    if (self = [super initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)]) {
        
        
        [self addSubview:self.backView];
        [self addSubview:self.showView];
        [self.showView addSubview:self.titleLabel];
        [self.showView addSubview:self.messageLabel];
//        [self.showView addSubview:self.lineView];
        [self.showView addSubview:self.cancleButton];
        [self.showView addSubview:self.confirmButton];

        self.showView.height = self.confirmButton.bottom + ScaleW(20);
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
        _showView = [[UIImageView alloc]initWithFrame:CGRectMake(ScaleW(30), 0, self.width - ScaleW(60), ScaleW(190))];
        _showView.backgroundColor = kBgColor;
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
        _titleLabel = [WLTools allocLabel:@"退出登录" font:systemFont(ScaleW(16)) textColor:RGBCOLOR(18, 18, 18) frame:CGRectMake(ScaleW(15), ScaleW(15), self.showView.width - ScaleW(30), ScaleW(16)) textAlignment:NSTextAlignmentCenter];
    }
    return _titleLabel;
}

-(UILabel *)messageLabel
{
    if (nil == _messageLabel) {
        _messageLabel = [WLTools allocLabel:@"" font:systemFont(ScaleW(12)) textColor:kSubTitleColor frame:CGRectMake(ScaleW(15), ScaleW(53), self.showView.width - ScaleW(30), ScaleW(18)) textAlignment:NSTextAlignmentCenter];
        _messageLabel.numberOfLines = 0;
    }
    return _messageLabel;
}

- (UIView *)lineView
{
    if (nil == _lineView) {
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(12), self.titleLabel.bottom+ScaleW(10), self.showView.width - ScaleW(24), 0.5)];
        _lineView.backgroundColor = kLineGrayColor;
        
       _lineView2 = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(12), _messageLabel.bottom+ScaleW(10), self.showView.width - ScaleW(24), 0.5)];
        [self.showView addSubview:_lineView2];
        
        _lineView2.backgroundColor = kLineGrayColor;
    }
    return _lineView;
}

-(UIButton *)cancleButton
{
    if (nil == _cancleButton) {
        
        _cancleButton = [[UIButton alloc]initWithFrame:CGRectMake(ScaleW(35), self.messageLabel.bottom + ScaleW(25), (self.showView.width - ScaleW(90)) * 0.5, ScaleW(36))];
        [_cancleButton setTitle:SSKJLocalized(@"取消",nil) forState:UIControlStateNormal];
        [_cancleButton setTitleColor:kMainTextColor forState:UIControlStateNormal];
        _cancleButton.titleLabel.font = systemFont(ScaleW(14));
        _cancleButton.layer.masksToBounds = YES;
        _cancleButton.layer.cornerRadius = ScaleW(5);
        _cancleButton.backgroundColor = UIColorFromRGB(0xf0f0f0);
//        _cancleButton.layer.borderWidth = 1;
//        _cancleButton.layer.borderColor = k.CGColor;
        [_cancleButton addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancleButton;
}

-(UIButton *)confirmButton
{
    if (nil == _confirmButton) {
    
        _confirmButton = [[UIButton alloc]initWithFrame:CGRectMake(self.cancleButton.right + ScaleW(20), self.cancleButton.y, self.cancleButton.width, self.cancleButton.height)];
        [_confirmButton setTitle:SSKJLocalized(@"确定",nil) forState:UIControlStateNormal];
        [_confirmButton setTitleColor:kMainColor forState:UIControlStateNormal];
        _confirmButton.titleLabel.font = systemFont(ScaleW(14));
        _confirmButton.layer.masksToBounds = YES;
        _confirmButton.layer.cornerRadius = ScaleW(5);
        _confirmButton.backgroundColor = kTheMeColor;
        [_confirmButton addTarget:self action:@selector(confirmEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmButton;
}

+(void)showWithTitle:(NSString *)title message:(NSString *)message cancleTitle:(NSString *)cancleTitle confirmTitle:(NSString *)confirmTitle confirmBlock:(nonnull void (^)(void))confirmblock
{
    
    HeBi_Default_AlertView *alertView = [[HeBi_Default_AlertView alloc]init];
    
    alertView.confirmBlock = confirmblock;
    alertView.titleLabel.text = title;
    alertView.messageLabel.text = message;
    
    
//    [alertView.cancleButton setTitle:cancleTitle forState:UIControlStateNormal];
    [alertView.confirmButton setTitle:confirmTitle forState:UIControlStateNormal];
    CGFloat height = [message boundingRectWithSize:CGSizeMake(alertView.messageLabel.width, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:alertView.messageLabel.font} context:nil].size.height;
    alertView.messageLabel.height = height;
//    if (message.length == 0) {
//        alertView.lineView.y = alertView.titleLabel.bottom + ScaleW(26);
//    }else if (title.length == 0){
//        alertView.messageLabel.y = ScaleW(30);
//        alertView.lineView.y = alertView.messageLabel.bottom + ScaleW(40);
//    }else{
//        alertView.lineView.y = alertView.messageLabel.bottom + ScaleW(40);
//    }
    
//    alertView.lineView.y = alertView.messageLabel.bottom + ScaleW(26);
    alertView.cancleButton.y = alertView.messageLabel.bottom + ScaleW(25);
    alertView.confirmButton.y = alertView.messageLabel.bottom + ScaleW(25);
  

    alertView.showView.height = alertView.confirmButton.bottom + ScaleW(20);
    alertView.showView.centerY = ScreenHeight / 2 - 20;
    
    if (cancleTitle.length == 0) {
        alertView.cancleButton.hidden = YES;
        
        alertView.confirmButton.centerX = alertView.showView.width * 0.5;
    }else{
        alertView.cancleButton.hidden = NO;
    }
    if ([title isEqualToString:SSKJLocalized(@"解除商家认证", nil)]) {
       
        alertView.cancleButton.layer.borderColor=[[UIColor clearColor] CGColor];
        
        alertView.confirmButton.backgroundColor=[UIColor clearColor];
        
        [alertView.confirmButton setTitleColor:kMainBlueColor forState:UIControlStateNormal];
        [alertView.cancleButton setTitleColor:kSubTitleColor forState:UIControlStateNormal];
        
        alertView.titleLabel.textAlignment= NSTextAlignmentLeft;
        
        [alertView.showView addSubview:alertView.lineView];
        
        alertView.lineView2.y=alertView.messageLabel.bottom+ScaleW(15);
        
    }
    else{
        alertView.titleLabel.textAlignment= NSTextAlignmentCenter;

//        alertView.titleLabel.hidden=YES;
    }
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:alertView];
}

-(void)hide
{
    [self removeFromSuperview];
}


-(void)confirmEvent
{
    [self hide];
    if (self.confirmBlock) {
        self.confirmBlock();
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
