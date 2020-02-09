//
//  FBRecodDetailHeaderView.m
//  SSKJ
//
//  Created by 张本超 on 2019/5/15.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "FBRecodDetailHeaderView.h"
@interface FBRecodDetailHeaderView()
@property (nonatomic, strong) UIView *topLine;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *orderNumNameLabel;
@property (nonatomic, strong) UILabel *orderNumLabel;
@property (nonatomic, strong) UILabel *statusLabel;
@property (nonatomic, strong) UILabel *priceName;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *amountName;
@property (nonatomic, strong) UILabel *amountLabel;
@property (nonatomic, strong) UILabel *totalName;
@property (nonatomic, strong) UILabel *totalLabel;

@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UILabel *payWaysLabel;
@property (nonatomic, strong) NSArray *paywaysArray;
@property (nonatomic, strong) UIView *line2View;


@property (nonatomic, strong) UIView *weChartPayView;
@property (nonatomic, strong) UIButton *weselectBtn;
@property (nonatomic, strong) UIImageView *weImg;
@property (nonatomic, strong) UILabel *weNum;
@property (nonatomic, strong) UIButton *twoCodeWeImg;

@property (nonatomic, strong) UIView *alpayChartView;
@property (nonatomic, strong) UIButton *alSelectBtn;
@property (nonatomic, strong) UIImageView *alImage;
@property (nonatomic, strong) UILabel *alPayNum;
@property (nonatomic, strong) UIButton *twoCodeAlImg;

@property (nonatomic, strong) UIView *bankView;
@property (nonatomic, strong) UIButton *bankSelectBtn;
@property (nonatomic, strong) UIImageView *bankImage;
@property (nonatomic, strong) UILabel *bakNumMessay;

@property (nonatomic, strong) UILabel *statusMessageLabel;

@property (nonatomic, strong) UILabel *warnningMessageLabel;

@property (nonatomic, strong) UIButton *commitBtn;
@property (nonatomic, strong) UIButton *commitSubBtn;

@end

@implementation FBRecodDetailHeaderView

