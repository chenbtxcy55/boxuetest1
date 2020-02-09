//
//  JB_Account_Asset_HeaderView.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/5/16.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "JB_Account_Asset_HeaderView.h"

@interface JB_Account_Asset_HeaderView ()
@property (nonatomic, strong) UIImageView *backImageView;
@property (nonatomic, strong) UILabel *assetNameLabel;
@property (nonatomic, strong) UILabel *balanceLabel;    // 余额
@property (nonatomic, strong) UILabel *unitLabel;   // AB单位
@property (nonatomic, strong) UILabel *cnyLabel;    // 人民币
@property (nonatomic, strong) UIButton *exchangeButton;  // 划转按钮
@property (nonatomic, strong) UIButton *chargeButton;  // 充币按钮
@property (nonatomic, strong) UIButton *extractButton;  // 提币按钮
@property (nonatomic, assign) AssetType assetType;
@end

@implementation JB_Account_Asset_HeaderView

- (instancetype)initWithFrame:(CGRect)frame assetType:(AssetType)assetType
{
    self = [super initWithFrame:frame];
    if (self) {
        self.assetType = assetType;
        [self addSubview:self.backImageView];
        [self.backImageView addSubview:self.assetNameLabel];
        [self.backImageView addSubview:self.balanceLabel];
        [self.backImageView addSubview:self.unitLabel];
        [self.backImageView addSubview:self.cnyLabel];
        [self.backImageView addSubview:self.exchangeButton];
        [self.backImageView addSubview:self.chargeButton];
        [self.backImageView addSubview:self.extractButton];

        if (assetType == AssetTypeDeal) {
            self.backImageView.image = [UIImage imageNamed:@"deal_asset_img"];
            self.assetNameLabel.text = SSKJLocalized(@"交易账户", nil);
            self.exchangeButton.hidden = YES;
            self.chargeButton.hidden = NO;
            self.extractButton.hidden = NO;
        }else{
            self.backImageView.image = [UIImage imageNamed:@"licai_asset_img"];
            self.assetNameLabel.text = SSKJLocalized(@"理财账户", nil);
            self.exchangeButton.hidden = NO;
            self.chargeButton.hidden = YES;
            self.extractButton.hidden = YES;
        }
        
    }
    return self;
}


-(UIImageView *)backImageView
{
    if (nil == _backImageView) {
        _backImageView = [[UIImageView alloc]initWithFrame:CGRectMake(ScaleW(15), ScaleW(10), ScreenWidth - ScaleW(30), ScaleW(130))];
        _backImageView.layer.masksToBounds = YES;
        _backImageView.layer.cornerRadius = ScaleW(8);
        _backImageView.userInteractionEnabled = YES;
    }
    return _backImageView;
}

-(UILabel *)assetNameLabel
{
    
    if (nil == _assetNameLabel) {
        _assetNameLabel = [WLTools allocLabel:SSKJLocalized(@"交易账户", nil) font:systemFont(ScaleW(13.5)) textColor:kMainWihteColor frame:CGRectMake(ScaleW(15), ScaleW(27), ScaleW(200), ScaleW(14)) textAlignment:NSTextAlignmentLeft];
    }
    return _assetNameLabel;
}

-(UILabel *)balanceLabel
{
    if (nil == _balanceLabel) {
        _balanceLabel = [WLTools allocLabel:@"----" font:systemBoldFont(ScaleW(23)) textColor:kMainWihteColor frame:CGRectMake(self.assetNameLabel.x, self.assetNameLabel.bottom + ScaleW(15), ScaleW(100), ScaleW(23)) textAlignment:NSTextAlignmentLeft];
    }
    return _balanceLabel;
}

-(UILabel *)unitLabel
{
    if (nil == _unitLabel) {
        _unitLabel = [WLTools allocLabel:@"AB" font:systemFont(ScaleW(12)) textColor:kMainWihteColor frame:CGRectMake(self.balanceLabel.right + ScaleW(5), 0, ScaleW(100), ScaleW(12)) textAlignment:NSTextAlignmentLeft];
        _unitLabel.bottom = self.balanceLabel.bottom;
    }
    return _unitLabel;
}

-(UILabel *)cnyLabel
{
    if (nil == _cnyLabel) {
        _cnyLabel = [WLTools allocLabel:@"----" font:systemFont(ScaleW(11)) textColor:kMainWihteColor frame:CGRectMake(self.balanceLabel.x, self.balanceLabel.bottom + ScaleW(15), ScaleW(200), ScaleW(12)) textAlignment:NSTextAlignmentLeft];
        
    }
    return _cnyLabel;
}

