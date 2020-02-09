//


#import "HeBi_Publish_ViewController.h"
// view
#import "HeBi_TitleAndInput_View.h"
#import "HeBi_Publish_Limmit_View.h"
#import "HeBi_Publish_PayMethodView.h"
#import "HeBi_Publish_AlertView.h"
#import "JB_FBC_Publish_TitleView.h"
/*#import "Mine_payWays_ViewController.h"*/

// controller
//#import "HeBi_PayMethodManager_ViewController.h"
#import "HeBi_PublishRecord_ViewController.h"
#import "HeBi_FB_OrderDetail_ViewController.h"
#import "BLSafeCenterViewController.h"

// model
#import "JB_PayWayModel.h"

// tools
#import "UITextField+Helper.h"

#import "ISCM_OTCLimit_Model.h"

@interface HeBi_Publish_ViewController ()<UITextFieldDelegate>
{
    NSDictionary *paywaysDic;
}
@property (nonatomic, strong) JB_FBC_Publish_TitleView *mainTitleView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UILabel *topLabel;
@property (nonatomic, strong) HeBi_TitleAndInput_View *amountView;
@property (nonatomic, strong) HeBi_Publish_Limmit_View *limmitView;
@property (nonatomic, strong) HeBi_TitleAndInput_View *priceView;
@property (nonatomic, strong) HeBi_TitleAndInput_View *remarkView;
@property (nonatomic, strong) HeBi_Publish_PayMethodView *payMethodView;
@property (nonatomic, strong) UIButton *addPayMethodButton;
@property (nonatomic, strong) UIButton *confirmButton;

@property (nonatomic, strong) HeBi_Publish_AlertView *publlishAlertView;

@property (nonatomic, strong) NSMutableArray *payMehhodArray;

@property(nonatomic, strong)ISCM_OTCLimit_Model *limitModel;
@end

@implementation HeBi_Publish_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self addRightNavgationItemWithImage:[UIImage imageNamed:@"icon_记录"]];
    [self setUI];
    
    if (self.publishType == PublishTypeSell) {
        [self.mainTitleView setSelectIndex:0];
    }else{
        [self.mainTitleView setSelectIndex:1];
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self getLimitInfo];
//    [self requestPayList];
//    [self requestDefaulePrice];

}

-(void)rigthBtnAction:(id)sender
{
    HeBi_PublishRecord_ViewController *vc = [[HeBi_PublishRecord_ViewController alloc]init];
    vc.publishType = self.publishType;
    [self.navigationController pushViewController:vc animated:YES];
}

-(NSMutableArray *)payMehhodArray
{
    if (nil == _payMehhodArray) {
        _payMehhodArray = [NSMutableArray arrayWithCapacity:10];
    }
    return _payMehhodArray;
}

#pragma mark - UI

-(void)setUI
{
    self.navigationItem.titleView = self.mainTitleView;
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.topLabel];
    [self.scrollView addSubview:self.amountView];
    [self.scrollView addSubview:self.limmitView];
    [self.scrollView addSubview:self.priceView];
    [self.scrollView addSubview:self.remarkView];
    
//    [self.scrollView addSubview:self.payMethodView];
//    [self.scrollView addSubview:self.addPayMethodButton];
    [self.scrollView addSubview:self.confirmButton];
    
    self.scrollView.contentSize = CGSizeMake(ScreenWidth, self.confirmButton.bottom + ScaleW(30));
}

-(JB_FBC_Publish_TitleView *)mainTitleView
{
    if (nil == _mainTitleView) {
        _mainTitleView = [[JB_FBC_Publish_TitleView alloc]initWithFrame:CGRectZero buyTitle:SSKJLocalized(@"发布购买", nil) sellTitle:SSKJLocalized(@"发布出售", nil)];
        WS(weakSelf);
        _mainTitleView.changeTypeBlock = ^(BuySellType buySellType) {
            if (buySellType == BuySellTypeBuy) {
                weakSelf.publishType = (PublishType)buySellType;

                [weakSelf.confirmButton setTitle:SSKJLocalized(@"购买", nil) forState:UIControlStateNormal];
            }else{
                
//                if (![weakSelf judgeSecondCertificate]) {
//                    [weakSelf.mainTitleView setSelectIndex:1];
//                    return ;
//                }
                weakSelf.publishType = (PublishType)buySellType;
                [weakSelf.confirmButton setTitle:SSKJLocalized(@"出售", nil) forState:UIControlStateNormal];
            }
        };
    }
    return _mainTitleView;
}

