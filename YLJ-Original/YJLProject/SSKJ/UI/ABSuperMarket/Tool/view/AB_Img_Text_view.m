//
//  AB_Img_Text_view.m
//  SSKJ
//
//  Created by 张本超 on 2019/6/5.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "AB_Img_Text_view.h"
@interface AB_Img_Text_view ()
{
    CGFloat _leftGap;
    UIFont *_font;
    NSString *_title;
    NSString *_placeHolder;
    UIKeyboardType _keyboardType;
    NSString *_headImgStr;
    BOOL _secured;
}
@end
@implementation AB_Img_Text_view


@synthesize valueString = _valueString;

-(instancetype)initWithFrame:(CGRect)frame leftGap:(CGFloat)leftGap placeHolder:(NSString *)placeHolder font:(UIFont *)font keyBoardType:(UIKeyboardType)keyBoardType headImg:(NSString *)headImgStr isShowSecured:(BOOL)secured
{
    if (self = [super initWithFrame:frame]) {
        _leftGap = leftGap;
        _font = font;
        _placeHolder = placeHolder;
        _keyboardType = keyBoardType;
        _headImgStr  = headImgStr;
        [self addSubview:self.titleImg];
       
        [self addSubview:self.securedButton];
        [self addSubview:self.textField];
        [self bringSubviewToFront:_securedButton];
        
        if (secured) {
            self.securedButton.hidden = NO;
            self.textField.secureTextEntry = YES;
        }else{
            self.securedButton.hidden = YES;
            self.textField.secureTextEntry = NO;
        }
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





-(UIImageView *)titleImg
{
    if (nil == _titleImg) {
        _titleImg = [WLTools allocImageView:CGRectMake(_leftGap, 0, [UIImage imageNamed:_headImgStr].size.width, [UIImage imageNamed:_headImgStr].size.height) image:[UIImage imageNamed:_headImgStr]];
        //        _titleLabel.adjustsFontSizeToFitWidth = YES;
        _titleImg.centerY = self.height/2.f;
    }
    return _titleImg;
}
-(UIButton *)securedButton
{
    if (nil == _securedButton) {
        _securedButton = [[UIButton alloc]initWithFrame:CGRectMake(self.width - _leftGap - ScaleW(49), 0, ScaleW(49), self.height)];
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
        _textField = [[UITextField alloc]initWithFrame:CGRectMake(ScaleW(35) + _leftGap, 0, self.securedButton.left - _leftGap, self.height)];
        _textField.placeholder = _placeHolder;
        _textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:_textField.placeholder attributes:@{NSForegroundColorAttributeName:kSubSubTxtColor}];
        _textField.font = _font;
        _textField.keyboardType = _keyboardType;
        _textField.textColor = kMainTextColor;
        _textField.adjustsFontSizeToFitWidth = YES;
        
   
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