-(instancetype)init
{
    if (self = [super init]) {
        [self viewConfig];
    }
    return self;
}
-(void)viewConfig
{
    self.frame = CGRectMake(0, 0, ScreenWidth, ScaleW(774));
    self.backgroundColor = kMianBgColor;
    [self addSubview:self.topLine];
    [self addSubview:self.titleLabel];
    [self addSubview:self.orderNumNameLabel];
    [self addSubview:self.orderNumLabel];
    [self addSubview:self.statusLabel];
    [self addSubview:self.priceName];
    [self addSubview:self.priceLabel];
    [self addSubview:self.amountName];
    [self addSubview:self.amountLabel];
    [self addSubview:self.totalName];
    [self addSubview:self.totalLabel];
    [self addSubview:self.lineView];
    [self addSubview:self.payWaysLabel];
    [self  addSubview:self.weChartPayView];
    [self addSubview:self.alpayChartView];
    [self addSubview:self.bankView];
}
-(UIView *)topLine
{
    if (!_topLine) {
        _topLine = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleW(10))];
        _topLine.backgroundColor = kMianDeepBgColor;
    }
    return _topLine;
}
-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(ScaleW(15), ScaleW(41) + _topLine.bottom, ScreenWidth - ScaleW(30), ScaleW(22))];
        [_titleLabel label:_titleLabel font:ScaleW(22) textColor:kMainTextColor text:@"您向李*兵  购买2.0000 AB"];
    }
    return _titleLabel;
}
-(UILabel *)orderNumNameLabel
{
    if (!_orderNumNameLabel) {
        _orderNumNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(ScaleW(15), ScaleW(33) + _titleLabel.bottom, ScaleW(80), ScaleW(14))];
        [_orderNumNameLabel label:_orderNumNameLabel font:ScaleW(14) textColor:kTextDarkBlueColor text:@"订单号 "];
        
    }
    return _orderNumNameLabel;
}
-(UILabel *)orderNumLabel
{
    if (!_orderNumLabel) {
        _orderNumLabel = [[UILabel alloc]initWithFrame:CGRectMake(_orderNumNameLabel.right, ScaleW(33) + _titleLabel.bottom, ScaleW(220), ScaleW(14))];
        [_orderNumLabel label:_orderNumLabel font:ScaleW(14) textColor:kMainTextColor text:@"----------- "];
    }
    return _orderNumLabel;
}
-(UILabel *)statusLabel
{
    if (!_statusLabel) {
        _statusLabel = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth - ScaleW(70) - ScaleW(15), _orderNumLabel.top, ScaleW(70), ScaleW(14))];
        [_statusLabel label:_statusLabel font:ScaleW(14) textColor:kTextDarkBlueColor text:@"待付款"];
        
    }
    return _statusLabel;
}
-(UILabel *)priceName
{
    if (!_priceName) {
        _priceName = [[UILabel alloc]initWithFrame:CGRectMake(ScaleW(15), ScaleW(20) + _orderNumNameLabel.bottom, ScaleW(80), ScaleW(14))];
        [_priceName label:_priceName font:ScaleW(14) textColor:kTextDarkBlueColor text:@"购买价 "];
        
    }
    return _priceName;
}
-(UILabel *)priceLabel
{
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(_priceName.right, _priceName.top, ScaleW(220), ScaleW(14))];
        [_priceLabel label:_priceLabel font:ScaleW(14) textColor:kMainTextColor text:@"----------- "];
    }
    return _priceLabel;
}
-(UILabel *)amountName
{
    if (!_amountName) {
        _amountName = [[UILabel alloc]initWithFrame:CGRectMake(ScaleW(15), ScaleW(20) + _priceLabel.bottom, ScaleW(80), ScaleW(14))];
        [_amountName label:_amountName font:ScaleW(14) textColor:kTextDarkBlueColor text:@"数   量 "];
        
    }
    return _amountName;
}
-(UILabel *)amountLabel
{
    if (!_amountLabel) {
        _amountLabel = [[UILabel alloc]initWithFrame:CGRectMake(_amountName.right, _amountName.top, ScaleW(220), ScaleW(14))];
        [_amountLabel label:_amountLabel font:ScaleW(14) textColor:kMainTextColor text:@"----------- "];
    }
    return _amountLabel;
}
-(UILabel *)totalName
{
    if (!_totalName) {
        _totalName = [[UILabel alloc]initWithFrame:CGRectMake(ScaleW(15), ScaleW(20) + _amountLabel.bottom, ScaleW(80), ScaleW(14))];
        [_totalName label:_totalName font:ScaleW(14) textColor:kTextDarkBlueColor text:@"总金额 "];
        
    }
    return _totalName;
}
-(UILabel *)totalLabel
{
    if (!_totalLabel) {
        _totalLabel = [[UILabel alloc]initWithFrame:CGRectMake(_totalName.right, _totalName.top, ScaleW(220), ScaleW(14))];
        [_totalLabel label:_totalLabel font:ScaleW(14) textColor:kMainTextColor text:@"----------- "];
    }
    return _totalLabel;
}
-(UIView *)lineView
{
    if (!_lineView) {
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(15), _totalName.bottom + ScaleW(25),ScreenWidth - ScaleW(30), 1)];
        _lineView.backgroundColor = kLineGrayColor;
    }
    return _lineView;
}
-(UILabel *)payWaysLabel
{
    if (!_payWaysLabel) {
        _payWaysLabel = [[UILabel alloc]initWithFrame:CGRectMake(ScaleW(15), ScaleW(24) + _lineView.bottom, ScaleW(90), ScaleW(15))];
        [_payWaysLabel label:_payWaysLabel font:ScaleW(15) textColor:kMainTextColor text:@"收款方式"];
    }
    return _payWaysLabel;
}

