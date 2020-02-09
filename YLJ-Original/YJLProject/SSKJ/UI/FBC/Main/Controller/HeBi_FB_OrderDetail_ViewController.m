//
//  HeBi_FB_OrderDetail_ViewController.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/4/15.
//  Copyright © 2019年 刘小雨. All rights reserved.
//


#import "HeBi_FB_OrderDetail_ViewController.h"

// view
#import "HeBi_FB_OrderDetail_HeaderView.h"
#import "HeBi_FB_OrderDetail_PayView.h"
#import "HeBi_FB_OrderDetail_BottomView.h"
#import "HeBi_Default_AlertView.h"
#import "HeBi_InputPWD_AlertView.h"
#import "HeBi_FB_Appeal_AlertView.h"
#import "HeBi_ShowQRCode_AlertView.h"

// model
#import "HeBi_FB_OrderDetail_Model.h"


@interface HeBi_FB_OrderDetail_ViewController ()
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) HeBi_FB_OrderDetail_HeaderView *headerView;
@property (nonatomic, strong) HeBi_FB_OrderDetail_PayView *payView;
@property (nonatomic, strong) HeBi_FB_OrderDetail_BottomView *bottomView;

@property (nonatomic, strong) HeBi_FB_OrderDetail_Model *orderDetailModel;

@property (nonatomic, strong) HeBi_Default_AlertView *alertView;        // 取消、付款提示
@property (nonatomic, strong) HeBi_InputPWD_AlertView *fangbiAlertView; // 放币提示
@property (nonatomic, strong) HeBi_FB_Appeal_AlertView *appealAlertView;// 申诉提示

@property (nonatomic, strong) HeBi_PayMethod_Index_Model *selectedPayModel;

@property (nonatomic, strong) NSTimer *timer;

@property(nonatomic, strong)UIButton *cancelBtn;
@property(nonatomic, strong)UIButton *ensureBtn;
@property(nonatomic)NSInteger timeLength;


@end

@implementation HeBi_FB_OrderDetail_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = SSKJLocalized(@"订单详情", nil);
    
//    [self fangbiEvent];
    
//    [self appealEvent];
    
//    [self cancleEvent];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self requestOrderDetail];
    
//    [self.timer fire];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    if (_timer) {
//        [_timer invalidate];
//    }
}

//-(NSTimer *)timer
//{
//    if (nil == _timer) {
//        _timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(requestOrderDetail) userInfo:nil repeats:YES];
//    }
//    return _timer;
//}

#pragma mark - UI

-(void)setUI
{
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.headerView];
//    [self.scrollView addSubview:self.payView];
//    [self.scrollView addSubview:self.bottomView];
}

-(UIScrollView *)scrollView
{
    if (nil == _scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - Height_NavBar)];
        
        _scrollView.backgroundColor = [UIColor clearColor];
        WS(weakSelf);
        _scrollView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weakSelf requestOrderDetail];
        }];
    }
    return _scrollView;
}

-(HeBi_InputPWD_AlertView *)fangbiAlertView
{
    if (nil == _fangbiAlertView) {
        _fangbiAlertView = [[HeBi_InputPWD_AlertView alloc]init];
        WS(weakSelf);
        _fangbiAlertView.confirmBlock = ^(NSString * _Nonnull pwd) {
                [weakSelf requestFangbiWithPWD:pwd];
            
        };
    }
    return _fangbiAlertView;
}

-(HeBi_FB_OrderDetail_HeaderView *)headerView
{
    if (nil == _headerView) {
        _headerView = [[HeBi_FB_OrderDetail_HeaderView alloc]initWithFrame:CGRectMake(0, ScaleW(0), ScreenWidth, 0)];
    }
    return _headerView;
}

-(HeBi_FB_OrderDetail_PayView *)payView
{
    if (nil == _payView) {
        _payView = [[HeBi_FB_OrderDetail_PayView alloc]initWithFrame:CGRectMake(0, self.headerView.bottom, ScreenWidth, 0)];
        _payView.showQRCodeBlock = ^(NSString * _Nonnull imageURL) {
            [HeBi_ShowQRCode_AlertView showWithImageURL:imageURL];
        };
    }
    return _payView;
}

