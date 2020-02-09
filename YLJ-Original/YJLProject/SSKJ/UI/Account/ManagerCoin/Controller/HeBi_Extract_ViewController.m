//
//  HeBi_Extract_ViewController.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/4/15.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "HeBi_Extract_ViewController.h"

// view
#import "HeBi_TitleAndInput_View.h"

// controller
#import "HeBi_AddressManager_ViewController.h"
#import "HeBi_TiBi_Record_ViewController.h"
// model
#import "HeBi_TiBiInfo_Model.h"
#import "RegularExpression.h"
#import "JB_CoinAssets_DoorViewController.h"
#import "JB_Account_Asset_CoinModel.h"
#import "ETF_Default_ActionsheetView.h"
#import "ETF_AssestRecordHeaderView.h"
#import "JB_CoinAssets_DoorViewController.h"


@interface HeBi_Extract_ViewController ()<UITextFieldDelegate>
@property (nonatomic, strong) HeBi_TitleAndInput_View *usableView;  // 可用
@property (nonatomic, strong) HeBi_TitleAndInput_View *addressView;  // 地址
@property (nonatomic, strong) UIButton *addressButton;
@property (nonatomic, strong) HeBi_TitleAndInput_View *amountView;  // 数量

@property (nonatomic, strong) UILabel *unitLabel;   // 单位
@property (nonatomic, strong) UIButton *allButton;//全部按钮
@property (nonatomic, strong) UILabel *feeLabel;   // 收付费
@property (nonatomic, strong) UILabel *maxLabel;  // 可提币最大数量
@property (nonatomic, strong) HeBi_TitleAndInput_View *pwdView;  // 安全密码
@property (nonatomic, strong) HeBi_TitleAndInput_View *smsCodeView; // 验证码
@property (nonatomic, strong) UIButton *smsCodebutton;

@property (nonatomic, strong) UIButton *confirmButton;

@property (nonatomic, strong) HeBi_TiBiInfo_Model *tibiInfoModel;
@property (nonatomic, strong) ETF_AssestRecordHeaderView *recordView;
@property (nonatomic, strong) NSMutableArray *coinArray;
@property (nonatomic, strong) JB_Account_Asset_Index_Model *selectedModel;


@end

@implementation HeBi_Extract_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.title = [NSString stringWithFormat:@"%@%@",self.coinModel.pname,SSKJLocalized(@"提币", nil)];
    self.title = SSKJLocalized(@"提币", nil);
    self.coinArray = [[NSMutableArray alloc]init];
    [self addRightNavgationItemWithImage:[UIImage imageNamed:@"mine_jiaoyijilu"]];
    [self setUI];
    [self requestLicaiCoinList];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.translucent = YES;
}

