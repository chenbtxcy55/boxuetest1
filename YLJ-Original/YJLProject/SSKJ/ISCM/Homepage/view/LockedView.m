//
//  LockedView.m
//  SSKJ
//
//  Created by 张本超 on 2019/7/19.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "LockedView.h"

@interface LockedView()

@property (nonatomic, strong) UIImageView *backImg;

@property (nonatomic, strong) UIButton *goBackBtn;

@property (nonatomic, strong) UILabel *titleNameLabel;

@property (nonatomic, strong) UILabel *moneyIscmLabel;

@property (nonatomic, strong) UILabel *cnyMoneyLabel;

@property (nonatomic, strong) UILabel *forzenLabel;

@property (nonatomic, strong) UILabel *forzenNameLabel;

@property (nonatomic, strong) UILabel *lockDownLabel;

@property (nonatomic, strong) UILabel *lockDownNameLabel;

@property (nonatomic, strong) UIButton *recodBtn;

@property (nonatomic, strong) UIView *lineH;

@property (nonatomic, strong) UILabel *propertyNameLabel;


@end

@implementation LockedView


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
    
    [self.backImg addSubview:self.goBackBtn];
    
    [self.backImg addSubview:self.titleNameLabel];
    
    [self.backImg addSubview:self.moneyIscmLabel];
    
    [self.backImg addSubview:self.cnyMoneyLabel];
    
    [self.backImg addSubview:self.forzenLabel];
    
    [self.backImg addSubview:self.forzenNameLabel];
    
    [self.backImg addSubview:self.lockDownLabel];
    
    [self.backImg addSubview:self.lockDownNameLabel];
    
    [self.backImg addSubview:self.recodBtn];
    
    [self addSubview:self.lineH];
    
    [self addSubview:self.propertyNameLabel];
    
    self.height = self.backImg.bottom + ScaleW(65);
}

-(UIImageView *)backImg
{
    if (!_backImg) {
        _backImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleW(220) - ScaleW(14) + Height_StatusBar)];
        _backImg.image = [UIImage imageNamed:@"lockBack"];
        _backImg.userInteractionEnabled = YES;
        
    }
    return _backImg;
}

-(UIButton *)goBackBtn
{
    if (!_goBackBtn) {
        _goBackBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _goBackBtn.frame = CGRectMake(0, ScaleW(10)+ Height_StatusBar, ScaleW(38), ScaleW(34));
        
        [_goBackBtn btn:_goBackBtn font:0 textColor:kTitleColor text:@"" image:[UIImage imageNamed:@"public_back"] sel:@selector(goBackBtnAction:) taget:self];
        //_goBackBtn.backgroundColor = [UIColor purpleColor];
    }
    return _goBackBtn;
}

-(UILabel *)titleNameLabel
{
    if (!_titleNameLabel) {
        _titleNameLabel = [WLTools allocLabel:SSKJLocalized(@"锁仓套餐", nil) font:systemFont(ScaleW(18)) textColor:kMainWihteColor frame:CGRectMake(ScaleW(152), ScaleW(10)+ Height_StatusBar, ScaleW(200), ScaleW(18)) textAlignment:(NSTextAlignmentLeft)];
        
    }
    return _titleNameLabel;
}