-(HeBi_FB_OrderDetail_BottomView *)bottomView
{
    if (nil == _bottomView) {
        _bottomView = [[HeBi_FB_OrderDetail_BottomView alloc]initWithFrame:CGRectMake(0, self.headerView.bottom, ScreenWidth, 0)];
        WS(weakSelf);
        _bottomView.actionBlock = ^(ActionType actionType) {
            if (actionType == ActionTypeCancle) {
                [weakSelf cancleEvent];
            }else if (actionType == ActionTypePay) {
                [weakSelf confirmPayEvent];
            }else if (actionType == ActionTypeAppeal) {
                [weakSelf appealEvent];
            }else if (actionType == ActionTypeFangbi) {
                [weakSelf fangbiEvent];
            }
//            else if (actionType == ActionTypeNextStep){
//                [weakSelf nextStepEvent];
//            }
        };
        
        _bottomView.countDownBlock = ^{
            [weakSelf requestOrderDetail];
        };
    }
    return _bottomView;
}

-(HeBi_Default_AlertView *)alertView
{
    if (nil == _alertView) {
        _alertView = [[HeBi_Default_AlertView alloc]init];
    }
    return _alertView;
}

-(HeBi_FB_Appeal_AlertView *)appealAlertView
{
    if (nil == _appealAlertView) {
        _appealAlertView = [[HeBi_FB_Appeal_AlertView alloc]init];
        WS(weakSelf);
        _appealAlertView.appeallock = ^(NSString * _Nonnull reason) {
            [weakSelf requestAppealWithReason:reason];
        };
    }
    return _appealAlertView;
}

#pragma mark - 用户操作

//-(void)nextStepEvent
//{
//    if (self.payView.selectPayModel == nil) {
//        [MBProgressHUD showError:SSKJLocalized(@"请选择付款方式", nil)];
//        return;
//    }
//
//    self.selectedPayModel = self.payView.selectPayModel;
//    [self requestOrderDetail];
//}

// 买家确认付款
-(void)confirmPayEvent
{
    WS(weakSelf);
    
    
    [HeBi_Default_AlertView showWithTitle:SSKJLocalized(@"标记已付款", nil) message:SSKJLocalized(@"已确认向卖家付款？", nil) cancleTitle:SSKJLocalized(@"取消", nil) confirmTitle:SSKJLocalized(@"确定", nil) confirmBlock:^{
        [weakSelf requestPay];
    }];
    
    
}
// 买家取消订单
-(void)cancleEvent
{
    WS(weakSelf);
    [HeBi_Default_AlertView showWithTitle:@"取消订单"  message:SSKJLocalized(@"每日取消次数超过3次，冻结当日OTC交易功能，24小时自动解除。", nil) cancleTitle:@"" confirmTitle:SSKJLocalized(@"继续取消订单", nil) confirmBlock:^{
        [weakSelf requestCancale];
    }];
}
// 卖家确认放币
-(void)fangbiEvent
{
    [self.fangbiAlertView showWithTitle:SSKJLocalized(@"确认支付", nil) cancleTitle:SSKJLocalized(@"取消", nil) confirmTitle:SSKJLocalized(@"确认", nil)];
}
// 卖家申诉
-(void)appealEvent
{
    [self.appealAlertView showWithTitle:SSKJLocalized(@"订单申诉", nil) cancleTitle:SSKJLocalized(@"取消", nil) confirmTitle:SSKJLocalized(@"提交", nil)];
}

#pragma mark - 网络请求
#pragma mark - 请求订单详情
-(void)requestOrderDetail
{
    
    NSDictionary *params = @{
                             @"order_num":self.orderNumber,
                             };
    
    
    WS(weakSelf);
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:FBC_DealOrderDetail_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        WL_Network_Model *net_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        [weakSelf.scrollView.mj_header endRefreshing];
        if (net_model.status.integerValue == SUCCESSED) {
            [weakSelf setUI];
            [weakSelf handleOrderDetailWithModel:net_model];
        }else{
            [MBProgressHUD showError:net_model.msg];
        }
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        //[MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
        [weakSelf.scrollView.mj_header endRefreshing];
    }];
}

