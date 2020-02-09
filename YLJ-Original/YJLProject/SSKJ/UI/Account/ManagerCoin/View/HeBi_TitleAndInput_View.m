//
//  HeBi_TitleAndInput_View.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/4/10.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "HeBi_TitleAndInput_View.h"

@interface HeBi_TitleAndInput_View ()
{
    NSString *_title;
    NSString *_placeHolder;
    UIKeyboardType _keyBoardType;
    BOOL _isSecured;
    CGFloat _leftGap;
}

@property (nonatomic, strong) UIView *lineView;
@end

@implementation HeBi_TitleAndInput_View


@synthesize valueString = _valueString;

-(instancetype)initWithFrame:(CGRect )frame leftGap:(CGFloat)leftGap title:(NSString *)title placeHolder:(NSString *)placeHolder keyBoardType:(UIKeyboardType)keyBoardType isSecured:(BOOL)isSecured
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = kMainWihteColor;
        _title = title;
        _placeHolder = placeHolder;
        _keyBoardType = keyBoardType;
        _isSecured = isSecured;
        _leftGap = leftGap;
        [self addSubview:self.titleLabel];
        [self addSubview:self.textField];
        if (_isSecured) {
            [self addSubview:self.secureButton];
            self.textField.secureTextEntry = YES;
        }
        
        [self addSubview:self.lineView];
    }
    return self;
}


-(UILabel *)titleLabel
{
    
    if (nil == _titleLabel) {
        _titleLabel =[WLTools allocLabel:_title font:systemFont(ScaleW(13)) textColor:kTitleColor frame:CGRectMake(_leftGap, ScaleW(20), ScaleW(200), ScaleW(15)) textAlignment:NSTextAlignmentLeft];
    }
    return _titleLabel;
}

-(UITextField *)textField
{
    if (nil == _textField) {
        _textField = [[UITextField alloc]initWithFrame:CGRectMake(self.titleLabel.x, self.titleLabel.bottom, self.width - 2 * _leftGap - ScaleW(30), self.height - self.titleLabel.bottom - 0.5)];
        _textField.textColor = kTitleColor;
        _textField.font = systemFont(ScaleW(15));
        _textField.placeholder = _placeHolder;
        _textField.keyboardType = _keyBoardType;
//        [_textField setValue:kGrayTitleColor forKeyPath:@"_placeholderLabel.textColor"];
        
        NSMutableAttributedString *placeholderString1 = [[NSMutableAttributedString alloc] initWithString: _placeHolder attributes:@{NSForegroundColorAttributeName : kGrayTitleColor}];
        
        _textField.attributedPlaceholder = placeholderString1;
    }
    return _textField;
}

-(UIButton *)secureButton
{
    if (nil == _secureButton) {
        _secureButton = [[UIButton alloc]initWithFrame:CGRectMake(self.width - ScaleW(30) - _leftGap, 0, ScaleW(30), ScaleW(15))];
        _secureButton.centerY = self.textField.centerY;
        [_secureButton setImage:[UIImage imageNamed:@"pwd_hide"] forState:UIControlStateNormal];
        [_secureButton setImage:[UIImage imageNamed:@"pwd_open"] forState:UIControlStateSelected];
        [_secureButton addTarget:self action:@selector(showPWD) forControlEvents:UIControlEventTouchUpInside];

    }
    return _secureButton;
}

-(UIView *)lineView
{
    if (nil == _lineView) {
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(self.textField.x, self.height - 0.5, self.width - 2 * _leftGap, 0.5)];
        _lineView.backgroundColor = UIColorFromRGB(0xf0f0f0);
    }
    return _lineView;
}

-(NSString *)valueString
{
    return self.textField.text;
}

-(void)setValueString:(NSString *)valueString
{
    self.textField.text = valueString;
}


-(void)showPWD
{
    self.secureButton.selected = !self.secureButton.selected;
    self.textField.secureTextEntry = !self.secureButton.selected;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
