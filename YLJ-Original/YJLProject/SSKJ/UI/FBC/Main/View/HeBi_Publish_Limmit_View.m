//
//  HeBi_Publish_Limmit_View.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/4/15.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "HeBi_Publish_Limmit_View.h"


@interface HeBi_Publish_Limmit_View ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *minLineView;
@property (nonatomic, strong) UILabel *minUnitLabel;

@property (nonatomic, strong) UIView *maxLineView;
@property (nonatomic, strong) UILabel *maxUnitLabel;
@end

@implementation HeBi_Publish_Limmit_View

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kMainWihteColor;
        [self setUI];
    }
    return self;
}

-(void)setUI
{
    [self addSubview:self.titleLabel];
    [self addSubview:self.minLineView];
    [self addSubview:self.minUnitLabel];
    [self addSubview:self.minTextField];
    
    [self addSubview:self.maxLineView];
    [self addSubview:self.maxUnitLabel];
    [self addSubview:self.maxTextField];
}

-(UILabel *)titleLabel
{
    if (nil == _titleLabel) {
        _titleLabel = [WLTools allocLabel:SSKJLocalized(@"限额", nil) font:systemThinFont(ScaleW(13)) textColor: kTitleColor frame:CGRectMake(ScaleW(15), 40, ScaleW(200), ScaleW(15)) textAlignment:NSTextAlignmentLeft];
    }
    return _titleLabel;
}

-(UIView *)minLineView
{
    if (nil == _minLineView) {
        _minLineView = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(15), self.height - 0.5, ScreenWidth / 2 - ScaleW(30), 0.5)];
        _minLineView.backgroundColor = kMainLineColor;
    }
    return _minLineView;
}

-(UILabel *)minUnitLabel
{
    if (nil == _minUnitLabel) {
        _minUnitLabel = [WLTools allocLabel:@"ETH" font:systemThinFont(ScaleW(14)) textColor: kGrayTitleColor frame:CGRectMake(self.minLineView.right - ScaleW(33), 0, ScaleW(40), ScaleW(14)) textAlignment:NSTextAlignmentRight];
        _minUnitLabel.bottom = self.minLineView.y - ScaleW(16);
    }
    return _minUnitLabel;
}

-(UITextField *)minTextField
{
    if (nil == _minTextField) {
        _minTextField = [[UITextField alloc]initWithFrame:CGRectMake(ScaleW(15), 0, self.minUnitLabel.x - ScaleW(15), ScaleW(30))];
        _minTextField.centerY = self.minUnitLabel.centerY;
        _minTextField.textColor =  kTitleColor;
        _minTextField.placeholder = SSKJLocalized(@"不能低于200", nil);
        _minTextField.font = systemThinFont(ScaleW(14));
//        [_minTextField setValue:kGrayTitleColor forKeyPath:@"_placeholderLabel.textColor"];
        
        NSMutableAttributedString *placeholderString1 = [[NSMutableAttributedString alloc] initWithString: SSKJLocalized(@"不能低于200", nil) attributes:@{NSForegroundColorAttributeName : kGrayTitleColor}];
        
        _minTextField.attributedPlaceholder = placeholderString1;
        _minTextField.keyboardType = UIKeyboardTypeDecimalPad;
    }
    return _minTextField;
    
}


-(UIView *)maxLineView
{
    if (nil == _maxLineView) {
        _maxLineView = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(15) + ScreenWidth / 2, self.height - 0.5, ScreenWidth / 2 - ScaleW(30), 0.5)];
        _maxLineView.backgroundColor = kMainLineColor;
    }
    return _maxLineView;
}

-(UILabel *)maxUnitLabel
{
    if (nil == _maxUnitLabel) {
        _maxUnitLabel = [WLTools allocLabel:@"ETH" font:systemThinFont(ScaleW(14)) textColor: kGrayTitleColor frame:CGRectMake(self.maxLineView.right - ScaleW(33), 0, ScaleW(40), ScaleW(14)) textAlignment:NSTextAlignmentRight];
        _maxUnitLabel.bottom = self.maxLineView.y - ScaleW(16);
    }
    return _maxUnitLabel;
}

-(UITextField *)maxTextField
{
    if (nil == _maxTextField) {
        _maxTextField = [[UITextField alloc]initWithFrame:CGRectMake(self.maxLineView.x, 0, self.minTextField.width, self.minTextField.height)];
        _maxTextField.centerY = self.maxUnitLabel.centerY;
        _maxTextField.textColor =  kTitleColor;
        _maxTextField.placeholder = SSKJLocalized(@"不能超过70000", nil);
        _maxTextField.font = systemThinFont(ScaleW(14));
//        [_maxTextField setValue:kGrayTitleColor forKeyPath:@"_placeholderLabel.textColor"];
        
        NSMutableAttributedString *placeholderString1 = [[NSMutableAttributedString alloc] initWithString: SSKJLocalized(@"不能超过70000", nil) attributes:@{NSForegroundColorAttributeName : kTitleColor}];
        
        _maxTextField.attributedPlaceholder = placeholderString1;
        _maxTextField.keyboardType = UIKeyboardTypeDecimalPad;

    }
    return _maxTextField;
    
}


-(NSString *)minlimmit
{
    return self.minTextField.text;
}

-(NSString *)maxlimmit
{
    return self.maxTextField.text;
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