-(void)rigthBtnAction:(id)sender
{
    JB_CoinAssets_DoorViewController *vc = [[JB_CoinAssets_DoorViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)uploadCoinInfo {
    self.recordView.coinItem.contentLB.text = self.selectedModel.pname?:@"";
    self.usableView.valueString = [NSString stringWithFormat:@"%@%@",[WLTools noroundingStringWith:self.selectedModel.usable.doubleValue afterPointNumber:8],self.selectedModel.pname?:@""];
    self.amountView.textField.placeholder = [NSString stringWithFormat:@"%@%@",SSKJLocalized(@"最小提币数量", nil),self.selectedModel.tb_min?:@""];
    self.unitLabel.text = self.selectedModel.pname?:@"";
    

    [self calculateInput:self.amountView.textField.text.doubleValue];
    self.feeLabel.text = [NSString stringWithFormat:@"%@：%@%%",SSKJLocalized(@"手续费", nil),[WLTools noroundingStringWith:self.selectedModel.tb_fee_rate.doubleValue afterPointNumber:8]];

}

- (void)allButtonClick {
    self.amountView.textField.text = [WLTools noroundingStringWith:self.selectedModel.usable.doubleValue afterPointNumber:8];
    [self calculateInput:self.amountView.textField.text.doubleValue];
}

- (void)calculateInput:(double)input {
    double dzFloat = input;
    if (dzFloat <= 0) {
        self.maxLabel.text = [NSString stringWithFormat:@"%@%@",SSKJLocalized(@"到账数量", nil),@"0"];
    }else{
        self.maxLabel.text = [NSString stringWithFormat:@"%@%@",SSKJLocalized(@"到账数量", nil),[WLTools noroundingStringWith:dzFloat afterPointNumber:8]];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([textField isEqual:self.amountView.textField]) {
        NSMutableString * futureString = [NSMutableString stringWithString:textField.text];
        if ([string isEqualToString:@""]) {
            [futureString replaceCharactersInRange:range withString:string];
        }else{
            [futureString  insertString:string atIndex:range.location];
        }
        [self calculateInput:futureString.doubleValue];

    }
    return YES;
}

#pragma mark - UI

-(void)setUI
{
    [self.view addSubview:self.recordView];
    [self.view addSubview:self.usableView];
    [self.view addSubview:self.addressView];
    [self.addressView addSubview:self.addressButton];
    [self.view addSubview:self.amountView];
    [self.amountView addSubview:self.unitLabel];
    [self.amountView addSubview:self.allButton];
    [self.view addSubview:self.maxLabel];
    [self.view addSubview:self.feeLabel];
    [self.view addSubview:self.pwdView];
    [self.view addSubview:self.smsCodeView];
    [self.smsCodeView addSubview:self.smsCodebutton];
    
    [self.view addSubview:self.confirmButton];
}



-(HeBi_TitleAndInput_View *)usableView
{
    if (nil == _usableView) {
        _usableView = [[HeBi_TitleAndInput_View alloc]initWithFrame:CGRectMake(0,self.recordView.bottom+ ScaleW(5), ScreenWidth, ScaleW(80)) leftGap:ScaleW(15) title:SSKJLocalized(@"可用", nil) placeHolder:SSKJLocalized(@"", nil) keyBoardType:UIKeyboardTypeDefault isSecured:NO];
        _usableView.textField.enabled = NO;
        _usableView.valueString = [NSString stringWithFormat:@"0.0000%@",self.coinModel.pname?:@""];
        _usableView.titleLabel.textColor = [UIColor colorWithHexStringToColor:@"6b6fb9"];
        _usableView.textField.textColor = [UIColor colorWithHexStringToColor:@"a7abdb"];
    }
    return _usableView;
}

-(HeBi_TitleAndInput_View *)addressView
{
    if (nil == _addressView) {
        _addressView = [[HeBi_TitleAndInput_View alloc]initWithFrame:CGRectMake(0, self.usableView.bottom, ScreenWidth , ScaleW(80)) leftGap:ScaleW(15) title:SSKJLocalized(@"提币地址", nil) placeHolder:SSKJLocalized(@"输入或长按粘贴地址", nil) keyBoardType:UIKeyboardTypeASCIICapable isSecured:NO];
        
    }
    return _addressView;
}

-(UIButton *)addressButton
{
    if (nil == _addressButton) {
        _addressButton = [[UIButton alloc]initWithFrame:CGRectMake(self.addressView.width - ScaleW(47), 0, ScaleW(47), ScaleW(40))];
        _addressButton.centerY = self.addressView.textField.centerY;
        [_addressButton setImage:[UIImage imageNamed:@"tibi-dzlb"] forState:UIControlStateNormal];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0.5, ScaleW(15))];
        lineView.backgroundColor = kLineGrayColor;
        lineView.centerY = _addressButton.height / 2;
        [_addressButton addSubview:lineView];
        
        [_addressButton addTarget:self action:@selector(selectAddress) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addressButton;
    
}


-(HeBi_TitleAndInput_View *)amountView
{
    if (nil == _amountView) {
        _amountView = [[HeBi_TitleAndInput_View alloc]initWithFrame:CGRectMake(0, self.addressView.bottom , ScreenWidth, ScaleW(80)) leftGap:ScaleW(15) title:SSKJLocalized(@"数量", nil) placeHolder:SSKJLocalized(@"最小提币数量", nil) keyBoardType:UIKeyboardTypeDecimalPad isSecured:NO];
        _amountView.textField.delegate = self;
    }
    return _amountView;
}

-(UILabel *)unitLabel
{
    
    if (nil == _unitLabel) {
        _unitLabel = [WLTools allocLabel:self.coinModel.pname font:systemFont(ScaleW(14)) textColor:[UIColor colorWithHexStringToColor:@"878ff5"] frame:CGRectMake(self.amountView.width - ScaleW(56)*2-ScaleW(10), 0, ScaleW(56), ScaleW(30)) textAlignment:NSTextAlignmentCenter];
        _unitLabel.centerY = self.amountView.textField.centerY;
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0.5, ScaleW(15))];
        lineView.backgroundColor = kLineGrayColor;
        lineView.centerY = _unitLabel.height / 2;
        [_unitLabel addSubview:lineView];
        _unitLabel.text = @"AB";
        
    }
    return _unitLabel;
}

- (UIButton *)allButton {
    if (!_allButton) {
        _allButton = [[UIButton alloc]initWithFrame:CGRectMake(self.amountView.width-ScaleW(56), 0, ScaleW(56), ScaleW(30))];
        [_allButton setTitle:SSKJLocalized(@"全部", nil) forState:UIControlStateNormal];
        [_allButton setTitleColor:[UIColor colorWithHexStringToColor:@"878ff5"] forState:UIControlStateNormal];
        _allButton.titleLabel.font = [UIFont systemFontOfSize:ScaleW(14)];
        _allButton.centerY = self.amountView.textField.centerY;
        [_allButton addTarget:self action:@selector(allButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _allButton;
    
}
- (UILabel *)maxLabel
{
    if (nil == _maxLabel) {
        _maxLabel = [WLTools allocLabel:@"" font:systemFont(ScaleW(11.5)) textColor:[UIColor colorWithHexStringToColor:@"5b5e95"] frame:CGRectMake(ScaleW(15), self.amountView.bottom, ScreenWidth - ScaleW(75), ScaleW(30)) textAlignment:NSTextAlignmentLeft];
        
        _maxLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _maxLabel;
}
- (UILabel *)feeLabel{
    if (nil == _feeLabel) {
        _feeLabel = [WLTools allocLabel:@"" font:systemFont(ScaleW(11.5)) textColor:[UIColor colorWithHexStringToColor:@"5b5e95"] frame:CGRectMake(ScreenWidth - ScaleW(210), self.amountView.bottom, ScaleW(200), ScaleW(30)) textAlignment:NSTextAlignmentRight];
        _feeLabel.adjustsFontSizeToFitWidth = YES;
//        _feeLabel.backgroundColor = kSubBackgroundColor;
        
    }
    return _feeLabel;
}

-(HeBi_TitleAndInput_View *)pwdView
{
    if (nil == _pwdView) {
        _pwdView = [[HeBi_TitleAndInput_View alloc]initWithFrame:CGRectMake(0, self.maxLabel.bottom, ScreenWidth, ScaleW(80)) leftGap:ScaleW(15) title:SSKJLocalized(@"安全密码", nil) placeHolder:SSKJLocalized(@"请输入安全密码", nil) keyBoardType:UIKeyboardTypeASCIICapable isSecured:YES];
        _pwdView.secureButton.hidden = YES;
    }
    return _pwdView;
}

-(HeBi_TitleAndInput_View *)smsCodeView
{
    if (nil == _smsCodeView) {
        
        NSString *title = SSKJLocalized(@"手机验证码", nil);
        NSString *placeHolder = SSKJLocalized(@"请输入手机验证码", nil);
        
        if ([kauth_emailIndex integerValue] == 1) {
            title = SSKJLocalized(@"邮箱验证码", nil);
            placeHolder = SSKJLocalized(@"请输入邮箱验证码", nil);
        }
        
        _smsCodeView = [[HeBi_TitleAndInput_View alloc]initWithFrame:CGRectMake(0, self.pwdView.bottom, ScreenWidth, ScaleW(80)) leftGap:ScaleW(15) title:title placeHolder:placeHolder keyBoardType:UIKeyboardTypeASCIICapable isSecured:NO];
    }
    return _smsCodeView;
}

-(UIButton *)smsCodebutton
{
    if (nil == _smsCodebutton) {
        _smsCodebutton = [[UIButton alloc]initWithFrame:CGRectMake(self.addressView.width - ScaleW(100), 0, ScaleW(100), ScaleW(40))];
        _smsCodebutton.centerY = self.smsCodeView.textField.centerY;
        [_smsCodebutton setTitle:SSKJLocalized(@"获取验证码", nil) forState:UIControlStateNormal];
        [_smsCodebutton setTitleColor:[UIColor colorWithHexStringToColor:@"878ff5"] forState:UIControlStateNormal];
        [_smsCodebutton setTitleColor:kLineGrayColor forState:UIControlStateDisabled];
        _smsCodebutton.titleLabel.font = systemFont(ScaleW(13));
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0.5, ScaleW(15))];
        lineView.backgroundColor = kLineGrayColor;
        lineView.centerY = _smsCodebutton.height / 2;
        [_smsCodebutton addSubview:lineView];
        
        [_smsCodebutton addTarget:self action:@selector(getSmsCode) forControlEvents:UIControlEventTouchUpInside];
    

    }
    return _smsCodebutton;
    
}


-(UIButton *)confirmButton
{
    if (nil == _confirmButton) {

        
        _confirmButton = [[UIButton alloc]initWithFrame:CGRectMake(ScaleW(15), self.smsCodeView.bottom + ScaleW(31), ScreenWidth - ScaleW(30), ScaleW(45))];
//        _confirmButton.backgroundColor = kMainTextColor;
        [_confirmButton setTitle:SSKJLocalized(@"提币", nil) forState:UIControlStateNormal];
        [_confirmButton setTitleColor:kMainWihteColor forState:UIControlStateNormal];
        _confirmButton.titleLabel.font = systemBoldFont(ScaleW(15));
        _confirmButton.layer.cornerRadius = _confirmButton.height / 2;
        [_confirmButton addTarget:self action:@selector(confirmEvent) forControlEvents:UIControlEventTouchUpInside];
        [_confirmButton addGradientColor];
        _confirmButton.layer.cornerRadius = ScaleW(5);
        _confirmButton.layer.masksToBounds = YES;
    }
    return _confirmButton;
}

- (ETF_AssestRecordHeaderView *)recordView {
    if (!_recordView) {
        _recordView = [[ETF_AssestRecordHeaderView alloc]initWithFrame:CGRectMake(0, ScaleW(10), ScreenWidth, ScaleW(50))];
        _recordView.typeItem.hidden = YES;
        _recordView.coinItem.titleLB.text = SSKJLocalized(@"币种", nil);
        _recordView.coinItem.contentLB.text = @"BTC";
        _recordView.backgroundColor = kMainBackgroundColor;
        WS(weakSelf);
        _recordView.coinBlock = ^{
            NSArray *titles = [weakSelf.coinArray valueForKeyPath:@"pname"];
            [ETF_Default_ActionsheetView showWithItems:titles title:@"" selectedIndexBlock:^(NSInteger selectIndex) {
                weakSelf.selectedModel = weakSelf.coinArray[selectIndex];
                [weakSelf uploadCoinInfo];
            } cancleBlock:^{
                
            }];
        };
        
    }
    return _recordView;
}




#pragma mark - 用户操作

// 选择地址
-(void)selectAddress
{
    HeBi_AddressManager_ViewController *vc = [[HeBi_AddressManager_ViewController alloc]init];
    WS(weakSelf);
    vc.addressSelectBlock = ^(HeBi_WalletAddress_Model * _Nonnull addressModel) {
        weakSelf.addressView.valueString = addressModel.qiaobao_url;
    };
    [self.navigationController pushViewController:vc animated:YES];
}

// 获取验证码
-(void)getSmsCode
{

    if ([RegularExpression validateMobile:kPhoneNumber] ) {
        [self requestSmsCode];
    }else{
        [self requestEmailCode];
    }
}


// 确认提取
-(void)confirmEvent
{
    if (self.addressView.valueString.length == 0) {
        [MBProgressHUD showError:SSKJLocalized(@"请输入提币地址", nil)];
        return;
    }
    
    if (self.amountView.valueString.length == 0) {
        [MBProgressHUD showError:SSKJLocalized(@"请输入提币数量", nil)];
        return;
    }
    
    if (self.amountView.valueString.doubleValue < self.selectedModel.tb_min.doubleValue) {
        [MBProgressHUD showError:[NSString stringWithFormat:@"%@%@ %@",SSKJLocalized(@"最小提币数量", nil),self.selectedModel.tb_min,self.selectedModel.pname?:@""]];
        return;
    }
    
    if (self.amountView.valueString.doubleValue > self.selectedModel.tb_max.doubleValue) {
        [MBProgressHUD showError:[NSString stringWithFormat:@"%@%@ %@",SSKJLocalized(@"可提币最大数量", nil),self.selectedModel.tb_max,self.selectedModel.pname?:@""]];
        return;
    }
    
    if (self.amountView.valueString.doubleValue == 0) {
        [MBProgressHUD showError:SSKJLocalized(@"提币数量不能为0", nil)];
        return;
    }
    
    if (self.pwdView.valueString.length == 0) {
        [MBProgressHUD showError:SSKJLocalized(@"请输入安全密码", nil)];
        return;
    }
    
    if (self.smsCodeView.valueString.length == 0) {
        [MBProgressHUD showError:SSKJLocalized(@"请输入手机验证码", nil)];
        return;
    }
    
    [self requestExtract];
}



#pragma mark - 倒计时
// 倒计时
- (void)changeCheckcodeButtonState {
    self.smsCodebutton.enabled = NO;
    __block int timeout=60; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    
    dispatch_source_set_timer(timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    WS(weakSelf);
    dispatch_source_set_event_handler(timer, ^{
        
        if(timeout<=0){ //倒计时结束，关闭
            
            dispatch_source_cancel(timer);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置界面的按钮显示 根据自己需求设置
                
                [weakSelf.smsCodebutton setTitle:SSKJLocalized(@"重新发送", nil) forState:UIControlStateNormal];
                
                weakSelf.smsCodebutton.enabled = YES;
                
            });
            
        }else{
            int seconds = timeout % 61;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [weakSelf.smsCodebutton setTitle:[NSString stringWithFormat:@"%@s%@",strTime,SSKJLocalized(@"重新获取", nil)] forState:UIControlStateDisabled];
                
                //标记第一次点击的时候，当在此启用倒计时的时候 可点击
                
                // sender.userInteractionEnabled =!_isGetPawd;
                
            });
            timeout--;
        }
    });
    dispatch_resume(timer);
}

