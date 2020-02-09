//
//  My_TitleAndInput_View.m
//  ZYW_MIT
//
//  Created by 刘小雨 on 2019/3/28.
//  Copyright © 2019年 Wang. All rights reserved.
//

#import "My_TitleAndInput_View.h"

@interface My_TitleAndInput_View ()



@property (nonatomic, strong) UIView *lineView;
@end

@implementation My_TitleAndInput_View

@synthesize valueString = _valueString;

-(instancetype)initWithFrame:(CGRect )frame title:(NSString *)title placeHolder:(NSString *)placeHolder keyBoardType:(UIKeyboardType)keyBoardType
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = kNavBGColor;
        
        [self addSubview:self.titleLabel];
        [self addSubview:self.textField];
        [self addSubview:self.lineView];
        [self.textField setPlaceholder:placeHolder];
        [self.textField setKeyboardType:keyBoardType];
        
        #pragma mark 重置Frame
        [self.titleLabel setFrame:CGRectMake(ScaleW(10), ScaleW(10), frame.size.width-ScaleW(20), ScaleW(30))];
        [self.textField setFrame:CGRectMake(self.titleLabel.left, self.titleLabel.bottom+ScaleW(10), self.titleLabel.width, ScaleW(40))];
//         [self.textField setValue:UIColorFromRGB(0xb5b8c2) forKeyPath:@"_placeholderLabel.textColor"];
        
        
        NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:placeHolder attributes:
                                          @{NSForegroundColorAttributeName:UIColorFromRGB(0xb5b8c2),
                                            }];
        self.textField.attributedPlaceholder = attrString;
        [self.lineView setFrame:CGRectMake(self.titleLabel.left, frame.size.height-ScaleW(0.5), self.titleLabel.width, ScaleW(0.5))];
        
        [self addSubview:self.secureButton];

        #pragma mark 赋值
        [self.titleLabel setText:SSKJLocalized(title, nil)];
    }
    return self;
}


-(UILabel *)titleLabel
{
    
    if (nil == _titleLabel)
    {
        _titleLabel  = [[UILabel alloc]init];
        [_titleLabel setTextColor:kMainWihteColor];
        [_titleLabel setFont:systemFont(ScaleW(16.0))];
    }
    return _titleLabel;
}

-(UITextField *)textField
{
    if (nil == _textField)
    {
        _textField = [[UITextField alloc]init];
        _textField.textColor = kMainWihteColor;
        _textField.font = systemFont(ScaleW(15));

       
    }
    return _textField;
}

-(UIView *)lineView
{
    if (nil == _lineView)
    {
        _lineView = [[UIView alloc]init];
        [_lineView setBackgroundColor:kLineGrayColor];
    }
    return _lineView;
}
-(UIButton *)secureButton
{
    if (nil == _secureButton) {
        _secureButton = [[UIButton alloc]initWithFrame:CGRectMake(self.width - ScaleW(30) - ScaleW(15), 0, ScaleW(30), ScaleW(15))];
        _secureButton.centerY = self.textField.centerY;
        [_secureButton setImage:[UIImage imageNamed:@"eye_no"] forState:UIControlStateNormal];
        [_secureButton setImage:[UIImage imageNamed:@"eye_yes"] forState:UIControlStateSelected];
        [_secureButton addTarget:self action:@selector(showPWD) forControlEvents:UIControlEventTouchUpInside];
        _secureButton.hidden = true;
    }
    return _secureButton;
}
-(void)showPWD
{
    self.secureButton.selected = !self.secureButton.selected;
    self.textField.secureTextEntry = !self.secureButton.selected;
}
-(NSString *)valueString
{
    return self.textField.text;
}

-(void)setValueString:(NSString *)valueString
{
    self.textField.text = valueString;
}


@end
