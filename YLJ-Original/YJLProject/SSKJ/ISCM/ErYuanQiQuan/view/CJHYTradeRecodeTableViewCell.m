//
//  CJHYTradeRecodeTableViewCell.m
//  SSKJ
//
//  Created by 张本超 on 2019/6/25.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "CJHYTradeRecodeTableViewCell.h"
@interface CJHYTradeRecodeTableViewCell()

@property (nonatomic, strong) UILabel *derectionCodeNameLabel;

@property (nonatomic, strong) UIButton *shareBtn;

@property (nonatomic, strong) UIView *lineView;
//资产币种
@property (nonatomic, strong) UILabel *moneyCodeName;

@property (nonatomic, strong) UILabel *moneyCode;

@property (nonatomic, strong) UILabel *getMoneyPriceName;

@property (nonatomic, strong) UILabel *getMoneyPrice;

@property (nonatomic, strong) UILabel *tradeAmountName;

@property (nonatomic, strong) UILabel *tradeAmount;

@property (nonatomic, strong) UILabel *pointLabelName;

@property (nonatomic, strong) UILabel *pointLabel;

@property (nonatomic, strong) UILabel *getTradeMoneyName;

@property (nonatomic, strong) UILabel *getTradeMoney;

@property (nonatomic, strong) UILabel *haveWinMoneyName;

@property (nonatomic, strong) UILabel *haveWinMoney;

@property (nonatomic, strong) UIView *line2View;

@property (nonatomic, strong) UILabel *typeNameLabel;

@property (nonatomic, strong) UILabel *dateLabel;

@property (nonatomic, assign) CGFloat widthGoods;

@end

@implementation CJHYTradeRecodeTableViewCell

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
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    
    {
        self.widthGoods = (ScreenWidth - ScaleW(30))/3.f;
        
        self.contentView.backgroundColor = self.backgroundColor = [WLTools day:kMainWihteColor night:kBgColor];
        
        [self.contentView addSubview:self.derectionCodeNameLabel];
//        [self.contentView addSubview:self.shareBtn];
        [self.contentView addSubview:self.lineView];
        [self.contentView addSubview:self.moneyCodeName];
        [self.contentView addSubview:self.moneyCode];
        [self.contentView addSubview:self.getMoneyPriceName
         ];
        [self.contentView addSubview:self.getMoneyPrice];
        [self.contentView addSubview:self.tradeAmountName];
        [self.contentView addSubview:self.tradeAmount];
        [self.contentView addSubview:self.pointLabelName];
        [self.contentView addSubview:self.pointLabel];
        [self.contentView addSubview:self.getTradeMoneyName];
        [self.contentView addSubview:self.getTradeMoney];
        
        [self.contentView addSubview:self.haveWinMoneyName];
        [self.contentView addSubview:self.haveWinMoney];
        
//        [self.contentView addSubview:self.line2View];
//
//        [self.contentView addSubview:self.typeNameLabel];
        [self.contentView addSubview:self.dateLabel];
        
        
        
    }
    return self;
}

-(UILabel *)derectionCodeNameLabel
{
    if (!_derectionCodeNameLabel) {
        _derectionCodeNameLabel = [WLTools allocLabel:@"买涨 XRP/USDT" font:systemFont(ScaleW(15)) textColor:kTitleColor frame:CGRectMake(ScaleW(15), ScaleW(20), ScreenWidth/2.f, ScaleW(15)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _derectionCodeNameLabel;
}

-(UIButton *)shareBtn
{
    if (!_shareBtn) {
        _shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_shareBtn btn:_shareBtn font:ScaleW(ScaleW(12)) textColor:kBtnBgColor text:SSKJLocalized(@"分享", nil) image:[UIImage imageNamed:@"fenxiang_icon"] sel:@selector(shareBtnAction:) taget:self];
        _shareBtn.frame = CGRectMake(ScreenWidth - ScaleW(80), ScaleW(8), ScaleW(80), ScaleW(36));
        [_shareBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -ScaleW(5), 0, 0)];
    }
    return _shareBtn;
}

-(UIView *)lineView
{
    if (!_lineView) {
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(15), ScaleW(44),ScreenWidth -ScaleW(30), 1)];
        _lineView.backgroundColor = kLineColor;
    }
    return _lineView;
}

