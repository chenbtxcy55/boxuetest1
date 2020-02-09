//
//  BBTrade_NumberView.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/1/15.
//  Copyright © 2019年 James. All rights reserved.
//

#import "BBTrade_NumberView.h"
#import "UITextField+Helper.h"

@interface BBTrade_NumberView ()<UITextFieldDelegate>
@property (nonatomic, strong) UILabel *numberTitleLabel;
@end
@implementation BBTrade_NumberView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        [self addSubview:self.numberTitleLabel];
        [self addSubview:self.unitLabel];
        [self addSubview:self.numberTextField];
        
        self.layer.borderColor = kTextDarkBlueColor.CGColor;
        self.layer.borderWidth = 0.5;
//        self.backgroundColor = kMainBackgroundColor;
        
    }
    return self;
}

-(UILabel *)numberTitleLabel
{
    if (nil == _numberTitleLabel) {
        _numberTitleLabel = [WLTools allocLabel:SSKJLocalized(@"数量",nil) font:systemFont(ScaleW(13)) textColor:kTextDarkBlueColor frame:CGRectMake(ScaleW(5), 0, ScaleW(30), self.height) textAlignment:NSTextAlignmentLeft];
        _numberTextField.keyboardType = UIKeyboardTypeDecimalPad;
    }
    return _numberTitleLabel;
}

- (UILabel *)unitLabel
{
    if (nil == _unitLabel) {
        _unitLabel = [WLTools allocLabel:SSKJLocalized(@"AB", nil) font:systemFont(ScaleW(11)) textColor:kTextLightBlueColor frame:CGRectMake(self.width - ScaleW(5) - ScaleW(35), 0, ScaleW(35), self.height) textAlignment:NSTextAlignmentRight];
    }
    return _unitLabel;
}

-(UITextField *)numberTextField
{
    if (nil == _numberTextField) {
        _numberTextField = [[UITextField alloc]initWithFrame:CGRectMake(self.numberTitleLabel.right + ScaleW(5), 0, self.unitLabel.x - self.numberTitleLabel.right - ScaleW(10), self.height)];
        _numberTextField.textColor = kMainWihteColor;
        _numberTextField.font = systemFont(ScaleW(13));
        _numberTextField.keyboardType = UIKeyboardTypeDecimalPad;
        _numberTextField.delegate = self;
        [_numberTextField addTarget:self action:@selector(inputChanged:) forControlEvents:UIControlEventEditingChanged];
    }
    return _numberTextField;
}

#pragma mark - UITextFieldDelegate

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == self.numberTextField) {
        return [textField textFieldShouldChangeCharactersInRange:range replacementString:string dotNumber:self.dotNumber];
    }else{
        return YES;
    }
}


-(void)inputChanged:(UITextField *)textField
{
    textField.text = [self deleteFirstZero:textField.text];
    
    if (self.numberChangeBlock) {
        self.numberChangeBlock(textField.text);
    }
}



// 出去首位0
-(NSString *)deleteFirstZero:(NSString *)string
{
    if (![string hasPrefix:@"0"] || [string isEqualToString:@"0"] || [string hasPrefix:@"0."]) {
        
        return string;
    }else{
        return [self deleteFirstZero:[string substringFromIndex:1]];
    }
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
