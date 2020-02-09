//
//  FBSellRecodTableViewCell.m
//  SSKJ
//
//  Created by 张本超 on 2019/5/15.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "FBSellRecodTableViewCell.h"
@interface FBSellRecodTableViewCell()
@property (nonatomic, strong)UILabel *dateLabel;
@property (nonatomic, strong) UIButton *cancellBtn;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UILabel *priceNameLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *limitLowName;
@property (nonatomic, strong) UILabel *limitLow;
@property (nonatomic, strong) UILabel *amoutNameLabel;
@property (nonatomic, strong) UILabel *amoutLabel;
@property (nonatomic, strong) UILabel *limitHightName;
@property (nonatomic, strong) UILabel *limitHight;
@property (nonatomic, strong) UILabel *totalNameLabel;
@property (nonatomic, strong) UILabel *totalLabel;
@property (nonatomic, strong) UILabel *tradeType;
@property (nonatomic, strong) NSArray *tradeTypeArray;
@property (nonatomic, strong) UIView *headerLine;
@property (nonatomic, strong) NSMutableArray *imageArray;


@end

@implementation FBSellRecodTableViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self viewConfig];
    }
    return self;
}
-(void)viewConfig
{
    self.contentView.backgroundColor = self.backgroundColor = kMianBgColor;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.contentView addSubview:self.headerLine];
    [self.contentView addSubview:self.dateLabel];
    [self.contentView addSubview:self.cancellBtn];
    [self.contentView addSubview:self.lineView];
    [self.contentView addSubview:self.priceNameLabel];
    [self.contentView addSubview:self.priceLabel];
    [self.contentView addSubview:self.limitLowName];
    [self.contentView addSubview:self.limitLow];
    [self.contentView addSubview:self.amoutNameLabel];
    [self.contentView addSubview:self.amoutLabel];
    [self.contentView addSubview:self.limitHightName];
    [self.contentView addSubview:self.limitHight];
    [self.contentView addSubview:self.totalNameLabel];
    [self.contentView addSubview:self.totalLabel];
    [self.contentView addSubview:self.tradeType];
    self.tradeTypeArray = @[@"FBCalpay",@"bankCard",@"weChat"];

}
-(UIView *)headerLine{
    if (!_headerLine) {
        _headerLine = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleW(5))];
        _headerLine.backgroundColor = kMianDeepBgColor;
        
    }
    return _headerLine;
}
-(UILabel *)dateLabel
{
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(ScaleW(15), _headerLine.bottom, ScaleW(200), ScaleW(50))];
        [_dateLabel label:_dateLabel font:ScaleW(13) textColor:kTextColorb2b9e7 text:@"创建时间 :xxxx-xx-xx xx:xx"];
    }
    return _dateLabel;
}
-(UIButton *)cancellBtn
{
    if (!_cancellBtn) {
        _cancellBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancellBtn.frame = CGRectMake(ScreenWidth - ScaleW(14) - ScaleW(55), 0, ScaleW(55), ScaleW(25));
        _cancellBtn.centerY = _dateLabel.centerY;
        [_cancellBtn btn:_cancellBtn font:ScaleW(13) textColor:kTextColor664fe5 text:@"撤单" image:nil sel:@selector(cancellBtnAction:) taget:self];
        [_cancellBtn setCornerRadius:ScaleW(25/2.f)];
        [_cancellBtn setBorderWithWidth:1.f andColor:kTextColor664fe5];
    }
    return _cancellBtn;
}
-(void)cancellBtnAction:(UIButton *)sender
{
    
}
-(UIView *)lineView{
    if (!_lineView) {
        //313359
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(15), _dateLabel.bottom,ScreenWidth - ScaleW(30), 1)];
        _lineView.backgroundColor = kLineGrayColor;
    }
    return _lineView;
}
-(UILabel *)priceNameLabel{
    if (!_priceNameLabel) {
        _priceNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(ScaleW(15), ScaleW(25) + _lineView.bottom, ScaleW(68), ScaleW(13))];
        [_priceNameLabel label:_priceNameLabel font:ScaleW(13) textColor:kTextColor5b5e95 text:@"购买单价 ："];
        
    }
    return _priceNameLabel;
}
-(UILabel *)priceLabel{
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(_priceNameLabel.right, ScaleW(25) + _lineView.bottom, ScaleW(105), ScaleW(13))];
        [_priceLabel label:_priceLabel font:ScaleW(13) textColor:kTextColorb2b9e7 text:@"￥6.31 "];
        
    }
    return _priceLabel;
}
-(UILabel *)limitLowName{
    if (!_limitLowName) {
        _limitLowName = [[UILabel alloc]initWithFrame:CGRectMake(_priceLabel.right, ScaleW(25) + _lineView.bottom, ScaleW(68), ScaleW(13))];
        [_limitLowName label:_limitLowName font:ScaleW(13) textColor:kTextColor5b5e95 text:@"最小限额 ："];
        
    }
    return _limitLowName;
}