#pragma mark - 网络请求


-(void)handleCoinInfoWithModel:(WL_Network_Model *)net_model
{
    self.tibiInfoModel = [HeBi_TiBiInfo_Model mj_objectWithKeyValues:net_model.data];
    self.usableView.valueString = [NSString stringWithFormat:@"%@ %@",[WLTools noroundingStringWith:self.tibiInfoModel.balance.doubleValue afterPointNumber:8],self.coinModel.pname];
    self.amountView.textField.placeholder = [NSString stringWithFormat:@"%@%@",SSKJLocalized(@"最小提币数量", nil),self.tibiInfoModel.tb_min];
    self.maxLabel.text = [NSString stringWithFormat:@"%@（%@）：%@",SSKJLocalized(@"可提币最大数量", nil),self.coinModel.pname,self.tibiInfoModel.tb_max];
    self.feeLabel.text = [NSString stringWithFormat:@"%@%@%%",SSKJLocalized(@"手续费", nil),self.tibiInfoModel.tb_fee?:@""];
}

#pragma mark 请求验证码

-(void)requestSmsCode
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"mobile"] = [SSKJ_User_Tool sharedUserTool].userInfoModel.mobile?:@"";
    params[@"type"] = @"5";
    WS(weakSelf);
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:JB_GetSMSCode_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        WL_Network_Model *network_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if ([network_model.status integerValue] == SUCCESSED) {
            [MBProgressHUD showError:network_model.msg];
            [weakSelf changeCheckcodeButtonState];
        }else{
            [MBProgressHUD showError:network_model.msg];
        }
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        //[MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
    }];
   
}


