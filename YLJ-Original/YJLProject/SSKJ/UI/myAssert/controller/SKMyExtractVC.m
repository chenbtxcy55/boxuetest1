//
//  SKMyExtractVC.m
//  SSKJ
//
//  Created by 孙 on 2019/7/19.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#define kAccount [kUserDefaults objectForKey:@"kAccount"]?:@""  // 登录账号
#define kUserID [kUserDefaults objectForKey:@"uid"]?:@""        // uid

#import "SKMyExtractVC.h"

#import "RegularExpression.h"

// controller
#import "BLAddAddressViewController.h"
#import "SKMyExtract_RecordVC.h"

// view
#import "FB_Action_TitleView.h"
#import "My_TitleAndInput_View.h"
#import "JMDropMenu.h"

// model
#import "WLLAssetsInfoModel.h"
#import "BI_AssetExtractInfo_Model.h"

#import "My_TB_ChooseCoin_AlertView.h"
#import "ETF_Default_ActionsheetView.h"
#import "My_BindGoogle_AlertView.h"

@interface SKMyExtractVC ()<JMDropMenuDelegate>
@property (nonatomic, strong) FB_Action_TitleView *mainTitleView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) My_TitleAndInput_View *addressView;
@property (nonatomic, strong) UIButton *addressButton;
@property (nonatomic, strong) My_TitleAndInput_View *amountView;
@property (nonatomic, strong) UIButton *typeButton;

@property (nonatomic, strong) UIButton *allButton;


@property (nonatomic, strong) UILabel *usableLabel;
@property (nonatomic, strong) UILabel *amountLabel;

@property (nonatomic, strong) UILabel *feeLabel;
@property (nonatomic, strong) My_TitleAndInput_View *pwdView;
@property (nonatomic, strong) My_TitleAndInput_View *smsCodeView;
@property (nonatomic, strong) UIButton *smsButton;

@property (nonatomic, strong) UIButton *submitButton;

@property (nonatomic, strong) WLLAssetsInfoModel *model;
@property (nonatomic, strong) BI_AssetExtractInfo_Model *entractInfoModel;

@property (nonatomic,strong) My_TB_ChooseCoin_AlertView * tbAlertView;

@property (nonatomic,strong)UILabel * showTile;

@property (nonatomic,copy)NSString * tb_max;
@property (nonatomic,copy)NSString * tb_min;

@property (nonatomic,copy)NSString * rate;

@property (nonatomic,copy)NSString * blance;

@end

@implementation SKMyExtractVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kMainColor;
    self.title = SSKJLocalized(@"提币", nil);
//    [self addRightNavgationItemWithImage:[UIImage imageNamed:@"cbjl_icon"]];
    [self initView];
    
}

//-(void)rigthBtnAction:(id)sender
//{
//    SKMyExtract_RecordVC * myExtract_RecordVC = [SKMyExtract_RecordVC new];
//
//    [self.navigationController pushViewController:myExtract_RecordVC animated:YES];
//
//}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO];
    [self requestCoinList];

//    [self requestGetTb];
}
-(void)initView
{
    
    UIView *style = [[UIView alloc] initWithFrame:CGRectMake(0, 5, ScreenWidth, ScaleW(50))];
    style.backgroundColor = kNavBGColor;
    [self.view addSubview:style];
    
    
    UILabel * showTile = [[UILabel alloc]initWithFrame:CGRectMake(ScaleW(16), 0, ScaleW(100), ScaleW(50))];
    showTile.textColor = kMainWihteColor;
    showTile.font = systemMediumFont(15);
    showTile.adjustsFontSizeToFitWidth = YES;
    showTile.textAlignment = NSTextAlignmentLeft;
    showTile.text = SSKJLocalized(@"选择币种", nil);
    
    [style addSubview:showTile];
    
    {
        UILabel * showTile = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth- ScaleW(16)-ScaleW(80)-ScaleW(6)-ScaleW(10), 0, ScaleW(80), ScaleW(50))];
        showTile.textColor = kMainWihteColor;
        showTile.font = systemMediumFont(15);
//        showTile.adjustsFontSizeToFitWidth = YES;
        showTile.textAlignment = NSTextAlignmentRight;
        showTile.text = @"ETH";
