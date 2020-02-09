//
//  ActivateDetailViewController.m
//  SSKJ
//
//  Created by zhao on 2019/10/9.
//  Copyright © 2019 刘小雨. All rights reserved.
//
/*
 套餐详情
 */
#import "ActivateDetailViewController.h"
#import "ActivateSuccessViewController.h"
#import "ActivateViewModel.h"

@interface ActivateDetailViewController ()

@property (nonatomic,strong)UILabel *priceUSDTLab;
@property (nonatomic,strong)UILabel *priceYECLab;
@property (nonatomic,strong)UILabel *detailLab;

@property (nonatomic,strong)UILabel *payUSDTLab;
@property (nonatomic,strong)UILabel *payYECLab;
@property (nonatomic, strong)UIButton *cancleButton;
@property (nonatomic, strong)UIButton *confirmButton;
@property (nonatomic,strong)ActivateViewModel *detailModel;
@end

@implementation ActivateDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = SSKJLocalized(@"套餐详情", nil);
    self.view.backgroundColor = kNavBGColor;
    [self createUI];
    [self requstListrequset];

}
- (void)createUI{
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, ScaleW(5))];
    lineView.backgroundColor = kMainColor;
    [self.view addSubview:lineView];
    
   
    [self.view addSubview:self.priceUSDTLab];
    [self.view addSubview:self.priceYECLab];
    [self.priceYECLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.priceUSDTLab.mas_centerY);
        make.right.equalTo(self.view.mas_right).offset(-ScaleW(15));
        make.width.equalTo(@((Screen_Width/2 - ScaleW(20))));
    }];

    UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(0, self.priceUSDTLab.bottom, Screen_Width, ScaleW(5))];
    lineView1.backgroundColor = kMainColor;
    [self.view addSubview:lineView1];
    
   
    
    UILabel *titleLab = [WLTools allocLabel:SSKJLocalized(@"套餐明细", nil) font:systemFont(ScaleW(15)) textColor:kMainWihteColor frame:CGRectMake(ScaleW(15), lineView1.bottom, (Screen_Width - ScaleW(30)), ScaleW(45)) textAlignment:NSTextAlignmentLeft];
    titleLab.numberOfLines = 1;
    [self.view addSubview:titleLab];
    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(0, titleLab.bottom, Screen_Width, ScaleW(1))];
    lineView2.backgroundColor = kMainColor;
    [self.view addSubview:lineView2];
    
    [self.view addSubview:self.detailLab];

    [self.detailLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(ScaleW(28));
        make.right.equalTo(self.view.mas_right).offset(ScaleW(-28));
        make.top.equalTo(lineView2.mas_bottom).offset(ScaleW(21));
    }];
    
    [self.view addSubview:self.payUSDTLab];
    [self.view addSubview:self.payYECLab];

   
    [self.payUSDTLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(ScaleW(28));
        make.top.equalTo(self.detailLab.mas_bottom).offset(ScaleW(20));
        make.width.equalTo(@(ScaleW(140)));
    }];
    [self.payYECLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(ScaleW(176));
        make.top.equalTo(self.detailLab.mas_bottom).offset(ScaleW(20));
        make.width.equalTo(@(ScaleW(170)));
    }];
    
    [self.view addSubview:self.cancleButton];
    [self.view addSubview:self.confirmButton];
    [self.cancleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.bottom.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(Screen_Width/2, ScaleW(45)));
    }];
    [self.confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view);
        make.left.equalTo(self.cancleButton.mas_right);
        make.size.mas_equalTo(CGSizeMake(Screen_Width/2, ScaleW(45)));
    }];
}

- (UILabel *)priceUSDTLab{
    if (!_priceUSDTLab) {
        _priceUSDTLab = [WLTools allocLabel:SSKJLocalized(@"可用：", nil) font:systemFont(ScaleW(15)) textColor:kMainWihteColor frame:CGRectMake(ScaleW(15), ScaleW(5), (Screen_Width/2 - ScaleW(20)), ScaleW(45)) textAlignment:NSTextAlignmentLeft];
        _priceUSDTLab.numberOfLines = 1;
    }
    return _priceUSDTLab;
}
- (UILabel *)priceYECLab{
    if (!_priceYECLab) {
        _priceYECLab = [WLTools allocLabel:SSKJLocalized(@"可用：", nil) font:systemFont(ScaleW(15)) textColor:kMainWihteColor frame:CGRectMake(ScaleW(15), ScaleW(5), (Screen_Width/2 - ScaleW(20)), ScaleW(45)) textAlignment:NSTextAlignmentLeft];
        _priceYECLab.numberOfLines = 1;

    }
    return _priceYECLab;
}

