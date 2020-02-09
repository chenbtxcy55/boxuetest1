//
//  My_InputView.m
//  ZYW_MIT
//
//  Created by 刘小雨 on 2019/3/28.
//  Copyright © 2019年 Wang. All rights reserved.
//

#import "My_InputView.h"

@interface My_InputView ()

@property (nonatomic, strong) UIView *lineView;

@end

@implementation My_InputView


@synthesize valueString = _valueString;
-(instancetype)initWithFrame:(CGRect)frame placeHolder:(NSString *)placeHolder keyboardType:(UIKeyboardType)keyboardType isSecured:(BOOL)isSecured
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = kSubBackgroundColor;
        [self addSubview:self.titleLB];
        [self addSubview:self.textField];
        self.textField.placeholder = placeHolder;
        self.textField.keyboardType = keyboardType;
        self.textField.secureTextEntry = isSecured;
        [_textField setValue:[UIColor colorWithHexStringToColor:@"5b5e95"] forKeyPath:@"_placeholderLabel.textColor"];

        [self addSubview:self.lineView];
        [self addSubview:self.secretButton];
    }
    return self;
}

- (UILabel *)titleLB {
    if (!_titleLB) {
        _titleLB = [[UILabel alloc]initWithFrame:CGRectMake(ScaleW(17), 0, ScaleW(90), self.height)];
        _titleLB.font = [UIFont systemFontOfSize:ScaleW(15)];
        _titleLB.textColor = [UIColor colorWithHexStringToColor:@"b3b7e9"];
    }
    return _titleLB;
}

-(UITextField *)textField
{
    if (nil == _textField) {
        _textField = [[UITextField alloc]initWithFrame:CGRectMake(self.titleLB.right+ScaleW(12), 0, self.width-ScaleW(100), self.height - 1)];
        _textField.textColor = kMainWihteColor;

        _textField.font = [UIFont systemFontOfSize:ScaleW(14)];
    }
    return _textField;
}

-(UIView *)lineView
{
    if (nil == _lineView) {
        _lineView = [[UITextField alloc]initWithFrame:CGRectMake(ScaleW(17), self.height - 1, self.width - ScaleW(12), 0.5)];
        _lineView.backgroundColor = kLineGrayColor;
    }
    return _lineView;
}

-(UIButton *)secretButton
{
    if (nil == _secretButton) {
        _secretButton = [[UIButton alloc]initWithFrame:CGRectMake(self.width - ScaleW(42), 0, ScaleW(30), ScaleW(30))];
        [_secretButton setImage:[UIImage imageNamed:@"hidden"] forState:UIControlStateNormal];
        [_secretButton setImage:[UIImage imageNamed:@"show"] forState:UIControlStateSelected];
        [_secretButton addTarget:self action:@selector(showOrHideText) forControlEvents:UIControlEventTouchUpInside];
        _secretButton.centerY = self.height / 2.0f;
        
    }
    return _secretButton;
}

-(NSString *)valueString
{
    NSString *string = self.textField.text;
    if (string.length == 0) {
        string = @"";
    }
    return string;
}

//
//-(void)textFieldDidBeginEditing:(UITextField *)textField
//{
//    self.lineView.backgroundColor = [UIColor colorWithHexString:@"#4E6993"];
//}
//
//-(void)textFieldDidEndEditing:(UITextField *)textField
//{
//    self.lineView.backgroundColor = [UIColor colorWithHexString:@"#D0D9DE"];
//}

-(void)showOrHideText
{
    self.secretButton.selected = !self.secretButton.selected;
    self.textField.secureTextEntry = !(self.secretButton.selected);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
