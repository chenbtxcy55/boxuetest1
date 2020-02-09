//
//  JB_BBTrade_MainHeader_View.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/5/14.
//  Copyright © 2019年 刘小雨. All rights reserved.
//


#import "JB_BBTrade_MainHeader_View.h"
#import "BBTrade_NumberView.h"
#import "BuySell5_View.h"
#import "LXY_DeepView.h"
#import "ETF_Default_ActionsheetView.h"
#import "JB_Slider_View.h"

@interface JB_BBTrade_MainHeader_View ()
@property (nonatomic, strong) BuySellSelectView *buySellSelectView; // 买入卖出选择按钮
@property (nonatomic, strong) UIButton *priceTypeButton;            // 市价、限价选择按钮
@property (nonatomic, strong) BBTrade_PriceView *priceView;         // 价格输入框
@property (nonatomic, strong) BBTrade_NumberView *numberView;       // 数量输入框
@property (nonatomic, strong) UILabel *canuseTitleLabel;                 // 可用label
@property (nonatomic, strong) UILabel *canuseLabel;                 // 可用label
@property (nonatomic, strong) JB_Slider_View *sliderView;
@property (nonatomic, strong) UILabel *totalMoneyLabel;             // 交易额
@property (nonatomic, strong) UIButton *buySellButton;              // 买入卖出按钮
@property (nonatomic, strong) LXY_DeepView *deepView;               // 深度图
@property (nonatomic, strong) BuySell5_View *buySell5View;

@property (nonatomic, assign) BuySellType buySellType;

@property (nonatomic, strong) JB_BBTrade_BalanceModel *balanceModel;

@end

@implementation JB_BBTrade_MainHeader_View

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kSubBackgroundColor;
        self.priceType = PriceTypeMarket;
        self.buySellType = BuySellTypeBuy;
        [self setUI];
        self.userInteractionEnabled = YES;
        self.height = self.deepView.bottom + ScaleW(30);
    }
    return self;
}

-(void)viewWilAppear
{
    if (!kLogin) {
        [self.buySellButton setTitle:SSKJLocalized(@"请登录", nil) forState:UIControlStateNormal];
    }else{
        NSString *buyType = SSKJLocalized(@"买入",nil);
        
        if (self.buySellType == BuySellTypeSell) {
            buyType = SSKJLocalized(@"卖出",nil);
        }
        [self.buySellButton setTitle:buyType forState:UIControlStateNormal];
        
    }
}

-(void)setUI
{
    [self addSubview:self.buySellSelectView];
    [self addSubview:self.priceTypeButton];
    [self addSubview:self.priceView];
    [self addSubview:self.numberView];
    [self addSubview:self.canuseTitleLabel];
    [self addSubview:self.canuseLabel];
    [self addSubview:self.sliderView];
    [self addSubview:self.totalMoneyLabel];
    [self addSubview:self.buySellButton];
    [self addSubview:self.deepView];
    [self addSubview:self.buySell5View];
}



-(BuySellSelectView *)buySellSelectView
{
    
    if (nil == _buySellSelectView) {
        _buySellSelectView = [[BuySellSelectView alloc]initWithFrame:CGRectMake(ScaleW(15), ScaleW(20), ScaleW(168), ScaleW(35))];
        WS(weakSelf);
        _buySellSelectView.buySellBlock = ^(BuySellType buySellType) {
            weakSelf.buySellType = buySellType;
            weakSelf.sliderView.buySellType = buySellType;
            NSString *buyType = SSKJLocalized(@"买入",nil);
            UIColor *color = GREEN_HEX_COLOR;
            
            if (buySellType == BuySellTypeSell) {
                buyType = SSKJLocalized(@"卖出",nil);
                color = RED_HEX_COLOR;
            }
            weakSelf.buySellButton.backgroundColor = color;
            if (!kLogin) {
                [weakSelf.buySellButton setTitle:SSKJLocalized(@"请登录", nil) forState:UIControlStateNormal];
            }else{
                [weakSelf.buySellButton setTitle:buyType forState:UIControlStateNormal];
            }
            
            // 执行setter方法
            weakSelf.priceType = weakSelf.priceType;
            
        };
    }
    return _buySellSelectView;
}

