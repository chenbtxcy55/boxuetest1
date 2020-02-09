//
//  JB_BBTrade_OrderList_Cell.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/5/14.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "JB_BBTrade_OrderList_Cell.h"

@interface JB_BBTrade_OrderList_Cell ()
@property (nonatomic, strong) UILabel *buySellTypeLabel;
@property (nonatomic, strong) UILabel *coinNameLabel;
@property (nonatomic, strong) UILabel *statusLabel;

@property (nonatomic, strong) UILabel *entrustTimeTitleLabel;           // 委托时间
@property (nonatomic, strong) UILabel *entrustTimeLabel;           // 委托时间

@property (nonatomic, strong) UILabel *entrustPriceTitleLabel;   // 委托价格
@property (nonatomic, strong) UILabel *entrustPriceLabel;   // 委托价格

@property (nonatomic, strong) UILabel *entrustAmountTitleLabel;  // 委托量
@property (nonatomic, strong) UILabel *entrustAmountLabel;  // 委托量

@property (nonatomic, strong) UILabel *dealTotalPriceTitleLabel;// 成交总额
@property (nonatomic, strong) UILabel *dealTotalPriceLabel;// 成交总额

@property (nonatomic, strong) UILabel *dealPriceTitleLabel;      // 成交均价
@property (nonatomic, strong) UILabel *dealPriceLabel;      // 成交均价

@property (nonatomic, strong) UILabel *dealAmountTitleLabel; // 成交量
@property (nonatomic, strong) UILabel *dealAmountLabel; // 成交量

@property (nonatomic, strong) UILabel *dealTimeTitleLabel; // 成交时间
@property (nonatomic, strong) UILabel *dealTimeLabel; // 成交时间

@property (nonatomic, strong) UILabel *sxFeeTitleLabel; // 手续费
@property (nonatomic, strong) UILabel *sxFeeLabel; // 手续费

@property (nonatomic, strong) UIButton *cancleButton;   // 撤销按钮

@property (nonatomic, strong) JB_BBTrade_Order_Index_Model *model;


@end

@implementation JB_BBTrade_OrderList_Cell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        [self addSubview:self.buySellTypeLabel];
        [self addSubview:self.coinNameLabel];
        [self addSubview:self.statusLabel];
        
        
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
        _coinNameLabel = [WLTools allocLabel:@"BTC/AB" font:systemFont(ScaleW(14)) textColor:kMainWihteColor frame:CGRectMake(self.buySellTypeLabel.right + ScaleW(17), self.buySellTypeLabel.y, ScaleW(100), ScaleW(14)) textAlignment:NSTextAlignmentLeft];
    }
    return _coinNameLabel;
}

-(UILabel *)statusLabel
{
    if (nil == _statusLabel) {
        _statusLabel = [WLTools allocLabel:@"已成交" font:systemFont(ScaleW(14)) textColor:kMainWihteColor frame:CGRectMake(ScreenWidth - ScaleW(15) - ScaleW(100), 0, ScaleW(100), ScaleW(14)) textAlignment:NSTextAlignmentRight];
        _statusLabel.centerY = self.coinNameLabel.centerY;
    }
    return _statusLabel;
}

