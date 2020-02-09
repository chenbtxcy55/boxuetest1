//
//  YLJAddBankViewController.m
//  SSKJ
//
//  Created by cy5566 on 2019/11/22.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "YLJAddBankViewController.h"
#import "HeBi_InputView.h"

@interface YLJAddBankViewController ()
//1注册 2 （重置/修改） 3 安全验证 4 安全密码设置 5 提币
@property (nonatomic,copy) NSString *smsType;

@property (nonatomic,strong) HeBi_InputView *accountView;
@property (nonatomic,strong) HeBi_InputView *bankTypeView;
@property (nonatomic,strong) HeBi_InputView *bankBranchView;
//@property (nonatomic, strong) UIButton *getSMSCodeButton;
@property (nonatomic,strong) HeBi_InputView *bankAcountView;
@property (nonatomic,strong) UIButton *submitBtn;
@property (nonatomic,strong) UIView *topView;
@end

@implementation YLJAddBankViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    

    [self.view addSubview:self.topView];
    [self.view addSubview:self.accountView];
    [self.view addSubview:self.bankTypeView];
    [self.view addSubview:self.bankBranchView];
//    [self.view addSubview:self.getSMSCodeButton];
    [self.view addSubview:self.bankAcountView];
    [self.view addSubview:self.submitBtn];

    

    self.title = SSKJLocalized(@"添加银行卡", nil);
    if (self.aType) {
        self.title = SSKJLocalized(@"修改银行卡", nil);
        [self.submitBtn setTitle:SSKJLocalized(@"修改银行卡", nil) forState:UIControlStateNormal];
    }
}

- (void)setBModel:(YLJBankInfoModel *)bModel {
    _bModel = bModel;

    self.accountView.textField.text = bModel.bank_user_name;
    self.bankTypeView.textField.text = bModel.bank_name;
    self.bankBranchView.textField.text = bModel.bank_open;
    self.bankAcountView.textField.text = bModel.bank_user_number;
    
}


- (void)submitEvent {
    if (self.accountView.valueString.length == 0) {
        [MBProgressHUD showError:@"请填写您本人的真实姓名"];
        return;
    }
    if (self.bankTypeView.valueString.length == 0) {
        [MBProgressHUD showError:@"请输入银行卡类型"];
        return;
    }
    if (self.bankBranchView.valueString.length == 0) {
        [MBProgressHUD showError:@"请输入开户行"];
        return;
    }
    if (self.bankAcountView.valueString.length == 0) {
        [MBProgressHUD showError:@"请输入银行卡号"];
        return;
    }
    [self requstData];
}

- (void)requstData {
    NSDictionary * params;
    params = @{
                   @"bank_user_name":self.accountView.valueString,
                  @"bank_name":self.bankTypeView.valueString,
                  @"bank_open":self.bankBranchView.valueString,
                   @"bank_number":self.bankAcountView.valueString,
                  };
//    if (self.aType) {
//        params = @{
//                       @"bank_user_name":self.accountView.valueString,
//                      @"bank_name":self.bankTypeView.valueString,
//                      @"bank_open":self.bankBranchView.valueString,
//                      @"bank_number":[WLTools md5:self.bankAcountView.valueString],
//                      };
//    }

    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    WS(weakSelf);
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:JB_Account_Bank_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        WL_Network_Model *network_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if ([network_model.status integerValue] == SUCCESSED) {
            [self.navigationController popViewControllerAnimated:YES];
        }else{
        }
        [MBProgressHUD showError:network_model.msg];
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        [MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
    }];
}

- (HeBi_InputView *)accountView
{
    if (nil == _accountView) {
        _accountView = [[HeBi_InputView alloc] initWithFrame:CGRectMake(ScaleW(15), self.topView.bottom + ScaleW(10), ScreenWidth-ScaleW(30), ScaleW(41)) titleWidth:ScaleW(95) gap:ScaleW(16)  titleName:SSKJLocalized(@"姓名", nil) placeHolder:SSKJLocalized(@"请填写您本人的真实姓名", nil) keyboardType:UIKeyboardTypeDefault isSecured:NO];
    }
    return _accountView;
}