//        showTile.userInteractionEnabled = YES;
        [style addSubview:showTile];
        UITapGestureRecognizer * tapGesture =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeBiTypeEvent:)];
        [style addGestureRecognizer:tapGesture];
        self.showTile = showTile;
        
        
    }
    
    UIImageView * jiaoImageView =[[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth - ScaleW(6) -ScaleW(16), (ScaleW(50)-ScaleW(10))/2, ScaleW(6), ScaleW(10))];
    jiaoImageView.image = [UIImage imageNamed:@"more_icon"];
    
    [style addSubview:jiaoImageView];
    
    UIView *style1 = [[UIView alloc] initWithFrame:CGRectMake(ScaleW(15), ScaleW(49), ScreenWidth -ScaleW(30), 1)];
    style1.backgroundColor = UIColorFromRGB(0x111c40);
    [style addSubview:style1];
    
    [self setUI];

}
-(void)changeBiTypeEvent:(UIGestureRecognizer *)gesture
{
    
    if (self.coinArray.count>0) {
        NSMutableArray *arr =[NSMutableArray array];
        for (int i = 0; i<self.coinArray.count; i++) {
            WLLAssetsInfoModel * model = self.coinArray[i];
            
            [arr addObject:[[model.code componentsSeparatedByString:@"_"].firstObject uppercaseString]];
            
        }
        
        WS(weakSelf);
        [ETF_Default_ActionsheetView showWithItems:arr title:SSKJLocalized(@"请选择提币的币种", nil) selectedIndexBlock:^(NSInteger selectIndex) {
            weakSelf.showTile.text = arr[selectIndex];
            weakSelf.model = weakSelf.coinArray[selectIndex];
            [weakSelf requestCoinInfo];
            [weakSelf.typeButton setTitle:weakSelf.showTile.text forState:UIControlStateNormal];

        } cancleBlock:^{
            
        }];
    }
    
    
  
}
- (void)didSelectRowAtIndex:(NSInteger)index Title:(NSString *)title Image:(NSString *)image {
    NSLog(@"index----%zd,  title---%@, image---%@", index, title, image);
    self.showTile.text = title;
    
    
    
    [_typeButton setTitle:SSKJLocalized(title, nil) forState:UIControlStateNormal];
    [self requestGetTb];

}
-(void)setCoinArray:(NSMutableArray *)coinArray
{
    for (WLLAssetsInfoModel *model in coinArray) {
        //        if ([model.pname isEqualToString:@"GCT"]) {
        //            [coinArray removeObject:model];
        //            break;
        //        }
    }
    
    _coinArray = coinArray;
}


#pragma mark - UI

-(void)setUI
{
//    self.navigationItem.titleView = self.mainTitleView;
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.pwdView];

    [self.scrollView addSubview:self.addressView];
    [self.addressView addSubview:self.addressButton];
    [self.scrollView addSubview:self.amountView];
    [self.amountView addSubview:self.typeButton];
    [self.amountView addSubview:self.allButton];
    [self.scrollView addSubview:self.feeLabel];
//    [self.scrollView addSubview:self.smsCodeView];
//    [self.smsCodeView addSubview:self.smsButton];
    [self.scrollView addSubview:self.usableLabel];

    [self.scrollView addSubview:self.submitButton];
    self.scrollView.contentSize = CGSizeMake(ScreenWidth, self.submitButton.bottom + 30);
    
}

- (FB_Action_TitleView *)mainTitleView
{
    if (nil == _mainTitleView) {
        
        NSMutableArray *coinNameArray = [NSMutableArray arrayWithCapacity:10];
        for (WLLAssetsInfoModel *model in self.coinArray) {
            [coinNameArray addObject:model.stockCode];
        }
        
        _mainTitleView = [[FB_Action_TitleView alloc]initWithFrame:CGRectMake(0, 0, 90, 44) titles:coinNameArray];
        
        
        WS(weakSelf);
        _mainTitleView.titleChangeBlock = ^(NSInteger index) {
            weakSelf.model = weakSelf.coinArray[index];
            [weakSelf requestCoinInfo];
        };
        
    }
    return _mainTitleView;
}


-(UIScrollView *)scrollView
{
    if (nil == _scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, ScaleW(55), ScreenWidth, ScreenHeight - Height_NavBar-ScaleW(50))];
        _scrollView.backgroundColor = kMainColor;
        

        
        if (@available(iOS 11.0, *)){
            _scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }else{
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
    }
    return _scrollView;
}

