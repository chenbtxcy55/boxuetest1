//
//  My_Yuanli_HeaderView.m
//  ZYW_MIT
//
//  Created by 刘小雨 on 2019/4/25.
//  Copyright © 2019年 Wang. All rights reserved.
//

#import "My_Yuanli_HeaderView.h"

@interface My_Yuanli_HeaderView ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *amountLabel;

@end

@implementation My_Yuanli_HeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kSubBackgroundColor;
        [self setUI];
    }
    return self;
}

-(void)setUI
{
    [self addSubview:self.titleLabel];
    [self addSubview:self.timeLabel];
    [self addSubview:self.amountLabel];
}

-(UILabel *)titleLabel
{
    if (nil == _titleLabel) {
        _titleLabel = [WLTools allocLabel:SSKJLocalized(@"名称", nil) font:systemBoldFont(ScaleW(13)) textColor:[UIColor colorWithHexStringToColor:@"6b6fb9"] frame:CGRectMake(ScaleW(15), 0, ScaleW(100), self.height) textAlignment:NSTextAlignmentLeft];
    }
    return _titleLabel;
}

-(UILabel *)amountLabel
{
    if (nil == _amountLabel) {
        _amountLabel = [WLTools allocLabel:SSKJLocalized(@"佣金", nil) font:systemBoldFont(ScaleW(13)) textColor:[UIColor colorWithHexStringToColor:@"6b6fb9"] frame:CGRectMake(self.titleLabel.right, 0, ScaleW(200), self.height) textAlignment:NSTextAlignmentLeft];
    }
    return _amountLabel;
}


-(UILabel *)timeLabel
{
    if (nil == _timeLabel) {
        _timeLabel = [WLTools allocLabel:SSKJLocalized(@"时间", nil) font:systemFont(ScaleW(13)) textColor:[UIColor colorWithHexStringToColor:@"6b6fb9"] frame:CGRectMake(ScreenWidth - ScaleW(15) - ScaleW(200), 0, ScaleW(200), self.height) textAlignment:NSTextAlignmentRight];
    }
    return _timeLabel;
}





/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