-(UIView *)weChartPayView
{
    if (!_weChartPayView) {
        _weChartPayView = [[UIView alloc]initWithFrame:CGRectMake(0, ScaleW(14) + _payWaysLabel.bottom, ScreenWidth, ScaleW(38))];
        [_weChartPayView addSubview:self.weselectBtn];
        [_weChartPayView addSubview:self.weImg];
        [_weChartPayView addSubview:self.weNum];
        [_weChartPayView addSubview:self.twoCodeWeImg];
    }
    return _weChartPayView;
}
-(UIButton *)weselectBtn
{
    if (!_weselectBtn) {
        _weselectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _weselectBtn.frame = CGRectMake(ScaleW(10), 0, ScaleW(21), ScaleW(38));
        [_weselectBtn btn:_weselectBtn font:ScaleW(0) textColor:kText878ff5 text:@"" image:[UIImage imageNamed:@"unSelected"] sel:@selector(selecteBtnAction:) taget:self];
        [_weselectBtn setImage:[UIImage imageNamed:@"FBCSelected"] forState:(UIControlStateSelected)];
    }
    return _weselectBtn;
}
-(UIImageView *)weImg{
    if (!_weImg) {
        _weImg = [[UIImageView alloc]initWithFrame:CGRectMake(_weselectBtn.right, ScaleW(9), ScaleW(20), ScaleW(20))];
        _weImg.image = [UIImage imageNamed:@"weChat"];
    }
    return _weImg;
}
-(UILabel *)weNum
{
    if (!_weNum) {
        _weNum = [[UILabel alloc]initWithFrame:CGRectMake(ScaleW(10) + _weImg.right, 0, ScaleW(96), ScaleW(13))];
        [_weNum label:_weNum font:ScaleW(13) textColor:kMainTextColor text:@"------------"];
        _weNum.centerY = _weImg.centerY;
    }
    return _weNum;
}
-(UIButton *)twoCodeWeImg
{
    if (!_twoCodeWeImg) {
        _twoCodeWeImg = [UIButton buttonWithType:UIButtonTypeCustom];
        _twoCodeWeImg.frame = CGRectMake(_weNum.right, 0, ScaleW(16), ScaleW(38));
        [_twoCodeWeImg btn:_twoCodeWeImg font:ScaleW(0) textColor:kText878ff5 text:@"" image:[UIImage imageNamed:@"twoCodeImg"] sel:@selector(twoCodeAction:) taget:self];
       
    }
    return _twoCodeWeImg;
}
-(UIView *)alpayChartView
{
    if (!_alpayChartView) {
        _alpayChartView = [[UIView alloc]initWithFrame:CGRectMake(0, _weChartPayView.bottom, ScreenWidth, ScaleW(38))];
        [_alpayChartView addSubview:self.alSelectBtn];
        [_alpayChartView addSubview:self.alImage];
        [_alpayChartView addSubview:self.alPayNum];
        [_alpayChartView addSubview:self.twoCodeAlImg];
    }
    return _alpayChartView;
}
-(UIButton *)alSelectBtn
{
    if (!_alSelectBtn) {
        _alSelectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _alSelectBtn.frame = CGRectMake(ScaleW(10), 0, ScaleW(21), ScaleW(38));
        [_alSelectBtn btn:_alSelectBtn font:ScaleW(0) textColor:kText878ff5 text:@"" image:[UIImage imageNamed:@"unSelected"] sel:@selector(selecteBtnAction:) taget:self];
        [_alSelectBtn setImage:[UIImage imageNamed:@"FBCSelected"] forState:(UIControlStateSelected)];
    }
    return _alSelectBtn;
}
-(UIImageView *)alImage{
    if (!_alImage) {
        _alImage = [[UIImageView alloc]initWithFrame:CGRectMake(_alSelectBtn.right, ScaleW(9), ScaleW(20), ScaleW(20))];
        _alImage.image = [UIImage imageNamed:@"FBCalpay"];
    }
    return _alImage;
}
-(UILabel *)alPayNum
{
    if (!_alPayNum) {
        _alPayNum = [[UILabel alloc]initWithFrame:CGRectMake(ScaleW(10) + _alImage.right, 0, ScaleW(96), ScaleW(13))];
        [_alPayNum label:_alPayNum font:ScaleW(13) textColor:kMainTextColor text:@"------------"];
        _alPayNum.centerY = _alImage.centerY;
    }
    return _alPayNum;
}
-(UIButton *)twoCodeAlImg
{
    if (!_twoCodeAlImg) {
        _twoCodeAlImg = [UIButton buttonWithType:UIButtonTypeCustom];
        _twoCodeAlImg.frame = CGRectMake(_alPayNum.right, 0, ScaleW(16), ScaleW(38));
        [_twoCodeAlImg btn:_twoCodeAlImg font:ScaleW(0) textColor:kText878ff5 text:@"" image:[UIImage imageNamed:@"twoCodeImg"] sel:@selector(twoCodeAction:) taget:self];
        
    }
    return _twoCodeAlImg;
}
-(UIView *)bankView
{
    if (!_bankView) {
        _bankView = [[UIView alloc]initWithFrame:CGRectMake(0,  _alpayChartView.bottom, ScreenWidth, ScaleW(38))];
        [_bankView addSubview:self.bankSelectBtn];
        [_bankView addSubview:self.bankImage];
        [_bankView addSubview:self.bakNumMessay];
      
    }
    return _bankView;
}
-(UIButton *)bankSelectBtn
{
    if (!_bankSelectBtn) {
        _bankSelectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _bankSelectBtn.frame = CGRectMake(ScaleW(10), 0, ScaleW(21), ScaleW(38));
        [_bankSelectBtn btn:_bankSelectBtn font:ScaleW(0) textColor:kText878ff5 text:@"" image:[UIImage imageNamed:@"unSelected"] sel:@selector(selecteBtnAction:) taget:self];
        [_bankSelectBtn setImage:[UIImage imageNamed:@"FBCSelected"] forState:(UIControlStateSelected)];
    }
    return _bankSelectBtn;
}
-(UIImageView *)bankImage{
    if (!_bankImage) {
        _bankImage = [[UIImageView alloc]initWithFrame:CGRectMake(_alSelectBtn.right, ScaleW(9), ScaleW(20), ScaleW(20))];
        _bankImage.image = [UIImage imageNamed:@"bankCard"];
    }
    return _bankImage;
}
-(UILabel *)bakNumMessay
{
    if (!_bakNumMessay) {
        _bakNumMessay = [[UILabel alloc]initWithFrame:CGRectMake(ScaleW(10) + _bankImage.right, 0, ScaleW(258), ScaleW(13))];
        [_bakNumMessay label:_bakNumMessay font:ScaleW(13) textColor:kMainTextColor text:@"------------"];
        _bakNumMessay.centerY = _bankImage.centerY;
    }
    return _bakNumMessay;
}
-(UIView *)line2View
{
    if (!_line2View) {
        _line2View = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(15), ScaleW(205) + _lineView.bottom,ScreenWidth - ScaleW(30), 1)];
        _line2View.backgroundColor = kLineGrayColor;
    }
    return _line2View;
}
-(UILabel *)statusMessageLabel
{
    if (!_statusMessageLabel) {
        _statusMessageLabel = [[UILabel alloc]initWithFrame:CGRectMake(ScaleW(15), _line2View.bottom + ScaleW(30), ScreenWidth - ScaleW(30), ScaleW(42))];
        _statusMessageLabel.numberOfLines = 0;
        [_statusMessageLabel label:_statusMessageLabel font:ScaleW(14) textColor:kTextOrgleColor text:@"待付款，请于“20:00:00”内向李*兵付款付款参考号：56987"];
    }
    return _statusMessageLabel;
}


-(void)selecteBtnAction:(UIButton *)sender
{
    
    
}
-(void)twoCodeAction:(UIButton *)sender
{
    
}
@end