-(My_TitleAndInput_View *)addressView
{
    if (nil == _addressView) {
        _addressView = [[My_TitleAndInput_View alloc]initWithFrame:CGRectMake(0, self.pwdView.bottom, ScreenWidth, ScaleW(90)) title:SSKJLocalized(@"提币地址", nil) placeHolder:SSKJLocalized(@"输入或长按粘贴地址", nil) keyBoardType:UIKeyboardTypeASCIICapable];
        _addressView.titleLabel.textColor = kSubTxtColor;
//        [_addressView.textField setValue:UIColorFromRGB(0xffffff) forKeyPath:@"_placeholderLabel.textColor"];
        NSMutableAttributedString *placeholderString1 = [[NSMutableAttributedString alloc] initWithString: SSKJLocalized(@"输入或长按粘贴地址", nil) attributes:@{NSForegroundColorAttributeName : UIColorFromRGB(0xffffff)}];
        
        _addressView.textField.attributedPlaceholder = placeholderString1;
    }
    return _addressView;
}

-(UIButton *)addressButton
{
    if (nil == _addressButton) {
        _addressButton =[[UIButton alloc]initWithFrame:CGRectMake(self.addressView.width - ScaleW(15) - ScaleW(17), ScaleW(56), ScaleW(20), ScaleW(20))];
//        _addressButton.backgroundColor = [UIColor redColor];
        [_addressButton setImage:[UIImage imageNamed:@"assert_address"] forState:UIControlStateNormal];
        [_addressButton addTarget:self action:@selector(selectAddress) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addressButton;
}

-(My_TitleAndInput_View *)amountView
{
    if (nil == _amountView) {
        _amountView = [[My_TitleAndInput_View alloc]initWithFrame:CGRectMake(0, self.addressView.bottom + ScaleW(10), ScreenWidth, ScaleW(90)) title:SSKJLocalized(@"数量", nil) placeHolder:SSKJLocalized(@"最小提币数量200", nil) keyBoardType:UIKeyboardTypeDecimalPad];
//        [_amountView.textField setValue:UIColorFromRGB(0xffffff) forKeyPath:@"_placeholderLabel.textColor"];

        
        NSMutableAttributedString *placeholderString1 = [[NSMutableAttributedString alloc] initWithString: SSKJLocalized(@"最小提币数量200", nil) attributes:@{NSForegroundColorAttributeName : UIColorFromRGB(0xffffff)}];
        
        _amountView.textField.attributedPlaceholder = placeholderString1;
        
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
    
    UITextField *textfield=[notification object];
    NSLog(@"%@",textfield.text);
    if (self.entractInfoModel.useFund.doubleValue>0)
    {
        if (textfield.text.doubleValue - self.rate.doubleValue *textfield.text.doubleValue >0) {
            //         _usableLabel.text = [NSString stringWithFormat:@"到账数量:%.8f",textfield.text.doubleValue - self.rate.doubleValue];
            
            _usableLabel.text = [NSString stringWithFormat:@"%@%@",SSKJLocalized(@"到账数量:", nil),[WLTools noroundingStringWith:_amountView.textField.text.doubleValue - self.entractInfoModel.tbFeeRate.doubleValue*_amountView.textField.text.doubleValue afterPointNumber:6]];
            
        }
        else
        {
            _usableLabel.text = [NSString stringWithFormat:@"%@--",SSKJLocalized(@"到账数量:", nil)];
        }
    }
    else
    {
        
        [MBProgressHUD showError:SSKJLocalized(@"请充值", nil)];
        textfield.text = @"";
    }
    
   
    
}
-(UILabel *)amountLabel
{
    if (nil == _amountLabel) {
        _amountLabel = [WLTools allocLabel:@"111111" font:systemFont(ScaleW(12)) textColor:[UIColor colorWithRed:150.0f/255.0f green:150.0f/255.0f blue:150.0f/255.0f alpha:1.0f] frame:CGRectMake(ScaleW(15), 0, ScreenWidth / 2 - ScaleW(15), ScaleW(12) +ScaleW(12) +ScaleW(10)) textAlignment:NSTextAlignmentLeft];
    }
    return _amountLabel;
}

-(UILabel *)feeLabel
{
    if (nil == _feeLabel) {
        _feeLabel = [WLTools allocLabel:@"手续费：0/次" font:systemFont(ScaleW(12)) textColor:kSubTxtColor frame:CGRectMake(ScaleW(16), self.amountView.bottom+ScaleW(5), ScreenWidth / 2 - ScaleW(15), ScaleW(12)) textAlignment:NSTextAlignmentLeft];
    }
    return _feeLabel;
}

-(UILabel *)usableLabel
{
    if (nil == _usableLabel) {
        _usableLabel = [WLTools allocLabel:[NSString stringWithFormat:@"%@--",SSKJLocalized(@"到账数量:", nil)] font:systemFont(ScaleW(17)) textColor:kMainWihteColor frame:CGRectMake(ScaleW(16), self.feeLabel.bottom + ScaleW(50), ScreenWidth  - ScaleW(30), ScaleW(18)) textAlignment:NSTextAlignmentLeft];
    }
    return _usableLabel;
}

-(My_TitleAndInput_View *)pwdView
{
    if (nil == _pwdView) {
        _pwdView = [[My_TitleAndInput_View alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleW(90)) title:SSKJLocalized(@"可用", nil) placeHolder:SSKJLocalized(@"", nil) keyBoardType:UIKeyboardTypeASCIICapable];
        _pwdView.textField.secureTextEntry = NO;
        _pwdView.textField.enabled = NO;
        _pwdView.titleLabel.textColor = kSubTxtColor;
        _pwdView.textField.text =@"0.0000 BTC";
        
    }
    return _pwdView;
}

-(My_TitleAndInput_View *)smsCodeView
{
#pragma mark 处理
    if (nil == _smsCodeView) {
//        NSString *string = SSKJLocalized(@"输入手机验证码", nil);
//        if (![RegularExpression validateMobile:kAccount]) {
//            string = SSKJLocalized(@"输入邮箱验证码", nil);
//        }
        _smsCodeView = [[My_TitleAndInput_View alloc]initWithFrame:CGRectMake(0, self.pwdView.bottom, ScreenWidth, ScaleW(102)) title:SSKJLocalized(@"手机验证码", nil) placeHolder:@"请输入手机验证码" keyBoardType:UIKeyboardTypeASCIICapable];
    }
    return _smsCodeView;
}

-(UIButton *)typeButton
{
    if (nil == _typeButton) {
        _typeButton = [[UIButton alloc]initWithFrame:CGRectMake(self.amountView.width - ScaleW(15) - ScaleW(40)- ScaleW(60), ScaleW(50), ScaleW(60), ScaleW(30))];
        [_typeButton setTitle:SSKJLocalized(@"", nil) forState:UIControlStateNormal];
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
    
    if (self.entractInfoModel.useFund.doubleValue>0) {
        
        if (self.entractInfoModel.tbMaxRate.doubleValue>self.entractInfoModel.useFund.doubleValue) {
            _amountView.textField.text = [NSString stringWithFormat:@"%@",[WLTools noroundingStringWith:self.entractInfoModel.useFund.doubleValue afterPointNumber:6]];
            
        }
        else
        {
            _amountView.textField.text = [NSString stringWithFormat:@"%@",[WLTools noroundingStringWith:self.entractInfoModel.tbMaxRate.doubleValue afterPointNumber:6]];
            
        }
        
          _usableLabel.text = [NSString stringWithFormat:@"%@%@",SSKJLocalized(@"到账数量:", nil),[WLTools noroundingStringWith:_amountView.textField.text.doubleValue - self.entractInfoModel.tbFeeRate.doubleValue*_amountView.textField.text.doubleValue afterPointNumber:6]];
        
    }
   

}
-(UIButton *)smsButton
{
    if (nil == _smsButton) {
        _smsButton = [[UIButton alloc]initWithFrame:CGRectMake(self.smsCodeView.width - ScaleW(15) - ScaleW(100), ScaleW(50), ScaleW(100), ScaleW(30))];
        [_smsButton setTitle:SSKJLocalized(@"获取验证码", nil) forState:UIControlStateNormal];
        [_smsButton setTitleColor:WLColor(80,113,210, 1) forState:UIControlStateNormal];
        _smsButton.titleLabel.font = systemFont(ScaleW(15));
   
//        _smsButton.layer.masksToBounds = YES;
//        _smsButton.layer.cornerRadius = _smsButton.height / 2;
//        _smsButton.layer.borderColor = kTextBlueColor.CGColor;
//        _smsButton.layer.borderWidth = 1;
        [_smsButton addTarget:self action:@selector(getCode) forControlEvents:UIControlEventTouchUpInside];
    }
    return _smsButton;
}

-(UIButton *)submitButton
{
    if (nil == _submitButton) {
        _submitButton = [[UIButton alloc]initWithFrame:CGRectMake(ScaleW(12), self.usableLabel.bottom + ScaleW(40) , ScreenWidth - ScaleW(24), ScaleW(45))];
//        _submitButton.layer.cornerRadius = 4.0f;
//        _submitButton.backgroundColor = WLColor(80,113,210, 1);
        [_submitButton setTitle:SSKJLocalized(@"提币", nil)  forState:UIControlStateNormal];
        [_submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _submitButton.titleLabel.font = systemFont(ScaleW(16));
        [_submitButton setBackgroundImage:[UIImage imageNamed:@"login_Btn_bg"] forState:UIControlStateNormal];
        
        [_submitButton addTarget:self action:@selector(submitEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitButton;
}



#pragma mark - 获取支持的币种
-(void)requestCoinList
{
    

    NSDictionary *params = @{@"type":@"2"};

    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    WS(weakSelf);
    
    
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:JB_get_recharge_coin_list_URL RequestType:RequestTypeGet Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        
        WL_Network_Model *netModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        
        if (netModel.status.integerValue == SUCCESSED) {
            
            weakSelf.coinArray = [WLLAssetsInfoModel mj_objectArrayWithKeyValuesArray:netModel.data];
            
            [weakSelf setUI];
            
            weakSelf.model = weakSelf.coinArray.firstObject;
            weakSelf.showTile.text = [[weakSelf.model.code componentsSeparatedByString:@"_"].firstObject uppercaseString];
            [weakSelf.typeButton setTitle:weakSelf.showTile.text forState:UIControlStateNormal];

            [weakSelf requestCoinInfo];
            
            
        }else{
            [MBProgressHUD showError:responseObject[@"msg"]];
        }
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD showError:SSKJLocalized(@"加载失败", nil)];
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
    }];
}


#pragma mark - 用户操作

#pragma mark 选择地址

-(void)selectAddress
{
    BLAddAddressViewController *vc = [[BLAddAddressViewController alloc]init];
    WS(weakSelf);
    vc.fromVC = 1;
    vc.getAddressBlock = ^(NSString *addressStr) {
        weakSelf.addressView.valueString = addressStr;
    };
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - 获取验证码
-(void)getCode
{
    //    if (![RegularExpression validateMobile:kAccount]) {// 邮箱登录
    //        [self getEmailCode];
    //    }else{
    [self getSmsCodeEvent];
    //    }
}

// 获取手机验证码
-(void)getSmsCodeEvent
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"mobile"] = kISCMPhoneNumber;
    params[@"type"] = @"5";
    WS(weakSelf);
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:JB_GetEmailCode_URL RequestType:RequestTypeGet Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        
        WL_Network_Model *netModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if (netModel.status.integerValue == SUCCESSED) {
            [MBProgressHUD showError:netModel.msg];
            [weakSelf changeCheckcodeButtonState];
        } else {
            [MBProgressHUD showError:netModel.msg];
        }
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        
    }];
    
}



//获取邮箱验证码
- (void)getEmailCode{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"email"] = kISCMPhoneNumber;
    //    params[@"type"] = @"1";
    __weak typeof(self) weakSelf = self;
#pragma mark 处理
    //    [HttpTool postWithURL:Getsend_email params:params success:^(id json) {
    //        NSString *status = json[@"status"];
    //        if (status.integerValue == SUCCESSED) {
    //            dispatch_async(dispatch_get_main_queue(), ^{
    //                [weakSelf changeCheckcodeButtonState];
    //            });
    //        } else {
    //            [MBProgressHUD showError:SSKJLocalized(@"该手机号或邮箱未注册", nil)];
    //        }
    //    } failure:^(NSError *error) {
    //        [MBProgressHUD showError:SSKJLocalized(SSKJLocalized(@"网络出错", nil), nil)];
    //    }];
}


// 倒计时
- (void)changeCheckcodeButtonState {
    __block int timeout= 59; //倒计时时间
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
        
        if(timeout<=0){ //倒计时结束，关闭
            
            dispatch_source_cancel(_timer);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self.smsButton setTitle:SSKJLocalized(@"重新发送", nil) forState:UIControlStateNormal];
                self.smsButton.enabled = YES;
                
            });
            
        }else{
            
            int seconds = timeout % 60;
            
            NSString *strTime = [NSString stringWithFormat:SSKJLocalized(@"%ld秒", nil), seconds];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self.smsButton setTitle:[NSString stringWithFormat:@"%@",strTime] forState:UIControlStateDisabled];
                self.smsButton.enabled = NO;
                
            });
            
            timeout--;
            
        }
        
    });
    
    dispatch_resume(_timer);
}