-(void)handleOrderDetailWithModel:(WL_Network_Model *)net_model
{
    self.orderDetailModel = [HeBi_FB_OrderDetail_Model mj_objectWithKeyValues:net_model.data];
//    NSArray *array = [HeBi_PayMethod_Index_Model mj_objectArrayWithKeyValuesArray:self.orderDetailModel.pay_list];
//    self.orderDetailModel.pay_list = array;
    
    [self stopTimer];
    
    [self.headerView setViewWithModel:self.orderDetailModel];
    
    
    self.scrollView.contentSize = CGSizeMake(ScreenWidth, MAX(self.headerView.bottom + ScaleW(80), ScreenHeight - Height_NavBar));
    if (self.orderDetailModel.status.integerValue == 1 && self.orderDetailModel.type.integerValue == 2) {
        
        self.timeLength = [self.orderDetailModel.down_time integerValue];
        [self addTimer];
        
        [self.scrollView addSubview:self.cancelBtn];
        [self.scrollView addSubview:self.ensureBtn];
    }else{
     
        [self.ensureBtn removeFromSuperview];
        [self.cancelBtn removeFromSuperview];
    }
    
    
    // 卖家只有一种支付方式时不用选择支付方式
//    if (self.orderDetailModel.pay_list.count == 1) {
//        self.selectedPayModel = self.orderDetailModel.pay_list.firstObject;
//        self.payView.selectPayModel = self.selectedPayModel;
//    }
//
//
//
//    [self.payView setViewWithModel:self.orderDetailModel];
    
//    if (self.orderDetailModel.status.integerValue == 5) {
//        self.payView.hidden = YES;
//        self.bottomView.y = self.headerView.bottom;
//    }else{
//        self.payView.hidden   = NO;
//        self.bottomView.y = self.payView.bottom;
//    }
//    self.bottomView.y = self.payView.bottom;
//
//    [self.bottomView setViewWithModel:self.orderDetailModel];
    
//    self.scrollView.contentSize = CGSizeMake(ScreenWidth, self.bottomView.bottom);
    
//    if (self.orderDetailModel.status.integerValue != 3 && self.orderDetailModel.status.integerValue != 5) {
//        [self performSelector:@selector(requestOrderDetail) withObject:nil afterDelay:3];
//    }

}

- (UIButton *)cancelBtn{
    if (!_cancelBtn) {
        UIButton *cancel = [[UIButton alloc]initWithFrame:CGRectMake(ScaleW(15), self.scrollView.contentSize.height - ScaleW(60), (ScreenWidth - ScaleW(55)) * 0.5, ScaleW(45))];
        [cancel setTitle:SSKJLocalized(@"取消订单", nil) forState:UIControlStateNormal];
        [cancel setTitleColor:kMainBlueColor forState:UIControlStateNormal];
        cancel.titleLabel.font = systemFont(ScaleW(14));
        cancel.layer.masksToBounds = YES;
        cancel.layer.cornerRadius = 4.0f;
        cancel.layer.borderColor = kMainBlueColor.CGColor;
        cancel.layer.borderWidth = 1;
        [cancel addTarget:self action:@selector(cancelEvent) forControlEvents:UIControlEventTouchUpInside];
        _cancelBtn = cancel;
        
    }
    return _cancelBtn;
}

- (UIButton *)ensureBtn{
 
    if (!_ensureBtn) {
        UIButton *ensure = [[UIButton alloc]initWithFrame:CGRectMake(self.cancelBtn.maxX + ScaleW(25), self.cancelBtn.y, self.cancelBtn.width, self.cancelBtn.height)];
        [ensure setTitle:SSKJLocalized(@"支付", nil) forState:UIControlStateNormal];
        [ensure setTitleColor:kMainWihteColor forState:UIControlStateNormal];
        ensure.titleLabel.font = systemBoldFont(ScaleW(15));
        ensure.layer.masksToBounds = YES;
        ensure.layer.cornerRadius = 4.0f;
        ensure.backgroundColor = kMainBlueColor;
        [ensure addTarget:self action:@selector(confirmEvent) forControlEvents:UIControlEventTouchUpInside];
        _ensureBtn = ensure;
    }
    return _ensureBtn;
}

