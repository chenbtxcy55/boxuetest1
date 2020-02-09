//
//  HeBi_BuySell_AlertView.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/4/12.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "HeBi_BuySell_AlertView.h"
#import "HeBi_FBC_SegmentView.h"

// tools
#import "UITextField+Helper.h"

#define kBorderColor UIColorFromRGB(0xf5f5f5)


typedef NS_ENUM(NSUInteger, AmountType) {
    AmountTypeFBC,      // 法币计价
    AmountTypeAmount,   // 数量计价
};

@interface HeBi_BuySell_AlertView ()<UITextFieldDelegate>
@property (nonatomic, strong) UIView *alertView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *priceLabel;

@property (nonatomic, strong) UIView *typeBackView;
@property (nonatomic, strong) HeBi_FBC_SegmentView *segmentView;

@property (nonatomic, strong) UIView *amountBackView;
@property (nonatomic, strong) UIButton *allButton;  // 全部购买按钮
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UILabel *unitLabel;   //单位
@property (nonatomic, strong) UITextField *amountTextField;
@property (nonatomic, strong) UILabel *limitLabel;  // 限额
@property (nonatomic, strong) UILabel *balanceLabel;    // 可用AB
@property (nonatomic, strong) UIView *pwdBackView;
@property (nonatomic, strong) UITextField *pwdTextField;    // 交易密码
@property (nonatomic, strong) UILabel *totalTitleLabel;
@property (nonatomic, strong) UILabel *totalValueLabel;  // 交易金额

@property (nonatomic, strong) UIButton *confirmButton;  // 确认按钮

@property (nonatomic, strong) UIButton *cancelButton;  // 取消按钮

@property (nonatomic, assign) AmountType amountType;    // 计价方式

@property (nonatomic, strong) JB_FBC_DealHall_OrderModel *model;

@property (nonatomic, assign) double balance;    // 余额


@property (nonatomic, assign) double totalPrice;    // 总金额

@property (nonatomic, assign) BuySellType type ;

@end

@implementation HeBi_BuySell_AlertView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
        [self setUI];
        self.amountType = AmountTypeFBC;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(screenTap)];
        [self addGestureRecognizer:tap];
        self.userInteractionEnabled = YES;
        // 添加通知监听见键盘弹出/退出// 键盘出现的通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardDidShowNotification object:nil];
        // 键盘消失的通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHiden:) name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}


-(void)setUI
{
    [self addSubview:self.alertView];
    [self.alertView addSubview:self.titleLabel];
    [self.alertView addSubview:self.priceLabel];
    [self.alertView addSubview:self.typeBackView];
    [self.typeBackView addSubview:self.segmentView];
    [self.alertView addSubview:self.amountBackView];
    [self.amountBackView addSubview:self.allButton];
    [self.amountBackView addSubview:self.lineView];
    [self.amountBackView addSubview:self.unitLabel];
    [self.amountBackView addSubview:self.amountTextField];
    [self.alertView addSubview:self.limitLabel];
    [self.alertView addSubview:self.balanceLabel];
    [self.alertView addSubview:self.pwdBackView];
    [self.pwdBackView addSubview:self.pwdTextField];
//    [self.alertView addSubview:self.totalTitleLabel];
//    [self.alertView addSubview:self.totalValueLabel];
    [self.alertView addSubview:self.confirmButton];
    [self.alertView addSubview:self.cancelButton];

    self.alertView.height = self.confirmButton.bottom + ScaleW(13);
    
}

- (UIView *)alertView
{
    if (nil == _alertView) {
        _alertView = [[UIView alloc]initWithFrame:CGRectMake(0, self.height, ScreenWidth, 0)];
        _alertView.backgroundColor = [UIColor whiteColor];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(editEndEvent)];
        
        [_alertView addGestureRecognizer:tap];
    }
    return _alertView;
}

-(void)editEndEvent
{
    [self endEditing:YES];
}

- (UILabel *)titleLabel
{
    if (nil == _titleLabel) {
       
        _titleLabel = [WLTools allocLabel:SSKJLocalized(@"购买ISCM", nil) font:systemBoldFont(ScaleW(16)) textColor: kMainTextColor frame:CGRectMake(ScaleW(15), 15, ScaleW(300), ScaleW(16)) textAlignment:NSTextAlignmentLeft];
    }
    return _titleLabel;
}

