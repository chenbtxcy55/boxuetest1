//
//  JB_BBTradeEntrust_Cell.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/5/21.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "JB_BBTradeEntrust_Cell.h"

@interface JB_BBTradeEntrust_Cell ()
@property (nonatomic, strong) UILabel *buySellTypeLabel;
@property (nonatomic, strong) UILabel *coinNameLabel;
@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) UILabel *entrustPriceTitleLabel;           // 委托价
@property (nonatomic, strong) UILabel *entrustPriceLabel;

@property (nonatomic, strong) UILabel *entrustAmountTitleLabel;  // 委托量
@property (nonatomic, strong) UILabel *entrustAmountLabel;  // 委托量

@property (nonatomic, strong) UILabel *dealAmountTitleLabel; // 成交量
@property (nonatomic, strong) UILabel *dealAmountLabel; // 成交量

@property (nonatomic, strong) UIButton *cancleButton;   // 撤销按钮

@property (nonatomic, strong) JB_BBTrade_Order_Index_Model *model;

@end

@implementation JB_BBTradeEntrust_Cell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        [self addSubview:self.buySellTypeLabel];
        [self addSubview:self.coinNameLabel];
        [self addSubview:self.timeLabel];
        
        
        [self addLabels];
        
        [self addSubview:self.cancleButton];
    }
    return self;
}


- (UILabel *)buySellTypeLabel
{
    if (nil == _buySellTypeLabel) {
        _buySellTypeLabel = [WLTools allocLabel:SSKJLocalized(@"买入", nil) font:systemFont(ScaleW(14)) textColor:RED_HEX_COLOR frame:CGRectMake(ScaleW(15), ScaleW(20), ScaleW(30), ScaleW(14)) textAlignment:NSTextAlignmentLeft];
    }
    return _buySellTypeLabel;
}

- (UILabel *)coinNameLabel
{
    if (nil == _coinNameLabel) {
        _coinNameLabel = [WLTools allocLabel:@"BTC/AB" font:systemFont(ScaleW(14)) textColor: kMainTextColor frame:CGRectMake(self.buySellTypeLabel.right + ScaleW(17), self.buySellTypeLabel.y, ScaleW(100), ScaleW(14)) textAlignment:NSTextAlignmentLeft];
    }
    return _coinNameLabel;
}

-(UILabel *)timeLabel
{
    if (nil == _timeLabel) {
        _timeLabel = [WLTools allocLabel:@"" font:systemFont(ScaleW(14)) textColor:kTextDarkBlueColor frame:CGRectMake(self.coinNameLabel.right + ScaleW(10), 0, ScaleW(200), ScaleW(14)) textAlignment:NSTextAlignmentLeft];
        _timeLabel.centerY = self.coinNameLabel.centerY;
    }
    return _timeLabel;
}

-(UIButton *)cancleButton
{
    if (nil == _cancleButton) {
        _cancleButton = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth - ScaleW(15) - ScaleW(40), 0, ScaleW(40), ScaleW(40))];
        _cancleButton.centerY = self.coinNameLabel.centerY;
        [_cancleButton setTitle:SSKJLocalized(@"撤单", nil) forState:UIControlStateNormal];
        [_cancleButton setTitleColor:kTextLightBlueColor forState:UIControlStateNormal];
        _cancleButton.titleLabel.font = systemBoldFont(ScaleW(14));
