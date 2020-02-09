//
//  YLJExchangeViewController.m
//  SSKJ
//
//  Created by cy5566 on 2019/11/21.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "YLJExchangeViewController.h"
#import "YLJAddBankViewController.h"
#import "YLJ_Default_AlertView.h"
#import "MyLayout.h"
#import "YLJBankInfoModel.h"
#import "GlobalProtocolViewController.h"
#import "HeBi_ConvertRecord_ViewController.h"

@interface YLJExchangeViewController()

@property (nonatomic,strong) UIView *topBackView;
@property (nonatomic,strong) UILabel *bankTitleLabel;
@property (nonatomic,strong) UILabel *bankDescLabel;
@property (nonatomic,strong) UIImageView *arrowImgView;
@property (nonatomic,strong) UIButton *addbankBtn;

@property (nonatomic,strong) UILabel *exchangeDescLabel;
@property (nonatomic,strong) UILabel *exchangePriceTitileLabel;
@property (nonatomic,strong) UILabel *exchangePriceLabel;
@property (nonatomic,strong) UITextField *exchangePriceTF;
@property (nonatomic,strong) UILabel *exchangeCountTitleLabel;
//倍数
@property (nonatomic,strong) UILabel *exchangeCountLabel;
@property (nonatomic,strong) UITextField *exchangeCountTF;
@property (nonatomic,strong) UIButton *addBtn;
@property (nonatomic,strong) UIButton *midBtn;
//到账数量
@property (nonatomic,strong) UILabel *acNumTitleLabel;
@property (nonatomic,strong) UILabel *acNumLabel;
@property (nonatomic,strong) UILabel *balanceLabel;
@property (nonatomic,strong) UIButton *confirmBtn;
//兑换说明
@property (nonatomic,strong) UILabel *confrmDescLabel;

@property (nonatomic,copy) NSString *currentCount;
@property (nonatomic,copy) NSString *currentPwd;


@property (nonatomic) BOOL isEditBank;

@property (nonatomic,strong) YLJBankInfoModel *bModel;

@end
@implementation YLJExchangeViewController

