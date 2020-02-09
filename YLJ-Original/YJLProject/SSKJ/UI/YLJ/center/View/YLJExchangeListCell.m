//
//  YLJExchangeListCell.m
//  SSKJ
//
//  Created by cy5566 on 2019/11/23.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "YLJExchangeListCell.h"
@interface YLJExchangeListCell()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *priceLabel;

@end
@implementation YLJExchangeListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self setUI];
    }
    return self;
    
}

- (void)setUI {
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.priceLabel];
    
}

-(void)setCellWithModel:(HeBi_ConvertRecord_Index_Model *)model
{
//    self.titleLabel.text = [NSString stringWithFormat:@"%@%@%@",@"ETH",SSKJLocalized(@"兑换", nil),@"ISCM"];
//    self.timeLabel.text = [WLTools convertTimestamp:model.addtime.doubleValue andFormat:@"yyyy-MM-dd HH:mm:ss"];
//    self.ammountLabel.text = [[WLTools noroundingStringWith:model.num.doubleValue afterPointNumber:[WLTools dotNumberOfCoinName:model.pname]] stringByAppendingString:model.pname];
//
//    self.getLabel.text = [[WLTools noroundingStringWith:model.exnum.doubleValue afterPointNumber:[WLTools dotNumberOfCoinName:model.expname]] stringByAppendingString:model.expname];
//
    
        self.titleLabel.text = model.memo;
        self.timeLabel.text = model.dtime;
        self.priceLabel.text = model.price;
}

-(UILabel *)titleLabel
{
    if (nil == _titleLabel) {
        _titleLabel = [WLTools allocLabel:SSKJLocalized(@"ETH兑换ISCM", nil) font:systemBoldFont(ScaleW(16)) textColor:[UIColor blackColor] frame:CGRectMake(ScaleW(15), ScaleW(15), ScreenWidth / 2 - ScaleW(15), ScaleW(16)) textAlignment:NSTextAlignmentLeft];
    }
    return _titleLabel;
}

- (UILabel *)priceLabel
{
    if (nil == _priceLabel) {
        _priceLabel = [WLTools allocLabel:@"-1000.00" font:systemFont(ScaleW(14)) textColor:kTheMeColor frame:CGRectMake(ScreenWidth / 2, ScaleW(25), ScreenWidth / 2 - ScaleW(15), ScaleW(15)) textAlignment:NSTextAlignmentRight];
//        _priceLabel.centerY = self.contentView.centerY;
    }
    return _priceLabel;
    
}

-(UILabel *)timeLabel
{
    if (nil == _timeLabel) {
        _timeLabel = [WLTools allocLabel:SSKJLocalized(@"2019-09-09 09:09:09", nil) font:systemFont(ScaleW(12)) textColor:kGrayTitleColor frame:CGRectMake(ScaleW(15), self.titleLabel.bottom + ScaleW(10), ScaleW(60), ScaleW(12)) textAlignment:NSTextAlignmentLeft];
    }
    return _timeLabel;
    
}
@end