-(UILabel *)priceLabel
{
    if (nil == _priceLabel) {
        _priceLabel = [WLTools allocLabel:@"单价：¥2，990.00" font:systemFont(ScaleW(12)) textColor:kSubTitleColor frame:CGRectMake(self.titleLabel.x, self.titleLabel.bottom + ScaleW(11.5), self.titleLabel.width, ScaleW(12)) textAlignment:NSTextAlignmentLeft];
    }
    return _priceLabel;
}

- (UIView *)typeBackView
{
    if (nil == _typeBackView) {
        _typeBackView = [[UIView alloc]initWithFrame:CGRectMake(0, self.priceLabel.bottom + ScaleW(16), ScreenWidth, ScaleW(40))];
        _typeBackView.backgroundColor = kBorderColor;
    }
    return _typeBackView;
}

-(HeBi_FBC_SegmentView *)segmentView
{
    if (nil == _segmentView) {
        _segmentView = [[HeBi_FBC_SegmentView alloc]initWithFrame:CGRectMake(ScaleW(15), 0, ScaleW(120), self.typeBackView.height)];
//        WS(weakSelf);
//        _segmentView.segmentBlock = ^(NSInteger index) {
//            if (index == 0) {
//                weakSelf.amountType = AmountTypeFBC;
//                if (self.type == BuySellTypeBuy) {
//                    weakSelf.amountTextField.placeholder = SSKJLocalized(@"请输入购买法币金额", nil);
//                }else{
//                    weakSelf.amountTextField.placeholder = SSKJLocalized(@"请输入出售法币金额", nil);
//                }
//                weakSelf.unitLabel.text = @"CNY";
////                weakSelf.balanceLabel.hidden = NO;
//            }else{
//                weakSelf.amountType = AmountTypeAmount;
//                if (self.type == BuySellTypeBuy) {
//                    weakSelf.amountTextField.placeholder = SSKJLocalized(@"请输入购买AB数量", nil);
//                }else{
//                    weakSelf.amountTextField.placeholder = SSKJLocalized(@"请输入出售AB数量", nil);
//                }
//                weakSelf.unitLabel.text = @"AB";
////                weakSelf.balanceLabel.hidden = YES;
//            }
//
//            weakSelf.amountTextField.text = nil;
//            weakSelf.totalValueLabel.text = @"¥0";
//        };
    }
    return _segmentView;
}

-(UIView *)amountBackView
{
    if (nil == _amountBackView) {
        _amountBackView = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(15), self.typeBackView.bottom + ScaleW(10), ScreenWidth - ScaleW(30), ScaleW(45))];
        _amountBackView.layer.cornerRadius = 4.0f;
        _amountBackView.layer.borderColor = kBorderColor.CGColor;
        _amountBackView.layer.borderWidth = 0.5;
    }
    return _amountBackView;
}