- (void)loadView {
    [super loadView];
    MyLinearLayout *contentLayout = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    contentLayout.padding = UIEdgeInsetsMake(0, ScaleW(15), 0, ScaleW(15)); //设置布局内的子视图离自己的边距.
    contentLayout.myHorzMargin = 0;                          //同时指定左右边距为0表示宽度和父视图一样宽
    contentLayout.heightSize.lBound(self.view.heightSize, 10, 1); //高度虽然是wrapContentHeight的。但是最小的高度不能低于父视图的高度加10.
    [self.view addSubview:contentLayout];
    
    [contentLayout addSubview:self.topBackView];
    [contentLayout addSubview:self.exchangeDescLabel];
    
    MyLinearLayout *hLyout = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    [contentLayout addSubview:hLyout];
    hLyout.myHeight = ScaleW(100);
    //        horzLayout1.wrapContentHeight = YES;
    hLyout.myHorzMargin = 0;
    //        horzLayout.weight = 1;
    hLyout.gravity = MyGravity_Horz_Fill;   //布局视图里面的所有子视图的宽度和布局相等。
    hLyout.subviewHSpace = ScaleW(0);   //里面所有子视图之间的水平间距。
    
    
    
    for (int i = 0; i < 2; i++) {
        UIView *view = [UIView new];
        view.weight = 1;
        view.myVertMargin = 0;
        [hLyout addSubview:view];
        MyLinearLayout *vLyout = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
        vLyout.myHorzMargin = 0;
        [view addSubview:vLyout];
        UILabel *titleLabel = [FactoryUI createLabelWithFrame:CGRectZero text:SSKJLocalized(@"兑换金额", nil) textColor:kMainTextColor font:systemFont(ScaleW(12))];
        titleLabel.myCenterX = 0;
        titleLabel.myTop = ScaleW(28);
        [vLyout addSubview:titleLabel];

        
        UIButton *addBtn = [UIButton new];

        [addBtn setImage:[UIImage imageNamed:@"ylj_icon_add"] forState:UIControlStateNormal];
        addBtn.mySize = CGSizeMake(ScaleW(22), ScaleW(22));

//        UILabel *priceLabel = [FactoryUI createLabelWithFrame:CGRectZero text:SSKJLocalized(@"500", nil) textColor:kMainTextColor font:systemBoldFont(ScaleW(18))];
        UITextField *pTF = [FactoryUI createTextFieldWithFrame:CGRectZero text:@"500" placeHolder:nil];
        [pTF addTarget:self action:@selector(textFieldDidchange:) forControlEvents:UIControlEventEditingChanged];
        pTF.textColor = kMainTextColor;
        pTF.font = systemBoldFont(ScaleW(18));
        pTF.myWidth = ScaleW(52);
        pTF.myHeight = ScaleW(22);
        pTF.textAlignment = NSTextAlignmentCenter;
        
        UIButton *midBtn = [UIButton new];
        [midBtn setImage:[UIImage imageNamed:@"ylj_icon_mid"] forState:UIControlStateNormal];
        midBtn.mySize = CGSizeMake(ScaleW(22), ScaleW(22));
        
        if (i == 1) {
            self.addBtn = addBtn;
            [self.addBtn addTarget:self action:@selector(addEvent) forControlEvents:UIControlEventTouchUpInside];
            self.midBtn = midBtn;
            [self.midBtn addTarget:self action:@selector(midEvent) forControlEvents:UIControlEventTouchUpInside];
//            self.exchangeCountLabel = priceLabel;
            self.exchangeCountTF = pTF;
            pTF.enabled = YES;
            titleLabel.text = @"兑换倍数";
        } else {
            pTF.textColor = kTheMeColor;
//            self.exchangePriceLabel = priceLabel;
            pTF.enabled = NO;
            self.exchangePriceTF = pTF;
            addBtn.hidden = YES;
            midBtn.hidden = YES;
        }
        MyLinearLayout *hLyout1 = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
        [vLyout addSubview:hLyout1];
        [contentLayout addSubview:hLyout];
        hLyout1.myTop = ScaleW(16);
        hLyout1.myCenterX = 0;
        hLyout1.myHeight = ScaleW(22);
        hLyout1.subviewHSpace = ScaleW(15);   //里面所有子视图之间的水平间距。
        [hLyout1 addSubview:midBtn];
        [hLyout1 addSubview:pTF];
        [hLyout1 addSubview:addBtn];
    }
    
    
    UIView *lineView = [UIView new];
    lineView.backgroundColor = kGrayWhiteColor;
    lineView.myHeight = ScaleW(1);
    lineView.myHorzMargin = 0;
    lineView.myTop = ScaleW(1);
    [contentLayout addSubview:lineView];
    
    MyLinearLayout *hLyout2 = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    [contentLayout addSubview:hLyout2];
    hLyout2.myHeight = ScaleW(50);
    hLyout2.myHorzMargin = 0;
    [hLyout2 addSubview:self.acNumTitleLabel];
    [hLyout2 addSubview:self.acNumLabel];
    
    
    UIView *lineView2 = [UIView new];
    lineView2.backgroundColor = kGrayWhiteColor;
    lineView2.myHeight = ScaleW(1);
    
    lineView2.myTop = ScaleW(1);
    [contentLayout addSubview:lineView2];

    
    MyLinearLayout *hLyout3 = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    [contentLayout addSubview:hLyout3];
    hLyout3.myHeight = ScaleW(50);
    hLyout3.myHorzMargin = 0;
    [hLyout3 addSubview:self.balanceLabel];
    
    UIView *lineView3 = [UIView new];
    lineView3.backgroundColor = kGrayWhiteColor;
    lineView3.myHeight = ScaleW(5);
    lineView3.myHorzMargin = 0;
    lineView3.myTop = ScaleW(1);
    [contentLayout addSubview:lineView3];
    
    [contentLayout addSubview:self.confirmBtn];
    [contentLayout addSubview:self.confrmDescLabel];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isEditBank = NO;
    self.title = SSKJLocalized(@"兑换", nil);
    [self addRightNavgationItemWithImage:[UIImage imageNamed:@"wd_icon_order"]];
    
}