-(UILabel *)limitLow{
    if (!_limitLow) {
        _limitLow = [[UILabel alloc]initWithFrame:CGRectMake(_limitLowName.right, ScaleW(25) + _lineView.bottom, ScaleW(105), ScaleW(13))];
        [_limitLow label:_limitLow font:ScaleW(13) textColor:kTextColorb2b9e7 text:@"￥1000.00"];
        
    }
    return _limitLow;
}
-(UILabel *)amoutNameLabel{
    if (!_amoutNameLabel) {
        _amoutNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(ScaleW(15), ScaleW(14) + _priceNameLabel.bottom, ScaleW(68), ScaleW(13))];
        [_amoutNameLabel label:_amoutNameLabel font:ScaleW(13) textColor:kTextColor5b5e95 text:@"购买数量 ："];
        
    }
    return _amoutNameLabel;
}
-(UILabel *)amoutLabel{
    if (!_amoutLabel) {
        _amoutLabel = [[UILabel alloc]initWithFrame:CGRectMake(_amoutNameLabel.right, _amoutNameLabel.top, ScaleW(105), ScaleW(13))];
        [_amoutLabel label:_amoutLabel font:ScaleW(13) textColor:kTextColorb2b9e7 text:@"263.00 AB"];
        
    }
    return _amoutLabel;
}
-(UILabel *)limitHightName{
    if (!_limitHightName) {
        _limitHightName = [[UILabel alloc]initWithFrame:CGRectMake(_amoutLabel.right, _amoutNameLabel.top, ScaleW(68), ScaleW(13))];
        [_limitHightName label:_limitHightName font:ScaleW(13) textColor:kTextColor5b5e95 text:@"最大限额 ："];
        
    }
    return _limitHightName;
}
-(UILabel *)limitHight{
    if (!_limitHight) {
        _limitHight = [[UILabel alloc]initWithFrame:CGRectMake(_limitHightName.right, _limitHightName.top, ScaleW(105), ScaleW(13))];
        [_limitHight label:_limitHight font:ScaleW(13) textColor:kTextColorb2b9e7 text:@"￥8000.00"];
        
    }
    return _limitHight;
}
-(UILabel *)totalNameLabel{
    if (!_totalNameLabel) {
        _totalNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(ScaleW(15), _amoutNameLabel.bottom + ScaleW(14), ScaleW(68), ScaleW(13))];
        [_totalNameLabel label:_totalNameLabel font:ScaleW(13) textColor:kTextColor5b5e95 text:@"购买总价 ："];
        
    }
    return _totalNameLabel;
}
-(UILabel *)totalLabel{
    if (!_totalLabel) {
        _totalLabel = [[UILabel alloc]initWithFrame:CGRectMake(_totalNameLabel.right, _totalNameLabel.top, ScaleW(105), ScaleW(13))];
        [_totalLabel label:_totalLabel font:ScaleW(13) textColor:kTextColorb2b9e7 text:@"￥23633.00"];
        
    }
    return _totalLabel;
}
-(UILabel *)tradeType{
    if (!_tradeType) {
        _tradeType = [[UILabel alloc]initWithFrame:CGRectMake(_totalLabel.right, _totalLabel.top, ScaleW(68), ScaleW(13))];
        [_tradeType label:_tradeType font:ScaleW(13) textColor:kTextColor5b5e95 text:@"交易方式 ："];
        
    }
    return _tradeType;
}
-(void)setTradeTypeArray:(NSArray *)tradeTypeArray
{
    for (UIImageView *img  in self.imageArray) {
        [img removeFromSuperview];
    }
    _tradeTypeArray = tradeTypeArray;
    
    for (int i = 0; i < _tradeTypeArray.count; i ++) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(_tradeType.right + i*ScaleW(23), _limitHightName.bottom + ScaleW(16), ScaleW(15), ScaleW(15))];
        imageView.image = [UIImage imageNamed:_tradeTypeArray[i]];
        [self.contentView addSubview:imageView];
        [self.imageArray addObject:imageView];
    }
}
-(NSMutableArray *)imageArray
{
    if (!_imageArray) {
        _imageArray = [NSMutableArray array];
    }
    return _imageArray;
}
@end
