//
//  HeBi_ConvertRecord_Cell.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/4/16.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "HeBi_ConvertRecord_Cell.h"

@interface HeBi_ConvertRecord_Cell ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) UILabel *ammountTitleLabel;// 兑换数量
@property (nonatomic, strong) UILabel *ammountLabel;

@property (nonatomic, strong) UILabel *getTitleLabel;// 获得资产
@property (nonatomic, strong) UILabel *getLabel;
@end

@implementation HeBi_ConvertRecord_Cell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self setUI];
    }
    return self;
    
}

#pragma mark - UI

-(void)setUI
{
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.ammountTitleLabel];
    [self.contentView addSubview:self.ammountLabel];
    [self.contentView addSubview:self.getTitleLabel];
    [self.contentView addSubview:self.getLabel];
    
}


-(UILabel *)titleLabel
{
    if (nil == _titleLabel) {
        _titleLabel = [WLTools allocLabel:SSKJLocalized(@"ETH兑换ISCM", nil) font:systemBoldFont(ScaleW(15)) textColor:[UIColor blackColor] frame:CGRectMake(ScaleW(15), ScaleW(20), ScreenWidth / 2 - ScaleW(15), ScaleW(15)) textAlignment:NSTextAlignmentLeft];
    }
    return _titleLabel;
}

- (UILabel *)timeLabel
{
    if (nil == _timeLabel) {
        _timeLabel = [WLTools allocLabel:@"2019-09-09 09:09:09" font:systemFont(ScaleW(13)) textColor:[UIColor colorWithRed:150.0f/255.0f green:150.0f/255.0f blue:150.0f/255.0f alpha:1.0f] frame:CGRectMake(ScreenWidth / 2, 0, ScreenWidth / 2 - ScaleW(15), ScaleW(15)) textAlignment:NSTextAlignmentRight];
        _timeLabel.centerY = self.titleLabel.centerY;
    }
    return _timeLabel;

}

-(UILabel *)ammountTitleLabel
{
    if (nil == _ammountTitleLabel) {
        _ammountTitleLabel = [WLTools allocLabel:SSKJLocalized(@"兑换数量", nil) font:systemFont(ScaleW(14)) textColor:WLColor(50, 50, 50, 1) frame:CGRectMake(ScaleW(15), self.titleLabel.bottom + ScaleW(20), ScaleW(60), ScaleW(14)) textAlignment:NSTextAlignmentLeft];
    }
    return _ammountTitleLabel;
    
}

-(UILabel *)ammountLabel
{
    if (nil == _ammountLabel) {
        _ammountLabel = [WLTools allocLabel:SSKJLocalized(@"3000.00 HBI", nil) font:systemFont(ScaleW(14)) textColor:[UIColor colorWithRed:150.0f/255.0f green:150.0f/255.0f blue:150.0f/255.0f alpha:1.0f] frame:CGRectMake(self.ammountTitleLabel.right + ScaleW(12), self.ammountTitleLabel.y, ScreenWidth/2 - ScaleW(15) - self.ammountTitleLabel.right - ScaleW(12), ScaleW(14)) textAlignment:NSTextAlignmentLeft];
    }
    return _ammountLabel;
    
}


-(UILabel *)getTitleLabel
{
    if (nil == _getTitleLabel) {
        _getTitleLabel = [WLTools allocLabel:SSKJLocalized(@"获得资产", nil) font:systemFont(ScaleW(14)) textColor:WLColor(50, 50, 50, 1) frame:CGRectMake( ScreenWidth/2+ScaleW(15), self.titleLabel.bottom + ScaleW(20), ScaleW(60), ScaleW(14)) textAlignment:NSTextAlignmentLeft];
    }
    return _getTitleLabel;
    
}

-(UILabel *)getLabel
{
    if (nil == _getLabel) {
        _getLabel = [WLTools allocLabel:SSKJLocalized(@"3000.00 USDT", nil) font:systemFont(ScaleW(14)) textColor:[UIColor colorWithRed:150.0f/255.0f green:150.0f/255.0f blue:150.0f/255.0f alpha:1.0f] frame:CGRectMake(self.getTitleLabel.right, self.titleLabel.bottom + ScaleW(20), ScreenWidth/2 - ScaleW(15) - self.ammountTitleLabel.right, ScaleW(14)) textAlignment:NSTextAlignmentLeft];
    }
    return _getLabel;
    
}

-(void)setCellWithModel:(HeBi_ConvertRecord_Index_Model *)model
{
    self.titleLabel.text = [NSString stringWithFormat:@"%@%@%@",@"ETH",SSKJLocalized(@"兑换", nil),@"ISCM"];
    self.timeLabel.text = [WLTools convertTimestamp:model.addtime.doubleValue andFormat:@"yyyy-MM-dd HH:mm:ss"];
    self.ammountLabel.text = [[WLTools noroundingStringWith:model.num.doubleValue afterPointNumber:[WLTools dotNumberOfCoinName:model.pname]] stringByAppendingString:model.pname];

    self.getLabel.text = [[WLTools noroundingStringWith:model.exnum.doubleValue afterPointNumber:[WLTools dotNumberOfCoinName:model.expname]] stringByAppendingString:model.expname];
    
    
//    self.titleLabel.text = model.memo;
//    self.timeLabel.text = model.dtime;
//    self.ammountLabel.text = model.price;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