-(UIButton *)allButton
{
    if (nil == _allButton) {
        _allButton = [[UIButton alloc]initWithFrame:CGRectMake(self.amountBackView.width - ScaleW(15) - ScaleW(60), 0, ScaleW(60), self.amountBackView.height)];
        [_allButton setTitle:SSKJLocalized(@"全部购买", nil) forState:UIControlStateNormal];
        [_allButton setTitleColor: kMainBlueColor forState:UIControlStateNormal];
        _allButton.titleLabel.font = systemBoldFont(ScaleW(14));
        [_allButton addTarget:self action:@selector(allEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _allButton;
}


-(UIView *)lineView
{
    if (nil == _lineView) {
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(self.allButton.x - ScaleW(15), 0, 0.5, ScaleW(13))];
        _lineView.backgroundColor = kBorderColor;
        _lineView.centerY = self.allButton.centerY;
    }
    return _lineView;
}

-(UILabel *)unitLabel
{
    if (nil == _unitLabel) {
        _unitLabel = [WLTools allocLabel:@"ISCM" font:systemFont(ScaleW(14)) textColor: kGrayTitleColor frame:CGRectMake(self.lineView.x - ScaleW(5) - ScaleW(38), 0, ScaleW(38), self.amountBackView.height) textAlignment:NSTextAlignmentCenter];
    }
    return _unitLabel;
}

-(UITextField *)amountTextField
{
    if (nil == _amountTextField) {
        _amountTextField = [[UITextField alloc]initWithFrame:CGRectMake(ScaleW(10), 0, self.unitLabel.x - ScaleW(15), self.amountBackView.height)];
        _amountTextField.textColor = kSubTitleColor;
        _amountTextField.placeholder = SSKJLocalized(@"请输入购买数量", nil);
//        [_amountTextField setValue:kGrayTitleColor forKeyPath:@"_placeholderLabel.textColor"];
//
        NSMutableAttributedString *placeholderString1 = [[NSMutableAttributedString alloc] initWithString: SSKJLocalized(@"请输入购买数量", nil) attributes:@{NSForegroundColorAttributeName : kGrayTitleColor}];
        

        _amountTextField.attributedPlaceholder = placeholderString1;
        
        _amountTextField.font = systemFont(ScaleW(12));
        _amountTextField.keyboardType = UIKeyboardTypeDecimalPad;
        _amountTextField.delegate = self;
        [_amountTextField addTarget:self action:@selector(inputChanged:) forControlEvents:UIControlEventEditingChanged];
    }
    return _amountTextField;
}

-(UILabel *)limitLabel
{
    if (nil == _limitLabel) {
        _limitLabel = [WLTools allocLabel:@"限额 ¥1,000.00-¥43,333.00" font:systemFont(ScaleW(12)) textColor:kGrayTitleColor frame:CGRectMake(self.amountBackView.x, self.amountBackView.bottom + ScaleW(15), self.amountBackView.width, ScaleW(14)) textAlignment:NSTextAlignmentLeft];
    }
    return _limitLabel;
}

-(UILabel *)balanceLabel
{
    if (nil == _balanceLabel) {
        _balanceLabel = [WLTools allocLabel:@"实际购买 0 ISCM" font:systemFont(ScaleW(12)) textColor: kGrayTitleColor frame:CGRectMake(self.amountBackView.x, self.limitLabel.top, self.amountBackView.width, ScaleW(11)) textAlignment:NSTextAlignmentRight];
    }
    return _balanceLabel;
}

-(UIView *)pwdBackView
{
    if (nil == _pwdBackView) {
        _pwdBackView = [[UIView alloc]initWithFrame:CGRectMake(self.amountBackView.x, self.limitLabel.bottom + ScaleW(15), self.amountBackView.width, self.amountBackView.height)];
        
        _pwdBackView.layer.cornerRadius = 4.0f;
        _pwdBackView.layer.borderColor = kBorderColor.CGColor;
        _pwdBackView.layer.borderWidth = 0.5;
    }
    return _pwdBackView;
}


-(UITextField *)pwdTextField
{
    if (nil == _pwdTextField) {
        _pwdTextField = [[UITextField alloc]initWithFrame:CGRectMake(ScaleW(10), 0, self.pwdBackView.width - ScaleW(20), self.pwdBackView.height)];
        _pwdTextField.secureTextEntry = YES;
        _pwdTextField.textColor =  kSubTitleColor;
        _pwdTextField.placeholder = SSKJLocalized(@"请输入安全密码", nil);
//        [_pwdTextField setValue:kGrayTitleColor forKeyPath:@"_placeholderLabel.textColor"];
//
        
        NSMutableAttributedString *placeholderString1 = [[NSMutableAttributedString alloc] initWithString: SSKJLocalized(@"请输入安全密码", nil) attributes:@{NSForegroundColorAttributeName : kGrayTitleColor}];
        
        _pwdTextField.attributedPlaceholder = placeholderString1;
        
        _pwdTextField.font = systemFont(ScaleW(12));
        _pwdTextField.delegate = self;
    }
    return _pwdTextField;
}

-(UILabel *)totalTitleLabel
{
    if (nil == _totalTitleLabel) {
        _totalTitleLabel = [WLTools allocLabel:SSKJLocalized(@"交易金额", nil) font:systemFont(ScaleW(13.5)) textColor:kTextDarkBlueColor frame:CGRectMake(self.pwdBackView.x, self.pwdBackView.bottom + ScaleW(17), ScreenWidth / 2 - ScaleW(15), ScaleW(14)) textAlignment:NSTextAlignmentLeft];
    }
    return _totalTitleLabel;
}


-(UILabel *)totalValueLabel
{
    if (nil == _totalValueLabel) {
        _totalValueLabel = [WLTools allocLabel:SSKJLocalized(@"¥0.00", nil) font:systemFont(ScaleW(13.5)) textColor: kMainTextColor frame:CGRectMake(ScreenWidth / 2, self.pwdBackView.bottom + ScaleW(17), ScreenWidth / 2 - ScaleW(15), ScaleW(14)) textAlignment:NSTextAlignmentRight];
    }
    return _totalValueLabel;
}

- (UIButton *)cancelButton{
 
    if (nil == _cancelButton) {
        
        _cancelButton = [[UIButton alloc]initWithFrame:CGRectMake(ScaleW(15), self.pwdBackView.bottom + ScaleW(15), (ScreenWidth - ScaleW(55)) * 0.5, ScaleW(45))];
        [_cancelButton setTitle:SSKJLocalized(@"取消", nil) forState:UIControlStateNormal];
        [_cancelButton setTitleColor:kMainBlueColor forState:UIControlStateNormal];
        _cancelButton.titleLabel.font = systemFont(ScaleW(15));
        _cancelButton.layer.masksToBounds = YES;
        _cancelButton.layer.cornerRadius = 4.0f;
        _cancelButton.layer.borderColor = kMainBlueColor.CGColor;
        _cancelButton.layer.borderWidth = 1;
        [_cancelButton addTarget:self action:@selector(cancelEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}


- (UIButton *)confirmButton
{
    if (nil == _confirmButton) {
        
        _confirmButton = [[UIButton alloc]initWithFrame:CGRectMake(self.cancelButton.maxX + ScaleW(25), self.cancelButton.y, self.cancelButton.width, self.cancelButton.height)];
        [_confirmButton setTitle:SSKJLocalized(@"下单", nil) forState:UIControlStateNormal];
        [_confirmButton setTitleColor:kMainWihteColor forState:UIControlStateNormal];
        _confirmButton.titleLabel.font = systemBoldFont(ScaleW(15));
        _confirmButton.layer.masksToBounds = YES;
        _confirmButton.layer.cornerRadius = 4.0f;
        _confirmButton.backgroundColor = kMainBlueColor;
        [_confirmButton addTarget:self action:@selector(confirmEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmButton;
}

#pragma mark - UITextFieldDelegate

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == self.amountTextField) {
        if (self.amountType == AmountTypeFBC) {
            return [textField textFieldShouldChangeCharactersInRange:range replacementString:string dotNumber:2];
        }else{
            return [textField textFieldShouldChangeCharactersInRange:range replacementString:string dotNumber:2];
        }
    }else{
        return YES;
    }
}


-(void)inputChanged:(UITextField *)textField
{
    textField.text = [self deleteFirstZero:textField.text];
    
    self.amountType = AmountTypeAmount;
    if (self.amountType == AmountTypeFBC) {
        self.totalValueLabel.text = [NSString stringWithFormat:@"¥%@",textField.text];
        self.totalPrice = textField.text.doubleValue;
        
        double ABAmount = textField.text.doubleValue / self.model.price.doubleValue;
        
        if (self.type == BuySellTypeBuy) {
            self.balanceLabel.text = [NSString stringWithFormat:@"%@%@ ISCM",SSKJLocalized(@"实际购买", nil),[WLTools noroundingStringWith:ABAmount afterPointNumber:2]];

        }else{
            self.balanceLabel.text = [NSString stringWithFormat:@"%@%@ ISCM",SSKJLocalized(@"实际出售", nil),[WLTools noroundingStringWith:ABAmount afterPointNumber:2]];

        }
        
    }else{
        double price = self.model.price.doubleValue;
        double totalPrice = price * self.amountTextField.text.doubleValue;
        self.totalPrice = totalPrice;
        self.totalValueLabel.text = [NSString stringWithFormat:@"¥%@",[WLTools noroundingStringWith:totalPrice afterPointNumber:4]];
        
        NSString *ABAmount = textField.text;

        if (self.type == BuySellTypeBuy) {
            self.balanceLabel.text = [NSString stringWithFormat:@"%@%@ ISCM",SSKJLocalized(@"实际购买", nil),ABAmount];
        }else{
            //手续费
            double rate = [[SSKJ_User_Tool sharedUserTool].userInfoModel.sxfee doubleValue] * 0.01;
            
            
            self.balanceLabel.text = [NSString stringWithFormat:@"%@%.4f ISCM",SSKJLocalized(@"实际出售", nil),[ABAmount doubleValue] * (1 - rate)];
        }

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

#pragma mark - 用户操作

#pragma mark - 全部购买、全部出售
-(void)allEvent
{
    self.amountType = AmountTypeAmount;
    if (self.amountType == AmountTypeFBC) {
        
        
        double shengyu = self.model.amount.doubleValue * self.model.price.doubleValue;
        
        if (shengyu < self.model.min_price.doubleValue) {
            self.amountTextField.text = [WLTools noroundingStringWith:self.model.min_price.doubleValue afterPointNumber:2];

        }else if (shengyu < self.model.max_price.doubleValue) {
                self.amountTextField.text = [WLTools noroundingStringWith:shengyu afterPointNumber:2];

        }else{
            self.amountTextField.text = [WLTools noroundingStringWith:self.model.max_price.doubleValue afterPointNumber:2];
        }

        
        double ABAmount = self.amountTextField.text.doubleValue / self.model.price.doubleValue;
        self.balanceLabel.text = [NSString stringWithFormat:@"%@ AB",[WLTools noroundingStringWith:ABAmount afterPointNumber:2]];
        
    }else{
        
        double shengyu = self.model.amount.doubleValue * self.model.price.doubleValue;
        
        if (shengyu < self.model.min_price.doubleValue) {
            self.amountTextField.text = [WLTools noroundingStringWith:self.model.min_price.doubleValue / self.model.price.doubleValue afterPointNumber:4];
        } if (shengyu < self.model.max_price.doubleValue) {
            self.amountTextField.text = [WLTools noroundingStringWith:self.model.amount.doubleValue afterPointNumber:4];
        }else{
            
            self.amountTextField.text = [WLTools noroundingStringWith:self.model.max_price.doubleValue / self.model.price.doubleValue afterPointNumber:2];
        }
        
    }
    
    [self inputChanged:self.amountTextField];
}


#pragma mark 下单

-(void)confirmEvent
{
    
    if (self.amountTextField.text.length == 0) {
//        if (self.amountType == AmountTypeFBC) {
//            [MBProgressHUD showError:SSKJLocalized(@"请输入法币金额", nil)];
//        }else{
            [MBProgressHUD showError:SSKJLocalized(@"请输入数量", nil)];
//        }
        return;
    }
    
//    if (self.type == BuySellTypeSell) {
//        NSString *number = self.amountTextField.text;
//        if (self.amountType == AmountTypeFBC) {
//            number = [WLTools noroundingStringWith:number.doubleValue / self.model.price.doubleValue afterPointNumber:2];
//        }
//        if (number.doubleValue < 20) {
//            [MBProgressHUD showError:SSKJLocalized(@"出售数量不能低于20AB", nil)];
//            return;
//        }
//    }
    
//    if (self.totalPrice > self.model.max_price.doubleValue || self.totalPrice < self.model.min_price.doubleValue) {
//        [MBProgressHUD showError:SSKJLocalized(@"超出限额", nil)];
//        return;
//    }
    
    if (self.pwdTextField.text.length == 0 && self.type == BuySellTypeSell) {
        [MBProgressHUD showError:SSKJLocalized(@"请输入安全密码", nil)];
        return;
    }
    
    NSString *type = @"1";
    if (self.type == BuySellTypeSell) {
        type = @"2";
    }
    
    NSString *number = self.amountTextField.text;
//    if (self.amountType == AmountTypeFBC) {
//        number = [WLTools noroundingStringWith:number.doubleValue / self.model.price.doubleValue afterPointNumber:2];
//    }
    
    
    NSString *totalPrice = self.amountTextField.text;
    
    if (totalPrice.doubleValue > _model.amount.doubleValue ) {
        [CMRemind error:@"购买总量超过订单数量"];
        return;
    }
    
    if (self.amountType == AmountTypeAmount) {
        totalPrice = [WLTools noroundingStringWith:totalPrice.doubleValue * self.model.price.doubleValue afterPointNumber:4];
    }
    if (totalPrice.doubleValue < _model.min_price.doubleValue || totalPrice.doubleValue > _model.max_price.doubleValue ) {
        [CMRemind error:@"总价不在限额范围"];
        return;
    }
    
    
    
    
    
    NSDictionary *params = @{
                             @"account":[SSKJ_User_Tool sharedUserTool].userInfoModel.account,
                             @"type":type,
                             @"tpwd":[WLTools md5:self.pwdTextField.text],
                             @"order_no":self.model.order_no,
                             @"total_num":number,
                             @"total_price":totalPrice
                             };
    
    
    if (self.confirmBlock) {
        self.confirmBlock(params);
    }
    
}

- (void)cancelEvent{
    [self hide];
}


// 出现
-(void)showWithModel:(JB_FBC_DealHall_OrderModel *)model buySellType:(BuySellType)type
{
    self.type = type;
    
//    if (self.type == BuySellTypeBuy) {
//        self.pwdBackView.hidden = YES;
//        self.totalTitleLabel.y = self.balanceLabel.bottom + ScaleW(5);
//        self.totalValueLabel.y = self.totalTitleLabel.y;
//        self.confirmButton.y = self.totalTitleLabel.bottom + ScaleW(18);
//        self.alertView.height = self.confirmButton.bottom + ScaleW(10);
//    }
    
    
    if (type == BuySellTypeBuy) {
        self.titleLabel.text = SSKJLocalized(@"购买ISCM", nil);
        [self.allButton setTitle:SSKJLocalized(@"全部购买", nil) forState:UIControlStateNormal];
        [self.segmentView changeAmountBtnTitle:SSKJLocalized(@"购买数量", nil)];
        self.balanceLabel.text = @"实际购买 0.00 ISCM";
        self.amountTextField.placeholder = SSKJLocalized(@"请输入购买数量", nil);
        self.amountTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString: SSKJLocalized(@"请输入购买数量", nil) attributes:@{NSForegroundColorAttributeName:kGrayTitleColor}];

//        if (self.amountType == AmountTypeFBC) {
//            self.amountTextField.placeholder = SSKJLocalized(@"请输入购买法币金额", nil);
//        }else{
//            self.amountTextField.placeholder = SSKJLocalized(@"请输入购买AB数量", nil);
//        }
    }else{
        self.titleLabel.text = SSKJLocalized(@"出售ISCM", nil);
        [self.allButton setTitle:SSKJLocalized(@"全部出售", nil) forState:UIControlStateNormal];
        [self.segmentView changeAmountBtnTitle:SSKJLocalized(@"出售数量", nil)];
        self.balanceLabel.text = @"实际出售 0.00 ISCM";
//        self.amountTextField.placeholder = SSKJLocalized(@"请输入出售数量", nil);
        self.amountTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString: SSKJLocalized(@"请输入出售数量", nil) attributes:@{NSForegroundColorAttributeName:kGrayTitleColor}];

//        if (self.amountType == AmountTypeFBC) {
//            self.amountTextField.placeholder = SSKJLocalized(@"请输入出售法币金额", nil);
//        }else{
//            self.amountTextField.placeholder = SSKJLocalized(@"请输入出售AB数量", nil);
//        }
    }
    
    
    self.model = model;
    self.priceLabel.text = [NSString stringWithFormat:@"%@ %@ETH",SSKJLocalized(@"单价", nil),[WLTools noroundingStringWith:model.price.doubleValue afterPointNumber:4]];
    self.limitLabel.text = [NSString stringWithFormat:@"%@ %@-%@ETH",SSKJLocalized(@"限额", nil),[WLTools noroundingStringWith:model.min_price.doubleValue afterPointNumber:4],[WLTools noroundingStringWith:model.max_price.doubleValue afterPointNumber:4]];
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    [window addSubview:self];
    
    WS(weakSelf);
    
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.alertView.y = weakSelf.height - weakSelf.alertView.height;
    }];
}

-(void)screenTap
{
    if (self.amountTextField.isFirstResponder || self.pwdTextField.isFirstResponder) {
        [self endEditing:YES];
    }else{
        [self hide];
    }
}

//消失

-(void)hide
{
    WS(weakSelf);
    [self clearView];
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.alertView.y = weakSelf.height;
    } completion:^(BOOL finished) {
        [weakSelf removeFromSuperview];
    }];
}

#pragma mark -键盘监听方法
- (void)keyboardWasShown:(NSNotification *)notification
{
    UIView *backView;

    if (self.amountTextField.isFirstResponder) {
        backView = self.amountBackView;
    }else{
        backView = self.pwdBackView;
    }
    // 获取键盘的高度
    CGRect frame = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];

    CGFloat textFieldY = ScreenHeight - (ScreenHeight - self.alertView.height / 2 + backView.bottom);
    
    if (frame.size.height > textFieldY) {
        CGFloat yscale = frame.size.height - textFieldY;
        self.alertView.y = ScreenHeight - self.alertView.height / 2 - yscale;
    }
    
}


- (void)keyboardWillBeHiden:(NSNotification *)notification
{
    self.alertView.y = self.height - self.alertView.height;;
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}


-(void)clearView
{
    self.amountTextField.text = @"";
    self.totalValueLabel.text = @"¥0.00";
    self.pwdTextField.text = nil;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