-(UIButton *)exchangeButton
{
    if (nil == _exchangeButton) {
        _exchangeButton = [[UIButton alloc]initWithFrame:CGRectMake(self.backImageView.width - ScaleW(30) - ScaleW(50), 0, ScaleW(50), ScaleW(22))];
        _exchangeButton.centerY = self.cnyLabel.y;
        [_exchangeButton setTitle:SSKJLocalized(@"划转", nil) forState:UIControlStateNormal];
        [_exchangeButton setTitleColor:kMainWihteColor forState:UIControlStateNormal];
        _exchangeButton.titleLabel.font = systemFont(ScaleW(12));
        _exchangeButton.layer.masksToBounds = YES;
        _exchangeButton.layer.cornerRadius = _exchangeButton.height / 2;
        _exchangeButton.layer.borderColor = kMainWihteColor.CGColor;
        _exchangeButton.layer.borderWidth = 0.5;
        [_exchangeButton addTarget:self action:@selector(exchangeEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _exchangeButton;
}


-(UIButton *)chargeButton
{
    if (nil == _chargeButton) {
        _chargeButton = [[UIButton alloc]initWithFrame:self.exchangeButton.frame];
        [_chargeButton setTitle:SSKJLocalized(@"充币", nil) forState:UIControlStateNormal];
        [_chargeButton setTitleColor:kMainWihteColor forState:UIControlStateNormal];
        _chargeButton.titleLabel.font = systemFont(ScaleW(12));
        _chargeButton.layer.masksToBounds = YES;
        _chargeButton.layer.cornerRadius = _chargeButton.height / 2;
        _chargeButton.layer.borderColor = kMainWihteColor.CGColor;
        _chargeButton.layer.borderWidth = 0.5;
        [_chargeButton addTarget:self action:@selector(chargeEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _chargeButton;
}

-(UIButton *)extractButton
{
    if (nil == _extractButton) {
        _extractButton = [[UIButton alloc]initWithFrame:CGRectMake(self.chargeButton.x - ScaleW(10) - ScaleW(50), 0, ScaleW(50), ScaleW(22))];
        _extractButton.titleLabel.font = systemFont(ScaleW(12));
        _extractButton.centerY = self.cnyLabel.y;
        [_extractButton setTitle:SSKJLocalized(@"提币", nil) forState:UIControlStateNormal];
        [_extractButton setTitleColor:kMainWihteColor forState:UIControlStateNormal];
        _extractButton.layer.masksToBounds = YES;
        _extractButton.layer.cornerRadius = _exchangeButton.height / 2;
        _extractButton.layer.borderColor = kMainWihteColor.CGColor;
        _extractButton.layer.borderWidth = 0.5;
        [_extractButton addTarget:self action:@selector(exchangeEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _extractButton;
}

-(void)setViewWithModel:(JB_Account_Asset_CoinModel *)assetModel
{
    if (self.assetType == AssetTypeDeal) {//交易
        self.balanceLabel.text = [WLTools noroundingStringWith:assetModel.total.ttl_money.doubleValue afterPointNumber:4];
        
        self.balanceLabel.width = [WLTools getWidthWithText:self.balanceLabel.text font:self.balanceLabel.font];
        self.unitLabel.x = self.balanceLabel.right + ScaleW(5);
        self.cnyLabel.text = [NSString stringWithFormat:@"≈ %@ CNY",[WLTools noroundingStringWith:assetModel.total.ttl_cnymoney.doubleValue afterPointNumber:2]];
    }else{
        self.balanceLabel.text = [WLTools noroundingStringWith:assetModel.ttl_money.doubleValue afterPointNumber:4];
        
        self.balanceLabel.width = [WLTools getWidthWithText:self.balanceLabel.text font:self.balanceLabel.font];
        self.unitLabel.x = self.balanceLabel.right + ScaleW(5);
        self.cnyLabel.text = [NSString stringWithFormat:@"≈ %@ CNY",[WLTools noroundingStringWith:assetModel.ttl_cnymoney.doubleValue afterPointNumber:2]];
    }

}

#pragma mark - 用户操作
// 划转
-(void)exchangeEvent
{
    if (self.exchangeBlock) {
        self.exchangeBlock();
    }
}

// 充币
-(void)chargeEvent
{
    if (self.chargeBlock) {
        self.chargeBlock();
    }
}


// 提币
-(void)extractEvent
{
    if (self.exchangeBlock) {
        self.exchangeBlock();
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
