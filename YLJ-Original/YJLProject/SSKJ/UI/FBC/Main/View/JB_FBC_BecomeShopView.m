//
//  JB_FBC_BecomeShopView.m
//  SSKJ
//
//  Created by James on 2019/5/23.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "JB_FBC_BecomeShopView.h"

@interface JB_FBC_BecomeShopView()
@property (nonatomic, strong) UIView *showView;
@property (nonatomic, strong) UILabel *titleLB;
@property (nonatomic, strong) UIButton *confirmButton;

@property (nonatomic, copy) void (^confirmBlock)(void);
@end

@implementation JB_FBC_BecomeShopView

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
        [self addSubview:self.showView];
        [self.showView addSubview:self.titleLB];
        [self.showView addSubview:self.confirmButton];
        self.showView.height = self.confirmButton.bottom + ScaleW(40);
        
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
-(UILabel *)titleLB
{
    if (nil == _titleLB) {
        _titleLB = [WLTools allocLabel:@"" font:systemFont(ScaleW(15)) textColor:kMainTextColor frame:CGRectMake(0, ScaleW(50), self.width, ScaleW(15)) textAlignment:NSTextAlignmentCenter];
    }
    return _titleLB;
}

-(UIButton *)confirmButton
{
    if (nil == _confirmButton) {
        _confirmButton = [[UIButton alloc]initWithFrame:CGRectMake(ScaleW(25), self.titleLB.bottom + ScaleW(50), ScreenWidth - ScaleW(50), ScaleW(45))];
        [_confirmButton setTitle:SSKJLocalized(@"去成为商家", nil) forState:UIControlStateNormal];
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
    if (self.confirmBlock) {
        self.confirmBlock();
    }
    [self hide];
}


+(void)showWithTitle:(NSString *)title confirmBlock:(void (^)(void))confirmBlock
{
    JB_FBC_BecomeShopView *actionSheet = [[JB_FBC_BecomeShopView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    actionSheet.confirmBlock = confirmBlock;
    actionSheet.titleLB.text = title?:@"";
    [actionSheet show];
}
@end
