//
//  SKNewExchangeVC.m
//  SSKJ
//
//  Created by 孙克强 on 2019/10/8.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "SKNewExchangeVC.h"
#import "My_TitleAndInput_View.h"
#import "ETF_Default_ActionsheetView.h"
#import "SSKJ_inputPwdAlertView.h"

@interface SKNewExchangeVC ()<UITextFieldDelegate>

@property (nonatomic, strong) My_TitleAndInput_View *amountView;
@property (nonatomic, strong) UIButton *typeButton;
@property (nonatomic, strong) UIImageView *shuLineView;

@property (nonatomic, strong) UIButton *allButton;

@property (nonatomic, strong) UILabel *usableLabel;
@property (nonatomic, strong) UILabel *amountLabel;

@property (nonatomic, strong) UILabel *feeLabel;

@property (nonatomic, strong) UIButton *submitButton;

@property (nonatomic, strong) NSDictionary *myDic;

@property (nonatomic, strong) NSMutableArray *myCoinArr;

@property (nonatomic, strong) UIButton * leftButton;
@property(nonatomic,assign)bool isHaveDian;


@end

@implementation SKNewExchangeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = SSKJLocalized(@"兑换", nil);
    [self initView];
    
//    if (self.codeStr.length>0) {
//        [self requestCoinInfo:self.codeStr];
//
//    }
//    else{
//        [self requestList];
//
//    }
    [self requestList];

}
-(void)initView
{
    
    UIView * topView =[[UIView alloc] initWithFrame:CGRectMake(0, ScaleW(5), ScreenWidth, ScaleW(103))];
    topView.backgroundColor = kNavBGColor;
    
    [self.view addSubview:topView];
    
    UILabel * showTile = [[UILabel alloc]initWithFrame:CGRectMake(ScaleW(16), ScaleW(19), ScaleW(100), ScaleW(15))];
    showTile.textColor = kMainWihteColor;
    showTile.font = systemMediumFont(15);
    showTile.adjustsFontSizeToFitWidth = YES;
    showTile.textAlignment = NSTextAlignmentLeft;
    showTile.text = SSKJLocalized(@"兑换资产", nil);
    
    [topView addSubview:showTile];
    
    UIButton * leftButton =[UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(ScaleW(16), ScaleW(17)+ showTile.bottom, ScaleW(149), ScaleW(27));
    [leftButton setTitle:@"  " forState:UIControlStateNormal];
    
    [leftButton setTitleColor:kMainTextColor forState:UIControlStateNormal];
    
    leftButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    

    leftButton.layer.cornerRadius = ScaleW(3);
    leftButton.layer.masksToBounds = YES;
    
    leftButton.layer.borderColor = UIColorFromRGB(0x8de96).CGColor;
    leftButton.layer.borderWidth = ScaleW(1);

    [leftButton addTarget:self action:@selector(leftClickEvent:) forControlEvents:UIControlEventTouchUpInside];
    leftButton.titleLabel.font = systemScaleFont(12);
    
    self.leftButton = leftButton;
    [topView addSubview:leftButton];
    
    
    UIImageView * arrowImagView =[[UIImageView alloc] initWithFrame:CGRectMake(leftButton.width - ScaleW(8)- ScaleW(5), (leftButton.height - ScaleW(5))/2, ScaleW(8), ScaleW(5))];
    arrowImagView.image = [UIImage imageNamed:@"assert_down"];
    
    [leftButton addSubview:arrowImagView];
//    if (self.codeStr.length==0) {
//
//
//
//    }
//    else{
//
//
//        leftButton.userInteractionEnabled = NO;
//    }
    
    
    
 
    
    
    
    UIImageView * middleImagView =[[UIImageView alloc] initWithFrame:CGRectMake(leftButton.right+ ScaleW(11), leftButton.top+ ScaleW(2.5), ScaleW(24), ScaleW(22))];
    middleImagView.image = [UIImage imageNamed:@"dui_icon"];
    
    [topView addSubview:middleImagView];
    
    UIButton * rightButton =[UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(middleImagView.right+ScaleW(11), ScaleW(17)+ showTile.bottom, ScaleW(149), ScaleW(27));
    [rightButton setTitle:@"  YEC" forState:UIControlStateNormal];
    
    [rightButton setTitleColor:kMainTextColor forState:UIControlStateNormal];
    
    rightButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    
    rightButton.layer.cornerRadius = ScaleW(3);
    rightButton.layer.masksToBounds = YES;
    
    rightButton.layer.borderColor = UIColorFromRGB(0x8de96).CGColor;
    rightButton.layer.borderWidth = ScaleW(1);
    rightButton.titleLabel.font = systemScaleFont(12);
    
    [topView addSubview:rightButton];
    
    [self.view addSubview:self.amountView];
    self.amountView.top = topView.bottom+ ScaleW(5);
    
    [self.amountView addSubview:self.typeButton];
    [self.amountView addSubview:self.shuLineView];

    [self.amountView addSubview:self.allButton];
    [self.view addSubview:self.usableLabel];
    [self.view addSubview:self.feeLabel];
    [self.view addSubview:self.amountLabel];
    [self.view addSubview:self.submitButton];
    
    
}
-(void)leftClickEvent:(UIButton*)sender
{
    if (self.myCoinArr.count>0) {
        
        NSMutableArray * array =[NSMutableArray array];
        
        for (int i = 0; i<self.myCoinArr.count; i++) {
            
            NSDictionary * dic = self.myCoinArr[i];
            
            [array addObject:dic[@"pname"]];
            
        }
        
        WS(weakSelf);
        [ETF_Default_ActionsheetView showWithItems:array title:SSKJLocalized(@"请选择币种", nil) selectedIndexBlock:^(NSInteger selectIndex) {
            NSDictionary * dic = weakSelf.myCoinArr[selectIndex];

            [weakSelf.leftButton setTitle:[NSString stringWithFormat:@"  %@",dic[@"pname"]] forState:UIControlStateNormal];
            [weakSelf.typeButton setTitle:[NSString stringWithFormat:@"%@",dic[@"pname"]] forState:UIControlStateNormal];

            [weakSelf requestCoinInfo:dic[@"coin"]];
            
            
        } cancleBlock:^{
            
        }];
        
    }
  
}

-(My_TitleAndInput_View *)amountView
{
    if (nil == _amountView) {
        _amountView = [[My_TitleAndInput_View alloc]initWithFrame:CGRectMake(0, ScaleW(105), ScreenWidth, ScaleW(90)) title:SSKJLocalized(@"兑换资产", nil) placeHolder:SSKJLocalized(@"请输入兑换数量", nil) keyBoardType:UIKeyboardTypeDecimalPad];
//        [_amountView.textField setValue:UIColorFromRGB(0xcbcbcb) forKeyPath:@"_placeholderLabel.textColor"];
        
        
        NSMutableAttributedString *placeholderString1 = [[NSMutableAttributedString alloc] initWithString: SSKJLocalized(@"请输入兑换数量", nil) attributes:@{NSForegroundColorAttributeName : UIColorFromRGB(0xcbcbcb)}];
        
        _amountView.textField.attributedPlaceholder = placeholderString1;
        
        _amountView.textField.delegate = self;
        [[NSNotificationCenter defaultCenter]
         addObserver:self
         selector:@selector(textFieldTextDidChangeOneCI:)
         name:UITextFieldTextDidChangeNotification
         object:_amountView.textField];
        
    }
    return _amountView;
}
-(void)textFieldTextDidChangeOneCI:(NSNotification *)notification
{
    
    
    self.usableLabel.text = [NSString stringWithFormat:@"%@%@",SSKJLocalized(@"到账数量:", nil),[WLTools noroundingStringWith:[self.myDic[@"ex_rate"] doubleValue] * [self.amountView.valueString doubleValue] afterPointNumber:6]];
    
}

-(UIButton *)typeButton
{
    if (nil == _typeButton) {
        _typeButton = [[UIButton alloc]initWithFrame:CGRectMake(self.amountView.width - ScaleW(15) - ScaleW(40)- ScaleW(60), ScaleW(50), ScaleW(60), ScaleW(30))];
        [_typeButton setTitle:SSKJLocalized(@"ETH", nil) forState:UIControlStateNormal];
        [_typeButton setTitleColor:kMainWihteColor forState:UIControlStateNormal];
        _typeButton.titleLabel.font = systemFont(ScaleW(15));
        
        //        _smsButton.layer.masksToBounds = YES;
        //        _smsButton.layer.cornerRadius = _smsButton.height / 2;
        //        _smsButton.layer.borderColor = kTextBlueColor.CGColor;
        //        _smsButton.layer.borderWidth = 1;
        [_typeButton addTarget:self action:@selector(typeEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _typeButton;
}

-(UIImageView*)shuLineView
{
    if (_shuLineView == nil) {
        
        _shuLineView = [[UIImageView alloc] initWithFrame:CGRectMake(_typeButton.right-ScaleW(5), _typeButton.top + ScaleW(8), 1, _typeButton.height -ScaleW(16))];
        
        _shuLineView.backgroundColor = kMainWihteColor;
    }
    
    return _shuLineView;
}
-(void)typeEvent:(UIButton *)sender
{
    
    
}
-(UIButton *)allButton
{
    if (nil == _allButton) {
        _allButton = [[UIButton alloc]initWithFrame:CGRectMake(self.amountView.width - ScaleW(15) - ScaleW(40), ScaleW(50), ScaleW(40), ScaleW(30))];
        [_allButton setTitle:SSKJLocalized(@"全部", nil) forState:UIControlStateNormal];
        [_allButton setTitleColor:kMainWihteColor forState:UIControlStateNormal];
        _allButton.titleLabel.font = systemFont(ScaleW(15));
        
        //        _smsButton.layer.masksToBounds = YES;
        //        _smsButton.layer.cornerRadius = _smsButton.height / 2;
        //        _smsButton.layer.borderColor = kTextBlueColor.CGColor;
        //        _smsButton.layer.borderWidth = 1;
        [_allButton addTarget:self action:@selector(allAmountEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _allButton;
}
#pragma mark -- 全部 事件

-(void)allAmountEvent:(UIButton *)sender
{
    
    
    self.amountView.valueString = [NSString stringWithFormat:@"%@",[WLTools noroundingStringWith:[self.myDic[@"usable"] doubleValue] afterPointNumber:8]];
      self.usableLabel.text = [NSString stringWithFormat:@"%@%@",SSKJLocalized(@"到账数量:", nil),[WLTools noroundingStringWith:[self.myDic[@"ex_rate"] doubleValue] * [self.amountView.valueString doubleValue] afterPointNumber:6]];
    
}

-(UILabel *)feeLabel
{
    if (nil == _feeLabel) {
        _feeLabel = [WLTools allocLabel:@"可用:0.2USDT" font:systemFont(ScaleW(15)) textColor:kSubTxtColor frame:CGRectMake(ScaleW(16), self.amountView.bottom+ScaleW(28), ScaleW(200), ScaleW(14)) textAlignment:NSTextAlignmentLeft];
    }
    return _feeLabel;
}
-(UILabel *)amountLabel
{
    if (nil == _amountLabel) {
        _amountLabel = [WLTools allocLabel:@"兑换比例:1000" font:systemFont(ScaleW(12)) textColor:kMainTextColor frame:CGRectMake(ScreenWidth -ScaleW(16)-ScaleW(150), self.amountView.bottom+ScaleW(28), ScaleW(150), ScaleW(14)) textAlignment:NSTextAlignmentRight];
    }
    return _amountLabel;
}
-(UILabel *)usableLabel
{
    if (nil == _usableLabel) {
        _usableLabel = [WLTools allocLabel:[NSString stringWithFormat:@"%@--",SSKJLocalized(@"到账数量:", nil)] font:systemFont(ScaleW(17)) textColor:kMainWihteColor frame:CGRectMake(ScaleW(16), self.feeLabel.bottom + ScaleW(50), ScreenWidth - ScaleW(17)*2, ScaleW(18)) textAlignment:NSTextAlignmentLeft];
    }
    return _usableLabel;
}
-(UIButton *)submitButton
{
    if (nil == _submitButton) {
        _submitButton = [[UIButton alloc]initWithFrame:CGRectMake(ScaleW(12), self.usableLabel.bottom + ScaleW(40) , ScreenWidth - ScaleW(24), ScaleW(45))];
        //        _submitButton.layer.cornerRadius = 4.0f;
        //        _submitButton.backgroundColor = WLColor(80,113,210, 1);
        [_submitButton setTitle:SSKJLocalized(@"兑换", nil)  forState:UIControlStateNormal];
        [_submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _submitButton.titleLabel.font = systemFont(ScaleW(16));
//        [_submitButton setBackgroundImage:[UIImage imageNamed:@"login_Btn_bg"] forState:UIControlStateNormal];
        _submitButton.backgroundColor = kTheMeColor;
        [_submitButton addTarget:self action:@selector(submitEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitButton;
}
-(void)submitEvent
{
    
    if (self.amountView.valueString.length>0) {
        SSKJ_inputPwdAlertView  *alertView = [[SSKJ_inputPwdAlertView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        WS(weakSelf);
        alertView.submitBlock = ^(NSString * _Nonnull pwdCode) {
            
            [weakSelf requestResult:pwdCode];
            
        };
        [alertView showAlert];
    }
    else
    {
        [MBProgressHUD showError:SSKJLocalized(@"请输入数量", nil)];
        
    }
  

}


-(void)requestList
{
    
    WS(weakSelf);
    
    //    NSString *language = [[SSKJLocalized sharedInstance]currentLanguage];
    //    NSString *type;
    //    if ([language isEqualToString:@"en"]) {
    //        type = @"2";
    //    }else{
    //        type = @"1";
    //    }
    NSDictionary *params = @{};
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
   
    
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:JB_coinList_assert_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject)
     {
         [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
         WL_Network_Model *network_Model=[WL_Network_Model mj_objectWithKeyValues:responseObject];
         
         if (network_Model.status.integerValue == SUCCESSED)
         {
             
             
             
             weakSelf.myCoinArr = network_Model.data;
             
             
             
             if (weakSelf.myCoinArr.count>0) {
                 weakSelf.myDic = network_Model.data[0];
                 
                [weakSelf.leftButton setTitle:[NSString stringWithFormat:@"  %@",weakSelf.myCoinArr[0][@"pname"]] forState:UIControlStateNormal];
                 
                 [weakSelf.typeButton setTitle:[NSString stringWithFormat:@"%@",weakSelf.myCoinArr[0][@"pname"]] forState:UIControlStateNormal];
                 
                 weakSelf.feeLabel.text =[NSString stringWithFormat:@"%@%@%@",SSKJLocalized(@"可用:", nil),[WLTools noroundingStringWith:[weakSelf.myCoinArr[0][@"usable"] doubleValue] afterPointNumber:6],weakSelf.myCoinArr[0][@"pname"]];
                 weakSelf.amountLabel.text =[NSString stringWithFormat:@"%@%@",SSKJLocalized(@"兑换比例:", nil),weakSelf.myCoinArr[0][@"ex_rate"]];
             }
           
           

             
         }else{
             [MBProgressHUD showError:network_Model.msg];
         }
     } Failure:^(NSError *error, NSInteger statusCode, id responseObject)
     {
         [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];

         [MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
     }];
}
-(void)requestCoinInfo:(NSString *)coinStr
{
    
    WS(weakSelf);
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];

    NSDictionary *params = @{
                             @"coin":coinStr
                             };
        
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:JB_thisCoinList_assert_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject)
     {
         [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
         WL_Network_Model *network_Model=[WL_Network_Model mj_objectWithKeyValues:responseObject];
         
         if (network_Model.status.integerValue == SUCCESSED)
         {
             
             
             
             weakSelf.myDic = network_Model.data[0];
            
             if ([weakSelf.myDic allKeys]>0) {
                 weakSelf.feeLabel.text =[NSString stringWithFormat:@"%@%@%@",SSKJLocalized(@"可用:", nil),[WLTools noroundingStringWith:[weakSelf.myDic[@"usable"] doubleValue] afterPointNumber:6],weakSelf.myDic[@"name"]];
                 weakSelf.amountLabel.text =[NSString stringWithFormat:@"%@%@",SSKJLocalized(@"兑换比例:", nil),weakSelf.myDic[@"ex_rate"]];
                 
                  self.usableLabel.text = [NSString stringWithFormat:@"%@--",SSKJLocalized(@"到账数量:", nil)];
             }
             
         
             
             
         }else{
             [MBProgressHUD showError:network_Model.msg];
         }
     } Failure:^(NSError *error, NSInteger statusCode, id responseObject)
     {
         [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];

         [MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
     }];
}

-(void)requestResult:(NSString *)tpwd
{
    
    WS(weakSelf);
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    NSDictionary *params = @{
                             @"coin":self.myDic[@"coin"],
                             @"ex_coin":@"yec_usdt",
                             @"num":self.amountView.valueString,
                             @"tpwd":[WLTools md5:tpwd],

                             };
    
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:JB_exchange_exchange_assert_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject)
     {
         [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
         WL_Network_Model *network_Model=[WL_Network_Model mj_objectWithKeyValues:responseObject];
         
         if (network_Model.status.integerValue == SUCCESSED)
         {
             
             
             [weakSelf.navigationController popViewControllerAnimated:YES];
             
             
             
         }else{
             [MBProgressHUD showError:network_Model.msg];
         }
     } Failure:^(NSError *error, NSInteger statusCode, id responseObject)
     {
         [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
         
         [MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
     }];
}

-(NSMutableArray*)myCoinArr
{
    if (_myCoinArr == nil) {
        
        _myCoinArr =[NSMutableArray array];
    }
    return _myCoinArr;
}
/**
 *  textField的代理方法，监听textField的文字改变
 *  textField.text是当前输入字符之前的textField中的text
 *
 *  @param textField textField
 *  @param range     当前光标的位置
 *  @param string    当前输入的字符
 *
 *  @return 是否允许改变
 */
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    /*
     * 不能输入.0-9以外的字符。
     * 设置输入框输入的内容格式
     * 只能有一个小数点
     * 小数点后最多能输入两位
     * 如果第一位是.则前面加上0.
     * 如果第一位是0则后面必须输入点，否则不能输入。
     */
    
    // 判断是否有小数点
    if ([textField.text containsString:@"."]) {
        self.isHaveDian = YES;
    }else{
        self.isHaveDian = NO;
    }
    
    if (string.length > 0) {
        
        //当前输入的字符
        unichar single = [string characterAtIndex:0];
        //        NSLog(@"single = %c",single);
        
        // 不能输入.0-9以外的字符
        if (!((single >= '0' && single <= '9') || single == '.'))
        {
            [MBProgressHUD showError:SSKJLocalized(@"您的输入格式不正确", nil)];
            
            return NO;
        }
        
        // 只能有一个小数点
        if (self.isHaveDian && single == '.') {
            [MBProgressHUD showError:SSKJLocalized(@"最多只能输入一个小数点", nil)];
            
            return NO;
        }
        
        // 如果第一位是.则前面加上0.
        if ((textField.text.length == 0) && (single == '.')) {
            textField.text = @"0";
        }
        
        // 如果第一位是0则后面必须输入点，否则不能输入。
        if ([textField.text hasPrefix:@"0"]) {
            if (textField.text.length > 1) {
                NSString *secondStr = [textField.text substringWithRange:NSMakeRange(1, 1)];
                if (![secondStr isEqualToString:@"."]) {
                    [MBProgressHUD showError:SSKJLocalized(@"第二个字符需要是小数点", nil)];
                    return NO;
                }
            }else{
                if (![string isEqualToString:@"."]) {
                    [MBProgressHUD showError:SSKJLocalized(@"第二个字符需要是小数点", nil)];
                    return NO;
                }
            }
        }
        
        
//         小数点后最多能输入两位
        if (self.isHaveDian) {
            NSRange ran = [textField.text rangeOfString:@"."];
            // 由于range.location是NSUInteger类型的，所以这里不能通过(range.location - ran.location)>2来判断
            if (range.location > ran.location) {
                if ([textField.text pathExtension].length > 7) {
                    [MBProgressHUD showError:SSKJLocalized(@"小数点后最多有八位小数", nil)];

                    return NO;
                }
            }
        }
        
    }
    
    return YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