-(UILabel *)moneyCodeName
{
    if (!_moneyCodeName) {
        _moneyCodeName = [WLTools allocLabel:SSKJLocalized(@"资产币种", nil) font:systemFont(ScaleW(14)) textColor:kSubTitleColor frame:CGRectMake(ScaleW(15), ScaleW(14) + _lineView.bottom, self.widthGoods, ScaleW(14)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _moneyCodeName;
}

-(UILabel *)moneyCode
{
    
    if (!_moneyCode) {
        _moneyCode = [WLTools allocLabel:@"---" font:systemFont(ScaleW(14)) textColor:kTitleColor frame:CGRectMake(ScaleW(15), ScaleW(13) + _moneyCodeName.bottom, self.widthGoods, ScaleW(14)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _moneyCode;
}
-(UILabel *)getMoneyPriceName
{
    if (!_getMoneyPriceName) {
        _getMoneyPriceName = [WLTools allocLabel:SSKJLocalized(@"下单价", nil) font:systemFont(ScaleW(14)) textColor:kSubTitleColor frame:CGRectMake(_moneyCode.right, ScaleW(14) + _lineView.bottom, self.widthGoods, ScaleW(14)) textAlignment:(NSTextAlignmentCenter)];
    }
    return _getMoneyPriceName;
}

-(UILabel *)getMoneyPrice
{
    
    if (!_getMoneyPrice) {
        _getMoneyPrice = [WLTools allocLabel:@"---" font:systemFont(ScaleW(14)) textColor:kTitleColor frame:CGRectMake(_moneyCode.right, ScaleW(13) + _getMoneyPriceName.bottom, self.widthGoods, ScaleW(14)) textAlignment:(NSTextAlignmentCenter)];
    }
    return _getMoneyPrice;
}
-(UILabel *)tradeAmountName
{
    if (!_tradeAmountName) {
        _tradeAmountName = [WLTools allocLabel:SSKJLocalized(@"交易金额", nil) font:systemFont(ScaleW(14)) textColor:kSubTitleColor frame:CGRectMake(_getMoneyPrice.right, ScaleW(14) + _lineView.bottom, self.widthGoods, ScaleW(14)) textAlignment:(NSTextAlignmentRight)];
    }
    return _tradeAmountName;
}

-(UILabel *)tradeAmount
{
    
    if (!_tradeAmount) {
        _tradeAmount = [WLTools allocLabel:@"---" font:systemFont(ScaleW(14)) textColor:kTitleColor frame:CGRectMake(_getMoneyPrice.right, ScaleW(13) + _tradeAmountName.bottom, self.widthGoods, ScaleW(14)) textAlignment:(NSTextAlignmentRight)];
    }
    return _tradeAmount;
}

-(UILabel *)pointLabelName
{
    if (!_pointLabelName) {
        _pointLabelName = [WLTools allocLabel:SSKJLocalized(@"点位", nil) font:systemFont(ScaleW(14)) textColor:kSubTitleColor frame:CGRectMake(ScaleW(15), ScaleW(20) + _tradeAmount.bottom, self.widthGoods, ScaleW(14)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _pointLabelName;
}

-(UILabel *)pointLabel
{
    
    if (!_pointLabel) {
        _pointLabel = [WLTools allocLabel:@"---" font:systemFont(ScaleW(14)) textColor:kTitleColor frame:CGRectMake(_pointLabelName.left, ScaleW(13) + _pointLabelName.bottom, self.widthGoods, ScaleW(14)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _pointLabel;
}

-(UILabel *)getTradeMoneyName
{
    if (!_getTradeMoneyName) {
        _getTradeMoneyName = [WLTools allocLabel:SSKJLocalized(@"平仓价", nil) font:systemFont(ScaleW(14)) textColor:kSubTitleColor frame:CGRectMake(_pointLabel.right,_pointLabelName.top, self.widthGoods, ScaleW(14)) textAlignment:(NSTextAlignmentCenter)];
    }
    return _getTradeMoneyName;
}

-(UILabel *)getTradeMoney
{
    
    if (!_getTradeMoney) {
        _getTradeMoney = [WLTools allocLabel:@"---" font:systemFont(ScaleW(14)) textColor:kTitleColor frame:CGRectMake(_pointLabel.right, ScaleW(13) + _getTradeMoneyName.bottom, self.widthGoods, ScaleW(14)) textAlignment:(NSTextAlignmentCenter)];
    }
    return _getTradeMoney;
}
-(UILabel *)haveWinMoneyName
{
    if (!_haveWinMoneyName) {
        _haveWinMoneyName = [WLTools allocLabel:SSKJLocalized(@"获利", nil) font:systemFont(ScaleW(14)) textColor:kSubTitleColor frame:CGRectMake(_getTradeMoney.right, _getTradeMoneyName.top, self.widthGoods, ScaleW(14)) textAlignment:(NSTextAlignmentRight)];
    }
    return _haveWinMoneyName;
}

-(UILabel *)haveWinMoney
{
    
    if (!_haveWinMoney) {
        _haveWinMoney = [WLTools allocLabel:@"---" font:systemFont(ScaleW(14)) textColor:kTitleColor frame:CGRectMake(_getMoneyPrice.right, ScaleW(13) + _haveWinMoneyName.bottom, self.widthGoods, ScaleW(14)) textAlignment:(NSTextAlignmentRight)];
    }
    return _haveWinMoney;
}

-(UIView *)line2View
{
    if (!_line2View) {
        _line2View = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(15), ScaleW(17) + _haveWinMoney.bottom, ScreenWidth - ScaleW(30), 1)];
        _line2View.backgroundColor = kLineColor;
    }
    return _line2View;
}


-(UILabel *)typeNameLabel

{
    if (!_typeNameLabel) {
        _typeNameLabel = [WLTools allocLabel:SSKJLocalized(@"止盈平仓", nil) font:systemFont(ScaleW(14)) textColor:kTextColorff5755 frame:CGRectMake(ScaleW(15), _line2View.bottom + ScaleW(15), ScaleW(100), ScaleW(14)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _typeNameLabel;
}

-(UILabel *)dateLabel
{
    if (!_dateLabel) {
        _dateLabel = [WLTools allocLabel:@"------- --:--:--" font:systemFont(ScaleW(14)) textColor:kSubTitleColor frame:CGRectMake(ScreenWidth/2-ScaleW(15), _derectionCodeNameLabel.top, ScreenWidth/2.f, ScaleW(14)) textAlignment:(NSTextAlignmentRight)];
    }
    return _dateLabel;
}

-(void)shareBtnAction:(UIButton *)sender
{
    !self.shareBlock?:self.shareBlock();
}
-(void)setModel:(CJHYPosionModel *)model
{
    _model = model;
    NSLog(@"timeModel::buynum::::%@",model.buynum);

    NSString *derection = nil;
    UIColor *buyColor = nil;
    
    if (_model.type.integerValue == 1) {
        derection = SSKJLocalized(@"买涨", nil);
        buyColor = GREEN_HEX_COLOR;
    }
    if (_model.type.integerValue == 2) {
        derection = SSKJLocalized(@"买跌", nil);
         buyColor = RED_HEX_COLOR;
    }
    self.derectionCodeNameLabel.text = [NSString stringWithFormat:@"%@  %@",derection,_model.mark];

    
    NSMutableAttributedString *muteString = [[NSMutableAttributedString alloc]initWithString:self.derectionCodeNameLabel.text];
    
    [muteString addAttribute:NSForegroundColorAttributeName value:buyColor range:[self.derectionCodeNameLabel.text rangeOfString:derection]];
    self.derectionCodeNameLabel.attributedText = muteString;
    
    self.moneyCode.text = [NSString stringWithFormat:@"%@",_model.ptype];
    
    self.getMoneyPrice.text = [WLTools noroundingStringWith:_model.buyprice.doubleValue afterPointNumber:[self pointCount:_model.mark]];

   self.tradeAmount.text = [NSString stringWithFormat:@"%@",model.buynum];
    
    self.pointLabel.text = _model.aim_point;
    //平仓价
    self.getTradeMoney.text = [WLTools noroundingStringWith:_model.sellprice.doubleValue afterPointNumber:[self pointCount:_model.mark]];
    
    NSString *income = [WLTools noroundingStringWith:_timeModel.income.doubleValue afterPointNumber:[self point:_timeModel.ptype]];
    
    if (income.doubleValue > 0) {
        self.haveWinMoney.textColor = RED_HEX_COLOR;
        self.haveWinMoney.text = [NSString stringWithFormat:@"+%@",income];
    }
    if (income.doubleValue < 0) {
        self.haveWinMoney.textColor = GREEN_HEX_COLOR;
        self.haveWinMoney.text = [NSString stringWithFormat:@"%@",income];
    }
    
    
    self.dateLabel.text = [WLTools convertTimestamp:_model.selltime.doubleValue andFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    self.typeNameLabel.text = [NSString stringWithFormat:SSKJLocalized(@"最新价:%@", nil),[WLTools noroundingStringWith:_model.stoploss.doubleValue afterPointNumber:[self pointCount:_model.mark ]]];
    
    NSString *string = nil;
    UIColor *color = nil;
    if (_model.pc_type.integerValue == 1) {
        string = SSKJLocalized(@"止盈平仓", nil);
        color = RED_HEX_COLOR;
         self.shareBtn.hidden = NO;
    }
    if (_model.pc_type.integerValue == 2) {
        string = SSKJLocalized(@"止损平仓", nil);
        color = GREEN_HEX_COLOR;
        self.shareBtn.hidden = YES;
    }
    
    self.typeNameLabel.text = string;
    
    self.typeNameLabel.numberOfLines = 1;
    
    [self.typeNameLabel sizeToFit];
    
    self.typeNameLabel.textColor = color;
    
    
    
    
}

-(NSInteger)point:(NSString *)code
{
    
    if ([code.lowercaseString isEqualToString:@"btc"]) {
        return 6;
    }
    
    if ([code.lowercaseString isEqualToString:@"eth"]) {
        return 5;
    }
    if ([code.lowercaseString isEqualToString:@"eos"]) {
        return 2;
    }
    if ([code.lowercaseString isEqualToString:@"usdt"]) {
        return 2;
    }
    return 4;
    
}

-(NSInteger)pointCount:(NSString *)code
{
    /*币种
     btc/usdt  2位
     ltc/usdt 2位
     eth/usdt 2位
     etc/usdt 4位
     zec/usdt 2位
     eos/usdt 4位
     xrp/usdt 4位
     trx/usdt 6位
     dash/usdt  2位
     bch/usdt 2位*/
    if ([code.lowercaseString isEqualToString:@"btc/usdt"]) {
        return 2;
    }
    if ([code.lowercaseString isEqualToString:@"ltc/usdt"]) {
        return 2;
    }
    if ([code.lowercaseString isEqualToString:@"eth/usdt"]) {
        return 2;
    }
    if ([code.lowercaseString isEqualToString:@"etc/usdt"]) {
        return 4;
    }
    if ([code.lowercaseString isEqualToString:@"zec/usdt"]) {
        return 2;
    }
    if ([code.lowercaseString isEqualToString:@"eos/usdt"]) {
        return 4;
    }
    if ([code.lowercaseString isEqualToString:@"xrp/usdt"]) {
        return 4;
    }
    if ([code.lowercaseString isEqualToString:@"trx/usdt"]) {
        return 6;
    }
    if ([code.lowercaseString isEqualToString:@"dash/usdt"]) {
        return 2;
    }
    if ([code.lowercaseString isEqualToString:@"bch/usdt"]) {
        return 2;
    }
    return 4;
    
}
-(void)setTimeModel:(CJHYPosionModel *)timeModel
{
    _timeModel = timeModel;
    
    
    NSString *derection = nil;
    UIColor *buyColor = nil;
    
    if (_timeModel.order_type.integerValue == 1) {
        derection = SSKJLocalized(@"买涨", nil);
        buyColor = GREEN_HEX_COLOR;
    }
    if (_timeModel.order_type.integerValue == 2) {
        derection = SSKJLocalized(@"买跌", nil);
        buyColor = RED_HEX_COLOR;
    }
    self.derectionCodeNameLabel.text = [NSString stringWithFormat:@"%@  %@",derection,_timeModel.pname];
   
    
    NSMutableAttributedString *muteString = [[NSMutableAttributedString alloc]initWithString:self.derectionCodeNameLabel.text];
    
    [muteString addAttribute:NSForegroundColorAttributeName value:buyColor range:[self.derectionCodeNameLabel.text rangeOfString:derection]];
    self.derectionCodeNameLabel.attributedText = muteString;
    
    self.moneyCode.text = [NSString stringWithFormat:@"%@",@""];
    
    self.getMoneyPrice.text = [WLTools noroundingStringWith:_timeModel.buyprice.doubleValue afterPointNumber:[self pointCount:_timeModel.mark]];
    
    self.tradeAmount.text = [NSString stringWithFormat:@"%@",_timeModel.buynum];
    
    
    
    self.pointLabel.text = [NSString stringWithFormat:@"%@min",_timeModel.time];
    //平仓价
    self.getTradeMoney.text = [WLTools noroundingStringWith:_timeModel.sellprice.doubleValue afterPointNumber:[self pointCount:_timeModel.mark]];
    
    NSString *income = [WLTools noroundingStringWith:_timeModel.income.doubleValue afterPointNumber:[self point:_timeModel.ptype]];
    
    if (income.doubleValue > 0) {
       self.haveWinMoney.textColor = GREEN_HEX_COLOR;
        self.haveWinMoney.text = [NSString stringWithFormat:@"+%@",income];
    }
    if (income.doubleValue < 0) {
        self.haveWinMoney.textColor = RED_HEX_COLOR;
        self.haveWinMoney.text = [NSString stringWithFormat:@"%@",income];
    }
    
    self.dateLabel.text = [WLTools convertTimestamp:_timeModel.selltime.doubleValue andFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    self.typeNameLabel.text = [NSString stringWithFormat:SSKJLocalized(@"最新价:%@", nil),[WLTools noroundingStringWith:_timeModel.stoploss.doubleValue afterPointNumber:[self pointCount:_timeModel.mark]]];
  
    NSString *string = nil;
    UIColor *color = nil;
    if (_timeModel.pc_type.integerValue == 1) {
        string = SSKJLocalized(@"止盈平仓", nil);
        color = RED_HEX_COLOR;
        self.shareBtn.hidden = NO;
    }
    if (_timeModel.pc_type.integerValue == 2) {
        string = SSKJLocalized(@"止损平仓", nil);
        color = GREEN_HEX_COLOR;
        self.shareBtn.hidden = YES;
    }
    
    string = [NSString stringWithFormat:@"%@%@%%",SSKJLocalized(@"收益率：", nil),@(_timeModel.odds.doubleValue * 100)];
    
    self.typeNameLabel.text = string;
    
    self.typeNameLabel.numberOfLines = 1;
    
    [self.typeNameLabel sizeToFit];
    
   // self.typeNameLabel.textColor = color;
    
    self.typeNameLabel.textColor = kTitleColor;
    
    self.pointLabelName.text = SSKJLocalized(@"交易周期", nil);
    
    
}
@end
