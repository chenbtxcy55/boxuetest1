//
//  BBTrade_PriceView.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/1/15.
//  Copyright © 2019年 James. All rights reserved.
//

#import "BBTrade_PriceView.h"

// tools
#import "UITextField+Helper.h"

@interface BBTrade_PriceView ()<UITextFieldDelegate>
@property (nonatomic, strong) UITextField *priceTextField;
@property (nonatomic, strong) UILabel *currentPriceLabel;
@property (nonatomic, strong) UIButton *addButton;                  // 加按钮
@property (nonatomic, strong) UIButton *minusButton;                // 减按钮
@end

@implementation BBTrade_PriceView
@synthesize price = _price;
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.addButton];
        [self addSubview:self.minusButton];
        [self addSubview:self.priceTextField];
        [self addSubview:self.currentPriceLabel];
        self.priceType = PriceTypeMarket;
        self.layer.borderColor = kTextDarkBlueColor.CGColor;
        self.layer.borderWidth = 0.5;
        self.backgroundColor = UIColorFromRGB(0x2d2e56);
    }
    return self;
}


-(UIButton *)addButton
{
    if (nil == _addButton) {
        _addButton = [[UIButton alloc]initWithFrame:CGRectMake(self.width - ScaleW(30), 0, ScaleW(30), self.height)];
        [_addButton setTitleColor:kTextLightBlueColor forState:UIControlStateNormal];
        [_addButton setTitle:@"+" forState:UIControlStateNormal];
        _addButton.backgroundColor = kSubBackgroundColor;
        [_addButton addTarget:self action:@selector(addPrice) forControlEvents:UIControlEventTouchUpInside];
        _addButton.hidden = YES;
    }
    return _addButton;
}

-(UIButton *)minusButton
{
    if (nil == _minusButton) {
        _minusButton = [[UIButton alloc]initWithFrame:CGRectMake(self.addButton.x - ScaleW(30), 0, ScaleW(30), self.height)];
        [_minusButton setTitleColor:kTextLightBlueColor forState:UIControlStateNormal];
        [_minusButton setTitle:@"-" forState:UIControlStateNormal];
        _minusButton.backgroundColor = kSubBackgroundColor;
        [_minusButton addTarget:self action:@selector(reducePrice) forControlEvents:UIControlEventTouchUpInside];
        _minusButton.hidden = YES;

    }
    return _minusButton;
}

-(UITextField *)priceTextField
{
    if (nil == _priceTextField) {
        _priceTextField = [[UITextField alloc]initWithFrame:CGRectMake(ScaleW(5), 0, self.minusButton.x - ScaleW(5), self.height)];
//        _priceTextField.backgroundColor = kSubBackgroundColor;
        _priceTextField.font = systemFont(ScaleW(14));
        _priceTextField.textColor = kMainWihteColor;
        _priceTextField.placeholder = SSKJLocalized(@"请输入价格",nil);
//        [_priceTextField setValue:kTextDarkBlueColor forKeyPath:@"_placeholderLabel.textColor"];
        
        NSMutableAttributedString *placeholderString1 = [[NSMutableAttributedString alloc] initWithString: SSKJLocalized(@"请输入价格",nil) attributes:@{NSForegroundColorAttributeName : kTextDarkBlueColor}];
        
        
        _priceTextField.attributedPlaceholder = placeholderString1;
        _priceTextField.keyboardType = UIKeyboardTypeDecimalPad;
        _priceTextField.hidden = YES;
        _priceTextField.delegate = self;
        [_priceTextField addTarget:self action:@selector(inputChanged) forControlEvents:UIControlEventEditingChanged];
    }
    return _priceTextField;
}

-(UILabel *)currentPriceLabel
{
    if (nil == _currentPriceLabel) {
        _currentPriceLabel = [WLTools allocLabel:SSKJLocalized(@"以当前最优交易价格",nil) font:systemFont(ScaleW(12)) textColor:kTextLightBlueColor frame:CGRectMake(ScaleW(5), 0, self.width - ScaleW(5), self.height) textAlignment:NSTextAlignmentLeft];
        _currentPriceLabel.backgroundColor = [UIColor clearColor];
    }
    return _currentPriceLabel;
}

-(void)setPriceType:(PriceType)priceType
{
    _priceType = priceType;
    if (_priceType == PriceTypeMarket) {
        self.currentPriceLabel.hidden = NO;
        self.addButton.hidden = YES;
        self.minusButton.hidden = YES;
        self.priceTextField.hidden = YES;
        self.backgroundColor = UIColorFromRGB(0x2d2e56);
    }else{
        self.currentPriceLabel.hidden = YES;
        self.addButton.hidden = NO;
        self.minusButton.hidden = NO;
        self.priceTextField.hidden = NO;
        self.backgroundColor = [UIColor clearColor];
    }
}

-(void)addPrice
{
    double number = pow(10, -self.dotNumber);
    double price = self.priceTextField.text.doubleValue + number;
    self.priceTextField.text = [NSString stringWithFormat:@"%@",[WLTools roundingStringWith:price afterPointNumber:self.dotNumber]];
    
    [self inputChanged];
}

-(void)reducePrice
{
    double number = pow(10, -self.dotNumber);

    double price = self.priceTextField.text.doubleValue - number;
    if (price < 0) {
        price = 0;
    }
    self.priceTextField.text = [NSString stringWithFormat:@"%@",[WLTools roundingStringWith:price afterPointNumber:self.dotNumber]];
    
    [self inputChanged];

}

-(NSString *)price
{
    return self.priceTextField.text;
}

-(void)setPrice:(NSString *)price
{
    self.priceTextField.text = [WLTools roundingStringWith:price.doubleValue afterPointNumber:self.dotNumber];
}


#pragma mark - UITextFieldDelegate

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    return [textField textFieldShouldChangeCharactersInRange:range replacementString:string dotNumber:self.dotNumber];
}

-(void)inputChanged
{
    if (self.priceChangeBlock) {
        self.priceChangeBlock(self.priceTextField.text);
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