#pragma mark - 取消订单
- (void)cancelEvent{
    
    
    
    //    [self appealEvent];
    
        [self cancleEvent];
}

#pragma mark - 支付
- (void)confirmEvent{
    [self fangbiEvent];
}

#pragma mark 买家请求标记付款
-(void)requestPay
{
    
    NSString *ptype;
    if ([self.payView.selectPayModel.type isEqualToString:@"wx"]) {
        ptype = @"1";
    }else if ([self.payView.selectPayModel.type isEqualToString:@"alipay"]){
        ptype = @"2";
    }else if ([self.payView.selectPayModel.type isEqualToString:@"backcard"]){
        ptype = @"3";
    }
    
    NSDictionary *params = @{
                             @"account":[[SSKJ_User_Tool sharedUserTool]getAccount],
                             @"order_no":self.orderNumber,
                             @"ptype":ptype
                             };
    
    
    WS(weakSelf);
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:FBC_ConfirmPay_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        WL_Network_Model *net_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        [weakSelf.scrollView.mj_header endRefreshing];
        if (net_model.status.integerValue == SUCCESSED) {
            [weakSelf requestOrderDetail];
        }else{
            [MBProgressHUD showError:net_model.msg];
        }
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        //[MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
        [weakSelf.scrollView.mj_header endRefreshing];
    }];
}

#pragma mark 买家请求取消订单
-(void)requestCancale
{
    NSDictionary *params = @{
                          @"order_num":self.orderNumber,
                          };
    
    
    WS(weakSelf);
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:FBC_CancleOrder_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        WL_Network_Model *net_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        [weakSelf.scrollView.mj_header endRefreshing];
        if (net_model.status.integerValue == SUCCESSED) {
            
            [weakSelf requestOrderDetail];
        }else{
            [MBProgressHUD showError:net_model.msg];
        }
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        //[MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
        [weakSelf.scrollView.mj_header endRefreshing];
    }];
    
}

#pragma mark 卖家请放币
-(void)requestFangbiWithPWD:(NSString *)pwd
{
    NSDictionary *params = @{
                             @"order_num":self.orderNumber,
                             @"tpwd":[WLTools md5:pwd]
                             };
    
    
    WS(weakSelf);
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:FBC_ConfirmFangbi_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        WL_Network_Model *net_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        [weakSelf.scrollView.mj_header endRefreshing];
        if (net_model.status.integerValue == SUCCESSED) {
            
            [weakSelf requestOrderDetail];
        }else{
            [MBProgressHUD showError:net_model.msg];
        }
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        //[MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
        [weakSelf.scrollView.mj_header endRefreshing];
    }];
}

#pragma mark 卖家请申诉
-(void)requestAppealWithReason:(NSString *)reason
{
    NSDictionary *params = @{
                             @"order_num":self.orderNumber,
                             @"refer":self.orderDetailModel.refer,
                             @"account":[[SSKJ_User_Tool sharedUserTool]getAccount],
                             @"shop_account":self.orderDetailModel.oop_account,
                             @"ss_reason":reason
                             };
    
    
    WS(weakSelf);
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:FBC_Apeal_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        WL_Network_Model *net_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        [weakSelf.scrollView.mj_header endRefreshing];
        if (net_model.status.integerValue == SUCCESSED) {
            
            [weakSelf requestOrderDetail];
        }else{
            [MBProgressHUD showError:net_model.msg];
        }
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        //[MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
        [weakSelf.scrollView.mj_header endRefreshing];
    }];
}


- (void)addTimer
{
    [self stopTimer];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeChange:) userInfo:nil repeats:YES];
}

- (void)stopTimer
{
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

- (void)timeChange:(NSTimer *)sender
{
    _timeLength--;
    if (_timeLength < 0) {
        [self stopTimer];
        [self requestOrderDetail];
    }else{
        self.headerView.detailLabel.text = [NSString stringWithFormat:@"订单待支付,请在%02d:%02d内付款.", _timeLength/60, _timeLength%60];
    }
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