-(UIScrollView *)scrollView
{
    if (nil == _scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - Height_NavBar)];
    }
    return _scrollView;
}

-(UILabel *)topLabel
{
    if (nil == _topLabel) {
        NSString *message = SSKJLocalized(@"商家自由出售ISCM，交易更灵活更快捷", nil);
        if (_publishType == PublishTypeBuy) {
            message = SSKJLocalized(@"商家自由购买ISCM，交易更灵活更快捷", nil);
        }
        _topLabel = [WLTools allocLabel:message font:systemFont(ScaleW(12)) textColor:kGrayTitleColor frame:CGRectMake(0, 0, ScreenWidth, ScaleW(35)) textAlignment:NSTextAlignmentCenter];
        _topLabel.backgroundColor = kBgColor;
    }
    return _topLabel;
    
}

-(HeBi_TitleAndInput_View *)amountView
{
    if (nil == _amountView) {
        _amountView = [[HeBi_TitleAndInput_View alloc]initWithFrame:CGRectMake(0, self.topLabel.bottom, ScreenWidth, ScaleW(93)) leftGap:ScaleW(15) title:SSKJLocalized(@"数量", nil) placeHolder:SSKJLocalized(@"发布出售数量", nil) keyBoardType:UIKeyboardTypeNumberPad isSecured:NO];
        
//        if (self.publishType == PublishTypeSell) {
//            _amountView.textField.placeholder = @"最少发布出售20";
//        }
    }
    return _amountView;
}


-(HeBi_Publish_Limmit_View *)limmitView
{
    if (nil == _limmitView) {
        _limmitView = [[HeBi_Publish_Limmit_View alloc]initWithFrame:CGRectMake(0, self.amountView.bottom, ScreenWidth, ScaleW(105))];
        
//        if (self.publishType == PublishTypeBuy) {
            _limmitView.minTextField.placeholder = SSKJLocalized(@"最低", nil) ;
            _limmitView.maxTextField.placeholder = SSKJLocalized(@"最高",nil);
//        }else{
//            _limmitView.minTextField.placeholder = @"最低";
//            _limmitView.maxTextField.placeholder = @"最高";
//        }
    }
    return _limmitView;
}

-(HeBi_TitleAndInput_View *)priceView
{
    if (nil == _priceView) {
        _priceView = [[HeBi_TitleAndInput_View alloc]initWithFrame:CGRectMake(0, self.limmitView.bottom, ScreenWidth, ScaleW(93)) leftGap:ScaleW(15) title:SSKJLocalized(@"单价", nil) placeHolder:SSKJLocalized(@"请输入出售单价", nil) keyBoardType:UIKeyboardTypeDecimalPad isSecured:NO];
        if (self.publishType == PublishTypeBuy) {
            _priceView.textField.placeholder = @"请输入购买单价";
        }else{
            _priceView.textField.placeholder = @"请输入出售单价";
        }
        _priceView.textField.delegate = self;

    }
    return _priceView;
}

-(HeBi_TitleAndInput_View *)remarkView
{
    if (nil == _remarkView) {
        _remarkView = [[HeBi_TitleAndInput_View alloc]initWithFrame:CGRectMake(0, self.priceView.bottom, ScreenWidth, ScaleW(93)) leftGap:ScaleW(15) title:SSKJLocalized(@"备注", nil) placeHolder:SSKJLocalized(@"请输入要备注信息（选填）", nil) keyBoardType:UIKeyboardTypeDefault isSecured:NO];
    }
    return _remarkView;
}

-(HeBi_Publish_PayMethodView *)payMethodView
{
    if (nil == _payMethodView) {
        _payMethodView = [[HeBi_Publish_PayMethodView alloc]initWithFrame:CGRectMake(0, self.remarkView.bottom + ScaleW(10), ScreenWidth, ScaleW(50))];
        
    }
    return _payMethodView;
}

