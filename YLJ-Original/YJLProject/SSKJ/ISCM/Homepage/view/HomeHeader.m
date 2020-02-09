//
//  HomeHeader.m
//  SSKJ
//
//  Created by 张本超 on 2019/7/19.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "HomeHeader.h"

@interface HomeHeader()

@property (nonatomic, strong) UIImageView *backImg;

@property (nonatomic, strong) UIButton *notifaBtn;

@property (nonatomic, strong) UILabel *titleNameLabel;

@property (nonatomic, strong) UILabel *moneyNameLabel;


@property (nonatomic, strong) UIButton *addressBtn;

@property (nonatomic, strong) UIView *septorLine;



@property (nonatomic, strong) UIButton *lockBtn;

@property (nonatomic, strong) UIView *lineH;

@property (nonatomic, strong) UILabel *propertyNameLabel;


@end

@implementation HomeHeader


-(instancetype)init
{
    if (self = [super init])
    
    {
        [self viewConfig];
    }
    return self;
}

-(void)viewConfig
{
    self.frame = CGRectMake(0, 0, ScreenWidth, ScaleW(500));
    
    [self addSubview:self.backImg];
    
    [self.backImg addSubview:self.notifaBtn];
    
    [self.backImg addSubview:self.titleNameLabel];
    
    [self.backImg addSubview:self.moneyNameLabel];
    
    [self.backImg addSubview:self.addressLabel];
    
    [self.backImg addSubview:self.addressBtn];
    
    [self.backImg addSubview:self.septorLine];
    
    [self.backImg addSubview:self.moneyValueLabel];
    
    [self.backImg addSubview:self.lockBtn];
    
    [self addSubview:self.lineH];
    
    [self addSubview:self.propertyNameLabel];
    
    self.height = self.backImg.bottom + ScaleW(65);
}

-(UIImageView *)backImg
{
    if (!_backImg) {
        _backImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleW(265))];
        _backImg.image = [UIImage imageNamed:@"homepageBack"];
        _backImg.userInteractionEnabled = YES;
        
    }
    return _backImg;
}

-(UIButton *)notifaBtn
{
    if (!_notifaBtn) {
        _notifaBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _notifaBtn.frame = CGRectMake(0, ScaleW(30), ScaleW(54), ScaleW(41));
        
        [_notifaBtn btn:_notifaBtn font:0 textColor:kTitleColor text:@"" image:[UIImage imageNamed:@"notifacIcon"] sel:@selector(notifacationAction:) taget:self];
    }
    return _notifaBtn;
}

-(UILabel *)titleNameLabel
{
    if (!_titleNameLabel) {
        _titleNameLabel = [WLTools allocLabel:SSKJLocalized(@"ETH-Wallet", nil) font:systemBoldFont(ScaleW(18)) textColor:kMainWihteColor frame:CGRectMake(ScaleW(46), ScaleW(96), ScaleW(200), ScaleW(18)) textAlignment:(NSTextAlignmentLeft)];
        
    }
    return _titleNameLabel;
}

-(UILabel *)moneyNameLabel
{
    if (!_moneyNameLabel) {
        _moneyNameLabel = [WLTools allocLabel:SSKJLocalized(@"总资产 ( $ )", nil) font:systemFont(ScaleW(15)) textColor:kWhiteColorClear frame:CGRectMake(ScaleW(44), ScaleW(15) + _titleNameLabel.bottom, ScaleW(200), ScaleW(15)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _moneyNameLabel;
}

-(UILabel *)addressLabel
{
    if (!_addressLabel) {
        _addressLabel = [WLTools allocLabel:@"****" font:systemFont(ScaleW(12)) textColor:kWhiteColorClear frame:CGRectMake(ScaleW(44), ScaleW(9) + _moneyNameLabel.bottom, ScaleW(274), ScaleW(12)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _addressLabel;
}

-(UIButton *)addressBtn{
    if (!_addressBtn) {
        _addressBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addressBtn btn:_addressBtn font:ScaleW(0) textColor:kWhiteColorClear text:@"" image:[UIImage imageNamed:@"twoCodeIcon"] sel:@selector(addressAction:) taget:self];
        _addressBtn.width = ScaleW(25);
        _addressBtn.height = ScaleW(25);
        _addressBtn.centerY = _addressLabel.centerY;
        
        _addressBtn.left = _addressLabel.right + ScaleW(5);
        
        
    }
    return _addressBtn;
}

-(UIView *)septorLine
{
    if (!_septorLine) {
        _septorLine = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(44), ScaleW(21) + _addressLabel.bottom, ScaleW(315), .5)];
        _septorLine.backgroundColor = kWhiteColorClear;
    }
    return _septorLine;
}

-(UILabel *)moneyValueLabel
{
    if (!_moneyValueLabel) {
        _moneyValueLabel = [WLTools allocLabel:@"0.00" font:systemFont(ScaleW(17)) textColor:kMainWihteColor frame:CGRectMake(ScaleW(44), ScaleW(23)+ _septorLine.bottom, ScaleW(220), ScaleW(17)) textAlignment:(NSTextAlignmentLeft)];
        
    }
    return _moneyValueLabel;
}

-(UIButton *)lockBtn
{
    if (!_lockBtn) {
        _lockBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [_lockBtn btn:_lockBtn font:ScaleW(0) textColor:kTitleColor text:@"" image:nil sel:@selector(lockAction:) taget:self];
        
        _lockBtn.frame = CGRectMake(ScreenWidth - ScaleW(90), ScaleW(15) + _septorLine.bottom, ScaleW(90), ScaleW(34));
        UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(ScaleW(71), ScaleW(10), ScaleW(8), ScaleW(14))];
        image.image = [UIImage imageNamed:@"allows"];
        [_lockBtn addSubview:image];
        
        UILabel *label = [WLTools allocLabel:@"锁仓套餐" font:systemFont(ScaleW(14)) textColor:kMainWihteColor frame:CGRectMake(0, ScaleW(10), ScaleW(65), ScaleW(14)) textAlignment:(NSTextAlignmentLeft)];
        [_lockBtn addSubview:label];
        
    }
    return _lockBtn;
}

-(UIView *)lineH
{
    if (!_lineH) {
        _lineH = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(16), ScaleW(21) + _backImg.bottom, ScaleW(3), ScaleW(15))];
        _lineH.backgroundColor = kMainBlueColor;
        
    }
    return _lineH;
}
-(UILabel *)propertyNameLabel
{
    
    if (!_propertyNameLabel) {
        _propertyNameLabel = [WLTools allocLabel:@"资产中心" font:systemFont(ScaleW(15)) textColor:kTitleColor frame:CGRectMake(_lineH.right + ScaleW(11), _lineH.top, ScaleW(200), ScaleW(15)) textAlignment:(NSTextAlignmentLeft)];
        
    }
    
    return _propertyNameLabel;
}
-(void)lockAction:(UIButton *)sender
{
    !self.lockedBlock?:self.lockedBlock();
}
-(void)notifacationAction:(UIButton *)sender
{
    !self.notifacationBlock?:self.notifacationBlock();
}
-(void)addressAction:(UIButton *)sender
{
    !self.showAddressBlock?:self.showAddressBlock(_addressLabel.text);
}
@end
