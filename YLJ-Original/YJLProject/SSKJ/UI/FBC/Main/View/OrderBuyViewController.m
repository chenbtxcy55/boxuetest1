//
//  OrderBuyViewController.m
//  SSKJ
//
//  Created by 张本超 on 2019/5/14.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "OrderBuyViewController.h"

@interface OrderBuyViewController ()<UITextFieldDelegate>
{
    UILabel *cnyLabel;
}
@property (weak, nonatomic) IBOutlet UIView *countView;
@property (weak, nonatomic) IBOutlet UITextField *amountTF;
@property (weak, nonatomic) IBOutlet UITextField *tradePswTf;
@property (weak, nonatomic) IBOutlet UIButton *buyNum;
@property (weak, nonatomic) IBOutlet UIButton *countBtn;
@property (weak, nonatomic) IBOutlet UILabel *priceSingle;

@property (weak, nonatomic) IBOutlet UILabel *limitValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *tradAmount;

@property (weak, nonatomic) IBOutlet UILabel *actBuyLabel;
@property (nonatomic, strong) UIView *movingLine;
//1法币计价 2 出售数量
@property (nonatomic, assign) NSInteger currenType;
@property (nonatomic, strong) NSString *currentPrice;
@property (nonatomic, strong) NSString *currenAmount;
@property (nonatomic, strong) NSString *frostAmount;

@property (nonatomic, strong) NSString *maxAmount;

@property (nonatomic, strong) NSString *minAmount;
@end