#pragma mark - 请求邮箱验证码
-(void)requestEmailCode
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"email"] = kPhoneNumber;
    
    WS(weakSelf);
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:JB_GetEmailCode_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        WL_Network_Model *network_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if ([network_model.status integerValue] == SUCCESSED) {
            [MBProgressHUD showError:network_model.msg];
            [weakSelf changeCheckcodeButtonState];
        }else{
            [MBProgressHUD showError:network_model.msg];
        }
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        //[MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
    }];
}

#pragma mark 请求提币
-(void)requestExtract
{
    NSDictionary *params = @{
                             @"num":self.amountView.valueString,
                             @"type":self.selectedModel.pid,
                             @"tpwd":[WLTools md5:self.pwdView.valueString?:@""],
                             @"code":self.smsCodeView.valueString,
                             @"qianbao_url":self.addressView.valueString
                             };
    
    WS(weakSelf);
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:JB_TiBi_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        WL_Network_Model *network_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if ([network_model.status integerValue] == SUCCESSED) {
            [weakSelf clearView];
            JB_CoinAssets_DoorViewController *vc = [[JB_CoinAssets_DoorViewController alloc]init];
            [weakSelf.navigationController pushViewController:vc animated:YES];
            
        }else{
            [MBProgressHUD showError:network_model.msg];
        }
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        //[MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
    }];
    
}

