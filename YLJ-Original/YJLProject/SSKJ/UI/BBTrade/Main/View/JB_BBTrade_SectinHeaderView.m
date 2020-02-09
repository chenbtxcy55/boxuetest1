//
//  JB_BBTrade_SectinHeaderView.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/5/14.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "JB_BBTrade_SectinHeaderView.h"

@interface JB_BBTrade_SectinHeaderView ()
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIView *vLineView;
@property (nonatomic, strong) UILabel *entrustLabel;
@property (nonatomic, strong) UIButton *allOrderButton;
@property (nonatomic, strong) UIView *lineView;
@end

@implementation JB_BBTrade_SectinHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.backView];
        [self.backView addSubview:self.vLineView];
        [self.backView addSubview:self.entrustLabel];
        [self.backView addSubview:self.allOrderButton];
        [self.backView addSubview:self.lineView];
    }
    return self;
}

-(UIView *)backView
{
    if (nil == _backView) {
        _backView = [[UIView alloc]initWithFrame:CGRectMake(0, ScaleW(10), self.width, self.height - ScaleW(10))];
        _backView.backgroundColor = kSubBackgroundColor;
    }
    return _backView;
}

-(UIView *)vLineView
{
    if (nil == _vLineView) {
        _vLineView = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(15), 0, ScaleW(2.5), ScaleW(15))];
        _vLineView.centerY = self.backView.height / 2;
        _vLineView.backgroundColor =  kMainTextColor;
    }
    return _vLineView;
}

-(UILabel *)entrustLabel
{
    if (nil == _entrustLabel) {
        _entrustLabel = [WLTools allocLabel:SSKJLocalized(@"当前委托", nil) font:systemFont(15) textColor: kMainTextColor frame:CGRectMake(self.vLineView.right + ScaleW(10), 0, ScaleW(100), self.backView.height) textAlignment:NSTextAlignmentLeft];
    }
    return _entrustLabel;
}

-(UIButton *)allOrderButton
{
    if (nil == _allOrderButton) {
        
        NSString *title = SSKJLocalized(@"全部委托", nil);
        CGFloat width = [WLTools getWidthWithText:title font:systemFont(ScaleW(15))] + ScaleW(2);
        
        _allOrderButton = [[UIButton alloc]initWithFrame:CGRectMake(self.width - width- ScaleW(15), 0, width, self.backView.height)];
        [_allOrderButton setTitle:title forState:UIControlStateNormal];
        [_allOrderButton setTitleColor:kTextLightBlueColor forState:UIControlStateNormal];
        _allOrderButton.titleLabel.font = systemFont(ScaleW(15));
        [_allOrderButton addTarget:self action:@selector(allEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _allOrderButton;
}

#pragma mark - 用户操作
-(void)allEvent
{
    if (self.allBlock) {
        self.allBlock();
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