@implementation OrderBuyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    self.view.userInteractionEnabled = YES;
    [self.view addGestureRecognizer:tap];
    self.currenType = 1;
   
    [_amountTF setBorderWithWidth:1 andColor:kLineGrayColor];
    _amountTF.leftViewMode = UITextFieldViewModeAlways;
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 12, 50)];
    _amountTF.leftView = view;
    _amountTF.keyboardType = UIKeyboardTypeDecimalPad;
    [_amountTF textField:_amountTF textFont:13 placeHolderFont:13 text:nil placeText:@"请输入出售数量" textColor: kMainTextColor placeHolderTextColor:kTextDarkBlueColor];
    _amountTF.rightViewMode = UITextFieldViewModeAlways;
    UIView *rightView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 50)];
    cnyLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    [cnyLabel label:cnyLabel font:12 textColor:kTextColorb2b9e7 text:@"CNY"];
    [rightView addSubview:cnyLabel];
    cnyLabel.textAlignment = NSTextAlignmentCenter;
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(cnyLabel.right, 20, 1, 12)];
    lineView.backgroundColor = kLineGrayColor;
    [rightView addSubview:lineView];
    UIButton *allBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [allBtn btn:allBtn font:12 textColor:kTextColor664fe5 text:@"全部" image:nil sel:@selector(allClicked:) taget:self];
    allBtn.frame = CGRectMake(cnyLabel.right, 0, 50, 50);
    [rightView addSubview:allBtn];
    _amountTF.rightView = rightView;
    _amountTF.delegate = self;
    [_countBtn addTarget:self action:@selector(countAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [_buyNum addTarget:self action:@selector(countAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [_countView addSubview:self.movingLine];
    [_tradePswTf setBorderWithWidth:1 andColor:kLineGrayColor];
    _tradePswTf.leftViewMode = UITextFieldViewModeAlways;
     view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 12, 50)];
    _tradePswTf.leftView = view;
    [_tradePswTf textField:_tradePswTf textFont:13 placeHolderFont:13 text:nil placeText:@"请输入安全密码" textColor: kMainTextColor placeHolderTextColor:kTextDarkBlueColor];
    [self gatePriceRequst];
    [self getCurrentAmountRequst];
    
}
-(void)tapAction:(UITapGestureRecognizer *)sender
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
-(void)allClicked:(UIButton *)sender
{
    //法币计量
    if (_currenType == 1) {
        self.amountTF.text = [NSString stringWithFormat:@"%.2f",self.currentPrice.doubleValue*self.currenAmount.doubleValue];
        
    }else
    {
        //出售数量
        self.amountTF.text = [NSString stringWithFormat:@"%.2f",self.currenAmount.doubleValue];
    }
    
}
-(UIView *)movingLine
{
    if (!_movingLine) {
        _movingLine = [[UIView alloc]initWithFrame:CGRectMake(16, 120, 55, 1)];
        _movingLine.backgroundColor = kTextColor664fe5;
        
    }
    return _movingLine;
}
-(void)countAction:(UIButton *)sender
{
    if (sender == _countBtn) {
        self.movingLine.centerX = 44;
        [_countBtn setTitleColor:kTextColor664fe5 forState:(UIControlStateNormal)];
        //kTextColorb2b9e7
        [_buyNum setTitleColor:kTextColorb2b9e7 forState:(UIControlStateNormal)];
        self.currenType = 1;
    }else{
        self.movingLine.centerX = 132;
        [_countBtn setTitleColor:kTextColorb2b9e7 forState:(UIControlStateNormal)];
        [_buyNum setTitleColor:kTextColor664fe5 forState:(UIControlStateNormal)];
        self.currenType = 2;
        
    }
}
-(void)setModel:(JB_FBC_DealHall_OrderModel *)model{
    _model = model;

    _priceSingle.text = [NSString stringWithFormat:@"单价￥%.2f",[model.price doubleValue]];
    _limitValueLabel.text = [NSString stringWithFormat:@"限额：%@CNY",model.quota];
    
    NSArray *array = [model.quota componentsSeparatedByString:@"-"];
    _minAmount = array[0];
    _maxAmount = array[1];
    
}

-(void)gatePriceRequst
{
    //ETF_FBHomeFbtransgGetPrice_URL
    NSDictionary *pama = @{};
    WS(weakSelf);
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:ETF_FBHomeFbtransgGetPrice_URL RequestType:RequestTypeGet Parameters:pama Success:^(NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        WL_Network_Model *net_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if (net_model.status.integerValue == 200) {
            
            self.currentPrice = [NSString stringWithFormat:@"%@",net_model.data[@"price"]];
            self.currenType = _currenType;
            
        }else{
            
            
            [MBProgressHUD showError:net_model.msg];
        }
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        
        
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
    }];
}
//
-(void)getCurrentAmountRequst
{
    //ETF_FBHomeFbtransgGetPrice_URL
    NSDictionary *pama = @{};
    WS(weakSelf);
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:Main_Get_My_AB_URL RequestType:RequestTypeGet Parameters:pama Success:^(NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        WL_Network_Model *net_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if (net_model.status.integerValue == 200) {
            
            self.currenAmount = [NSString stringWithFormat:@"%@",net_model.data[@"usable"]];
            self.frostAmount = [NSString stringWithFormat:@"%@",net_model.data[@"frost"]];
            
        }else{
            
            
            [MBProgressHUD showError:net_model.msg];
        }
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        
        
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
    }];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
   
    //赋值
    self.model = _model;
}
-(void)setCurrenType:(NSInteger)currenType
{
    _currenType = currenType;
    if (_currenType == 1) {
        cnyLabel.text = @"CNY";
        _amountTF.text = nil;
        _amountTF.placeholder = @"请输入出售法币金额";
        _amountTF.attributedPlaceholder = [[NSAttributedString alloc] initWithString: SSKJLocalized(@"请输入出售法币金额", nil) attributes:@{NSForegroundColorAttributeName:kGrayTitleColor}];

        self.actBuyLabel.text = [NSString stringWithFormat:@"实际出售%.4fAB", self.amountTF.text.floatValue/_currentPrice.doubleValue];
        self.tradAmount.text = [NSString stringWithFormat:@"￥%.2f", self.amountTF.text.floatValue];
    }else{
        cnyLabel.text = @"AB";
        _amountTF.text = nil;
        _amountTF.placeholder = @"请输入出售数量";
        _amountTF.attributedPlaceholder = [[NSAttributedString alloc] initWithString: SSKJLocalized(@"请输入出售数量", nil) attributes:@{NSForegroundColorAttributeName:kGrayTitleColor}];

        self.actBuyLabel.text = [NSString stringWithFormat:@"实际出售%.4fAB",self.tradAmount.text.floatValue];
        self.tradAmount.text = [NSString stringWithFormat:@"￥%.2f",self.tradAmount.text.floatValue*_currentPrice.doubleValue];
    }
    
}
-(NSString *)currentPrice
{
    if (!_currentPrice) {
        _currentPrice = @"0";
    }
    return _currentPrice;
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString * strContent = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    double allCny =  _currenAmount.doubleValue * _currentPrice.doubleValue;
    //删除
    if ([string isEqualToString:@""]) {
        if (_currenType == 1) {
            self.actBuyLabel.text = [NSString stringWithFormat:@"实际出售%.4fAB",strContent.floatValue/_currentPrice.doubleValue];
            self.tradAmount.text = [NSString stringWithFormat:@"￥%.2f",strContent.floatValue];
        }else{
            self.actBuyLabel.text = [NSString stringWithFormat:@"实际出售%.4fAB",strContent.floatValue];
            self.tradAmount.text = [NSString stringWithFormat:@"￥%.2f",strContent.floatValue*_currentPrice.doubleValue];
        }
        
        return YES;
    }else{
        //法币计量
        if (_currenType == 1) {
            if (allCny < _minAmount.doubleValue) {
                [MBProgressHUD showError:@"总资产小于最小限额不能出售"];
                
            }else{
                
                if (allCny <= _maxAmount.doubleValue) {
                    
                    if (strContent.doubleValue >= allCny) {
                        textField.text = [NSString stringWithFormat:@"%.2f",allCny];
                        self.actBuyLabel.text = [NSString stringWithFormat:@"实际出售%.4fAB",allCny/_currentPrice.doubleValue];
                        self.tradAmount.text = [NSString stringWithFormat:@"￥%.2f",allCny];
                        return NO;
                    }
                }else{
                    if (strContent.doubleValue >= _maxAmount.doubleValue) {
                        textField.text= [NSString stringWithFormat:@"%.2f",_maxAmount.doubleValue];
                        self.actBuyLabel.text = [NSString stringWithFormat:@"实际出售%.4fAB",_maxAmount.doubleValue/_currentPrice.doubleValue];
                        self.tradAmount.text = [NSString stringWithFormat:@"￥%.2f",_maxAmount.doubleValue];
                        return NO;
                    }
                }
                
            }
            
            self.actBuyLabel.text = [NSString stringWithFormat:@"实际出售%.4fAB",strContent.floatValue/_currentPrice.doubleValue];
            self.tradAmount.text = [NSString stringWithFormat:@"￥%.2f",strContent.floatValue];
        }else
        {
            //出售数量
            double minAB = _minAmount.doubleValue / _currentPrice.doubleValue;
            double maxAB = _maxAmount.doubleValue / _currentPrice.doubleValue;
            if (_currenAmount.doubleValue < minAB) {
                [MBProgressHUD showError:@"总资产小于最小限额不能出售"];
                
            }else{
                if (_currenAmount.doubleValue <= maxAB) {
                    
                    if (strContent.doubleValue >= _currenAmount.doubleValue) {
                        textField.text = [NSString stringWithFormat:@"%.4f",_currenAmount.doubleValue];
                        self.actBuyLabel.text = [NSString stringWithFormat:@"实际出售%.4fAB",_currenAmount.doubleValue];
                        self.tradAmount.text = [NSString stringWithFormat:@"￥%.2f",_currenAmount.doubleValue*_currentPrice.doubleValue];
                        return NO;
                    }
                }else{
                    if (strContent.doubleValue >= maxAB) {
                        textField.text = [NSString stringWithFormat:@"%.4f",maxAB];
                        self.actBuyLabel.text = [NSString stringWithFormat:@"实际出售%.4fAB",maxAB];
                        self.tradAmount.text = [NSString stringWithFormat:@"￥%.2f",maxAB*_currentPrice.doubleValue];
                        return NO;
                    }
                }
                
            }
            self.actBuyLabel.text = [NSString stringWithFormat:@"实际出售%.4fAB",strContent.floatValue];
            self.tradAmount.text = [NSString stringWithFormat:@"￥%.2f",strContent.floatValue*_currentPrice.doubleValue];
        }
    }
    return YES;
}
- (IBAction)gotobuttingBillAction:(id)sender {
    NSString *Account=[[SSKJ_User_Tool sharedUserTool] getAccount];
    NSDictionary *pama = nil;
    if ([self pamasIsOk] == NO) {
        return;
    }
    if (_currenType == 1) {
        NSString *amount = [NSString stringWithFormat:@"%.2f",_amountTF.text.doubleValue/ _currentPrice.doubleValue];
        pama = @{@"account":Account,@"type":@"1",@"order_no":self.model.order_no,@"total_price":_amountTF.text,@"total_num":amount};
    }else{
        NSString *price = [NSString stringWithFormat:@"%.2f",_amountTF.text.doubleValue *_currentPrice.doubleValue];
        pama = @{@"account":Account,@"type":@"1",@"order_no":self.model.order_no,@"total_num":_amountTF.text,@"total_price":price};
    }
    
    WS(weakSelf);
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:Main_Get_create_order_URL RequestType:RequestTypePost Parameters:pama Success:^(NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        WL_Network_Model *net_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if (net_model.status.integerValue == 200) {
            
            
            
        }else{
            
            
        }
        
        [MBProgressHUD showError:net_model.msg];
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
    }];
}
-(BOOL)pamasIsOk
{
    if (_currenType == 1) {
        if (!_amountTF.text.length)
        {
            [MBProgressHUD showError:@"请输入购买金额"];
            return NO;
        }
        
    }else{
        if (!_amountTF.text.length)
        {
            [MBProgressHUD showError:@"请输入购买数量"];
            return NO;
        }
    }
    if (!_tradePswTf.text.length) {
        [MBProgressHUD showError:@"请输入安全密码"];
        return NO;
    }
    
    return YES;
}
@end
