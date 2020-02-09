//
//  BBTrade_SectiobHeaderView.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/5/14.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "BBTrade_SectiobHeaderView.h"

@interface BBTrade_SectiobHeaderView ()
@property (nonatomic, strong) UIView *topLineView;
@property (nonatomic, strong) UIView *bottomLineView;
@end

@implementation BBTrade_SectiobHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.topLineView];
        [self addSubview:self.priceLabel];
        [self addSubview:self.cnyPriceLabel];
        [self addSubview:self.bottomLineView];
    }
    return self;
}

-(UIView *)topLineView
{
    if (nil == _topLineView) {
        _topLineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.width, 0.5)];
        _topLineView.backgroundColor = kLineGrayColor;
    }
    return _topLineView;
}

-(UILabel *)priceLabel
{
    if (nil == _priceLabel) {
        _priceLabel = [WLTools allocLabel:@"0.0000" font:systemFont(ScaleW(18)) textColor:GREEN_HEX_COLOR frame:CGRectMake(0, self.topLineView.bottom + ScaleW(15), self.width, ScaleW(18)) textAlignment:NSTextAlignmentLeft];
        
    }
    return _priceLabel;
}


-(UILabel *)cnyPriceLabel
{
    if (nil == _cnyPriceLabel) {
        _cnyPriceLabel = [WLTools allocLabel:@"≈4567.6789" font:systemFont(ScaleW(10)) textColor:kTextDarkBlueColor frame:CGRectMake(0, self.priceLabel.bottom + ScaleW(9), self.width, ScaleW(10)) textAlignment:NSTextAlignmentLeft];
    }
    return _cnyPriceLabel;
}

-(UIView *)bottomLineView
{
    if (nil == _bottomLineView) {
        _bottomLineView = [[UIView alloc]initWithFrame:CGRectMake(0, self.cnyPriceLabel.bottom + ScaleW(18), self.width, 0.5)];
        _bottomLineView.backgroundColor = kLineGrayColor;
    }
    return _bottomLineView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