#pragma mark - 请求提币信息

-(void)requestCoinInfo
{
    
    NSDictionary *params = @{
                             @"pid":self.model.pid
                             };
    WS(weakSelf);
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:JB_get_withdraw_coin_data_list_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        
        WL_Network_Model *netModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if (netModel.status.integerValue == SUCCESSED) {
            weakSelf.entractInfoModel = [BI_AssetExtractInfo_Model mj_objectWithKeyValues:netModel.data];
            [weakSelf resetView];
            weakSelf.addressView.textField.text = @"";

            weakSelf.amountView.textField.text = @"";
        }else{
            [MBProgressHUD showError:netModel.msg];
        }
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        
    }];
}


-(void)resetView
{
    self.amountView.textField.placeholder = [NSString stringWithFormat:@"%@%@",SSKJLocalized(@"最小提取", nil),self.entractInfoModel.tbMinRate];
    
    
    NSMutableAttributedString *placeholderString1 = [[NSMutableAttributedString alloc] initWithString: [NSString stringWithFormat:@"%@%@",SSKJLocalized(@"最小提取", nil),self.entractInfoModel.tbMinRate] attributes:@{NSForegroundColorAttributeName : UIColorFromRGB(0xffffff)}];
    
    _amountView.textField.attributedPlaceholder = placeholderString1;
    
    
    self.feeLabel.text = [NSString stringWithFormat:@"%@%@%%",SSKJLocalized(@"提币手续费", nil),self.entractInfoModel.tbFeeRate];
    
    self.pwdView.textField.text = [NSString stringWithFormat:@"%@:%@ %@",SSKJLocalized(@"可用", nil),[WLTools noroundingStringWith:self.entractInfoModel.useFund.doubleValue afterPointNumber:6],[[self.model.code componentsSeparatedByString:@"_"].firstObject uppercaseString]];
}