//        _cancleButton.layer.masksToBounds = YES;
//        _cancleButton.layer.cornerRadius = _cancleButton.height / 2;
//        _cancleButton.layer.borderColor = kTextDarkBlueColor.CGColor;
//        _cancleButton.layer.borderWidth = 0.5;
        [_cancleButton addTarget:self action:@selector(cancleOrderEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancleButton;
}

-(void)addLabels
{
    
    NSArray *titleArray = @[
                            SSKJLocalized(@"委托价", nil),
                            SSKJLocalized(@"委托量(ETH)", nil),
                            SSKJLocalized(@"成交量(ETH)", nil),
                            ];
    
    CGFloat width = (ScreenWidth - ScaleW(30)) / 3;
    
    for (int i = 0; i < titleArray.count; i++) {
        NSInteger line = i % 3;
        NSInteger row = i / 3;
        NSString *title = titleArray[i];
        
        NSTextAlignment aligment = NSTextAlignmentLeft;
        if (line == 0) {
            aligment = NSTextAlignmentLeft;
        }else if (line == 2){
            aligment = NSTextAlignmentRight;
        }
        
        
        UILabel *titleLabel = [WLTools allocLabel:title font:systemFont(ScaleW(13.5)) textColor:kTextDarkBlueColor frame:CGRectMake(ScaleW(15) + line * width, self.buySellTypeLabel.bottom + ScaleW(20) + row * ScaleW(55), width, ScaleW(13.5)) textAlignment:aligment];
        
        [self addSubview:titleLabel];
        
        UILabel *valueLabel = [WLTools allocLabel:@"xx" font:systemBoldFont(ScaleW(13.5)) textColor: kMainTextColor frame:CGRectMake(titleLabel.x, titleLabel.bottom + ScaleW(12), width, ScaleW(13.5)) textAlignment:aligment];
        
        [self addSubview:valueLabel];
        
        switch (i) {
            case 0:
            {
                self.entrustPriceTitleLabel = titleLabel;
                self.entrustPriceLabel = valueLabel;
            }
                break;
            case 1:
            {
                self.entrustAmountTitleLabel = titleLabel;
                self.entrustAmountLabel = valueLabel;
            }
                break;
            case 2:
            {
                self.dealAmountTitleLabel = titleLabel;
                self.dealAmountLabel = valueLabel;
            }
                break;
           
                
            default:
                break;
        }
    }
    
}



-(void)setCellWithModel:(JB_BBTrade_Order_Index_Model *)model
{
    self.model = model;
    NSString *type;
    UIColor *color;
    if (model.type.integerValue == 1 ) {
        type = SSKJLocalized(@"买入", nil);
        color = GREEN_HEX_COLOR;
    }else{
        type = SSKJLocalized(@"卖出", nil);
        color = RED_HEX_COLOR;
    }
    
    NSArray *array = [model.pname componentsSeparatedByString:@"/"];

    NSString *left_code = array.firstObject;
    NSString *right_code = array.lastObject;
    
    self.buySellTypeLabel.textColor = color;
    self.buySellTypeLabel.layer.borderColor = color.CGColor;
    self.buySellTypeLabel.text = type;
    
    self.coinNameLabel.text = model.pname;

    self.timeLabel.text = [WLTools convertTimestamp:model.add_time.doubleValue andFormat:@"MM-dd HH:mm"];
    
    NSInteger priceType = model.otype.integerValue; // 1 限价 2 市价
    self.entrustPriceTitleLabel.text = [NSString stringWithFormat:@"%@(%@)",SSKJLocalized(@"委托价", nil),right_code];

    if (priceType == 2) {
        self.entrustPriceLabel.text = SSKJLocalized(@"市价", nil);
    }else{
        self.entrustPriceLabel.text = [WLTools noroundingStringWith:model.wtprice.doubleValue afterPointNumber:[WLTools dotNumberOfCoinName:right_code]];
    }
    
    
    if (priceType == 2 && model.type.integerValue == 1) {
        self.entrustAmountTitleLabel.text = [NSString stringWithFormat:@"%@(%@)",SSKJLocalized(@"委托金额", nil),right_code];
        self.entrustAmountLabel.text =  [WLTools noroundingStringWith:model.totalprice.doubleValue afterPointNumber:[WLTools dotNumberOfCoinName:right_code]];
    }else{
        self.entrustAmountTitleLabel.text = [NSString stringWithFormat:@"%@(%@)",SSKJLocalized(@"委托量", nil),left_code];
        self.entrustAmountLabel.text =
        self.entrustAmountLabel.text =  [WLTools noroundingStringWith:model.wtnum.doubleValue afterPointNumber:[WLTools dotNumberOfCoinName:left_code]];

    }
    
    self.dealAmountLabel.text =  [WLTools noroundingStringWith:model.cjnum.doubleValue afterPointNumber:[WLTools dotNumberOfCoinName:left_code]];
    
    self.dealAmountTitleLabel.text = [NSString stringWithFormat:@"%@(%@)",SSKJLocalized(@"成交数量", nil),left_code];
}


-(void)cancleOrderEvent
{
    if (self.cancleBlock) {
        self.cancleBlock(self.model);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
