//
//  Mine_PayWays_InputView.m
//  SSKJ
//
//  Created by 张本超 on 2019/6/12.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "Mine_PayWays_InputView.h"

@interface Mine_PayWays_InputView ()
{
    CGFloat _leftGap;
    UIFont *_font;
    NSString *_title;
    NSString *_placeHolder;
    UIKeyboardType _keyboardType;
    NSString *_headImgStr;
    UIView *_rightView;
    UIFont *_titleFont;
    
}
@end
@implementation Mine_PayWays_InputView


@synthesize valueString = _valueString;

-(instancetype)initWithFrame:(CGRect)frame leftGap:(CGFloat)leftGap  placeHolder:(NSString *)placeHolder font:(UIFont *)font keyBoardType:(UIKeyboardType)keyBoardType titleText:(NSString *)titleText rightView:(UIView *)rightView
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = kMainWihteColor;
        _leftGap = leftGap;
        _font = font;
        _titleFont = font;
        _placeHolder = placeHolder;
        _keyboardType = keyBoardType;
        _title  = titleText;
        _rightView = rightView;
        [self addSubview:self.titleLabel];
        
        //[self addSubview:self.securedButton];
        [self addSubview:self.textField];
        [self bringSubviewToFront:_securedButton];
        
        
        self.securedButton.hidden = YES;
        self.textField.secureTextEntry = NO;
        [self addSubview:self.lineView];
    }
    return self;
}

-(UIView *)lineView
{
    if (nil == _lineView) {
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(_leftGap, self.height - 1, ScreenWidth - 2 * _leftGap, 1)];
        _lineView.backgroundColor = kMainLineColor;
    }
    return _lineView;
}


-(UILabel *)titleLabel
{
    if (nil == _titleLabel) {
        _titleLabel = [WLTools allocLabel:_title font:_titleFont?: systemFont(15) textColor:kMainTextColor frame:CGRectMake(_leftGap, ScaleW(12), self.width - _leftGap, ScaleW(12)) textAlignment:(NSTextAlignmentLeft)];
        
    }
    return _titleLabel;
}
-(UIButton *)securedButton
{
    if (nil == _securedButton) {
        _securedButton = [[UIButton alloc]initWithFrame:CGRectMake(self.width - _leftGap - ScaleW(49), 0, ScaleW(40), self.height)];
        [_securedButton setImage:[UIImage imageNamed:@"eye_yes"] forState:UIControlStateNormal];
        [_securedButton setImage:[UIImage imageNamed:@"eye_no"] forState:UIControlStateSelected];
        _securedButton.selected = YES;
        [_securedButton addTarget:self action:@selector(showSecure:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _securedButton;
}
-(UITextField *)textField
{
    if (nil == _textField) {
        _textField = [[UITextField alloc]initWithFrame:CGRectMake(_leftGap, _titleLabel.bottom, self.width - _leftGap, ScaleW(37))];
        _textField.placeholder = _placeHolder;
        _textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:_textField.placeholder attributes:@{NSForegroundColorAttributeName:kSubSubTxtColor}];
        _textField.font = _font;
        _textField.keyboardType = _keyboardType;
        _textField.textColor = kMainTextColor;
        _textField.adjustsFontSizeToFitWidth = YES;
        if (_rightView!=nil) {
            _textField.rightViewMode = UITextFieldViewModeAlways;
            _textField.rightView = _rightView;
        }
        
        
    }
    return _textField;
}


-(void)showSecure:(UIButton *)button
{
    button.selected = !button.selected;
    self.textField.secureTextEntry = button.selected;
}

-(void)setValueString:(NSString *)valueString
{
    _valueString = valueString;
    self.textField.text = valueString;
}

-(NSString *)valueString
{
    _valueString = self.textField.text;
    if (_valueString.length == 0) {
        _valueString = @"";
    }
    return _valueString;
}


@end
