//
//  BuySellSelectView.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/1/15.
//  Copyright © 2019年 James. All rights reserved.
//

#import "BuySellSelectView.h"

@interface BuySellSelectView ()
@property (nonatomic, strong) UIButton *buyButton;
@property (nonatomic, strong) UIButton *sellButton;

@end

@implementation BuySellSelectView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.buyButton];
        [self addSubview:self.sellButton];
        self.buySellType = BuySellTypeBuy;
    }
    return self;
}

-(UIButton *)buyButton
{
    if (nil == _buyButton) {
        _buyButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.width / 2 - ScaleW(3.5), self.height)];
        [_buyButton setTitle:SSKJLocalized(@"买入",nil) forState:UIControlStateNormal];
        [_buyButton setTitleColor: kMainTextColor forState:UIControlStateNormal];
        [_buyButton setTitleColor:GREEN_HEX_COLOR forState:UIControlStateSelected];
        _buyButton.backgroundColor = UIColorFromRGB(0x2d2e56);
        _buyButton.titleLabel.font = systemFont(ScaleW(15));
//        [_buyButton setBackgroundImage:[UIImage imageNamed:@"bb_buy_unselect"] forState:UIControlStateNormal];
//        [_buyButton setBackgroundImage:[UIImage imageNamed:@"bb_buy_select"] forState:UIControlStateSelected];
        _buyButton.layer.masksToBounds = YES;
        _buyButton.layer.cornerRadius = 2.0f;
        _buyButton.selected = YES;
        _buyButton.layer.borderWidth = 0.5;
        _buyButton.layer.borderColor = GREEN_HEX_COLOR.CGColor;
        [_buyButton addTarget:self action:@selector(buyEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _buyButton;
}

-(UIButton *)sellButton
{
    if (nil == _sellButton) {
        _sellButton = [[UIButton alloc]initWithFrame:CGRectMake(self.width / 2 + ScaleW(3.5), 0, self.width / 2 - ScaleW(3.5), self.height)];
        [_sellButton setTitle:SSKJLocalized(@"卖出",nil) forState:UIControlStateNormal];
        _sellButton.backgroundColor = UIColorFromRGB(0x2d2e56);
        _sellButton.titleLabel.font = systemFont(ScaleW(15));
        [_sellButton setTitleColor: kMainTextColor forState:UIControlStateNormal];
        [_sellButton setTitleColor:RED_HEX_COLOR forState:UIControlStateSelected];
//        [_sellButton setBackgroundImage:[UIImage imageNamed:@"bb_sell_unselect"] forState:UIControlStateNormal];
//        [_sellButton setBackgroundImage:[UIImage imageNamed:@"bb_sell_select"] forState:UIControlStateSelected];
        _sellButton.layer.masksToBounds = YES;
        _sellButton.layer.cornerRadius = 2.0f;
        _sellButton.layer.borderWidth = 0.5;
        _sellButton.layer.borderColor = [UIColor clearColor].CGColor;
        [_sellButton addTarget:self action:@selector(sellEvent) forControlEvents:UIControlEventTouchUpInside];

    }
    return _sellButton;
}

-(void)buyEvent
{
    if (self.buyButton.selected) {
        return;
    }
    
    self.buyButton.layer.borderColor = GREEN_HEX_COLOR.CGColor;
    self.sellButton.layer.borderColor = [UIColor clearColor].CGColor;
    
    self.buySellType = BuySellTypeBuy;
    self.buyButton.selected = YES;
    self.sellButton.selected = NO;
    if (self.buySellBlock) {
        self.buySellBlock(self.buySellType);
    }
}

-(void)sellEvent
{
    if (self.sellButton.selected) {
        return;
    }
    self.sellButton.layer.borderColor = RED_HEX_COLOR.CGColor;
    self.buyButton.layer.borderColor = [UIColor clearColor].CGColor;
    self.buySellType = BuySellTypeSell;

    self.sellButton.selected = YES;
    self.buyButton.selected = NO;
    if (self.buySellBlock) {
        self.buySellBlock(self.buySellType);
    }

}

- (void)setBuySellType:(BuySellType)buySellType
{
    _buySellType = buySellType;
    if (buySellType == BuySellTypeBuy) {
        self.buyButton.selected = YES;
        self.sellButton.selected = NO;
        self.buyButton.layer.borderColor = GREEN_HEX_COLOR.CGColor;
        self.sellButton.layer.borderColor = [UIColor clearColor].CGColor;

    }else{
        self.buyButton.selected = NO;
        self.sellButton.selected = YES;
        self.sellButton.layer.borderColor = RED_HEX_COLOR.CGColor;
        self.buyButton.layer.borderColor = [UIColor clearColor].CGColor;

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
