//
//  My_Info_Cell.h
//  ZYW_MIT
//
//  Created by 刘小雨 on 2019/4/1.
//  Copyright © 2019年 Wang. All rights reserved.
//

#import "JB_Info_Cell.h"

@interface JB_Info_Cell ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *valueLabel;
@end

@implementation JB_Info_Cell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = kSubBackgroundColor;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setUI];

    }
    return self;
}

-(void)setUI
{
    [self addSubview:self.titleLabel];
    [self addSubview:self.valueLabel];
}

-(UILabel *)titleLabel
{
    if (nil == _titleLabel) {
        _titleLabel = [WLTools allocLabel:@"" font:systemFont(ScaleW(14)) textColor:[UIColor colorWithHexStringToColor:@"6b6fb9"] frame:CGRectMake(ScaleW(15), 0, ScaleW(80), ScaleW(20)) textAlignment:NSTextAlignmentLeft];
        _titleLabel.centerY = ScaleW(25);
        _titleLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _titleLabel;
}

-(UILabel *)valueLabel
{
    if (nil == _valueLabel) {
        _valueLabel = [WLTools allocLabel:@"" font:systemFont(ScaleW(14)) textColor:[UIColor colorWithHexStringToColor:@"b2b9e7"] frame:CGRectMake(self.titleLabel.right + ScaleW(10), 0, ScreenWidth - self.titleLabel.right - ScaleW(10), ScaleW(20)) textAlignment:NSTextAlignmentLeft];
        _valueLabel.centerY = self.titleLabel.centerY;
    }
    return _valueLabel;
}
-(void)setCellWithTitle:(NSString *)title value:(NSString *)valueString
{
    self.titleLabel.text = title;
    self.valueLabel.text = valueString;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
