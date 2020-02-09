//
//  ETF_BBTrade_TableHeaderView.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/1/15.
//  Copyright © 2019年 James. All rights reserved.
//

#import "ETF_BBTrade_TableHeaderView.h"

@interface ETF_BBTrade_TableHeaderView ()

@property (nonatomic, strong) UIImageView *bgImageView;

@property (nonatomic, strong) UILabel *currentPricelabel;
@property (nonatomic, strong) UILabel *rateLabel;
@property (nonatomic, strong) UILabel *CNYLabel;
@property (nonatomic, strong) UILabel *highTitleLabel;
@property (nonatomic, strong) UILabel *highLabel;
@property (nonatomic, strong) UILabel *lowTitleLabel;
@property (nonatomic, strong) UILabel *lowLabel;
@property (nonatomic, strong) UILabel *volumeTitleLabel;
@property (nonatomic, strong) UILabel *volumeLabel;
@property (nonatomic, strong) UIImageView *statusView;

@end

@implementation ETF_BBTrade_TableHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kNavBGColor;
        
        [self addSubview:self.bgImageView];
        
        [self.bgImageView addSubview:self.currentPricelabel];
        
        [self.bgImageView addSubview:self.CNYLabel];
        [self.bgImageView addSubview:self.rateLabel];
        [self.bgImageView addSubview:self.statusView];

        [self.bgImageView addSubview:self.highLabel];
        [self.bgImageView addSubview:self.highTitleLabel];
        [self.bgImageView addSubview:self.lowLabel];
        [self.bgImageView addSubview:self.lowTitleLabel];
        [self.bgImageView addSubview:self.volumeTitleLabel];
        [self.bgImageView addSubview:self.volumeLabel];
    }
    return self;
}
-(UIImageView*)bgImageView
{
    if (_bgImageView ==nil) {
        
        _bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(ScaleW(15), ScaleW(15), ScreenWidth-ScaleW(30), ScaleW(80))];
        _bgImageView.image = [UIImage imageNamed:@"kLine_bg"];
    }
    
    return _bgImageView;
    
}




-(UILabel *)currentPricelabel
{
    if (nil == _currentPricelabel) {
        _currentPricelabel = [WLTools allocLabel:@"0000.0000" font:systemBoldFont(ScaleW(22)) textColor:kRedColor frame:CGRectMake(ScaleW(15), ScaleW(20), ScaleW(230), ScaleW(15)) textAlignment:NSTextAlignmentLeft];
//        _currentPricelabel.adjustsFontSizeToFitWidth = YES;

    }
    return _currentPricelabel;
}