-(UIButton *)cancleButton
{
    if (nil == _cancleButton) {
        _cancleButton = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth - ScaleW(15) - ScaleW(80), 0, ScaleW(80), ScaleW(40))];
        _cancleButton.centerY = self.sxFeeLabel.centerY;
        [_cancleButton setTitle:SSKJLocalized(@"撤销", nil) forState:UIControlStateNormal];
        [_cancleButton setTitleColor:kTextDarkBlueColor forState:UIControlStateNormal];
        _cancleButton.layer.masksToBounds = YES;
        _cancleButton.layer.cornerRadius = _cancleButton.height / 2;
        _cancleButton.layer.borderColor = kTextDarkBlueColor.CGColor;
        _cancleButton.layer.borderWidth = 0.5;
        [_cancleButton addTarget:self action:@selector(cancleOrderEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancleButton;
}

-(void)addLabels
{
    
    NSArray *titleArray = @[
                            SSKJLocalized(@"委托时间", nil),
                            SSKJLocalized(@"委托价(AB)", nil),
                            SSKJLocalized(@"委托量(ETH)", nil),
                            SSKJLocalized(@"成交总额(ETH)", nil),
                            SSKJLocalized(@"成交均价(ETH)", nil),
                            SSKJLocalized(@"成交量(ETH)", nil),
                            SSKJLocalized(@"成交时间", nil),
                            SSKJLocalized(@"手续费(AB)", nil),
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
        
        
        UILabel *titleLabel = [WLTools allocLabel:title font:systemFont(ScaleW(13.5)) textColor:UIColorFromRGB(0x8591ac) frame:CGRectMake(ScaleW(15) + line * width, self.buySellTypeLabel.bottom + ScaleW(20) + row * ScaleW(55), width, ScaleW(13.5)) textAlignment:aligment];
        
        [self addSubview:titleLabel];
        
        UILabel *valueLabel = [WLTools allocLabel:@"--" font:systemBoldFont(ScaleW(13.5)) textColor:kMainWihteColor frame:CGRectMake(titleLabel.x, titleLabel.bottom + ScaleW(12), width, ScaleW(13.5)) textAlignment:aligment];
        
        [self addSubview:valueLabel];
        
        switch (i) {
            case 0:
                {
                    self.entrustTimeTitleLabel = titleLabel;
                    self.entrustTimeLabel = valueLabel;
                }
                break;
            case 1:
            {
                self.entrustPriceTitleLabel = titleLabel;
                self.entrustPriceLabel = valueLabel;
            }
                break;
            case 2:
            {
                self.entrustAmountTitleLabel = titleLabel;
                self.entrustAmountLabel = valueLabel;
            }
                break;
            case 3:
            {
                self.dealTotalPriceTitleLabel = titleLabel;
                self.dealTotalPriceLabel = valueLabel;
            }
                break;
            case 4:
            {
                self.dealPriceTitleLabel = titleLabel;
                self.dealPriceLabel = valueLabel;
            }
                break;
            case 5:
            {
                self.dealAmountTitleLabel = titleLabel;
                self.dealAmountLabel = valueLabel;
            }
                break;
            case 6:
            {
                self.dealTimeTitleLabel = titleLabel;
                self.dealTimeLabel = valueLabel;
            }
                break;
            case 7:
            {
                self.sxFeeTitleLabel = titleLabel;
                self.sxFeeLabel = valueLabel;
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
    
    self.buySellTypeLabel.textColor = color;
    self.buySellTypeLabel.layer.borderColor = color.CGColor;
    self.buySellTypeLabel.text = type;
    
    self.coinNameLabel.text = model.pname;
    NSString *statusString;
    
    
    self.entrustTimeLabel.text = [WLTools convertTimestamp:model.add_time.doubleValue andFormat:@"MM-dd HH:mm:ss"];
    
    NSArray *array = [model.pname componentsSeparatedByString:@"/"];
    NSString *left_code = array.firstObject;
    NSString *right_code = array.lastObject;
    NSInteger priceType = model.otype.integerValue;
    
    self.entrustPriceTitleLabel.text = [NSString stringWithFormat:@"%@(%@)",SSKJLocalized(@"委托价", nil),right_code];
    
    self.entrustAmountTitleLabel.text = [NSString stringWithFormat:@"%@(%@)",SSKJLocalized(@"委托量", nil),left_code];

    if (priceType == 1) {       // 限价
        self.entrustPriceLabel.text = [WLTools noroundingStringWith:model.wtprice.doubleValue afterPointNumber:[WLTools dotNumberOfCoinName:right_code]];
        self.entrustAmountLabel.text = [WLTools noroundingStringWith:model.wtnum.doubleValue afterPointNumber:[WLTools dotNumberOfCoinName:left_code]];
    }else{                  // 市价
        self.entrustPriceLabel.text = SSKJLocalized(@"市价", nil);

        if (model.type.integerValue == 1 ) {    // 买入
            self.entrustAmountTitleLabel.text = [NSString stringWithFormat:@"%@(%@)",SSKJLocalized(@"委托金额", nil),right_code];
            self.entrustAmountLabel.text = [WLTools noroundingStringWith:model.totalprice.doubleValue afterPointNumber:[WLTools dotNumberOfCoinName:right_code]];;
        }else{
            self.entrustAmountLabel.text = [WLTools noroundingStringWith:model.wtnum.doubleValue afterPointNumber:[WLTools dotNumberOfCoinName:left_code]];
            self.entrustAmountLabel.text = [WLTools noroundingStringWith:model.wtnum.doubleValue afterPointNumber:[WLTools dotNumberOfCoinName:left_code]];
        }
        
    }
    
    self.dealTotalPriceTitleLabel.text = [NSString stringWithFormat:@"%@(%@)",SSKJLocalized(@"成交总额", nil),right_code];
    self.dealTotalPriceLabel.text = [WLTools noroundingStringWith:model.cjnum.doubleValue * model.cjprice.doubleValue afterPointNumber:[WLTools dotNumberOfCoinName:right_code]];
    
    self.dealPriceTitleLabel.text =  [NSString stringWithFormat:@"%@(%@)",SSKJLocalized(@"成交均价", nil),right_code];
    self.dealPriceLabel.text = [WLTools noroundingStringWith:model.cjprice.doubleValue afterPointNumber:[WLTools dotNumberOfCoinName:right_code]];
    
    self.dealAmountTitleLabel.text = [NSString stringWithFormat:@"%@(%@)",SSKJLocalized(@"成交量", nil),left_code];
    self.dealAmountLabel.text = [WLTools noroundingStringWith:model.cjnum.doubleValue afterPointNumber:[WLTools dotNumberOfCoinName:left_code]];
    
    self.dealTimeLabel.text = [WLTools convertTimestamp:model.trade_time.doubleValue andFormat:@"MM-dd HH:mm:ss"];
    
    self.sxFeeTitleLabel.text = [NSString stringWithFormat:@"%@(%@)",SSKJLocalized(@"手续费", nil),right_code];
    self.sxFeeLabel.text = [WLTools noroundingStringWith:model.fee.doubleValue afterPointNumber:[WLTools dotNumberOfCoinName:right_code]];
    
    NSInteger status = model.status.integerValue;
    self.cancleButton.hidden = YES;
    switch (status) {
        case 0:
        {
            statusString = SSKJLocalized(@"委托中", nil);
            self.cancleButton.hidden = NO;
            self.dealTotalPriceLabel.text = @"--";
            self.dealPriceLabel.text = @"--";
            self.dealAmountLabel.text = @"--";
            self.dealTimeLabel.text = @"--";
            self.sxFeeLabel.text = @"--";
        }
            break;
        case 1:
            statusString = SSKJLocalized(@"交易中", nil);
            self.cancleButton.hidden = NO;
            break;
        case 2:
            statusString = SSKJLocalized(@"已成交", nil);
            break;
        case -1:
            statusString = SSKJLocalized(@"已撤销", nil);
            break;
            
        default:
            break;
    }
    self.statusLabel.text = statusString;
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
