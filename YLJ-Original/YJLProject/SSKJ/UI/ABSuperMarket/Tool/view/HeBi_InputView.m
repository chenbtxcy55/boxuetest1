//
//  HeBi_InputView.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/4/10.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "HeBi_InputView.h"

@interface HeBi_InputView ()
{
    NSString *_placeHolder;
    NSString *_imageName;
    UIKeyboardType _keyboardType;
    BOOL _isSecured;
}
@property (nonatomic, assign) CGFloat leftGap;
@property (nonatomic, assign) CGFloat titleWidth;

//@property (nonatomic, strong) UIButton *secureButotn;
@property (nonatomic, strong) UIView *lineView;
@end

@implementation HeBi_InputView

@synthesize valueString = _valueString;

- (instancetype)initWithFrame:(CGRect)frame titleWidth:(CGFloat)titleWidth gap:(CGFloat)leftGap titleName:(NSString *)imageName placeHolder:(NSString *)placeHolder keyboardType:(UIKeyboardType)keyboardType isSecured:(BOOL)isSecured
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kMainColor;
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = ScaleW(2);
        _keyboardType = keyboardType;
        _placeHolder = placeHolder;
        _imageName = imageName;
        _isSecured = isSecured;
        _titleWidth = titleWidth;
        _leftGap = leftGap;
        [self setUI];
        
        if (!isSecured) {
            self.secureButotn.hidden = YES;
        }
    }
    return self;
}

#pragma mark - ui

-(void)setUI
{
    [self addSubview:self.titleLab];
    [self addSubview:self.textField];
    [self addSubview:self.secureButotn];
    [self addSubview:self.lineView];
}

-(UILabel *)titleLab
{
    if (nil == _titleLab) {
        
        _titleLab = [[UILabel alloc]initWithFrame:CGRectMake(ScaleW(0), 0, _titleWidth, self.height)];
        _titleLab.text = SSKJLocalized(_imageName, nil);
        _titleLab.font= systemFont(ScaleW(15));
        _titleLab.textColor = kMainTextColor;
        _titleLab.centerY = self.height / 2;
    }
    return _titleLab;
}



-(UITextField *)textField
{
    if (nil == _textField) {
        _textField = [[UITextField alloc]initWithFrame:CGRectMake(self.titleLab.right + _leftGap, 0, self.width - self.titleLab.right - _leftGap -(_isSecured?self.secureButotn.width:0) , self.height - 1)];
        _textField.textColor = kMainTextColor;
        _textField.font = systemFont(ScaleW(14));
//        _textField.placeholder = _placeHolder;
        
        _textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString: _placeHolder attributes:@{NSForegroundColorAttributeName: kGrayTitleColor}];

        
        _textField.keyboardType = _keyboardType;
//        [_textField setValue:UIColorFromARGB(0xffffff, .5) forKeyPath:@"_placeholderLabel.textColor"];
        _textField.secureTextEntry = _isSecured;
    }
    return _textField;
}

-(UIButton *)secureButotn
{
    if (nil == _secureButotn) {
        _secureButotn = [UIButton buttonWithType:UIButtonTypeCustom];
        _secureButotn.frame = CGRectMake(self.width - ScaleW(44), 0, ScaleW(44), self.height);
        [_secureButotn setImage:SSKJIMAGE_NAMED(@"eye_no") forState:UIControlStateNormal];
       
//        [_secureButotn setImage:SSKJIMAGE_NAMED(@"psw_show_login") forState:UIControlStateSelected];
        [_secureButotn addTarget:self action:@selector(secureEvent) forControlEvents:UIControlEventTouchUpInside];
//        _secureButotn.selected = NO;
    }
    return _secureButotn;
}

-(UIView *)lineView
{
    if (nil == _lineView) {
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(0, self.height - 0.5, self.width, ScaleW(1))];
        _lineView.backgroundColor = kLineGrayColor;
    }
    return _lineView;
    
}


-(void)secureEvent
{
    
    _isSecured = !_isSecured;
    
    if (_isSecured) {
        
        [_secureButotn setImage:SSKJIMAGE_NAMED(@"eye_no") forState:UIControlStateNormal];

    }
    else
    {
        [_secureButotn setImage:SSKJIMAGE_NAMED(@"eye_yes") forState:UIControlStateNormal];

    }
//    self.secureButotn.selected = !self.secureButotn.selected;
    self.textField.secureTextEntry = _isSecured;
}

-(NSString *)valueString
{
    return self.textField.text;
}

-(void)setValueString:(NSString *)valueString
{
    _valueString = valueString;
    self.textField.text = valueString;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
