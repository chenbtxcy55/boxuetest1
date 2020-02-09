//
//  JB_BBTrade_SliderMarket_Cell.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/5/14.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "JB_BBTrade_SliderMarket_Cell.h"

@interface JB_BBTrade_SliderMarket_Cell ()
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@end

@implementation JB_BBTrade_SliderMarket_Cell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addSubview:self.nameLabel];
        [self addSubview:self.priceLabel];
    }
    return self;
}

-(UILabel *)nameLabel
{
    if (nil == _nameLabel) {
        _nameLabel = [WLTools allocLabel:@"" font:systemFont(ScaleW(14)) textColor:kMainWihteColor frame:CGRectMake(ScaleW(15), 0, ScaleW(90), ScaleW(51)) textAlignment:NSTextAlignmentLeft];
    }
    return _nameLabel;
}

-(UILabel *)priceLabel
{
    if (nil == _priceLabel) {
        _priceLabel = [WLTools allocLabel:@"" font:systemFont(ScaleW(14)) textColor:kMainWihteColor frame:CGRectMake(ScreenWidth - ScaleW(120) - ScaleW(15) - ScaleW(100), 0, ScaleW(100), ScaleW(50)) textAlignment:NSTextAlignmentRight];
    }
    return _priceLabel;
}

-(void)setCellWithModel:(JB_Market_Index_Model *)model
{
    NSString *name = model.code;
    NSArray *array = [name componentsSeparatedByString:@"/"];
    
    name = [NSString stringWithFormat:@"%@ /%@",array.firstObject,array.lastObject];
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:name];
    [attributeString addAttribute:NSFontAttributeName value:systemFont(ScaleW(11)) range:NSMakeRange(name.length - [array.lastObject length], [array.lastObject length])];
    
    self.nameLabel.attributedText = attributeString;
    
    UIColor *color = GREEN_HEX_COLOR;
    if (model.change.doubleValue < 0) {
        color = RED_HEX_COLOR;
    }
    
    self.priceLabel.textColor = color;
    
    
    self.priceLabel.text = [WLTools roundingStringWith:model.price.doubleValue afterPointNumber:[WLTools dotNumberOfCoinCode:model.code]];
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
