
//
//  ETF_BBTrade_IntroductHeaderView.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/5/8.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "ETF_BBTrade_IntroductHeaderView.h"

@interface ETF_BBTrade_IntroductHeaderView ()
@property (nonatomic, strong) UIButton *dealButton;     // 成交
@property (nonatomic, strong) UIButton *introductButton;    // 简介
@property (nonatomic, strong) UIView *segmentLineView;
@property (nonatomic, strong) UIView *lineView;
@end

@implementation ETF_BBTrade_IntroductHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = kMainWihteColor;
//        [self addSubview:self.dealButton];
        [self addSubview:self.introductButton];
//        [self addSubview:self.segmentLineView];
//        [self addSubview:self.lineView];
    }
    return self;
}


-(UIButton *)dealButton
{
    if (nil == _dealButton) {
        _dealButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.width / 2, self.height)];
        [_dealButton setTitle:SSKJLocalized(@"成交", nil) forState:UIControlStateNormal];
        [_dealButton setTitleColor:kTextDarkBlueColor forState:UIControlStateNormal];
        [_dealButton setTitleColor:kTextLightBlueColor forState:UIControlStateSelected];
        _dealButton.titleLabel.font = systemFont(ScaleW(15));
        _dealButton.selected = YES;
        [_dealButton addTarget:self action:@selector(dealEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _dealButton;
}


-(UIButton *)introductButton
{
    if (nil == _introductButton) {
        _introductButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        [_introductButton setTitle:SSKJLocalized(@"简介", nil) forState:UIControlStateNormal];
        [_introductButton setTitleColor:kMainWihteColor forState:UIControlStateNormal];
//        [_introductButton setTitleColor:kTextLightBlueColor forState:UIControlStateSelected];
        _introductButton.titleLabel.font = systemFont(ScaleW(15));
        _introductButton.userInteractionEnabled = NO;
//        _introductButton.selected = YES;
//        [_introductButton addTarget:self action:@selector(introductEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _introductButton;
}

-(UIView *)segmentLineView
{
    if (nil == _segmentLineView) {
        _segmentLineView = [[UIView alloc]initWithFrame:CGRectMake(0, self.height - 2, ScaleW(30), 2)];
        _segmentLineView.backgroundColor = kTextLightBlueColor;
        _segmentLineView.centerX = self.dealButton.centerX;
    }
    return _segmentLineView;
}


-(UIView *)lineView
{
    if (nil == _lineView) {
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(0, self.height - 0.5, self.width, 0.5)];
        _lineView.backgroundColor = kMarketLineColor;
    }
    return _lineView;
}


-(void)dealEvent
{
    self.dealButton.selected = YES;
    self.introductButton.selected = NO;
    self.segmentLineView.centerX = self.dealButton.centerX;
    self.selectedIndex = 0;
    if (self.segmentSelectBlock) {
        self.segmentSelectBlock(0);
    }
}

-(void)introductEvent
{
    self.introductButton.selected = YES;
    self.dealButton.selected = NO;
    self.segmentLineView.centerX = self.introductButton.centerX;
    self.selectedIndex = 1;

    if (self.segmentSelectBlock) {
        self.segmentSelectBlock(1);
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