- (void)rigthBtnAction:(id)sender {
    NSLog(@"记录");
    HeBi_ConvertRecord_ViewController *vc = [HeBi_ConvertRecord_ViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self requestConfig];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}


#pragma mark - Event
- (void)confrmDescEvent {
    GlobalProtocolViewController *gVC = [GlobalProtocolViewController new];
    gVC.type = 4;
    [self.navigationController pushViewController:gVC animated:YES];
}

- (void)addBankEvent {

    YLJAddBankViewController *vc = [YLJAddBankViewController new];
    vc.aType = self.isEditBank;
    if (self.isEditBank) {
        vc.bModel = self.bModel;
    }
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)confirmEvent {
    if (self.bModel.bank_name.length == 0) {
        [MBProgressHUD showError:@"请添加银行卡后再试"];
        return;
    }
    [YLJ_Default_AlertView showWithTitle:@"安全密码" message:@"请输入安全密码" cancleTitle:@"取消" confirmTitle:@"确定" confirmBlock:^(NSString * _Nonnull str) {
        self.currentPwd = str;
        [self requestExchange];
    }];
    
    
}

- (void)addEvent {
//    [WLTools noroundingStringWith:self.userInfoModel.money.doubleValue afterPointNumber:2]
    int count = self.exchangeCountTF.text.intValue;
    if (count == [self.bModel.num_min intValue]) {
        [MBProgressHUD showError:@"已是最大值"];
    } else {
        count ++;
    }
//        self.acNumLabel.text = [NSString stringWithFormat:@"%f",self.exchangePriceTF.text.doubleValue * count - (self.exchangePriceTF.text.doubleValue * count *self.bModel.tb_fee.intValue/100)];
    self.acNumLabel.text = [WLTools noroundingStringWith:self.exchangePriceTF.text.doubleValue * count - (self.exchangePriceTF.text.doubleValue * count *self.bModel.tb_fee.intValue/100) afterPointNumber:2];
    self.exchangeCountTF.text = [NSString stringWithFormat:@"%ld",(long)count];
}
- (void)midEvent {
    int count = self.exchangeCountTF.text.intValue;
    if (count == 1) {
        return;
    }
    count --;
    self.acNumLabel.text = [WLTools noroundingStringWith:self.exchangePriceTF.text.doubleValue * count - (self.exchangePriceTF.text.doubleValue * count *self.bModel.tb_fee.intValue/100) afterPointNumber:2];

    self.exchangeCountTF.text = [NSString stringWithFormat:@"%ld",(long)count];
}
#pragma mark - request
- (void)requestConfig {
    
//    NSDictionary * params = @{
//                              @"bank_user_name":self.accountView.valueString,
//                              @"bank_name":self.bankTypeView.valueString,
//                              @"bank_open":self.bankBranchView.valueString,
//                              @"bank_number":[WLTools md5:self.bankAcountView.valueString],
//                              };
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    WS(weakSelf);
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:JB_Account_tibiInfo_URL RequestType:RequestTypePost Parameters:nil Success:^(NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        WL_Network_Model *network_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if ([network_model.status integerValue] == SUCCESSED) {
            YLJBankInfoModel *infoModel = [YLJBankInfoModel mj_objectWithKeyValues:network_model.data];
            self.bModel = infoModel;
            [self hanlderModel:infoModel];
//            [self.navigationController popViewControllerAnimated:YES];
        }else{
        }
//        [MBProgressHUD showError:network_model.msg];
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        [MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
    }];
}

