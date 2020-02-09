
#import "TradePosionTableViewCell.h"
@interface TradePosionTableViewCell()

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

@property (nonatomic, strong) UILabel *mostNewPriceLabel;

@property (nonatomic, strong) UILabel *dateLabel;

@property (nonatomic, assign) CGFloat widthGoods;

@property (nonatomic, strong) UILabel *nePriceLabel;


@end

@implementation TradePosionTableViewCell

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
        [self.contentView addSubview:self.nePriceLabel];
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
        
        [self.contentView addSubview:self.line2View];
        
        [self.contentView addSubview:self.mostNewPriceLabel];
        [self.contentView addSubview:self.dateLabel];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(longSockedNewPrice:) name:@"postionSockedLongPost" object:nil];
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

-(UILabel *)nePriceLabel
{
    if (!_nePriceLabel) {
        _nePriceLabel = [WLTools allocLabel:@"0.00" font:systemFont(ScaleW(14)) textColor:GREEN_HEX_COLOR frame:CGRectMake(Screen_Width/2, _derectionCodeNameLabel.top, Screen_Width/2 - ScaleW(15), ScaleW(15)) textAlignment:(NSTextAlignmentRight)];
        _nePriceLabel.hidden = YES;
    }
    return _nePriceLabel;
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
        _moneyCodeName = [WLTools allocLabel:SSKJLocalized(@"资产币种",nil) font:systemFont(ScaleW(14)) textColor:kSubTitleColor frame:CGRectMake(ScaleW(15), ScaleW(14) + _lineView.bottom, self.widthGoods, ScaleW(14)) textAlignment:(NSTextAlignmentLeft)];
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
        _getTradeMoneyName = [WLTools allocLabel:SSKJLocalized(@"止盈价", nil) font:systemFont(ScaleW(14)) textColor:kSubTitleColor frame:CGRectMake(_pointLabel.right,_pointLabelName.top, self.widthGoods, ScaleW(14)) textAlignment:(NSTextAlignmentCenter)];
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
        _haveWinMoneyName = [WLTools allocLabel:SSKJLocalized(@"止损价", nil) font:systemFont(ScaleW(14)) textColor:kSubTitleColor frame:CGRectMake(_getTradeMoney.right, _getTradeMoneyName.top, self.widthGoods, ScaleW(14)) textAlignment:(NSTextAlignmentRight)];
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


-(UILabel *)mostNewPriceLabel

{
    if (!_mostNewPriceLabel) {
        _mostNewPriceLabel = [WLTools allocLabel:@"最新价：----" font:systemFont(ScaleW(14)) textColor:kMainWihteColor frame:CGRectMake(ScaleW(15), _line2View.bottom + ScaleW(8), ScaleW(130), ScaleW(31)) textAlignment:(NSTextAlignmentCenter)];
        _mostNewPriceLabel.backgroundColor = kTextColorff5755;
        
        
//        [_mostNewPriceLabel setCornerRadius:ScaleW(10)];
    }
    return _mostNewPriceLabel;
}

-(UILabel *)dateLabel
{
    if (!_dateLabel) {
        _dateLabel = [WLTools allocLabel:@"------- --:--:--" font:systemFont(ScaleW(14)) textColor:kSubTitleColor frame:CGRectMake(ScreenWidth/2 - ScaleW(15), _mostNewPriceLabel.top, ScreenWidth/2.f, ScaleW(14)) textAlignment:(NSTextAlignmentRight)];
        _dateLabel.centerY = _mostNewPriceLabel.centerY;
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
    //    name = [NSString stringWithFormat:@"%@ /%@",array.firstObject,array.lastObject];
    //    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:name];
    //    [attributeString addAttribute:NSFontAttributeName value:systemFont(ScaleW(11)) range:NSMakeRange(name.length - [array.lastObject length], [array.lastObject length])];
    
    NSMutableAttributedString *muteString = [[NSMutableAttributedString alloc]initWithString:self.derectionCodeNameLabel.text];
    
    [muteString addAttribute:NSForegroundColorAttributeName value:buyColor range:[self.derectionCodeNameLabel.text rangeOfString:derection]];
    self.derectionCodeNameLabel.attributedText = muteString;
    
    self.moneyCode.text = [NSString stringWithFormat:@"%@",_model.ptype];
    
    self.getMoneyPrice.text = [WLTools noroundingStringWith:_model.buyprice.doubleValue afterPointNumber:[self pointCount:_model.mark]];;
    
      self.tradeAmount.text = [WLTools noroundingStringWith:_model.total_num.doubleValue afterPointNumber:[self pointCount:_model.mark]];
    
    self.pointLabel.text = _model.aim_point;
    
    self.getTradeMoney.text = [WLTools noroundingStringWith:_model.stopwin.doubleValue afterPointNumber:[self pointCount:_model.mark]];
    
    self.haveWinMoney.text = [WLTools noroundingStringWith:_model.stoploss.doubleValue afterPointNumber:[self pointCount:_model.mark]];
    
    self.dateLabel.text = [WLTools convertTimestamp:_model.addtime.doubleValue andFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    self.mostNewPriceLabel.text = [NSString stringWithFormat:SSKJLocalized(@"最新价:%@", nil),[WLTools noroundingStringWith:_model.actprice.doubleValue afterPointNumber:[self pointCount:_model.mark]]];
    
}

-(void)setTimeModel:(CJHYPosionModel *)timeModel
{
    _timeModel = timeModel;
    
    NSString *derection = nil;
    UIColor *buyColor = nil;
    
    NSLog(@"_timeModel.type:type::%@",_timeModel.type);
    
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
    
    self.moneyCode.text = [NSString stringWithFormat:@"%@",@"YEC"];
    
    self.getMoneyPrice.text = [WLTools noroundingStringWith:_timeModel.buyprice.doubleValue afterPointNumber:[self pointCount:_timeModel.mark]];;
    
    self.tradeAmount.text = [NSString stringWithFormat:@"%@",_timeModel.buynum];
    
    //self.pointLabel.text = _model.aim_point;
    
   // self.getTradeMoney.text = [WLTools noroundingStringWith:_model.stopwin.doubleValue afterPointNumber:[self pointCount:_model.mark]];
    
    //self.haveWinMoney.text = [WLTools noroundingStringWith:_model.stoploss.doubleValue afterPointNumber:[self pointCount:_model.mark]];
    
    self.dateLabel.text = [WLTools convertTimestamp:_timeModel.addtime.doubleValue andFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    _nePriceLabel.hidden = NO;
    
    _nePriceLabel.text = [WLTools noroundingStringWith:_timeModel.free_rate.doubleValue afterPointNumber:[WLTools dotNumberOfCoinCode:_timeModel.pname]];
    
    _nePriceLabel.textColor = buyColor;
    
    _mostNewPriceLabel.textAlignment = NSTextAlignmentLeft;
    
    _mostNewPriceLabel.backgroundColor = [UIColor clearColor];
    
    _mostNewPriceLabel.textColor = kSubTitleColor;
   
    _mostNewPriceLabel.text = [NSString stringWithFormat:@"%@%.2f%%", SSKJLocalized(@"预期收益率:", nil),_timeModel.profit_ratio.doubleValue*100];
    
    _mostNewPriceLabel.numberOfLines = 1;
    
    [_mostNewPriceLabel sizeToFit];
    
     _mostNewPriceLabel.centerY = _dateLabel.centerY;
    
    _pointLabelName.text = SSKJLocalized(@"交易周期", nil);
    
    _pointLabel.text = [NSString stringWithFormat:@"%@min",_timeModel.time];
    
    
    _getTradeMoney.textColor = RED_HEX_COLOR;
    
    
   NSInteger seconds =  _timeModel.times.integerValue;
    
    _getTradeMoneyName.text = SSKJLocalized(@"倒计时", nil);
    
    _getTradeMoney.text = [NSString stringWithFormat:@"%ldS",seconds];
    
    _haveWinMoneyName.text = SSKJLocalized(@"预期回报", nil);
    //_timeModel.total_num.doubleValue * _timeModel.odds.doubleValue
    _haveWinMoney.text = [WLTools noroundingStringWith:_timeModel.buynum.doubleValue *(1+_timeModel.profit_ratio.doubleValue)  afterPointNumber:[self pointCount:_model.mark]];
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

-(void)longSockedNewPrice:(NSNotification *)notifa
{
    id objc = notifa.object;
    
    JB_Market_Index_Model *model = objc;
    
    if ([model.code isEqualToString:_timeModel.mark]) {
        self.nePriceLabel.text = [NSString stringWithFormat:SSKJLocalized(@"%@", nil),[WLTools noroundingStringWith:model.price.doubleValue afterPointNumber:[self pointCount:model.code]]];
        NSLog(@"%@",model.price);
    }
    
    if ([model.code isEqualToString:_model.mark]) {
        self.mostNewPriceLabel.text = [NSString stringWithFormat:SSKJLocalized(@"最新价:%@", nil),[WLTools noroundingStringWith:model.price.doubleValue afterPointNumber:[self pointCount:model.code]]];
    }
    
    
}

@end