- (HeBi_InputView *)bankTypeView
{
    if (nil == _bankTypeView) {
        _bankTypeView = [[HeBi_InputView alloc] initWithFrame:CGRectMake(ScaleW(15), self.accountView.bottom + ScaleW(10), ScreenWidth-ScaleW(30), ScaleW(41)) titleWidth:ScaleW(95) gap:ScaleW(16)  titleName:SSKJLocalized(@"银行卡类型", nil) placeHolder:SSKJLocalized(@"请输入银行卡类型", nil) keyboardType:UIKeyboardTypeDefault isSecured:NO];
    }
    return _bankTypeView;
}

- (HeBi_InputView *)bankBranchView {
    if (nil == _bankBranchView) {
        _bankBranchView = [[HeBi_InputView alloc] initWithFrame:CGRectMake(ScaleW(15),_bankTypeView.bottom + ScaleW(10), ScreenWidth-ScaleW(30), ScaleW(41)) titleWidth:ScaleW(95) gap:ScaleW(16)  titleName:SSKJLocalized(@"开户行", nil) placeHolder:SSKJLocalized(@"请输入开户行", nil) keyboardType:UIKeyboardTypeDefault isSecured:NO];
    }
    return _bankBranchView;
}

//-(UIButton *)getSMSCodeButton
//{
//    if (nil == _getSMSCodeButton) {
//        _getSMSCodeButton = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth - ScaleW(134) - ScaleW(15), 0, ScaleW(134), ScaleW(40))];
//        _getSMSCodeButton.centerY = self.bankBranchView.centerY;
//        [_getSMSCodeButton setTitle:SSKJLocalized(@"获取验证码", nil) forState:UIControlStateNormal];
//        [_getSMSCodeButton setTitleColor:kTheMeColor forState:UIControlStateNormal];
//        _getSMSCodeButton.titleLabel.font = systemFont(ScaleW(16));
//        [_getSMSCodeButton addTarget:self action:@selector(getSmsCodeEvent) forControlEvents:UIControlEventTouchUpInside];
//    }
//    return _getSMSCodeButton;
//}
- (UIView *)topView {
    if (!_topView) {
        _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleW(45))];
        _topView.backgroundColor = kSubBackgroundColor;
        UILabel *label = [FactoryUI createLabelWithFrame:CGRectMake(ScaleW(15), 0, ScaleW(200), ScaleW(12)) text:SSKJLocalized(@"请填写您本人真实的银行卡信息", nil) textColor:kGrayTitleColor font:systemFont(ScaleW(12))];
        label.centerY = _topView.centerY;
        [_topView addSubview:label];
    }
    return _topView;
}


- (HeBi_InputView *)bankAcountView {
    if (nil == _bankAcountView) {
        _bankAcountView = [[HeBi_InputView alloc] initWithFrame:CGRectMake(ScaleW(15),self.bankBranchView.bottom + ScaleW(10), ScreenWidth-ScaleW(30), ScaleW(41)) titleWidth:ScaleW(95) gap:ScaleW(16)  titleName:SSKJLocalized(@"银行卡号", nil) placeHolder:SSKJLocalized(@"请输入银行卡号", nil) keyboardType:UIKeyboardTypeNumberPad isSecured:NO];
    }
    return _bankAcountView;
}



-(UIButton *)submitBtn
{
    if (nil == _submitBtn) {
        _submitBtn = [[UIButton alloc]initWithFrame:CGRectMake(ScaleW(15), self.bankAcountView.bottom + ScaleW(83), ScreenWidth - ScaleW(30), ScaleW(45))];
        [_submitBtn setTitle:SSKJLocalized(@"添加银行卡", nil) forState:UIControlStateNormal];
        [_submitBtn setTitleColor:kMainWihteColor forState:UIControlStateNormal];
        _submitBtn.titleLabel.font = systemBoldFont(ScaleW(16));
        
        [_submitBtn addTarget:self action:@selector(submitEvent) forControlEvents:UIControlEventTouchUpInside];
        [_submitBtn setBackgroundColor:kTheMeColor];
        [_submitBtn setCornerRadius:ScaleW(5)];
    }
    return _submitBtn;
}



@end
