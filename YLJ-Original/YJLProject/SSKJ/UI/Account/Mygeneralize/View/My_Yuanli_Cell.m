//
//  My_Yuanli_Cell.m
//  ZYW_MIT
//
//  Created by 刘小雨 on 2019/3/29.
//  Copyright © 2019年 Wang. All rights reserved.
//

#import "My_Yuanli_Cell.h"

@interface My_Yuanli_Cell ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *amountLabel;
@end

@implementation My_Yuanli_Cell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
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
    [self addSubview:self.timeLabel];
    [self addSubview:self.amountLabel];
}

-(UILabel *)titleLabel
{
    if (nil == _titleLabel) {
        _titleLabel = [WLTools allocLabel:@"xx" font:systemBoldFont(ScaleW(15)) textColor:[UIColor colorWithHexStringToColor:@"b2b9e7"] frame:CGRectMake(ScaleW(15), 0, ScaleW(100), ScaleW(45)) textAlignment:NSTextAlignmentLeft];
    }
    return _titleLabel;
}

-(UILabel *)amountLabel
{
    if (nil == _amountLabel) {
        _amountLabel = [WLTools allocLabel:@"xxx" font:systemBoldFont(ScaleW(15)) textColor:[UIColor colorWithHexStringToColor:@"b2b9e7"] frame:CGRectMake(self.titleLabel.right, 0, ScaleW(200), ScaleW(45)) textAlignment:NSTextAlignmentLeft];
    }
    return _amountLabel;
}


-(UILabel *)timeLabel
{
    if (nil == _timeLabel) {
        _timeLabel = [WLTools allocLabel:@"xxx" font:systemFont(ScaleW(13)) textColor:[UIColor colorWithHexStringToColor:@"b2b9e7"] frame:CGRectMake(ScreenWidth - ScaleW(15) - ScaleW(200), 0, ScaleW(200), ScaleW(60)) textAlignment:NSTextAlignmentRight];
    }
    return _timeLabel;
}



-(void)setCellWithModel:(My_Yuanli_Model *)model
{
    self.titleLabel.text = model.realname;;
    self.amountLabel.text = [WLTools noroundingStringWith:model.price.doubleValue afterPointNumber:2];
    self.timeLabel.text = model.dtime;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