-(UILabel *)rateLabel
{
    if (nil == _rateLabel) {
        _rateLabel = [WLTools allocLabel:@"+0.00%" font:systemFont(ScaleW(12)) textColor:kRedColor frame:CGRectMake(self.CNYLabel.right+ ScaleW(10), self.currentPricelabel.bottom + ScaleW(15), ScaleW(80), ScaleW(15)) textAlignment:NSTextAlignmentLeft];
//        _rateLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _rateLabel;
}
-(UIImageView*)statusView
{
    if (_statusView ==nil) {
        
        _statusView = [[UIImageView alloc] initWithFrame:CGRectMake(_rateLabel.left + ScaleW(40)+ ScaleW(13), self.currentPricelabel.bottom + ScaleW(15), ScaleW(6), ScaleW(13))];
        _statusView.image = [UIImage imageNamed:@"xiadie_status"];
    }
    
    return _statusView;
    
}
- (UILabel *)CNYLabel
{
    if (nil == _CNYLabel) {
        _CNYLabel = [WLTools allocLabel:@"≈00000.00CNY" font:systemFont(ScaleW(12)) textColor:[UIColor colorWithHexStringToColor:@"e3e3e3"] frame:CGRectMake(self.currentPricelabel.x, self.currentPricelabel.bottom + ScaleW(15), ScaleW(95), ScaleW(15)) textAlignment:NSTextAlignmentLeft];
    }
    return _CNYLabel;
}

- (UILabel *)highLabel
{
    if (nil == _highLabel) {
        _highLabel = [WLTools allocLabel:@"0000.0000" font:systemFont(ScaleW(11)) textColor:kMainTextColor frame:CGRectMake(self.bgImageView.width - ScaleW(15) - ScaleW(90), ScaleW(10), ScaleW(90), ScaleW(15)) textAlignment:NSTextAlignmentRight];
//        _highLabel.centerY = self.currentPricelabel.centerY;
    }
    return _highLabel;
}

-(UILabel *)highTitleLabel
{
    if (nil == _highTitleLabel) {
        _highTitleLabel = [WLTools allocLabel:SSKJLocalized(@"高",nil)  font:systemFont(ScaleW(11)) textColor:kMainTextColor frame:CGRectMake(self.highLabel.x - ScaleW(10), 0, ScaleW(15), ScaleW(15)) textAlignment:NSTextAlignmentLeft];
        _highTitleLabel.centerY = self.highLabel.centerY;
    }
    return _highTitleLabel;
}

- (UILabel *)lowLabel
{
    if (nil == _lowLabel) {
        _lowLabel = [WLTools allocLabel:@"0000.0000" font:systemFont(ScaleW(11)) textColor:kMainTextColor frame:CGRectMake(self.bgImageView.width - ScaleW(15) - ScaleW(90), self.highLabel.bottom + ScaleW(8), ScaleW(90), ScaleW(15)) textAlignment:NSTextAlignmentRight];
//        _lowLabel.centerY = self.rateLabel.centerY - ScaleW(10);
    }
    return _lowLabel;
}

-(UILabel *)lowTitleLabel
{
    if (nil == _lowTitleLabel) {
        _lowTitleLabel = [WLTools allocLabel:SSKJLocalized(@"低",nil) font:systemFont(ScaleW(11)) textColor:kMainTextColor frame:CGRectMake(self.highLabel.x - ScaleW(10), self.lowLabel.y, ScaleW(15), ScaleW(15)) textAlignment:NSTextAlignmentLeft];
        _lowTitleLabel.centerY = self.lowLabel.centerY;
    }
    return _lowTitleLabel;
}


- (UILabel *)volumeLabel
{
    if (nil == _volumeLabel) {
        _volumeLabel = [WLTools allocLabel:@"0000.0000" font:systemFont(ScaleW(11)) textColor:kMainTextColor frame:CGRectMake(self.bgImageView.width - ScaleW(15) - ScaleW(90), self.lowLabel.bottom + ScaleW(8), ScaleW(90), ScaleW(15)) textAlignment:NSTextAlignmentRight];
//        _volumeLabel.centerY = self.rateLabel.centerY + ScaleW(10);
    }
    return _volumeLabel;
}

-(UILabel *)volumeTitleLabel
{
    if (nil == _volumeTitleLabel) {
        _volumeTitleLabel = [WLTools allocLabel:SSKJLocalized(@"量",nil) font:systemFont(ScaleW(11)) textColor:kMainTextColor frame:CGRectMake(self.highLabel.x - ScaleW(10), self.volumeLabel.y, ScaleW(15), ScaleW(15)) textAlignment:NSTextAlignmentLeft];
        _volumeTitleLabel.centerY = self.volumeLabel.centerY;
    }
    return _volumeTitleLabel;
}


-(void)setCoinModel:(SSKJ_Market_Index_Model *)coinModel
{
    if (coinModel == nil) {
        return;
    }
    
    
//    NSArray *nameArray = [coinModel.code componentsSeparatedByString:@"/"];
    
    self.currentPricelabel.text = [WLTools roundingStringWith:coinModel.price.doubleValue afterPointNumber:[WLTools dotNumberOfCoinCode:coinModel.code]];
    
    if (![coinModel.changeRate hasPrefix:@"-"]) {
        
        self.rateLabel.text = [NSString stringWithFormat:@"+%@",coinModel.changeRate];
        
    }else{
        self.rateLabel.text = [NSString stringWithFormat:@"%@",coinModel.changeRate];
    }
    
    UIColor *color;
    if (coinModel.change.doubleValue < 0) {
        color = RED_HEX_COLOR;
        self.statusView.image = [UIImage imageNamed:@"xiadie_status"];
    }else{
        color = GREEN_HEX_COLOR;
        self.statusView.image = [UIImage imageNamed:@"shangzhang_status"];

    }
    
    self.rateLabel.textColor = color;
    
//    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:self.rateLabel.text];
//    [attributeString addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(SSKJLocalized(@"涨跌幅", nil).length + 1, attributeString.length - SSKJLocalized(@"涨跌幅", nil).length - 1)];
//    [attributeString addAttribute:NSFontAttributeName value:systemFont(ScaleW(14)) range:NSMakeRange(0, SSKJLocalized(@"涨跌幅", nil).length)];
//    self.rateLabel.attributedText = attributeString;
    self.currentPricelabel.textColor = color;
    
    self.CNYLabel.text = [NSString stringWithFormat:@"≈%@CNY",[WLTools noroundingStringWith:coinModel.cnyPrice.doubleValue afterPointNumber:2]];
    self.highLabel.text = [WLTools roundingStringWith:coinModel.high.doubleValue afterPointNumber:[WLTools dotNumberOfCoinCode:coinModel.code]];
    
    self.lowLabel.text = [WLTools roundingStringWith:coinModel.low.doubleValue afterPointNumber:[WLTools dotNumberOfCoinCode:coinModel.code]];
    if (coinModel.volume.doubleValue>10000) {
        self.volumeLabel.text = [NSString stringWithFormat:@"%@%@",[WLTools roundingStringWith:coinModel.volume.doubleValue/10000.0 afterPointNumber:2],SSKJLocalized(@"万", nil)];

    }
    else
    {
        
        self.volumeLabel.text = [WLTools roundingStringWith:coinModel.volume.doubleValue afterPointNumber:2];

    }

    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