-(UIButton *)addPayMethodButton
{
    if (nil == _addPayMethodButton) {
        _addPayMethodButton = [[UIButton alloc]initWithFrame:CGRectMake(0, self.payMethodView.bottom, ScreenWidth, ScaleW(54))];
        [_addPayMethodButton setTitle:SSKJLocalized(@"添加或选择支付方式", nil) forState:UIControlStateNormal];
        [_addPayMethodButton setTitleColor:kTextLightBlueColor forState:UIControlStateNormal];
        _addPayMethodButton.titleLabel.font = systemThinFont(ScaleW(14));
        [_addPayMethodButton addTarget:self action:@selector(addPayMethod) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addPayMethodButton;
}


-(UIButton *)confirmButton
{
    if (nil == _confirmButton) {
        
        _confirmButton = [[UIButton alloc]initWithFrame:CGRectMake(ScaleW(15), self.remarkView.bottom + 40, ScreenWidth - ScaleW(30), ScaleW(45))];
//        [_confirmButton addGradientColor];
        if (_publishType == PublishTypeBuy) {
            [_confirmButton setTitle:SSKJLocalized(@"购买", nil) forState:UIControlStateNormal];
        }else{
            [_confirmButton setTitle:SSKJLocalized(@"出售", nil) forState:UIControlStateNormal];
        }
        [_confirmButton setTitleColor:kMainWihteColor forState:UIControlStateNormal];
        _confirmButton.titleLabel.font = systemBoldFont(ScaleW(15));
        _confirmButton.layer.masksToBounds = YES;
        _confirmButton.layer.cornerRadius = 4.0f;
        [_confirmButton setBackgroundColor:kMainBlueColor];
        [_confirmButton addTarget:self action:@selector(confirmEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmButton;
}


-(HeBi_Publish_AlertView *)publlishAlertView
{
    if (nil == _publlishAlertView) {
        _publlishAlertView = [[HeBi_Publish_AlertView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        WS(weakSelf);
        _publlishAlertView.confirmBlock = ^(NSString * _Nonnull pwd) {
                [weakSelf requestPublishWithPWD:pwd];
            
        };
    }
    return _publlishAlertView;
}

-(void)setPublishType:(PublishType)publishType
{
    _publishType = publishType;
    
    if (publishType == PublishTypeBuy) {
        self.title = SSKJLocalized(@"发布购买", nil);
        self.amountView.textField.placeholder = SSKJLocalized(@"发布购买数量", nil);
        self.priceView.textField.placeholder = SSKJLocalized(@"请输入购买单价", nil);
        self.topLabel.text = @"商家自由购买ISCM，交易更灵活更快捷";
    }else{
        self.title = SSKJLocalized(@"发布出售", nil);

//        self.amountView.textField.placeholder = SSKJLocalized(@"发布出售数量", nil);
        
        self.amountView.textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString: SSKJLocalized(@"发布出售数量", nil) attributes:@{NSForegroundColorAttributeName:kGrayTitleColor}];

        
//        self.priceView.textField.placeholder = SSKJLocalized(@"请输入出售单价", nil);
        _priceView.textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString: SSKJLocalized(@"请输入出售单价", nil) attributes:@{NSForegroundColorAttributeName:kGrayTitleColor}];

        self.topLabel.text = @"商家自由出售ISCM，交易更灵活更快捷";
    }
    [self LimitInfo];

}


#pragma mark - 用户操作


#pragma mark  添加支付方式

-(void)addPayMethod
{
   /* Mine_payWays_ViewController *vc = [[Mine_payWays_ViewController alloc]init];
    WS(weakSelf);
    vc.index = 1;
    vc.callBackBlock = ^(NSDictionary * _Nonnull dic) {
        //paywaysDic = dic;
    };
    [self.navigationController pushViewController:vc animated:YES];*/
}

#pragma mark  确认发布判断条件
-(void)confirmEvent
{
    [OTCVerifyDealTool startVerifyCompletion:^{
        [self judgePublish];
    }];
}

- (void)judgePublish{
    if (self.amountView.valueString.length == 0) {
        if (self.publishType == PublishTypeBuy) {
            [MBProgressHUD showError:SSKJLocalized(@"请输入购买数量", nil)];
        }else{
            [MBProgressHUD showError:SSKJLocalized(@"请输入出售数量", nil)];
        }
        return;
    }
    
    if (self.amountView.valueString.doubleValue == 0) {
        if (self.publishType == PublishTypeBuy) {
            [MBProgressHUD showError:SSKJLocalized(@"购买数量不能为0", nil)];
        }else{
            [MBProgressHUD showError:SSKJLocalized(@"出售数量不能为0", nil)];
        }
        return;
    }
    
    //    if (self.publishType == PublishTypeSell) {
    //        if (self.amountView.valueString.doubleValue < 20) {
    //            [MBProgressHUD showError:SSKJLocalized(@"出售数量不能小于20", nil)];
    //            return;
    //        }
    //    }
    
    if (self.limmitView.minlimmit.length == 0) {
        [MBProgressHUD showError:SSKJLocalized(@"请输入最小限额", nil)];
        return;
    }
    
    if (self.limmitView.maxlimmit.length == 0) {
        [MBProgressHUD showError:SSKJLocalized(@"请输入最大限额", nil)];
        return;
    }
    
    if (self.priceView.valueString.length == 0) {
        [MBProgressHUD showError:SSKJLocalized(@"请输入单价", nil)];
        return;
    }
    
    if (self.priceView.valueString.doubleValue == 0) {
        [MBProgressHUD showError:SSKJLocalized(@"单价不能为0", nil)];
        return;
    }
    
    if (self.publishType == PublishTypeBuy) {
        if (self.priceView.valueString.doubleValue < [self.limitModel.buy_min doubleValue] || self.priceView.valueString.doubleValue > [self.limitModel.buy_max doubleValue]) {
            [MBProgressHUD showError:SSKJLocalized(@"单价不在设定范围内", nil)];
            return;
        }
    }else{
        
        if (self.priceView.valueString.doubleValue < [self.limitModel.sell_min doubleValue] || self.priceView.valueString.doubleValue > [self.limitModel.sell_max doubleValue]) {
            [MBProgressHUD showError:SSKJLocalized(@"单价不在设定范围内", nil)];
            return;
        }
        
    }
    
    //    if (self.publishType == PublishTypeBuy) {
    //        if (self.limmitView.minlimmit.doubleValue < 200) {
    //            [MBProgressHUD showError:SSKJLocalized(@"最低限额不能低于100CNY", nil)];
    //            return;
    //        }
    //
    //        if (self.limmitView.maxlimmit.doubleValue > 70000) {
    //            [MBProgressHUD showError:SSKJLocalized(@"最低限额不能超过70000CNY", nil)];
    //            return;
    //        }
    //    }
    
    
    if (self.limmitView.minlimmit.doubleValue > self.priceView.valueString.doubleValue * self.amountView.valueString.doubleValue) {
        [MBProgressHUD showError:SSKJLocalized(@"总价需大于最低限额", nil)];
        return;
    }
    
    if (self.limmitView.maxlimmit.doubleValue < self.limmitView.minlimmit.doubleValue) {
        [MBProgressHUD showError:SSKJLocalized(@"最高限额必须大于最低限额", nil)];
        return;
    }
    
    //    if (self.payMethodView.selectedPayMethodArray.count == 0) {
    //        [MBProgressHUD showError:SSKJLocalized(@"请选择收款方式", nil)];
    //        return;
    //    }
    
    [self.publlishAlertView showWithPublishType:self.publishType price:self.priceView.valueString amount:self.amountView.valueString];
}



#pragma mark - 网络请求

#pragma mark - 请求发布


-(void)requestPublishWithPWD:(NSString *)pwd
{
    [self.publlishAlertView hide];
    
    NSString *type = @"pmma";//请选择支付方式
    if (self.publishType == PublishTypeSell) {
        type = @"sell";
    }
    
    NSString *pay_alipay = @"0";
    NSString *pay_backcard = @"0";
    NSString *pay_wx = @"0";

    for (JB_PayWayModel *model in self.payMethodView.selectedPayMethodArray) {
        if ([model.type isEqualToString:@"alipay"]) {
            pay_alipay = @"1";
        }
        
        if ([model.type isEqualToString:@"backcard"]) {
            pay_backcard = @"1";
        }
        
        if ([model.type isEqualToString:@"wx"]) {
            pay_wx = @"1";
        }
    }
    
    NSDictionary *params = @{
                             @"account":[[SSKJ_User_Tool sharedUserTool]getAccount],
                             @"tpwd":[WLTools md5:pwd],
                             @"trans_num":self.amountView.valueString,
                             @"min_price":self.limmitView.minlimmit,
                             @"max_price":self.limmitView.maxlimmit,
                             @"price":self.priceView.valueString,
                             @"type":type,
                             @"notes":self.remarkView.valueString,
                             @"pay_alipay":pay_alipay,
                             @"pay_backcard":pay_backcard,
                             @"pay_wx":pay_wx
                             };
    
    
    WS(weakSelf);
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:ETF_FBHomeFbtransPmma_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        WL_Network_Model *net_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if (net_model.status.integerValue == SUCCESSED) {
            
            
            [MBProgressHUD showSuccess:SSKJLocalized(@"发布成功", nil)];
    
//            [weakSelf clearView];
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }else{
            [MBProgressHUD showError:net_model.msg];
        }
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        //[MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
        
    }];
}

// 清除视图数据
-(void)clearView
{
    self.amountView.valueString = @"";
    self.limmitView.minlimmit = @"";
    self.limmitView.maxlimmit = @"";
    self.priceView.valueString = @"";
    self.remarkView.valueString = @"";
    
    self.payMethodView.payMethodArray = self.payMehhodArray;
}


#pragma mark - 请求支付方式列表

-(void)requestPayList
{
    
    NSDictionary *params = @{
                             //@"account":[SSKJ_User_Tool sharedUserTool].userInfoModel.account
                             };
    
    
    WS(weakSelf);
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:JB_Account_PayList_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        WL_Network_Model *net_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if (net_model.status.integerValue == SUCCESSED) {
            [weakSelf handlePayMethodListWithModel:net_model];
        }else{
            [MBProgressHUD showError:net_model.msg];
        }
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        //[MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
        
    }];
}

-(void)handlePayMethodListWithModel:(WL_Network_Model *)net_model
{
    NSArray *array = [JB_PayWayModel mj_objectArrayWithKeyValuesArray:net_model.data];
    
    [self.payMehhodArray removeAllObjects];
    
    for (JB_PayWayModel *model in array) {
        if (model.status.integerValue == 1) {
            [self.payMehhodArray addObject:model];
        }
    }
    
    self.payMethodView.payMethodArray = self.payMehhodArray;
    
//    if (self.payMehhodArray.count == 2) {
//        self.addPayMethodButton.hidden = YES;
//    }else{
//        self.addPayMethodButton.hidden = NO;
//    }
    
    self.addPayMethodButton.y = self.payMethodView.bottom;
    self.confirmButton.y = self.addPayMethodButton.bottom;
    self.scrollView.contentSize = CGSizeMake(ScreenWidth, self.confirmButton.bottom + ScaleW(20));
    
}

#pragma mark - 请求默认价格
-(void)requestDefaulePrice
{
    WS(weakSelf);
//    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:Main_GetDefaultrice_order_URL RequestType:RequestTypePost Parameters:nil Success:^(NSInteger statusCode, id responseObject) {
//        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        WL_Network_Model *net_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if (net_model.status.integerValue == SUCCESSED) {
            weakSelf.priceView.valueString = [WLTools noroundingStringWith:[net_model.data[@"price"] doubleValue] afterPointNumber:2];
        }else{
            [MBProgressHUD showError:net_model.msg];
        }
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
//        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        //[MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
        
    }];
}