#pragma mark - 提币请求
-(void)submitEvent
{
    //个数范围校验
    
    

    
    double num =  self.amountView.valueString.doubleValue;
    NSString *max = self.entractInfoModel.tbMaxRate;
    NSString *min = self.entractInfoModel.tbMinRate;
    NSString * yuE = self.entractInfoModel.useFund;
    
    if (num < min.doubleValue) {
        [MBProgressHUD showError:[NSString stringWithFormat:@"%@%@",SSKJLocalized(@"最小提币数量为", nil),min]];
        return;
    }
    if (num > max.doubleValue) {
        [MBProgressHUD showError:[NSString stringWithFormat:@"%@%@",SSKJLocalized(@"最大提币数量为", nil),max]];
        return;
    }
    
    if (num > yuE.doubleValue) {
        [MBProgressHUD showError:SSKJLocalized(@"余额不足", nil)];
        return;
    }
    
    if (self.addressView.valueString.length == 0) {
        [MBProgressHUD showError:SSKJLocalized(@"请输入提币地址", nil)];
        return;
    }
    
    if (self.amountView.valueString.length == 0) {
        [MBProgressHUD showError:SSKJLocalized(@"请输入提币数量", nil)];
        return;
    }
    
    
    
    My_BindGoogle_AlertView * alertView = [[My_BindGoogle_AlertView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    WS(weakSelf);
    alertView.submitBlock = ^(NSString * _Nonnull googleCode, NSString * _Nonnull smsCode) {
        
     
        [weakSelf requestGetCoinAdress:googleCode withTpwd:smsCode];

    };
    [alertView showWithType:GOOGLETYPEADD];
    
    
    
    
}
-(void)requestGetTb
{
    
//    kIscm_get_tb_Api
    WS(weakSelf);
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
   
    [params setObject:[self.showTile.text isEqualToString:@"ETH"]?@(3):@(0) forKey:@"pid"];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:kIscm_get_tb_Api RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        WL_Network_Model *netModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if (netModel.status.integerValue == 200) {
          
//            self.amountView.textField.placeholder = [NSString stringWithFormat:@"%@%@",SSKJLocalized(@"最小提取", nil),netModel.data[@"tb_min"]];
            
            NSMutableAttributedString *placeholderString1 = [[NSMutableAttributedString alloc] initWithString: [NSString stringWithFormat:@"%@%@",SSKJLocalized(@"最小提取", nil),netModel.data[@"tb_min"]] attributes:@{NSForegroundColorAttributeName : UIColorFromRGB(0xffffff)}];
            
            self.amountView.textField.attributedPlaceholder = placeholderString1;
            
            
            self.feeLabel.text = [NSString stringWithFormat:@"%@%@%%",SSKJLocalized(@"提币手续费", nil),netModel.data[@"tb_fee"]];
            
            self.amountLabel.text =[NSString stringWithFormat:@"%@:%@%@",SSKJLocalized(@"可用", nil),netModel.data[@"balance"],self.showTile.text ];
            self.tb_max = netModel.data[@"tb_max"];
            self.tb_min = netModel.data[@"tb_min"];

            self.blance =netModel.data[@"balance"];
            
            self.rate = netModel.data[@"tb_fee"];
            self.usableLabel.text = [NSString stringWithFormat:@"%@--",SSKJLocalized(@"到账数量:", nil)];
        }else{
            [MBProgressHUD showError:responseObject[@"msg"]];
        }
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD showError:SSKJLocalized(@"请求超时", nil)];
        
    }];
    
    
}

