
//
//  JB_BBTrade_BuyAlert_View.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/5/21.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "JB_BBTrade_BuyAlert_View.h"

@interface JB_BBTrade_BuyAlert_View ()
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIImageView *showView;

@property (nonatomic, strong) UILabel *directTitleLabel;     // 方向label
@property (nonatomic, strong) UILabel *directLabel;     // 方向label

@property (nonatomic, strong) UILabel *typeTitleLabel;
@property (nonatomic, strong) UILabel *typeLabel;

@property (nonatomic, strong) UILabel *priceTypeLabel;
@property (nonatomic, strong) UILabel *priceLabel;

@property (nonatomic, strong) UILabel *amountTitleLabel;
@property (nonatomic, strong) UILabel *amountLabel;

@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIButton *cancleButton;
@property (nonatomic, strong) UIButton *confirmButton;

@property (nonatomic, copy) void (^confirmBlock)(void);
@end

@implementation JB_BBTrade_BuyAlert_View



-(instancetype)init
{
    if (self = [super initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)]) {
        
        
        [self addSubview:self.backView];
        [self addSubview:self.showView];
        
        [self.showView addSubview:self.directTitleLabel];
        [self.showView addSubview:self.directLabel];
        
        [self.showView addSubview:self.typeTitleLabel];
        [self.showView addSubview:self.typeLabel];
        
        [self.showView addSubview:self.priceTypeLabel];
        [self.showView addSubview:self.priceLabel];
        
        [self.showView addSubview:self.amountTitleLabel];
        [self.showView addSubview:self.amountLabel];
        
        [self.showView addSubview:self.lineView];
        [self.showView addSubview:self.cancleButton];
        [self.showView addSubview:self.confirmButton];
        
        self.showView.height = self.cancleButton.bottom + ScaleW(20);
        self.showView.centerY = ScreenHeight / 2;
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
        _showView = [[UIImageView alloc]initWithFrame:CGRectMake(ScaleW(12), 0, self.width - ScaleW(24), ScaleW(190))];
        _showView.backgroundColor = kSubBackgroundColor;
        _showView.center = CGPointMake(ScreenWidth / 2, ScreenHeight / 2);
        _showView.layer.masksToBounds = YES;
        _showView.layer.cornerRadius = 6.0f;
        _showView.userInteractionEnabled = YES;
    }
    return _showView;
}

-(UILabel *)directTitleLabel
{
    if (nil == _directTitleLabel) {
        _directTitleLabel = [WLTools allocLabel:SSKJLocalized(@"方向", nil) font:systemFont(ScaleW(13)) textColor:kTextDarkBlueColor frame:CGRectMake(ScaleW(15), ScaleW(30), ScaleW(60),  ScaleW(13)) textAlignment:NSTextAlignmentLeft];
    }
    return _directTitleLabel;
}

-(UILabel *)directLabel
{
    if (nil == _directLabel) {
        _directLabel = [WLTools allocLabel:SSKJLocalized(@"", nil) font:systemFont(ScaleW(13)) textColor:kTextDarkBlueColor frame:CGRectMake(self.directTitleLabel.right, self.directTitleLabel.y, self.showView.width / 2 -  self.directTitleLabel.right,  ScaleW(13)) textAlignment:NSTextAlignmentLeft];
    }
    return _directLabel;
}


-(UILabel *)typeTitleLabel
{
    if (nil == _typeTitleLabel) {
        _typeTitleLabel = [WLTools allocLabel:SSKJLocalized(@"类型", nil) font:systemFont(ScaleW(13)) textColor:kTextDarkBlueColor frame:CGRectMake(self.directLabel.right, self.directTitleLabel.y, self.directTitleLabel.width,  ScaleW(13)) textAlignment:NSTextAlignmentLeft];
    }
    return _typeTitleLabel;
}

-(UILabel *)typeLabel
{
    if (nil == _typeLabel) {
        _typeLabel = [WLTools allocLabel:SSKJLocalized(@"", nil) font:systemFont(ScaleW(13)) textColor:kTextDarkBlueColor frame:CGRectMake(self.typeTitleLabel.right, self.directTitleLabel.y, self.directLabel.width,  ScaleW(13)) textAlignment:NSTextAlignmentLeft];
    }
    return _typeLabel;
}


-(UILabel *)priceTypeLabel
{
    if (nil == _priceTypeLabel) {
        _priceTypeLabel = [WLTools allocLabel:SSKJLocalized(@"价格", nil) font:systemFont(ScaleW(13)) textColor:kTextDarkBlueColor frame:CGRectMake(ScaleW(15), self.directTitleLabel.bottom + ScaleW(20), self.directTitleLabel.width,  ScaleW(13)) textAlignment:NSTextAlignmentLeft];
    }
    return _priceTypeLabel;
}

-(UILabel *)priceLabel
{
    if (nil == _priceLabel) {
        _priceLabel = [WLTools allocLabel:SSKJLocalized(@"", nil) font:systemFont(ScaleW(13)) textColor:kTextDarkBlueColor frame:CGRectMake(self.directLabel.x, self.priceTypeLabel.y, self.directLabel.width,  ScaleW(13)) textAlignment:NSTextAlignmentLeft];
    }
    return _priceLabel;
}


