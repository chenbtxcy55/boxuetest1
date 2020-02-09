//
//  FBCSellingHeaderView.m
//  SSKJ
//
//  Created by 张本超 on 2019/5/15.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "FBCSellingHeaderView.h"
@interface FBCSellingHeaderView()


@end

@implementation FBCSellingHeaderView

-(instancetype)init
{
    if (self = [super init]) {
        [self viewConfig];
    }
    return self;
}
-(void)viewConfig
{
    self.frame = CGRectMake(0, 0, ScreenWidth, ScaleW(200));
    [self addSubview:self.headerLabel];
    [self addSubview:self.amountNameLabel];
    [self addSubview:self.amountTF];
    [self addSubview:self.limitAmountName];
    [self addSubview:self.lowLimitTf];
    [self addSubview:self.hightLimitTf];
    [self addSubview:self.signlePriceName];
    [self addSubview:self.signlePriceTf];
    [self  addSubview:self.momoNameLabel];
    [self addSubview:self.momoTf];
    [self addSubview:self.boomLine];
    [self addSubview:self.payWaysName];
    self.height = self.payWaysName.bottom;
    self.backgroundColor = kMianBgColor;
    self.sellingType = 1;
}
-(UILabel *)headerLabel{
    if (!_headerLabel) {
        _headerLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleW(35))];
        _headerLabel.backgroundColor = kMainBackgroundColor;
        [_headerLabel label:_headerLabel font:ScaleW(13) textColor:kTextColor5b5e95 text:@"商家自由购买AB，交易更灵活更便捷"];
        _headerLabel.textAlignment = NSTextAlignmentCenter;
        
    }
    return _headerLabel;
}
-(UILabel *)amountNameLabel
{
    if (!_amountNameLabel) {
        _amountNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(ScaleW(16),_headerLabel.bottom + ScaleW(31), ScaleW(50), ScaleW(12))];
        [_amountNameLabel label:_amountNameLabel font:ScaleW(12) textColor:kTextColorb2b9e7 text:@"数量"];
    }
    return _amountNameLabel;
}
-(UITextField *)amountTF
{
    if (!_amountTF) {
        _amountTF = [[UITextField alloc]initWithFrame:CGRectMake(_amountNameLabel.left, ScaleW(7) + _amountNameLabel.bottom,ScreenWidth - ScaleW(32), ScaleW(45))];
        [_amountTF textField:_amountTF textFont:ScaleW(14) placeHolderFont:ScaleW(14) text:nil placeText:@"发布购买数量" textColor:kMainTextColor placeHolderTextColor:kTextColor5b5e95];
        UIView *bommline = [[UIView alloc]initWithFrame:CGRectMake(0, _amountTF.height - 1, _amountTF.width, 1)];
        bommline.backgroundColor = kTextColor313359;
        _amountTF.keyboardType = UIKeyboardTypeDecimalPad;
        [_amountTF addSubview:bommline];
        
    }
    return _amountTF;
}

-(UILabel *)limitAmountName
{
    if (!_limitAmountName) {
        _limitAmountName = [[UILabel alloc]initWithFrame:CGRectMake(ScaleW(16), ScaleW(31) + _amountTF.bottom, ScaleW(50), ScaleW(12))];
        [_limitAmountName label:_limitAmountName font:ScaleW(12) textColor:kTextColorb2b9e7 text:@"限额"];
    }
    return _limitAmountName;
}
-(UITextField *)lowLimitTf
{
    if (!_lowLimitTf) {
        _lowLimitTf = [[UITextField alloc]initWithFrame:CGRectMake(_limitAmountName.left, ScaleW(7) + _limitAmountName.bottom, ScaleW(157), ScaleW(45))];
        [_lowLimitTf textField:_lowLimitTf textFont:ScaleW(14) placeHolderFont:ScaleW(14) text:nil placeText:@"最低" textColor:kMainTextColor placeHolderTextColor:kTextColor5b5e95];
        UIView *bommline = [[UIView alloc]initWithFrame:CGRectMake(0, _lowLimitTf.height - 1, _lowLimitTf.width, 1)];
        bommline.backgroundColor = kTextColor313359;
        [_lowLimitTf addSubview:bommline];
        _lowLimitTf.rightViewMode = UITextFieldViewModeAlways;
        UILabel *rightView = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, ScaleW(32), ScaleW(45))];
        [rightView label:rightView font:ScaleW(14) textColor:kTextColorb2b9e7 text:@"CNY"];
        _lowLimitTf.rightView = rightView;
        _lowLimitTf.keyboardType = UIKeyboardTypeDecimalPad;
        
        
    }
    return _lowLimitTf;
}
-(UITextField *)hightLimitTf
{
    if (!_hightLimitTf) {
        _hightLimitTf = [[UITextField alloc]initWithFrame:CGRectMake(_lowLimitTf.right + ScaleW(35), ScaleW(7) + _limitAmountName.bottom, ScaleW(157), ScaleW(45))];
        [_hightLimitTf textField:_hightLimitTf textFont:ScaleW(14) placeHolderFont:ScaleW(14) text:nil placeText:@"最高" textColor:kMainTextColor placeHolderTextColor:kTextColor5b5e95];
        UIView *bommline = [[UIView alloc]initWithFrame:CGRectMake(0, _hightLimitTf.height - 1, _hightLimitTf.width, 1)];
        bommline.backgroundColor = kTextColor313359;
        [_hightLimitTf addSubview:bommline];
        _hightLimitTf.rightViewMode = UITextFieldViewModeAlways;
        UILabel *rightView = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, ScaleW(32), ScaleW(45))];
        [rightView label:rightView font:ScaleW(14) textColor:kTextColorb2b9e7 text:@"CNY"];
        _hightLimitTf.rightView = rightView;
        
        _hightLimitTf.keyboardType = UIKeyboardTypeDecimalPad;
    }
    return _hightLimitTf;
}

