//
//  My_Friend_HeaderView.m
//  ZYW_MIT
//
//  Created by 刘小雨 on 2019/3/29.
//  Copyright © 2019年 Wang. All rights reserved.
//

#import "My_Friend_HeaderView.h"

@interface My_Friend_HeaderView ()
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *phoneLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@end

@implementation My_Friend_HeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kMainBackgroundColor;
        [self setUI];
    }
    return self;
}

-(void)setUI
{
    [self addSubview:self.nameLabel];
    [self addSubview:self.phoneLabel];
    [self addSubview:self.timeLabel];
}

-(UILabel *)nameLabel
{
    if (nil == _nameLabel) {
        
        CGFloat width = (ScreenWidth - ScaleW(30)) / 3;

        _nameLabel = [WLTools allocLabel:SSKJLocalized(@"名称", nil) font:systemFont(ScaleW(13)) textColor:[UIColor colorWithHexStringToColor:@"6b6fb9"] frame:CGRectMake(ScaleW(15), 0, width, self.height) textAlignment:NSTextAlignmentLeft];
    }
    return _nameLabel;
}
-(UILabel *)phoneLabel
{
    if (nil == _phoneLabel) {
        
        CGFloat width = (ScreenWidth - ScaleW(30)) / 3;

        _phoneLabel = [WLTools allocLabel:SSKJLocalized(@"账号", nil) font:systemFont(ScaleW(13)) textColor:[UIColor colorWithHexStringToColor:@"6b6fb9"] frame:CGRectMake(self.nameLabel.right, 0, width, self.height) textAlignment:NSTextAlignmentCenter];
    }
    return _phoneLabel;
}
-(UILabel *)timeLabel
{
    if (nil == _timeLabel) {
        
        CGFloat width = (ScreenWidth - ScaleW(30)) / 3;
        
        _timeLabel = [WLTools allocLabel:SSKJLocalized(@"注册时间", nil) font:systemFont(ScaleW(13)) textColor:[UIColor colorWithHexStringToColor:@"6b6fb9"] frame:CGRectMake(self.phoneLabel.right, 0, width, self.height) textAlignment:NSTextAlignmentRight];
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
