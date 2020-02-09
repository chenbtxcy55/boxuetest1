//
//  MarketCoinCell.m
//  SSKJ
//
//  Created by 张本超 on 2019/5/14.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "MarketCoinCell.h"
@interface MarketCoinCell()


@property (nonatomic, strong)UIImageView *coinImage;
@property (nonatomic, strong) UILabel *coinLable;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *cnyPriceLabel;

@property (nonatomic, strong) UILabel *percentlabel;

@property (nonatomic, strong) SSKJ_Market_Index_Model *coinModel;

@end

@implementation MarketCoinCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self viewConfig];
    }
    return self;
}
-(void)viewConfig
{
    
    [self.contentView addSubview:self.bgView];

    [self.bgView addSubview:self.coinImage];
    [self.bgView addSubview:self.coinLable];
    [self.bgView addSubview:self.priceLabel];
    [self.bgView addSubview:self.cnyPriceLabel];

    [self.bgView addSubview:self.percentlabel];
    //kMianBgColor
    self.contentView.backgroundColor = self.backgroundColor = kMainColor;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

-(UIImageView *)bgView
{
    if (!_bgView) {
        _bgView = [[UIImageView alloc]init];
        _bgView.frame = CGRectMake(ScaleW(15), ScaleW(0), ScreenWidth-ScaleW(30), ScaleW(56));
        _bgView.backgroundColor = kBgColor353750;
    }
    return _bgView;
}
-(UIImageView *)coinImage
{
    if (!_coinImage) {
        _coinImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"btc"]];
        _coinImage.frame = CGRectMake(ScaleW(15), (ScaleW(56)-ScaleW(25))/2, ScaleW(25), ScaleW(25));
        _coinImage.layer.masksToBounds = YES;
        _coinImage.layer.cornerRadius = _coinImage.height / 2;
    }
    return _coinImage;
}
-(UILabel *)coinLable{
    if (!_coinLable) {
        _coinLable = [[UILabel alloc]initWithFrame:CGRectMake(ScaleW(9) + _coinImage.right, 0, ScaleW(100), ScaleW(14))];
        [_coinLable label:_coinLable font:ScaleW(15) textColor:kMainTextColor text:@"BTC/AB"];
        _coinLable.centerY = _coinImage.centerY;
        
    }
    return _coinLable;
}
-(UILabel *)priceLabel
{
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(ScaleW(156), 0, ScaleW(90), ScaleW(12))];
        _priceLabel.centerY = _coinImage.centerY - _priceLabel.height/2 -ScaleW(5);
        [_priceLabel label:_priceLabel font:ScaleW(15) textColor:kMainTextColor text:@"0000.0000"];
        _priceLabel.font = systemFont(ScaleW(15));
    }
    return _priceLabel;
}


-(UILabel *)cnyPriceLabel
{
    if (!_cnyPriceLabel) {
        _cnyPriceLabel = [[UILabel alloc]initWithFrame:CGRectMake(ScaleW(156) , 0, ScaleW(90), ScaleW(12))];
        _cnyPriceLabel.centerY = _coinImage.centerY + _cnyPriceLabel.height/2 + ScaleW(5);
        [_cnyPriceLabel label:_cnyPriceLabel font:ScaleW(10) textColor:UIColorFromARGB(0xffffff, 0.75) text:@"≈0.034CNY"];
        
    }
    return _cnyPriceLabel;
}

-(UILabel *)percentlabel
{
    if (!_percentlabel) {
        _percentlabel = [[UILabel alloc]initWithFrame:CGRectMake(ScaleW(284), 0, ScaleW(100), ScaleW(12))];
        _percentlabel.centerY = _coinImage.centerY;
//        _percentlabel.right = ScreenWidth - ScaleW(30);
        [_percentlabel label:_percentlabel font:ScaleW(12) textColor:kTextColorff5755 text:@"-00.00%"];
        _percentlabel.textAlignment = NSTextAlignmentLeft;
    }
    return _percentlabel;
}

-(void)setCellWithModel:(SSKJ_Market_Index_Model *)model
{
    self.coinModel = model;
    NSString *name = model.code;
    NSArray *array = [name componentsSeparatedByString:@"_"];
    
    self.coinImage.image = [UIImage imageNamed:[array.firstObject uppercaseString]];
    
    name = [NSString stringWithFormat:@"%@/%@",[array.firstObject uppercaseString],[array.lastObject uppercaseString]];
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:name];
    [attributeString addAttribute:NSFontAttributeName value:systemFont(ScaleW(10)) range:NSMakeRange(name.length - [array.lastObject length]-1, [array.lastObject length]+1)];
    [attributeString addAttribute:NSForegroundColorAttributeName value:UIColorFromARGB(0xffffff, 0.75) range:NSMakeRange(name.length - [array.lastObject length]-1, [array.lastObject length]+1)];

    self.coinLable.attributedText = attributeString;
    
    UIColor *color = GREEN_HEX_COLOR;
    if (model.change.doubleValue < 0) {
        color = RED_HEX_COLOR;
    }
    self.cnyPriceLabel.text = [NSString stringWithFormat:@"≈%@CNY",[WLTools noroundingStringWith:[model.cnyPrice doubleValue] afterPointNumber:2]];
//    self.priceLabel.textColor = color;
    
    self.priceLabel.text = [WLTools roundingStringWith:model.price.doubleValue afterPointNumber:[WLTools dotNumberOfCoinCode:model.code]];
    
    if ([model.changeRate containsString:@"-"]) {
        self.percentlabel.text = model.changeRate;
    }else{
        self.percentlabel.text = [NSString stringWithFormat:@"+%@",model.changeRate] ;
    }
    
    self.percentlabel.textColor = color;
}

@end