#pragma mark - UITextFieldDelegate

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == self.priceView.textField){
        return [textField textFieldShouldChangeCharactersInRange:range replacementString:string dotNumber:6];
    }else{
        return YES;
    }
}


-(void)inputChanged:(UITextField *)textField
{
    textField.text = [self deleteFirstZero:textField.text];
    
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

- (void)getLimitInfo{
    
    WS(weakSelf);
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:ISCM_OTCLimit_URL RequestType:RequestTypePost Parameters:nil Success:^(NSInteger statusCode, id responseObject) {
        
        WL_Network_Model *net_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if (net_model.status.integerValue == SUCCESSED) {

            self.limitModel = [ISCM_OTCLimit_Model mj_objectWithKeyValues:net_model.data];
            [self LimitInfo];
        }else{
            [MBProgressHUD showError:net_model.msg];
        }
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        //        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        //[MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
        
    }];
}

- (void)LimitInfo{
    
    if (!self.limitModel.buy_min.length) {
        return;
    }
    if (self.publishType == PublishTypeBuy) {
//        _priceView.textField.placeholder = [NSString stringWithFormat:@"%@ - %@", self.limitModel.buy_min, self.limitModel.buy_max];
        _priceView.textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString: [NSString stringWithFormat:@"%@ - %@", self.limitModel.buy_min, self.limitModel.buy_max] attributes:@{NSForegroundColorAttributeName:kGrayTitleColor}];

    }else{
//        _priceView.textField.placeholder = [NSString stringWithFormat:@"%@ - %@", self.limitModel.sell_min, self.limitModel.sell_max];
        
        _priceView.textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString: [NSString stringWithFormat:@"%@ - %@", self.limitModel.sell_min, self.limitModel.sell_max] attributes:@{NSForegroundColorAttributeName:kGrayTitleColor}];

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