-(UILabel *)amountTitleLabel
{
    if (nil == _amountTitleLabel) {
        _amountTitleLabel = [WLTools allocLabel:SSKJLocalized(@"数量", nil) font:systemFont(ScaleW(13)) textColor:kTextDarkBlueColor frame:CGRectMake(self.typeTitleLabel.x, self.priceTypeLabel.y, self.directTitleLabel.width,  ScaleW(13)) textAlignment:NSTextAlignmentLeft];
    }
    return _amountTitleLabel;
}

-(UILabel *)amountLabel
{
    if (nil == _amountLabel) {
        _amountLabel = [WLTools allocLabel:SSKJLocalized(@"", nil) font:systemFont(ScaleW(13)) textColor:kTextDarkBlueColor frame:CGRectMake(self.typeLabel.x, self.amountTitleLabel.y, self.directLabel.width,  ScaleW(13)) textAlignment:NSTextAlignmentLeft];
    }
    return _amountLabel;
}



- (UIView *)lineView
{
    if (nil == _lineView) {
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(0), self.amountLabel.bottom + ScaleW(30), self.showView.width, 0.5)];
        _lineView.backgroundColor = kLineGrayColor;
    }
    return _lineView;
}

-(UIButton *)cancleButton
{
    if (nil == _cancleButton) {
        
        _cancleButton = [[UIButton alloc]initWithFrame:CGRectMake(0, self.lineView.bottom + ScaleW(14), self.showView.width / 2, ScaleW(35))];
        _cancleButton.layer.masksToBounds = YES;
        //        _cancleButton.layer.cornerRadius = _cancleButton.height / 2;
        //        _cancleButton.layer.borderColor = MainTextColor.CGColor;
        //        _cancleButton.layer.borderWidth = 0.5;
        [_cancleButton setTitle:SSKJLocalized(@"取消", nil)  forState:UIControlStateNormal];
        [_cancleButton setTitleColor:kTextLightBlueColor forState:UIControlStateNormal];
        _cancleButton.titleLabel.font = systemFont(ScaleW(15));
        [_cancleButton addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancleButton;
}

-(UIButton *)confirmButton
{
    if (nil == _confirmButton) {
        
        _confirmButton = [[UIButton alloc]initWithFrame:CGRectMake(self.showView.width / 2, self.cancleButton.y, self.showView.width / 2, ScaleW(35))];
        //        _confirmButton.backgroundColor = MainTextColor;
        //        _confirmButton.layer.cornerRadius = _confirmButton.height / 2;
        [_confirmButton setTitle:SSKJLocalized(@"确定",nil) forState:UIControlStateNormal];
        [_confirmButton setTitleColor:kTextBlueColor forState:UIControlStateNormal];
        _confirmButton.titleLabel.font = systemBoldFont(ScaleW(15));
        [_confirmButton addTarget:self action:@selector(confirmEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmButton;
}

-(void)hide
{
    [self removeFromSuperview];
}


-(void)show
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
}

+(void)showWithAmount:(NSString *)amount priceType:(PriceType)priceType buySellType:(BuySellType)buySellType price:(NSString *)price confirmBlock:(void(^)(void))confirmblock
{
    
    JB_BBTrade_BuyAlert_View *alertView = [[JB_BBTrade_BuyAlert_View alloc]init];
    
    
    alertView.confirmBlock = confirmblock;

    
    if (buySellType == BuySellTypeBuy) {
        alertView.directLabel.text = SSKJLocalized(@"买入", nil);
        alertView.directLabel.textColor = GREEN_HEX_COLOR;
    }else{
        alertView.directLabel.text = SSKJLocalized(@"卖出", nil);
        alertView.directLabel.textColor = RED_HEX_COLOR;
    }
    
    
    if (priceType == PriceTypeLimite) {
        alertView.typeLabel.text = SSKJLocalized(@"限价", nil);
        alertView.priceLabel.text = price;
        alertView.amountLabel.text = amount;
    }else{
        alertView.typeLabel.text = SSKJLocalized(@"市价", nil);
        if (buySellType == BuySellTypeBuy) {
            alertView.priceTypeLabel.text = SSKJLocalized(@"金额", nil);
            alertView.priceLabel.text = amount;
            alertView.amountLabel.text = @"--";
        }else{
            alertView.priceLabel.text = @"--";
            alertView.amountLabel.text = amount;
        }
    }
    
    
//    alertView.cancleButton.y = alertView.lineView.y;
//
//    alertView.confirmButton.y = alertView.cancleButton.y;
//
//    alertView.showView.height = alertView.confirmButton.bottom + ScaleW(20);
//    alertView.showView.centerY = ScreenHeight / 2;
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:alertView];
}

-(void)confirmEvent
{
    if (self.confirmBlock) {
        self.confirmBlock();
    }
    
    [self hide];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
