//
//  CoinPriceTableViewCell.m
//  SSKJ
//
//  Created by 张本超 on 2019/7/19.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "CoinPriceTableViewCell.h"

@implementation CoinPriceTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self viewConfig];
    }
    return self;
    
}

-(void)viewConfig
{
    [self.contentView addSubview:self.coinImg];
    
    [self.contentView addSubview:self.nameLabel];
    
    [self.contentView addSubview:self.priceLabel];
    
    [self.contentView addSubview:self.usLabel];
    
    [self.contentView addSubview:self.lineView];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
}
-(UIImageView *)coinImg
{
    if (!_coinImg) {
        _coinImg = [[UIImageView alloc]initWithFrame:CGRectMake(ScaleW(16), ScaleW(15), ScaleW(35), ScaleW(35))];
        
        _coinImg.layer.cornerRadius = ScaleW(35/2.f);
        
        //_coinImg.backgroundColor = kMainBlueColor;
        
        
    }
    return _coinImg;
}

-(UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [WLTools allocLabel:@"ETH" font:systemBoldFont(ScaleW(15)) textColor:kTitleColor frame:CGRectMake(ScaleW(15) + _coinImg.right, 0, ScaleW(200), ScaleW(65)) textAlignment:(NSTextAlignmentLeft)];
        
    }
    return _nameLabel;
}


-(UILabel *)priceLabel
{
    if (!_priceLabel) {
        _priceLabel = [WLTools allocLabel:@"0.000000" font:systemBoldFont(ScaleW(15)) textColor:kTitleColor frame:CGRectMake(ScaleW(15), ScaleW(16), ScaleW(200), ScaleW(15)) textAlignment:(NSTextAlignmentRight)];
        
        _priceLabel.right = ScreenWidth - ScaleW(15);
        
        
    }
    return _priceLabel;
}

-(UILabel *)usLabel
{
    if (!_usLabel) {
        _usLabel = [WLTools allocLabel:@"$0.00" font:systemFont(ScaleW(12)) textColor:kSubTitleColor frame:CGRectMake(ScaleW(15), _priceLabel.bottom + ScaleW(11), ScaleW(200), ScaleW(12)) textAlignment:(NSTextAlignmentRight)];
        _usLabel.right = ScreenWidth - ScaleW(15);
    }
    return _usLabel;
}

-(UIView *)lineView
{
    if (!_lineView) {
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(0, ScaleW(65)- .5, ScreenWidth, .5)];
        
        _lineView.backgroundColor = kLineGrayColor;
    }
    return _lineView;
}

-(void)setModel:(MoneyListModel *)model
{
    _model = model;
    
//    _nameLabel.text = _model.pname;
//    
//    _priceLabel.text =  [NSString stringWithFormat:@"%.4f",_model.usable.doubleValue];
//    
//    _usLabel.text = [NSString stringWithFormat:@"￥%.2f",_model.cny.doubleValue];
    
}
@end