-(UILabel *)moneyIscmLabel
{
    if (!_moneyIscmLabel) {
        _moneyIscmLabel = [WLTools allocLabel:SSKJLocalized(@"0.0000 ISCM", nil) font:systemBoldFont(ScaleW(24)) textColor:kMainWihteColor frame:CGRectMake(ScaleW(42), ScaleW(37) + _titleNameLabel.bottom, ScaleW(300), ScaleW(24)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _moneyIscmLabel;
}

-(UILabel *)cnyMoneyLabel
{
    if (!_cnyMoneyLabel) {
        _cnyMoneyLabel = [WLTools allocLabel:@"≈0.00 CNY" font:systemFont(ScaleW(12)) textColor:kWhiteColorClear frame:CGRectMake(ScaleW(44), ScaleW(9) + _moneyIscmLabel.bottom, ScaleW(144), ScaleW(12)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _cnyMoneyLabel;
}

-(UILabel *)forzenLabel
{
    if (!_forzenLabel) {
        _forzenLabel = [WLTools allocLabel:@"0.00" font:systemBoldFont(ScaleW(15)) textColor:kMainWihteColor frame:CGRectMake(0, ScaleW(33) + _cnyMoneyLabel.bottom, ScreenWidth/3.f, ScaleW(15)) textAlignment:(NSTextAlignmentCenter)];
       _forzenLabel.hidden = YES;
    }
    return _forzenLabel;
}

-(UILabel *)forzenNameLabel
{
    if (!_forzenNameLabel) {
        _forzenNameLabel = [WLTools allocLabel:@"冻结" font:systemFont(ScaleW(12)) textColor:kMainWihteColor frame:CGRectMake(0, _forzenLabel.bottom + ScaleW(5), ScreenWidth/3.f, ScaleW(12)) textAlignment:(NSTextAlignmentCenter)];
        _forzenNameLabel.hidden = YES;
    }
    return _forzenNameLabel;
}

-(UILabel *)lockDownLabel
{
    if (!_lockDownLabel) {
        _lockDownLabel = [WLTools allocLabel:@"0.00" font:systemBoldFont(ScaleW(15)) textColor:kMainWihteColor frame:CGRectMake(0, ScaleW(33) + _cnyMoneyLabel.bottom, ScreenWidth/3.f, ScaleW(15)) textAlignment:(NSTextAlignmentCenter)];
    }
    return _lockDownLabel;
}

-(UILabel *)lockDownNameLabel
{
    if (!_lockDownNameLabel) {
        _lockDownNameLabel = [WLTools allocLabel:@"锁仓" font:systemFont(ScaleW(12)) textColor:kMainWihteColor frame:CGRectMake(_lockDownLabel.left, _lockDownLabel.bottom + ScaleW(5), ScreenWidth/3.f, ScaleW(12)) textAlignment:(NSTextAlignmentCenter)];
    }
    return _lockDownNameLabel;
}


-(UIButton *)recodBtn
{
    if (!_recodBtn) {
        _recodBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [_recodBtn btn:_recodBtn font:ScaleW(0) textColor:kTitleColor text:@"" image:nil sel:@selector(recodeAction:) taget:self];
        
        _recodBtn.frame = CGRectMake(ScreenWidth - ScaleW(78), ScaleW(159), ScaleW(90), ScaleW(36));
        _recodBtn.bottom = _backImg.height - ScaleW(26);
        UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(ScaleW(10), ScaleW(10), ScaleW(13), ScaleW(15))];
        image.image = [UIImage imageNamed:@"order"];
        [_recodBtn addSubview:image];
        
        UILabel *label = [WLTools allocLabel:@"记录" font:systemBoldFont(ScaleW(14)) textColor:kMainWihteColor frame:CGRectMake(ScaleW(8) + image.right, ScaleW(10), ScaleW(35), ScaleW(16)) textAlignment:(NSTextAlignmentLeft)];
        [_recodBtn addSubview:label];
        
    }
    return _recodBtn;
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
        _propertyNameLabel = [WLTools allocLabel:@"锁仓套餐" font:systemFont(ScaleW(15)) textColor:kTitleColor frame:CGRectMake(_lineH.right + ScaleW(11), _lineH.top, ScaleW(200), ScaleW(15)) textAlignment:(NSTextAlignmentLeft)];
        
    }
    
    return _propertyNameLabel;
}
-(void)recodeAction:(UIButton *)sender
{
    !self.recodeBlcok?:self.recodeBlcok();
}
-(void)goBackBtnAction:(UIButton *)sender
{
    !self.gobackBlcok?:self.gobackBlcok();
}

-(void)setModel:(LockHeaderModel *)model
{
    _model = model;
    
    self.moneyIscmLabel.text = [NSString stringWithFormat:@"%@",model.ttlnum];
    _cnyMoneyLabel.text = [NSString stringWithFormat:@"≈%@ CNY",model.rmb_ttl];
    _lockDownLabel.text = [NSString stringWithFormat:@"%@",model.synum];
   
}
@end