-(void)clearView
{
    self.amountView.valueString = @"";
    self.pwdView.valueString = @"";
    self.smsCodeView.valueString = @"";
    self.addressView.valueString = @"";

}


// 请求币种列表
-(void)requestLicaiCoinList
{
    WS(weakSelf);
    
    NSString *url = JB_Account_DealAsset_URL;
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:url RequestType:RequestTypePost Parameters:nil Success:^(NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        WL_Network_Model *network_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if ([network_model.status integerValue] == SUCCESSED) {
            [weakSelf handleExchangeListWithModel:network_model];
        }else{
            [MBProgressHUD showError:network_model.msg];
        }
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        
        //[MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
    }];
    
}

-(void)handleExchangeListWithModel:(WL_Network_Model *)net_model
{
    
    JB_Account_Asset_CoinModel *assetModel = [JB_Account_Asset_CoinModel mj_objectWithKeyValues:net_model.data[@"res"]];
    [self.coinArray removeAllObjects];
    
    for (JB_Account_Asset_Index_Model *model in assetModel.asset) {
        if (model.is_act.integerValue == 1) {
            [self.coinArray addObject:model];
        }
    }
    self.selectedModel = self.coinArray.firstObject;
    self.recordView.coinItem.contentLB.text = self.selectedModel.pname?:@"";
    [self uploadCoinInfo];
}


@end