- (UILabel *)detailLab{
    if (!_detailLab) {
        _detailLab = [WLTools allocLabel:SSKJLocalized(@"", nil) font:systemFont(ScaleW(13)) textColor:kMainWihteColor frame:CGRectZero textAlignment:NSTextAlignmentLeft];
    }
    return _detailLab;
}
- (UILabel *)payUSDTLab{
    if (!_payUSDTLab) {
        _payUSDTLab = [WLTools allocLabel:SSKJLocalized(@"待支付：", nil) font:systemFont(ScaleW(13)) textColor:kGreenTextColor frame:CGRectZero textAlignment:NSTextAlignmentLeft];
        _payUSDTLab.numberOfLines = 1;
    }
    return _payUSDTLab;
}
- (UILabel *)payYECLab{
    if (!_payYECLab) {
        _payYECLab = [WLTools allocLabel:SSKJLocalized(@"待支付：", nil) font:systemFont(ScaleW(13)) textColor:kGreenTextColor frame:CGRectZero textAlignment:NSTextAlignmentLeft];
        _payYECLab.numberOfLines = 1;
    }
    return _payYECLab;
}
-(UIButton *)cancleButton
{
    if (nil == _cancleButton) {
        
        _cancleButton = [[UIButton alloc]initWithFrame:CGRectMake(0, ScreenHeight - ScaleW(45), Screen_Width/2, ScaleW(45))];
        [_cancleButton setTitle:SSKJLocalized(@"取消", nil) forState:UIControlStateNormal];
        [_cancleButton setTitleColor:kMainWihteColor forState:UIControlStateNormal];
        _cancleButton.titleLabel.font = systemFont(ScaleW(16));
        _cancleButton.backgroundColor = kMainColor;
        [_cancleButton addTarget:self action:@selector(cancleClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancleButton;
}

-(UIButton *)confirmButton
{
    if (nil == _confirmButton) {
        
        _confirmButton = [[UIButton alloc]initWithFrame:CGRectMake(Screen_Width/2, ScreenHeight - ScaleW(45), Screen_Width/2, ScaleW(45))];
        [_confirmButton setTitle:SSKJLocalized(@"付款", nil) forState:UIControlStateNormal];
        [_confirmButton setBackgroundImage:[UIImage imageNamed:@"pay_Btn_bg"] forState:UIControlStateNormal];
        [_confirmButton setBackgroundImage:[UIImage imageNamed:@"pay_Btn_bg"] forState:UIControlStateHighlighted];
        [_confirmButton setTitleColor:kMainWihteColor forState:UIControlStateNormal];
        _confirmButton.titleLabel.font = systemBoldFont(ScaleW(16));
        [_confirmButton addTarget:self action:@selector(payClcik) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmButton;
}
#pragma mark - 取消
- (void)cancleClick{
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    WS(weakSelf);
    
    
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:Qx_yuyue_lockURL RequestType:RequestTypeGet Parameters:@{@"id":_detailModel.ID} Success:^(NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        
        
        WL_Network_Model *net_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        
        if (net_model.status.integerValue == 200) {
           [MBProgressHUD showError:net_model.msg];
            [weakSelf.navigationController popToRootViewControllerAnimated:false];
            
            
        }else{
            [MBProgressHUD showError:net_model.msg];
        }
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        [MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
    }];
    
}
#pragma mark - 支付
- (void)payClcik{
    
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    WS(weakSelf);
    
    
    
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:buy_lockURL RequestType:RequestTypeGet Parameters:@{@"id":_detailModel.ID} Success:^(NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        
        
        WL_Network_Model *net_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        
        if (net_model.status.integerValue == 200) {
            [MBProgressHUD showError:net_model.msg];
            ActivateSuccessViewController *vc = [[ActivateSuccessViewController alloc] init];
            [self.navigationController pushViewController:vc animated:true];
            
            
        }else{
            [MBProgressHUD showError:net_model.msg];
        }
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        [MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
    }];
    
    
   
}
#pragma mark - 请求数据
-(void)requstListrequset
{
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];

    WS(weakSelf);
    
    NSMutableDictionary *pamas = [NSMutableDictionary dictionary];
    
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:ActivateListURL RequestType:RequestTypeGet Parameters:pamas Success:^(NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];

        
        WL_Network_Model *net_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        
        if (net_model.status.integerValue == 200) {
            if ([net_model.data[@"list"] isKindOfClass:NSDictionary.class]) {
//                ActivateViewModel = [ActivateViewModel ];
                weakSelf.detailModel = [ActivateViewModel mj_objectWithKeyValues:net_model.data[@"list"]];
                weakSelf.priceUSDTLab.text = [NSString stringWithFormat:@"%@%@ USDT",SSKJLocalized(@"可用：", nil),[WLTools noroundingStringWith:[net_model.data[@"usdt_use"] doubleValue] afterPointNumber:4]];
                 weakSelf.priceYECLab.text = [NSString stringWithFormat:@"%@%@ YEC",SSKJLocalized(@"可用：", nil),[WLTools noroundingStringWith:[net_model.data[@"yec_use"] doubleValue] afterPointNumber:4]];
                [weakSelf changeUI];
            }
            
            
           
        }else{
            [MBProgressHUD showError:net_model.msg];
        }
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        [MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
    }];
}
- (void)changeUI{
  
    self.payUSDTLab.text = [NSString stringWithFormat:@"%@%@ USDT",SSKJLocalized(@"待支付：", nil),[WLTools noroundingStringWith:[_detailModel.usdt_num doubleValue] afterPointNumber:4]];
     self.payYECLab.text = [NSString stringWithFormat:@"%@%@ YEC",SSKJLocalized(@"待支付：", nil),[WLTools noroundingStringWith:[_detailModel.usdt_yec_num doubleValue] afterPointNumber:4]];
    self.detailLab.text = _detailModel.content;;
//    self.detailLab.text = [NSString stringWithFormat:SSKJLocalized(@"%@：%@USDT（套餐包含：赠送价值140USDT的YEC（每天释放1%）+价值140的USDT的YEC(每天释放0.5USDT的YEC))", nil),_detailModel.rname,[WLTools noroundingStringWith:[_detailModel.num doubleValue] afterPointNumber:4]]
}
@end