- (void)requestExchange {
//    NSString *total = [NSString stringWithFormat:@"%f",self.exchangePriceTF.text.doubleValue * self.exchangeCountTF.text.intValue];
        NSDictionary * params = @{
                                  @"num":self.exchangeCountTF.text,
//                                  @"money":total,
                                  @"money":[NSString stringWithFormat:@"%f",[self.exchangePriceTF.text doubleValue] * [self.exchangeCountTF.text intValue]],
                                  @"tpwd":[WLTools md5:self.currentPwd]
                                  };
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    WS(weakSelf);
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:JB_Account_Order_tibi RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
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

- (void)hanlderModel:(YLJBankInfoModel *)model {
//    self.exchangeCountTF.text = model.num_min;
    self.exchangeCountTF.text = @"1";
    self.exchangePriceTF.text = model.money_min;
    self.exchangeDescLabel.text = [NSString stringWithFormat:@"兑换金额（收取%@%%手续费）",model.tb_fee];
    if (model.bank_name.length > 0) {
        self.bankTitleLabel.text = model.bank_name;
        [self.bankTitleLabel sizeToFit];
        self.bankDescLabel.text = model.bank_number;
//        self.addbankBtn.enabled = NO;
        self.isEditBank = YES;
        
    }
    
    
//    self.acNumLabel.text = [NSString stringWithFormat:@"%f",model.num_min.intValue * model.money_min.doubleValue - ((model.num_min.intValue * model.money_min.doubleValue) *model.tb_fee.intValue/100)];
    self.acNumLabel.text = [WLTools noroundingStringWith:self.exchangeCountTF.text.intValue * model.money_min.doubleValue - (self.exchangeCountTF.text.intValue * model.money_min.doubleValue *self.bModel.tb_fee.intValue/100) afterPointNumber:2];
//    [self.acNumLabel sizeToFit];
    self.balanceLabel.text = [NSString stringWithFormat:@"可用余额  %@",[SSKJ_User_Tool sharedUserTool].userInfoModel.money];
    [self.balanceLabel sizeToFit];
}

#pragma UITextFieldDelegate

- (void)textFieldDidchange:(UITextField *)textField {
    NSString *textString = textField.text;
    if (![self inputShouldNumberWithText:textString] && textString.length > 0) {
        [MBProgressHUD showError:@"请输入数字"];
        textField.text = self.currentCount;
        return;
    } else if ([self inputShouldNumberWithText:textString] && textString.length > 0){
        if (textString.intValue > self.bModel.num_min.intValue) {
            [MBProgressHUD showError:@"已是最大值"];
            textField.text = self.currentCount;
            return;
        }
    }
    self.currentCount = textString;
}


- (BOOL)inputShouldNumberWithText:(NSString *)inputString {
    if (inputString.length == 0) return NO;
    NSString *regex =@"[0-9]*";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [pred evaluateWithObject:inputString];
}



#pragma mark - lazyLoad
- (UIView *)topBackView {
    if (!_topBackView) {
        _topBackView = [UIView new];
        _topBackView.mySize = CGSizeMake(ScreenWidth - ScaleW(30), ScaleW(70));
//        _topBackView.backgroundColor = [UIColor redColor];
        [_topBackView addSubview:self.bankTitleLabel];
        [_topBackView addSubview:self.bankDescLabel];
        [_topBackView addSubview:self.arrowImgView];
        [_topBackView addSubview:self.addbankBtn];
        UIView *lineView = [UIView new];
        lineView.backgroundColor = kGrayWhiteColor;
        lineView.frame = CGRectMake(-ScaleW(15), self.bankDescLabel.bottom + ScaleW(15), ScreenWidth, ScaleW(5));
        [_topBackView addSubview:lineView];
    }
    return _topBackView;
}

- (UILabel *)bankTitleLabel {
    if (!_bankTitleLabel) {
        _bankTitleLabel = [FactoryUI createLabelWithFrame:CGRectMake(ScaleW(0), ScaleW(15), ScaleW(120), ScaleW(16)) text:SSKJLocalized(@"添加银行卡", nil) textColor:kMainTextColor font:systemBoldFont(ScaleW(16))];
    }
    return _bankTitleLabel;
}

- (UILabel *)bankDescLabel {
    if (!_bankDescLabel) {
        _bankDescLabel = [FactoryUI createLabelWithFrame:CGRectMake(self.bankTitleLabel.x, self.bankTitleLabel.bottom + ScaleW(15), ScaleW(140), ScaleW(12)) text:SSKJLocalized(@"填写提现到银行卡账户", nil) textColor:kTitleGrayColor font:systemFont(ScaleW(12))];
    }
    return _bankDescLabel;
}

- (UIImageView *)arrowImgView {
    if (!_arrowImgView) {
        _arrowImgView = [FactoryUI createImageViewWithFrame:CGRectMake(ScaleW(315), ScaleW(30), ScaleW(22), ScaleW(22)) imageName:@"wd_icon_right"];
        
    }
    return _arrowImgView;
}

- (UIButton *)addbankBtn {
    if (!_addbankBtn) {
        _addbankBtn = [UIButton new];
        [_addbankBtn addTarget:self action:@selector(addBankEvent) forControlEvents:UIControlEventTouchUpInside];
        _addbankBtn.frame = CGRectMake(0, 0, ScreenWidth - ScaleW(30), ScaleW(70));
    }
    return _addbankBtn;
}

- (UILabel *)exchangeDescLabel {
    if (!_exchangeDescLabel) {
        _exchangeDescLabel = [FactoryUI createLabelWithFrame:CGRectZero text:SSKJLocalized(@"兑换金额（收取0.1%手续费）", nil) textColor:kTitleGrayColor font:systemFont(ScaleW(12))];
        _exchangeDescLabel.myTop = ScaleW(30);
    }
    return _exchangeDescLabel;
}

- (UILabel *)acNumTitleLabel {
    if (!_acNumTitleLabel) {
        _acNumTitleLabel = [FactoryUI createLabelWithFrame:CGRectZero text:SSKJLocalized(@"到账数量", nil) textColor:kMainTextColor font:systemFont(ScaleW(12))];
        _acNumTitleLabel.myCenterY = 0;
        _acNumTitleLabel.myLeading = 0;
        _acNumTitleLabel.weight = 1;

    }
    return _acNumTitleLabel;
}

- (UILabel *)acNumLabel {
    if (!_acNumLabel) {
        _acNumLabel = [FactoryUI createLabelWithFrame:CGRectZero text:@"0" textColor:kTheMeColor font:systemBoldFont(ScaleW(20))];
        _acNumLabel.myCenterY = 0;
        _acNumLabel.myRight = 0;
        _acNumLabel.myWidth = ScaleW(120);
        _acNumLabel.textAlignment = NSTextAlignmentRight;
//        _acNumLabel.weight = 1;
    }
    return _acNumLabel;
}

- (UILabel *)balanceLabel {
    if (!_balanceLabel) {
        _balanceLabel = [FactoryUI createLabelWithFrame:CGRectZero text:SSKJLocalized(@"可用余额5582.00", nil) textColor:kMainTextColor font:systemFont(ScaleW(12))];
        _balanceLabel.myCenterY = 0;

    }
    return _balanceLabel;
}

- (UIButton *)confirmBtn {
    if (!_confirmBtn) {
        _confirmBtn = [FactoryUI createButtonWithFrame:CGRectZero title:SSKJLocalized(@"确认兑换", nil) titleColor:kMainColor imageName:nil backgroundImageName:nil target:self selector:@selector(confirmEvent) font:systemBoldFont(16)];
        _confirmBtn.backgroundColor = kTheMeColor;
        [_confirmBtn setCornerRadius:ScaleW(3)];
        _confirmBtn.mySize = CGSizeMake(ScreenWidth - ScaleW(30), ScaleW(44));
        _confirmBtn.myTop = ScaleW(57);
    }
    return _confirmBtn;
}

- (UILabel *)confrmDescLabel {
    if (!_confrmDescLabel) {
        _confrmDescLabel = [FactoryUI createLabelWithFrame:CGRectZero text:SSKJLocalized(@"兑换说明", nil) textColor:kTheMeColor font:systemFont(ScaleW(12))];
        _confrmDescLabel.myRight = 0;
        _confrmDescLabel.userInteractionEnabled = YES;
        _confrmDescLabel.attributedText = [WLTools setUnderLine:@"兑换说明"];
        _confrmDescLabel.myTop = ScaleW(25);
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(confrmDescEvent)];
        [_confrmDescLabel addGestureRecognizer:tap];
    }
    return _confrmDescLabel;
}

@end