-(UILabel *)signlePriceName
{
    if (!_signlePriceName) {
        _signlePriceName = [[UILabel alloc]initWithFrame:CGRectMake(ScaleW(16), ScaleW(42) + _hightLimitTf.bottom, ScaleW(50), ScaleW(12))];
        [_signlePriceName label:_signlePriceName font:ScaleW(12) textColor:kTextColorb2b9e7 text:@"单价"];
    }
    return _signlePriceName;
}
-(UITextField *)signlePriceTf
{
    if (!_signlePriceTf) {
        _signlePriceTf = [[UITextField alloc]initWithFrame:CGRectMake(_signlePriceName.left, ScaleW(7) + _signlePriceName.bottom,ScreenWidth - ScaleW(32), ScaleW(45))];
        [_signlePriceTf textField:_signlePriceTf textFont:ScaleW(14) placeHolderFont:ScaleW(14) text:nil placeText:@"请输入购买单价" textColor:kMainTextColor placeHolderTextColor:kTextColor5b5e95];
        UIView *bommline = [[UIView alloc]initWithFrame:CGRectMake(0, _signlePriceTf.height - 1, _signlePriceTf.width, 1)];
        bommline.backgroundColor = kTextColor313359;
        [_signlePriceTf addSubview:bommline];
         _signlePriceTf.keyboardType = UIKeyboardTypeDecimalPad;
    }
    return _signlePriceTf;
}
-(UILabel *)momoNameLabel
{
    if (!_momoNameLabel) {
        _momoNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(ScaleW(16), ScaleW(42) + _signlePriceTf.bottom, ScaleW(50), ScaleW(12))];
        [_momoNameLabel label:_momoNameLabel font:ScaleW(12) textColor:kTextColorb2b9e7 text:@"备注"];
    }
    return _momoNameLabel;
}
-(UITextField *)momoTf
{
    if (!_momoTf) {
        _momoTf = [[UITextField alloc]initWithFrame:CGRectMake(_momoNameLabel.left, ScaleW(7) + _momoNameLabel.bottom,ScreenWidth - ScaleW(32), ScaleW(45))];
        [_momoTf textField:_momoTf textFont:ScaleW(14) placeHolderFont:ScaleW(14) text:nil placeText:@"请输入要备注信息（选填）" textColor:kMainTextColor placeHolderTextColor:kTextColor5b5e95];
        UIView *bommline = [[UIView alloc]initWithFrame:CGRectMake(0, _momoTf.height - 1, _momoTf.width, 1)];
        bommline.backgroundColor = kTextColor313359;
        [_momoTf addSubview:bommline];
        
    }
    return _momoTf;
}
-(UIView *)boomLine{
    if (!_boomLine) {
        _boomLine = [[UIView alloc]initWithFrame:CGRectMake(0, _momoTf.bottom, ScreenWidth, ScaleW(10))];
        _boomLine.backgroundColor = kMainBackgroundColor;
    }
    return _boomLine;
}
-(UILabel *)payWaysName
{
    if (!_payWaysName) {
        _payWaysName = [[UILabel alloc]initWithFrame:CGRectMake(ScaleW(16), _boomLine.bottom + ScaleW(25), ScaleW(100), ScaleW(13))];
        [_payWaysName label:_payWaysName font:ScaleW(13) textColor:kTextColorb2b9e7 text:@"支付方式"];
    }
    return _payWaysName;
}

-(void)setSellingType:(NSInteger)sellingType
{
    _sellingType = sellingType;
    
//    if (<#condition#>) {
//        <#statements#>
//    }
    if (_sellingType == 1) {
        _amountTF.text = nil;
//        _amountTF.placeholder = @"发布出售数量";
        _amountTF.attributedPlaceholder = [[NSAttributedString alloc] initWithString: SSKJLocalized(@"发布出售数量", nil) attributes:@{NSForegroundColorAttributeName:kGrayTitleColor}];

        _lowLimitTf.text = nil;
        _hightLimitTf.text = nil;
        _signlePriceTf.text = nil;
        _signlePriceTf.placeholder = @"请输入出售单价";
        _signlePriceTf.attributedPlaceholder = [[NSAttributedString alloc] initWithString: SSKJLocalized(@"请输入出售单价", nil) attributes:@{NSForegroundColorAttributeName:kGrayTitleColor}];

        _momoTf.text = nil;
    }else{
        _amountTF.text = nil;
        _amountTF.placeholder = @"发布购买数量";
        _amountTF.attributedPlaceholder = [[NSAttributedString alloc] initWithString: SSKJLocalized(@"发布购买数量", nil) attributes:@{NSForegroundColorAttributeName:kGrayTitleColor}];

        _lowLimitTf.text = nil;
        _hightLimitTf.text = nil;
        _signlePriceTf.text = nil;
        _signlePriceTf.placeholder = @"请输入购买单价";
        _signlePriceTf.attributedPlaceholder = [[NSAttributedString alloc] initWithString: SSKJLocalized(@"请输入购买单价", nil) attributes:@{NSForegroundColorAttributeName:kGrayTitleColor}];

        _momoTf.text = nil;
    }
    
}




@end