-(void)requestGetCoinAdress:(NSString *)adressStr withTpwd:(NSString *)tpwd
{
    WS(weakSelf);
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[SSKJ_User_Tool sharedUserTool].userInfoModel.email forKey:@"account"];
    [params setObject:self.amountView.valueString forKey:@"num"];
    [params setObject:[WLTools md5:tpwd] forKey:@"tpwd"];
    //先不添加
    [params setObject:self.model.pid forKey:@"pid"];
    [params setObject:self.addressView.valueString forKey:@"address"];
    [params setObject:adressStr forKey:@"code"];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:kIscm_order_ti_bi_Api RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        WL_Network_Model *netModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if (netModel.status.integerValue == 200) {
            [MBProgressHUD showError:responseObject[@"msg"]];
            weakSelf.addressView.valueString = nil;
            weakSelf.amountView.valueString = nil;
            weakSelf.pwdView.valueString = nil;
            weakSelf.smsCodeView.valueString = nil;
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }else{
            [MBProgressHUD showError:responseObject[@"msg"]];
        }
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD showError:SSKJLocalized(@"请求超时", nil)];
        
    }];
    
    
    
    //    [HttpTool postWithURL:TiBiURL params:params success:^(id json) {
    //        NSString *status = json[@"status"];
    //        if (status.integerValue == SUCCESSED) {
    //            dispatch_async(dispatch_get_main_queue(), ^{
    //        } else {
    //            [MBProgressHUD showSuccess:json[@"msg"]];
    //        }
    //    } failure:^(NSError *error) {
    //        [MBProgressHUD showSuccess:SSKJLocalized(@"请求超时", nil)];
    //    }];
}

- (My_TB_ChooseCoin_AlertView *)tbAlertView
{
    if (_tbAlertView == nil) {
        
        _tbAlertView = [[My_TB_ChooseCoin_AlertView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        
        WS(weakSelf);
        
        _tbAlertView.coinBlock = ^(WLLAssetsInfoModel * _Nonnull model) {
            
            weakSelf.tbAlertView.hidden = YES;
            
            weakSelf.model = model;
            
            [weakSelf requestCoinInfo];
            
        };
        _tbAlertView.hidden = YES;
        
        [self.view addSubview:_tbAlertView];
    }
    return _tbAlertView;
}

- (void)hiddenAlertView
{
    self.tbAlertView.hidden = YES;
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