-(UIButton *)priceTypeButton
{
    if (nil == _priceTypeButton) {
        _priceTypeButton = [[UIButton alloc]initWithFrame:CGRectMake(self.buySellSelectView.x, self.buySellSelectView.bottom + ScaleW(10), ScaleW(60), ScaleW(30))];
        _priceTypeButton.titleLabel.font = systemFont(ScaleW(13));
        [_priceTypeButton setTitleColor:kTextLightBlueColor forState:UIControlStateNormal];
        [_priceTypeButton setTitle:SSKJLocalized(@"市价",nil) forState:UIControlStateNormal];
        CGFloat width = [WLTools getWidthWithText:SSKJLocalized(@"市价交易",nil) font:_priceTypeButton.titleLabel.font];
        _priceTypeButton.width = width + ScaleW(15);
        [_priceTypeButton setImage:[UIImage imageNamed:@"bc_bb_down"] forState:UIControlStateNormal];
        [_priceTypeButton setImage:[UIImage imageNamed:@"bc_bb_up"] forState:UIControlStateSelected];
        [_priceTypeButton setTitleEdgeInsets:UIEdgeInsetsMake(0, - _priceTypeButton.imageView.image.size.width - ScaleW(4), 0, _priceTypeButton.imageView.image.size.width + ScaleW(4))];
        [_priceTypeButton setImageEdgeInsets:UIEdgeInsetsMake(0, _priceTypeButton.titleLabel.bounds.size.width, 0, -_priceTypeButton.titleLabel.bounds.size.width)];
        [_priceTypeButton addTarget:self action:@selector(selectPriceType) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _priceTypeButton;
}

-(BBTrade_PriceView *)priceView
{
    if (nil == _priceView) {
        _priceView = [[BBTrade_PriceView alloc]initWithFrame:CGRectMake(self.buySellSelectView.x, self.priceTypeButton.bottom + ScaleW(10), self.buySellSelectView.width, ScaleW(45))];
        WS(weakSelf);
        _priceView.priceChangeBlock = ^(NSString * _Nonnull price) {
            NSArray *array = [weakSelf.coinModel.code componentsSeparatedByString:@"/"];
            
//            weakSelf.totalMoneyLabel.text = [NSString stringWithFormat:@"%@:%@%@",SSKJLocalized(@"交易额", nil),[WLTools noroundingStringWith:self.numberView.numberTextField.text.doubleValue * price.doubleValue afterPointNumber:weakSelf.priceView.dotNumber],array.lastObject];
            
            if (weakSelf.priceType == PriceTypeLimite) {
                if (weakSelf.buySellType == BuySellTypeBuy) {
                    NSArray *array = [weakSelf.coinModel.code componentsSeparatedByString:@"/"];
                    weakSelf.totalMoneyLabel.text = [NSString stringWithFormat:@"%@:%@%@",SSKJLocalized(@"交易额", nil),[WLTools noroundingStringWith:self.numberView.numberTextField.text.doubleValue * weakSelf.priceView.price.doubleValue * (1 + self.balanceModel.trans_fee.doubleValue) afterPointNumber:weakSelf.priceView.dotNumber],array.lastObject];
                    if (self.balanceModel.right_code.doubleValue == 0) {
                        weakSelf.sliderView.progress = 0;
                    }else{
                        weakSelf.sliderView.progress = weakSelf.priceView.price.doubleValue * (1 + self.balanceModel.trans_fee.doubleValue) / self.balanceModel.right_code.doubleValue;
                    }
                }else{
                    NSArray *array = [weakSelf.coinModel.code componentsSeparatedByString:@"/"];
                    weakSelf.totalMoneyLabel.text = [NSString stringWithFormat:@"%@:%@%@",SSKJLocalized(@"交易额", nil),[WLTools noroundingStringWith:self.numberView.numberTextField.text.doubleValue * weakSelf.priceView.price.doubleValue * (1 + self.balanceModel.trans_fee.doubleValue) afterPointNumber:weakSelf.priceView.dotNumber],array.lastObject];
                    if (self.balanceModel.right_code.doubleValue == 0) {
                        weakSelf.sliderView.progress = 0;
                    }else{
                        weakSelf.sliderView.progress = self.numberView.numberTextField.text.doubleValue * weakSelf.priceView.price.doubleValue * (1 + self.balanceModel.trans_fee.doubleValue) / self.balanceModel.right_code.doubleValue;
                    }
                }
            }
//            else{
//                NSArray *array = [weakSelf.coinModel.code componentsSeparatedByString:@"/"];
//                weakSelf.totalMoneyLabel.text = [NSString stringWithFormat:@"%@:%@%@",SSKJLocalized(@"交易额", nil),[WLTools noroundingStringWith:weakSelf.priceView.price.doubleValue afterPointNumber:weakSelf.priceView.dotNumber],array.lastObject];
//            }
        };
    }
    return _priceView;
    
}

-(BBTrade_NumberView *)numberView
{
    if (nil == _numberView) {
        _numberView = [[BBTrade_NumberView alloc]initWithFrame:CGRectMake(self.priceView.x, self.priceView.bottom + ScaleW(10), self.priceView.width, self.priceView.height)];
        WS(weakSelf);
        _numberView.numberChangeBlock = ^(NSString * _Nonnull number) {
            if (weakSelf.priceType == PriceTypeLimite) {
                if (weakSelf.buySellType == BuySellTypeBuy) {
                    NSArray *array = [weakSelf.coinModel.code componentsSeparatedByString:@"/"];

                    double totalNumber = self.balanceModel.right_code.doubleValue / self.priceView.price.doubleValue  / (1 + self.balanceModel.trans_fee.doubleValue);
                    if (number.doubleValue > totalNumber) {
                        number = [WLTools roundingStringWith:totalNumber afterPointNumber:[WLTools dotNumberOfCoinName:array.firstObject]];
                        weakSelf.numberView.numberTextField.text = [WLTools roundingStringWith:totalNumber afterPointNumber:[WLTools dotNumberOfCoinName:array.firstObject]];
                    }
                    
                    weakSelf.totalMoneyLabel.text = [NSString stringWithFormat:@"%@:%@%@",SSKJLocalized(@"交易额", nil),[WLTools noroundingStringWith:number.doubleValue * self.priceView.price.doubleValue  * (1 + self.balanceModel.trans_fee.doubleValue) afterPointNumber:weakSelf.priceView.dotNumber],array.lastObject];
                    if (self.balanceModel.right_code.doubleValue == 0) {
                        weakSelf.sliderView.progress = 0;
                    }else{
                        weakSelf.sliderView.progress = number.doubleValue * self.priceView.price.doubleValue  * (1 + self.balanceModel.trans_fee.doubleValue) / self.balanceModel.right_code.doubleValue;
                    }
                }else{
                    NSArray *array = [weakSelf.coinModel.code componentsSeparatedByString:@"/"];
                    if (number.doubleValue > weakSelf.balanceModel.left_code.doubleValue) {
                        number = [WLTools noroundingStringWith:weakSelf.balanceModel.left_code.doubleValue afterPointNumber:[WLTools dotNumberOfCoinName:array.firstObject]];
                        weakSelf.numberView.numberTextField.text = number;
                    }
                    weakSelf.totalMoneyLabel.text = [NSString stringWithFormat:@"%@:%@%@",SSKJLocalized(@"交易额", nil),[WLTools noroundingStringWith:number.doubleValue * self.priceView.price.doubleValue afterPointNumber:weakSelf.priceView.dotNumber],array.lastObject];
                    if (self.balanceModel.right_code.doubleValue == 0) {
                        weakSelf.sliderView.progress = 0;
                    }else{
                        weakSelf.sliderView.progress = number.doubleValue  / self.balanceModel.left_code.doubleValue;
                    }

                }
            }else{
                NSArray *array = [weakSelf.coinModel.code componentsSeparatedByString:@"/"];

                if (weakSelf.buySellType == BuySellTypeBuy) {
                    if (number.doubleValue > self.balanceModel.right_code.doubleValue) {
                        number = self.balanceModel.right_code;
                        weakSelf.numberView.numberTextField.text = [WLTools noroundingStringWith:weakSelf.balanceModel.right_code.doubleValue afterPointNumber:[WLTools dotNumberOfCoinName:array.lastObject]];
                    }
                    weakSelf.totalMoneyLabel.text = [NSString stringWithFormat:@"%@:%@%@",SSKJLocalized(@"交易额", nil),[WLTools noroundingStringWith:weakSelf.numberView.numberTextField.text.doubleValue * (1 + self.balanceModel.trans_fee.doubleValue) afterPointNumber:weakSelf.priceView.dotNumber],array.lastObject];
                    if (self.balanceModel.right_code.doubleValue == 0) {
                        weakSelf.sliderView.progress = 0;
                    }else{
                        weakSelf.sliderView.progress = weakSelf.numberView.numberTextField.text.doubleValue * (1 + self.balanceModel.trans_fee.doubleValue) / self.balanceModel.right_code.doubleValue;
                    }

                }else{
                    if (number.doubleValue > self.balanceModel.left_code.doubleValue) {
                        number = self.balanceModel.left_code;
                        weakSelf.numberView.numberTextField.text = [WLTools noroundingStringWith:weakSelf.balanceModel.left_code.doubleValue afterPointNumber:[WLTools dotNumberOfCoinName:array.firstObject]];
                    }
                    weakSelf.totalMoneyLabel.text = [NSString stringWithFormat:@"%@:%@%@",SSKJLocalized(@"交易量", nil),[WLTools noroundingStringWith:weakSelf.numberView.numberTextField.text.doubleValue afterPointNumber:weakSelf.priceView.dotNumber],array.firstObject];
                    if (self.balanceModel.left_code.doubleValue == 0) {
                        weakSelf.sliderView.progress = 0;
                    }else{
                        weakSelf.sliderView.progress = weakSelf.numberView.numberTextField.text.doubleValue / self.balanceModel.left_code.doubleValue;
                    }

                }
            }
        };
    }
    return _numberView;
}

-(UILabel *)canuseTitleLabel
{
    if (nil == _canuseTitleLabel) {
        NSString *title = SSKJLocalized(@"可用", nil) ;
        _canuseTitleLabel = [WLTools allocLabel:title font:systemFont(ScaleW(12)) textColor: kMainTextColor frame:CGRectMake(self.numberView.x, self.numberView.bottom + ScaleW(10), self.numberView.width / 3, ScaleW(30)) textAlignment:NSTextAlignmentLeft];
    }
    return _canuseTitleLabel;
}

-(UILabel *)canuseLabel
{
    if (nil == _canuseLabel) {
        NSString *title = @"0.000000AB";
        
        _canuseLabel = [WLTools allocLabel:title font:systemFont(ScaleW(12)) textColor:kMainWihteColor frame:CGRectMake(self.canuseTitleLabel.right, self.numberView.bottom + ScaleW(10), self.numberView.width / 3 * 2, ScaleW(30)) textAlignment:NSTextAlignmentRight];
        _canuseLabel.backgroundColor = [UIColor clearColor];
    }
    return _canuseLabel;
}

-(JB_Slider_View *)sliderView
{
    if (nil == _sliderView) {
        _sliderView = [[JB_Slider_View alloc]initWithFrame:CGRectMake(self.numberView.x, self.canuseLabel.bottom + ScaleW(10), self.numberView.width, ScaleW(25))];
        _sliderView.progress = 0;
        WS(weakSelf);
        _sliderView.changeProgressBlock = ^(double progress) {
            [weakSelf changeProgress:progress];
        };
    }
    return _sliderView;
}


-(void)changeProgress:(double)progress
{

    NSArray *array = [self.coinModel.code componentsSeparatedByString:@"/"];

    
    
    if (self.priceType == PriceTypeLimite) {
        if (self.buySellType == BuySellTypeBuy) {
            double totalNumber;
            if (self.priceView.price.doubleValue == 0) {
                totalNumber = 0;
            }else{
                totalNumber = self.balanceModel.right_code.doubleValue / self.priceView.price.doubleValue / (self.balanceModel.trans_fee.doubleValue + 1);
            }
            self.numberView.numberTextField.text = [WLTools roundingStringWith:totalNumber * progress afterPointNumber:[WLTools dotNumberOfCoinName:array.firstObject]];

            self.totalMoneyLabel.text = [NSString stringWithFormat:@"%@:%@%@",SSKJLocalized(@"交易额", nil),[WLTools noroundingStringWith:self.balanceModel.right_code.doubleValue * progress afterPointNumber:self.priceView.dotNumber],array.lastObject];
            
        }else{
            double totalNumber = self.balanceModel.left_code.doubleValue;
            self.numberView.numberTextField.text = [WLTools roundingStringWith:self.balanceModel.left_code.doubleValue * progress afterPointNumber:[WLTools dotNumberOfCoinName:array.firstObject]];

            self.totalMoneyLabel.text = [NSString stringWithFormat:@"%@:%@%@",SSKJLocalized(@"交易额", nil),[WLTools noroundingStringWith:totalNumber * progress * self.priceView.price.doubleValue afterPointNumber:self.priceView.dotNumber],array.lastObject];

        }
    }else{
        
        if (self.buySellType == BuySellTypeBuy) {
            self.numberView.numberTextField.text = [WLTools roundingStringWith:self.balanceModel.right_code.doubleValue * progress afterPointNumber:[WLTools dotNumberOfCoinName:array.lastObject]];

            self.totalMoneyLabel.text = [NSString stringWithFormat:@"%@:%@%@",SSKJLocalized(@"交易额", nil),[WLTools noroundingStringWith:self.numberView.numberTextField.text.doubleValue * (1 + self.balanceModel.trans_fee.doubleValue) afterPointNumber:self.priceView.dotNumber],array.lastObject];

        }else{
//            double totalNumber;
//            if (self.priceView.price.doubleValue == 0) {
//                totalNumber = 0;
//            }else{
//                totalNumber = self.balanceModel.right_code.doubleValue / self.priceView.price.doubleValue / (self.balanceModel.trans_fee.doubleValue + 1);
//            }
            self.numberView.numberTextField.text = [WLTools roundingStringWith:self.balanceModel.left_code.doubleValue * progress afterPointNumber:[WLTools dotNumberOfCoinName:array.firstObject]];

            self.totalMoneyLabel.text = [NSString stringWithFormat:@"%@:%@%@",SSKJLocalized(@"交易量", nil),[WLTools noroundingStringWith:self.numberView.numberTextField.text.doubleValue afterPointNumber:self.priceView.dotNumber],array.firstObject];

        }
    }
}


-(UILabel *)totalMoneyLabel
{
    if (nil == _totalMoneyLabel) {
        NSString *title = [NSString stringWithFormat:@"%@：--",SSKJLocalized(@"交易额",nil)];
        _totalMoneyLabel = [WLTools allocLabel:title font:systemFont(ScaleW(12)) textColor:kTextLightBlueColor frame:CGRectMake(self.canuseTitleLabel.x, self.sliderView.bottom, self.numberView.width, ScaleW(43)) textAlignment:NSTextAlignmentLeft];
//        _totalMoneyLabel.hidden = YES;
    }
    return _totalMoneyLabel;
}

-(UIButton *)buySellButton
{
    if (nil == _buySellButton) {
        _buySellButton = [[UIButton alloc]initWithFrame:CGRectMake(self.numberView.x, self.totalMoneyLabel.bottom + ScaleW(5), self.numberView.width, ScaleW(40))];
        NSString *title = SSKJLocalized(@"买入",nil);
        [_buySellButton setTitle:title forState:UIControlStateNormal];
        [_buySellButton setTitleColor:kMainWihteColor forState:UIControlStateNormal];
        _buySellButton.titleLabel.font = systemFont(ScaleW(12));
        _buySellButton.layer.cornerRadius = 4.0f;;
        _buySellButton.backgroundColor = GREEN_HEX_COLOR;
        [_buySellButton addTarget:self action:@selector(confirmBuy) forControlEvents:UIControlEventTouchUpInside];
    }
    return _buySellButton;
}

-(LXY_DeepView *)deepView
{
    if (nil == _deepView) {
        _deepView = [[LXY_DeepView alloc]initWithFrame:CGRectMake(self.buySellButton.x, self.buySellButton.bottom + ScaleW(5), self.buySellButton.width, ScaleW(157))];
    }
    return _deepView;
}

-(BuySell5_View *)buySell5View
{
    if (nil == _buySell5View) {
        _buySell5View = [[BuySell5_View alloc]initWithFrame:CGRectMake(self.numberView.right + ScaleW(18), ScaleW(20), self.width - self.numberView.right - ScaleW(18), self.deepView.bottom - self.buySellSelectView.y)];
        WS(weakSelf);
        _buySell5View.selectPriceBlock = ^(NSString * _Nonnull price) {
            if (weakSelf.priceType == PriceTypeLimite && ![price isEqualToString:@"--"]) {
                weakSelf.priceView.price = price;
            }
        };
    }
    return _buySell5View;
}



#pragma mark - 用户操作
#pragma mark 更换市价、限价

-(void)selectPriceType
{
    WS(weakSelf);
    __block NSArray *array = @[SSKJLocalized(@"市价", nil),SSKJLocalized(@"限价", nil)];
    self.priceTypeButton.selected = YES;
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    [ETF_Default_ActionsheetView showWithItems:array title:@"" selectedIndexBlock:^(NSInteger selectIndex) {
        NSString *title = array[selectIndex];
        [weakSelf.priceTypeButton setTitle:title forState:UIControlStateNormal];
        weakSelf.priceTypeButton.selected = NO;
        if (selectIndex == 0) {
            weakSelf.priceType = PriceTypeMarket;
        }else{
            weakSelf.priceType = PriceTypeLimite;
        }
    } cancleBlock:^{
        weakSelf.priceTypeButton.selected = NO;

    }];
}


-(void)setBuysellType:(BuySellType)buysellType
{
    _buySellType = buysellType;
    self.buySellSelectView.buySellType = buysellType;
    self.sliderView.buySellType = buysellType;
    NSString *buyType = SSKJLocalized(@"买入",nil);
    UIColor *color = GREEN_HEX_COLOR;
    
    if (buysellType == BuySellTypeSell) {
        buyType = SSKJLocalized(@"卖出",nil);
        color = RED_HEX_COLOR;
    }
    self.buySellButton.backgroundColor = color;
    if (!kLogin) {
        [self.buySellButton setTitle:SSKJLocalized(@"请登录", nil) forState:UIControlStateNormal];
    }else{
        [self.buySellButton setTitle:buyType forState:UIControlStateNormal];
    }
    
    // 执行setter方法
    self.priceType = self.priceType;
}

-(void)setPriceType:(PriceType)priceType
{
    _priceType = priceType;
    self.priceView.priceType = priceType;
    self.sliderView.progress = 0;
    if (priceType == PriceTypeMarket) {
        [self.priceTypeButton setTitle:SSKJLocalized(@"市价交易",nil) forState:UIControlStateNormal];
        self.priceTypeButton.selected = NO;
        self.totalMoneyLabel.hidden = NO;
    }else{
        [self.priceTypeButton setTitle:SSKJLocalized(@"限价交易",nil) forState:UIControlStateNormal];
        self.priceTypeButton.selected = NO;
        self.totalMoneyLabel.hidden = NO;
    }
    
    CGFloat width = [WLTools getWidthWithText:[self.priceTypeButton titleForState:UIControlStateNormal] font:_priceTypeButton.titleLabel.font];
    _priceTypeButton.width = width + ScaleW(15);
    [_priceTypeButton setTitleEdgeInsets:UIEdgeInsetsMake(0, - _priceTypeButton.imageView.image.size.width - ScaleW(4), 0, _priceTypeButton.imageView.image.size.width + ScaleW(4))];
    [_priceTypeButton setImageEdgeInsets:UIEdgeInsetsMake(0, _priceTypeButton.titleLabel.bounds.size.width, 0, -_priceTypeButton.titleLabel.bounds.size.width)];
    
    self.priceView.priceType = self.priceType;
    
    NSString *coinName = self.coinModel.name;
    
    NSArray *array = [coinName componentsSeparatedByString:@"/"];
    
    if (self.priceType == PriceTypeMarket) {

        if (self.buySellType == BuySellTypeBuy) {
            self.totalMoneyLabel.text = [NSString stringWithFormat:@"%@:--",SSKJLocalized(@"交易额", nil)];

            self.numberView.unitLabel.text = array.lastObject;
            self.canuseLabel.text = [NSString stringWithFormat:@"%@ %@",[WLTools noroundingStringWith:self.balanceModel.right_code.doubleValue afterPointNumber:[WLTools dotNumberOfCoinName:array.lastObject]],array.lastObject];
//            self.numberView.dotNumber = [WLTools dotNumberOfCoinName:array.lastObject];
            self.numberView.dotNumber = [WLTools dotNumberOfCoinCode:self.coinModel.code];

        }else{
            self.totalMoneyLabel.text = [NSString stringWithFormat:@"%@:--",SSKJLocalized(@"交易量", nil)];

            self.numberView.unitLabel.text = array.firstObject;
            self.canuseLabel.text = [NSString stringWithFormat:@"%@ %@",[WLTools noroundingStringWith:self.balanceModel.left_code.doubleValue afterPointNumber:[WLTools dotNumberOfCoinName:array.firstObject]],array.firstObject];
            self.numberView.dotNumber = [WLTools dotNumberOfCoinName:array.firstObject];

        }
        
        
    }else{
        self.totalMoneyLabel.text = [NSString stringWithFormat:@"%@:--",SSKJLocalized(@"交易额", nil)];

        if (self.buySellType == BuySellTypeBuy) {
            self.numberView.unitLabel.text = array.firstObject;
            self.canuseLabel.text = [NSString stringWithFormat:@"%@ %@",[WLTools noroundingStringWith:self.balanceModel.right_code.doubleValue afterPointNumber:[WLTools dotNumberOfCoinName:array.lastObject]],array.lastObject];
            self.priceView.price = [WLTools noroundingStringWith:self.coinModel.price.doubleValue afterPointNumber:[WLTools dotNumberOfCoinCode:self.coinModel.code]];
            self.numberView.dotNumber = [WLTools dotNumberOfCoinName:array.firstObject];
        }else{
            self.numberView.unitLabel.text = array.firstObject;
            self.canuseLabel.text = [NSString stringWithFormat:@"%@ %@",[WLTools noroundingStringWith:self.balanceModel.left_code.doubleValue afterPointNumber:[WLTools dotNumberOfCoinName:array.firstObject]],array.firstObject];
            self.priceView.price = [WLTools noroundingStringWith:self.coinModel.price.doubleValue afterPointNumber:[WLTools dotNumberOfCoinCode:self.coinModel.code]];
            self.numberView.dotNumber = [WLTools dotNumberOfCoinName:array.firstObject];
        }
        

    }
    
    self.numberView.numberTextField.text = nil;
    [self setSliderViewWithBalanceModel:self.balanceModel priceType:self.priceType buySelType:self.buySellType];

}

-(void)confirmBuy
{
    if (!kLogin) {
        if (self.loginBlock) {
            self.loginBlock();
        }
        return;
    }
    
    if (self.numberView.numberTextField.text.length == 0) {
        [MBProgressHUD showError:SSKJLocalized(@"请输入数量", nil)];
        return;
    }else if (self.numberView.numberTextField.text.doubleValue == 0){
        [MBProgressHUD showError:SSKJLocalized(@"数量不能为0", nil)];
        return;
    }
    
    if (self.confirmBuyBlock) {        self.confirmBuyBlock(self.numberView.numberTextField.text,self.buySellType,self.priceType,self.priceView.price);
    }
}


-(void)setCoinModel:(JB_Market_Index_Model *)coinModel
{
    _coinModel = coinModel;
    self.priceView.dotNumber = [WLTools dotNumberOfCoinCode:coinModel.code];
    [self.buySell5View setCoinModel:coinModel];
    NSString *coinName = coinModel.name;
    
    NSArray *array = [coinName componentsSeparatedByString:@"/"];
    
    if (self.priceType == PriceTypeMarket) {
        self.numberView.unitLabel.text = array.lastObject;
    }else{
        self.numberView.unitLabel.text = array.firstObject;
        self.priceView.price = [WLTools noroundingStringWith:coinModel.price.doubleValue afterPointNumber:[WLTools dotNumberOfCoinCode:coinModel.code]];
    }
    self.buySell5View.coinAmountDotNumber = [WLTools dotNumberOfCoinName:array.firstObject];

    self.priceType = self.priceType;
}

-(void)setViewWithBalanceModel:(JB_BBTrade_BalanceModel *)balanceModel
{
    self.balanceModel = balanceModel;
    NSString *coinName = self.coinModel.name;
    
    NSArray *array = [coinName componentsSeparatedByString:@"/"];
    
    if (self.priceType == PriceTypeMarket) {
        
        if (self.buySellType == BuySellTypeBuy) {
            self.canuseLabel.text = [NSString stringWithFormat:@"%@ %@",[WLTools noroundingStringWith:balanceModel.right_code.doubleValue afterPointNumber:[WLTools dotNumberOfCoinName:array.lastObject]],array.lastObject];
            
        }else{
            self.canuseLabel.text = [NSString stringWithFormat:@"%@ %@",[WLTools noroundingStringWith:balanceModel.left_code.doubleValue afterPointNumber:[WLTools dotNumberOfCoinName:array.firstObject]],array.firstObject];
        }
    }else{
        if (self.buySellType == BuySellTypeBuy) {
            self.canuseLabel.text = [NSString stringWithFormat:@"%@ %@",[WLTools noroundingStringWith:balanceModel.right_code.doubleValue afterPointNumber:[WLTools dotNumberOfCoinName:array.lastObject]],array.lastObject];

        }else{
            self.canuseLabel.text = [NSString stringWithFormat:@"%@ %@",[WLTools noroundingStringWith:balanceModel.left_code.doubleValue afterPointNumber:[WLTools dotNumberOfCoinName:array.firstObject]],array.firstObject];

        }
        
        
    }
    
    [self setSliderViewWithBalanceModel:self.balanceModel priceType:self.priceType buySelType:self.buySellType];
}


-(void)setSliderViewWithBalanceModel:(JB_BBTrade_BalanceModel *)balanceModel priceType:(PriceType)priceType buySelType:(BuySellType)buySellType
{
    self.sliderView.startLabel.text = @"0";
    NSArray *nameArray = [self.coinModel.code componentsSeparatedByString:@"/"];
    if (priceType == PriceTypeLimite) {
        if (buySellType == BuySellTypeBuy) {
            self.sliderView.endLabel.text = [NSString stringWithFormat:@"%@ %@",[WLTools roundingStringWith:self.balanceModel.right_code.doubleValue afterPointNumber:[WLTools dotNumberOfCoinName:nameArray.lastObject]],nameArray.lastObject];
        }else{
            self.sliderView.endLabel.text = [NSString stringWithFormat:@"%@ %@",[WLTools roundingStringWith:self.balanceModel.left_code.doubleValue afterPointNumber:[WLTools dotNumberOfCoinName:nameArray.firstObject]],nameArray.firstObject];
        }
    }else{
        if (buySellType == BuySellTypeBuy) {
            self.sliderView.endLabel.text = [NSString stringWithFormat:@"%@ %@",[WLTools roundingStringWith:self.balanceModel.left_code.doubleValue afterPointNumber:[WLTools dotNumberOfCoinName:nameArray.firstObject]],nameArray.lastObject];
        }else{
            self.sliderView.endLabel.text = [NSString stringWithFormat:@"%@ %@",[WLTools roundingStringWith:self.balanceModel.left_code.doubleValue afterPointNumber:[WLTools dotNumberOfCoinName:nameArray.firstObject]],nameArray.firstObject];
            
        }
    }
}

-(void)setDeepData:(NSDictionary *)deepData
{
    [self.deepView setData:deepData];
}

-(void)setPankouData:(ETF_Contract_Depth_Model *)Model
{
    [self.buySell5View setViewWithModel:Model];
}

-(void)setMarketData:(JB_Market_Index_Model *)Model
{
    [self.buySell5View setPriceModel:Model];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
