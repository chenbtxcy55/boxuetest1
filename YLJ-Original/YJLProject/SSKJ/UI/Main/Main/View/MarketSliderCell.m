//
//  MarketSliderCell.m
//  SSKJ
//
//  Created by 张本超 on 2019/5/14.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "MarketSliderCell.h"
@interface MarketSliderCell()
@property (nonatomic, strong) UILabel *codenameLabel;
@property (nonatomic, strong) UILabel *currentPrice;
@end

@implementation MarketSliderCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self viewConfig];
    }
    return self;
}
-(void)viewConfig
{
    [self.contentView addSubview:self.codenameLabel];
    [self.contentView addSubview:self.currentPrice];
     self.contentView.backgroundColor = self.backgroundColor = kMianBgColor;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

-(UILabel *)codenameLabel
{
    if (!_codenameLabel) {
        _codenameLabel = [[UILabel alloc]initWithFrame:CGRectMake(ScaleW(15), 0, ScaleW(100), ScaleW(52))];
        [_codenameLabel label:_codenameLabel font:ScaleW(17) textColor:kMainWihteColor text:@"MANA/AB"];
    }
    return _codenameLabel;
}
-(UILabel *)currentPrice
{
    if (!_currentPrice) {
        _currentPrice = [[UILabel alloc]initWithFrame:CGRectMake(0, _codenameLabel.top, ScaleW(140), ScaleW(17))];
        [_currentPrice label:_currentPrice font:ScaleW(17) textColor:GREEN_HEX_COLOR text:@"0.0000"];
        _currentPrice.right = ScaleW(238);
        _currentPrice.centerY = _codenameLabel.centerY;
        _currentPrice.font = [UIFont boldSystemFontOfSize:17];
        _currentPrice.textAlignment = NSTextAlignmentRight;
    }
    return _currentPrice;
    
}
@end
