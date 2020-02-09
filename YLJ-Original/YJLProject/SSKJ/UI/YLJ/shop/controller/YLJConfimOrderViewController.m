//
//  YLJConfimOrderViewController.m
//  SSKJ
//
//  Created by cy5566 on 2019/11/20.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "YLJConfimOrderViewController.h"
#import "YLJOrderDetailViewController.h"
#import "MyLayout.h"
#import "UILabel+WJFUN.h"
#import "FSTextView.h"
#import "Super_Myaddress_ViewController.h"
#import "YLJConfimOrderModel.h"
#import "YLJ_Default_AlertView.h"
@interface YLJConfimOrderViewController ()
@property (nonatomic,strong) UIImageView *shopImgView;
@property (nonatomic,strong) UILabel *shopTitleLabel;
@property (nonatomic,strong) UILabel *shopDescLabel;
@property (nonatomic,strong) UILabel *shopPriceLabel;
@property (nonatomic,strong) UILabel *peisongLabel;

@property (nonatomic,strong) MyLinearLayout *addressView;
@property (nonatomic,strong) UILabel *normalAddressLabel;
@property (nonatomic,strong) UILabel *normalNameLabel;
@property (nonatomic,strong) UILabel *noneAddressLabel;
@property (nonatomic,strong) UIImageView *addressImgView;

@property (nonatomic,strong) UILabel *countTitleLabel;
@property (nonatomic,strong) UIButton *miBtn;
@property (nonatomic,strong) UIButton *addBtn;
@property (nonatomic,strong) UILabel *countLabel;

@property (nonatomic,strong) UILabel *markLabel;
@property (nonatomic,strong) FSTextView *markTextView;

@property (nonatomic,strong) UIView *bottomView;

@property (nonatomic,strong) YLJConfimOrderModel *cModel;

@property (nonatomic,copy) NSString *currentPwd;
@property (nonatomic,copy) NSString *orderID;

//单个购物券或余额
@property (nonatomic,strong) UILabel *totalLabel;

//购物券+余额用下面两个属性
@property (nonatomic,strong) UILabel *totalCouponLabel;
@property (nonatomic,strong) UILabel *totalBalanceLabel;

//共几件
@property (nonatomic,strong) UILabel *cTotalLabel;

@end

@implementation YLJConfimOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = SSKJLocalized(@"确认订单", nil);
    [self.view addSubview:self.bottomView];

}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self requstData];
}


- (void)loadView {
    [super loadView];
    UIScrollView *scrollView = [UIScrollView new];
    scrollView.frame = self.view.frame;
    scrollView.backgroundColor = kMainColor;
    [self.view addSubview:scrollView];
    MyLinearLayout *contentLayout = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    contentLayout.padding = UIEdgeInsetsMake(0, ScaleW(15), 0, ScaleW(0)); //设置布局内的子视图离自己的边距.
    contentLayout.myHorzMargin = 0;                          //同时指定左右边距为0表示宽度和父视图一样宽
    contentLayout.heightSize.lBound(scrollView.heightSize, 10, 1); //高度虽然是wrapContentHeight的。但是最小的高度不能低于父视图的高度加10.
    [scrollView addSubview:contentLayout];
    
    MyLinearLayout *hLayout = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
//    hLayout.myHeight = ScaleW(90);
    hLayout.myHorzMargin = ScaleW(0);
    hLayout.wrapContentHeight = YES;
    [contentLayout addSubview:hLayout];
    [hLayout addSubview:self.shopImgView];
    
    MyLinearLayout *nameLayout = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    nameLayout.weight = 1.0;
    nameLayout.myLeading = ScaleW(15);
    [hLayout addSubview:nameLayout];
    
    [nameLayout addSubview:self.shopTitleLabel];
    [nameLayout addSubview:self.shopDescLabel];
    [nameLayout addSubview:self.shopPriceLabel];
    
    [contentLayout addSubview:self.peisongLabel];
    [contentLayout addSubview:self.normalNameLabel];
    [contentLayout addSubview:self.addressView];
    MyLinearLayout *addressLayout = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    [self.addressView addSubview:addressLayout];
//    [self.addressView addSubview:self.normalAddressLabel];

//    [self.addressView addSubview:self.noneAddressLabel];
    addressLayout.wrapContentHeight = YES;
    [addressLayout addSubview:self.normalAddressLabel];
    [addressLayout addSubview:self.addressImgView];
    UIView *lineView = [UIView new];
    lineView.backgroundColor = kLineGrayColor;
    lineView.mySize = CGSizeMake(ScreenWidth - ScaleW(30), ScaleW(1));
    lineView.myTop = ScaleW(20);
    [contentLayout addSubview:lineView];
    
    MyLinearLayout *conutLayout = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    conutLayout.wrapContentHeight = YES;
    conutLayout.myTop = ScaleW(41);

    [contentLayout addSubview:conutLayout];
    [conutLayout addSubview:self.countTitleLabel];
    [conutLayout addSubview:self.miBtn];
    [conutLayout addSubview:self.countLabel];
    [conutLayout addSubview:self.addBtn];
    [contentLayout addSubview:self.markLabel];
    [contentLayout addSubview:self.markTextView];

}

//下单接口
- (void)requestPlaceOrder {
    
    NSDictionary * params = @{
                              @"goods_id":self.goodsID,
                              @"num":self.countLabel.text,
                              @"address_id":self.cModel.address_info.ID,
                              @"note":self.markTextView.text
                              };
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    WS(weakSelf);
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:AB_Shop_user_order_add_post RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        WL_Network_Model *network_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if ([network_model.status integerValue] == SUCCESSED) {
            self.orderID = network_model.data[@"order_id"];
            [YLJ_Default_AlertView showWithTitle:@"安全密码" message:@"请输入安全密码" cancleTitle:@"取消" confirmTitle:@"确定" confirmBlock:^(NSString * _Nonnull str) {
                weakSelf.currentPwd = str;
                [weakSelf requestconfirmOrder];
            }];
        }else{
            [MBProgressHUD showError:network_model.msg];
        }
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        [MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
    }];
}
//确认支付接口
- (void)requestconfirmOrder {
    NSDictionary * params = @{
                              @"tpwd":[WLTools md5:self.currentPwd],
                              @"order_id":self.orderID
                              };
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    WS(weakSelf);
    [[WLHttpManager shareManager]requestWithURL:AB_Shop_user_order_pay_post RequestType:RequestTypePost Parameters:params Success:^(id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        WL_Network_Model *network_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if ([network_model.status integerValue] == SUCCESSED) {
            NSLog(@"跳转立即支付页面");
            YLJOrderDetailViewController *dVC = [YLJOrderDetailViewController new];
            dVC.orderID = self.orderID;
            [self.navigationController pushViewController:dVC animated:YES];
        }else{
            [MBProgressHUD showError:network_model.msg];
        }
        
    } Failure:^(NSError *error, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        [MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
    }];
}

#pragma mark - Event
- (void)gotoBuyEvent {
    if (!kLogin) {
        [self presentLoginController];
        [MBProgressHUD showError:@"请先登录"];
        return;
    }
    if ([[SSKJ_User_Tool sharedUserTool].userInfoModel.state intValue] == 0 ) {
        [MBProgressHUD showError:@"请先激活用户"];
        return;
    }
    if ([[SSKJ_User_Tool sharedUserTool].userInfoModel.tpwd intValue] == 0) {
        [MBProgressHUD showError:@"请设置安全密码后再试"];
        return;
    }
    [self requestPlaceOrder];
}
- (void)testEvent {
    
}

-(void)addressEvent {
    NSLog(@"点击了地址");
    if (!kLogin) {
        [self presentLoginController];
        [MBProgressHUD showError:@"请先登录"];
        return;
    }
    
    Super_Myaddress_ViewController *aVC = [Super_Myaddress_ViewController new];
    aVC.callBackBlcok = ^(AddressMessageModel * _Nonnull model) {
        self.normalNameLabel.hidden = NO;
        self.normalAddressLabel.textColor = kMainTextColor;
        self.normalNameLabel.text = [NSString stringWithFormat:@"%@ %@",model.name,model.mobile];
        [self.normalNameLabel sizeToFit];
        self.normalAddressLabel.text = [NSString stringWithFormat:@"%@%@%@-%@",model.sheng,model.shi,model.qu,model.address];
    };
    [self.navigationController pushViewController:aVC animated:YES];
}

- (void)addEvent {
    int count = self.countLabel.text.intValue;
    count ++;
    self.countLabel.text = [NSString stringWithFormat:@"%ld",(long)count];
    self.cTotalLabel.text = [NSString stringWithFormat:@"共%d件",count];
//    self.totalLabel.text = [WLTools setTotalPriceWithJifen:[NSString stringWithFormat:@"%f",self.cModel.data.can_sell_price.doubleValue * count]
//                                                  andPrice:[NSString stringWithFormat:@"%f",self.cModel.data.rmb_price.doubleValue * count]];
    if (self.cModel.data.can_sell_price.length == 0) {
        [self configTotalWithPrice:[NSString stringWithFormat:@"%f",self.cModel.data.rmb_price.doubleValue * count] andJifen:nil];
    } else if (self.cModel.data.rmb_price.length == 0) {
        [self configTotalWithPrice:nil andJifen:[NSString stringWithFormat:@"%f",self.cModel.data.can_sell_price.doubleValue * count]];
    } else {
        [self configTotalWithPrice:[NSString stringWithFormat:@"%f",self.cModel.data.rmb_price.doubleValue * count] andJifen:[NSString stringWithFormat:@"%f",self.cModel.data.can_sell_price.doubleValue * count]];
    }
}

- (void)midEvent {
    int count = self.countLabel.text.intValue;
    if (count < 1) {
        [MBProgressHUD showError:@"最小购买一件"];
        return;
    }
    
    count --;

    self.countLabel.text = [NSString stringWithFormat:@"%ld",(long)count];
    self.cTotalLabel.text = [NSString stringWithFormat:@"共%d件",count];
//    self.totalLabel.text = [WLTools setTotalPriceWithJifen:[NSString stringWithFormat:@"%f",self.cModel.data.can_sell_price.doubleValue * count]
//                                                  andPrice:[NSString stringWithFormat:@"%f",self.cModel.data.rmb_price.doubleValue * count]];
    if (self.cModel.data.can_sell_price.length == 0) {
        [self configTotalWithPrice:[NSString stringWithFormat:@"%f",self.cModel.data.rmb_price.doubleValue * count] andJifen:nil];
    } else if (self.cModel.data.rmb_price.length == 0) {
        [self configTotalWithPrice:nil andJifen:[NSString stringWithFormat:@"%f",self.cModel.data.can_sell_price.doubleValue * count]];
    } else {
        [self configTotalWithPrice:[NSString stringWithFormat:@"%f",self.cModel.data.rmb_price.doubleValue * count] andJifen:[NSString stringWithFormat:@"%f",self.cModel.data.can_sell_price.doubleValue * count]];
    }

}

- (UIImageView *)shopImgView {
    if (!_shopImgView) {
        _shopImgView = [FactoryUI createImageViewWithFrame:CGRectZero imageName:@"suolueTu"];
        _shopImgView.mySize = CGSizeMake(ScaleW(90), ScaleW(90));
        _shopImgView.myTop = ScaleW(15);
    }
    return _shopImgView;
}

- (UILabel *)shopTitleLabel {
    if (!_shopTitleLabel) {
        _shopTitleLabel = [FactoryUI createLabelWithFrame:CGRectMake(0, 0, ScaleW(200), ScaleW(14)) text:@"智能音箱无线蓝牙迷你家用小音箱小音箱小音箱小音箱" textColor:kMainTextColor font:systemFont(ScaleW(14))];
        _shopTitleLabel.numberOfLines = 1;
        _shopTitleLabel.myTop = ScaleW(15);
        _shopTitleLabel.myWidth = ScaleW(237);
    }
    return _shopTitleLabel;
}

- (UILabel *)shopDescLabel {
    if (!_shopDescLabel) {
        _shopDescLabel = [FactoryUI createLabelWithFrame:CGRectMake(0, 0, ScaleW(150), ScaleW(12)) text:@"库存4252件" textColor:kGrayTitleColor font:systemFont(ScaleW(12))];
        _shopDescLabel.myTop = ScaleW(12);
    }
    return _shopDescLabel;
}

- (UILabel *)shopPriceLabel {
    if (!_shopPriceLabel) {
        _shopPriceLabel = [FactoryUI createLabelWithFrame:CGRectMake(0, 0, ScaleW(150), ScaleW(14)) text:@"10购物券+10余额" textColor:kTheMeColor font:systemFont(ScaleW(16))];
        _shopPriceLabel.myTop = ScaleW(25);

    }
    return _shopPriceLabel;
}

- (UILabel *)peisongLabel {
    if (!_peisongLabel) {
        _peisongLabel = [FactoryUI createLabelWithFrame:CGRectZero text:@"配送至" textColor:kGrayTitleColor font:systemFont(ScaleW(13))];
        _peisongLabel.myTop = ScaleW(36);
    }
    return _peisongLabel;
}

- (UILabel *)normalNameLabel {
    if (!_normalNameLabel) {
        _normalNameLabel = [FactoryUI createLabelWithFrame:CGRectZero text:@"张小明 15832254525" textColor:kMainTextColor font:systemFont(ScaleW(14))];
        [_normalNameLabel text:@"15832254525" color:kGrayTitleColor font:systemFont(12)];
        _normalNameLabel.myTop = ScaleW(20);
    }
    return _normalNameLabel;
}

- (MyLinearLayout *)addressView {
    if (!_addressView) {
        _addressView = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
        _addressView.myTop = ScaleW(14);
        _addressView.myWidth = ScreenWidth - ScaleW(30);
        UITapGestureRecognizer* singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addressEvent)];
        [_addressView addGestureRecognizer:singleTap];
//        _addressView.mySize = CGSizeMake(ScreenWidth - ScaleW(30), 0)
    }
    return _addressView;
}

- (UILabel *)normalAddressLabel {
    if (!_normalAddressLabel) {
        _normalAddressLabel = [FactoryUI createLabelWithFrame:CGRectZero text:@"河南省郑州市中原区航海西路工人路帝湖花园-西王府4号楼2单元2号楼12C" textColor:kMainTextColor font:systemFont(ScaleW(12))];
        _normalAddressLabel.mySize = CGSizeMake(ScaleW(250), ScaleW(40));

        _normalAddressLabel.numberOfLines = 2;
    }
    return _normalAddressLabel;
}

- (UILabel *)noneAddressLabel {
    if (!_noneAddressLabel) {
        _noneAddressLabel = [FactoryUI createLabelWithFrame:CGRectZero text:@"添加收货地址" textColor:kTheMeColor font:systemFont(ScaleW(12))];
    }
    return _noneAddressLabel;
}

- (UIImageView *)addressImgView {
    if (!_addressImgView) {
        _addressImgView = [FactoryUI createImageViewWithFrame:CGRectZero imageName:@"wd_icon_right"];
        _addressImgView.myLeading = ScaleW(84);
        _addressImgView.myCenterY = self.normalAddressLabel.myCenterY;
        _addressImgView.mySize = CGSizeMake(ScaleW(22), ScaleW(22));
    }
    return _addressImgView;
}

- (UILabel *)countTitleLabel {
    if (!_countTitleLabel) {
        _countTitleLabel = [FactoryUI createLabelWithFrame:CGRectZero text:SSKJLocalized(@"购买数量", nil) textColor:kGrayTitleColor font:systemFont(14)];
    }
    return _countTitleLabel;
}

- (UILabel *)countLabel {
    if (!_countLabel) {
        _countLabel = [FactoryUI createLabelWithFrame:CGRectZero text:SSKJLocalized(@"1", nil) textColor:kMainTextColor font:systemFont(14)];
        _countLabel.textAlignment = NSTextAlignmentCenter;
        _countLabel.mySize = CGSizeMake(ScaleW(25), ScaleW(23));
        _countLabel.backgroundColor = kGrayWhiteColor;
        _countLabel.myLeading = ScaleW(6);
    }
    return _countLabel;
}

- (UIButton *)addBtn {
    if (!_addBtn) {
        _addBtn = [FactoryUI createButtonWithFrame:CGRectZero title:@"" titleColor:nil imageName:@"ylj_icon_add" backgroundImageName:nil target:self selector:@selector(addEvent) font:nil];
        _addBtn.mySize = CGSizeMake(ScaleW(30), ScaleW(23));
        _addBtn.myLeading = ScaleW(6);
    }
    return _addBtn;
}

- (UIButton *)miBtn {
    if (!_miBtn) {
        _miBtn = [FactoryUI createButtonWithFrame:CGRectZero title:@"" titleColor:nil imageName:@"ylj_icon_mid" backgroundImageName:nil target:self selector:@selector(midEvent) font:nil];
        _miBtn.mySize = CGSizeMake(ScaleW(23), ScaleW(23));
        _miBtn.myLeading = ScaleW(212);
    }
    return _miBtn;
}

- (UILabel *)markLabel {
    if (!_markLabel) {
        _markLabel = [FactoryUI createLabelWithFrame:CGRectZero text:SSKJLocalized(@"订单备注", nil) textColor:kGrayTitleColor font:systemFont(14)];
        _markLabel.myTop = ScaleW(44);
        
    }
    return _markLabel;
}


-(FSTextView *)markTextView
{
    if (nil == _markTextView) {
        _markTextView = [[FSTextView alloc]initWithFrame:CGRectZero];
        _markTextView.font = systemFont(ScaleW(12));
        _markTextView.textColor = kMainTextColor;
//        _markTextView.delegate = self;
        _markTextView.placeholder = SSKJLocalized(@"请填写备注（选填）",nil);
        _markTextView.placeholderColor = kGrayTitleColor;
        _markTextView.backgroundColor = [UIColor clearColor];
        _markTextView.mySize = CGSizeMake(ScaleW(335), ScaleW(130));
        _markTextView.myLeading = ScaleW(10);
        _markTextView.myTop = ScaleW(15);
    }
    return _markTextView;
}

- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [UIView new];
//        _bottomView.myBottom = 0;
//        _bottomView.myWidth = ScreenWidth;
//        _bottomView.myLeft = ScaleW(0);
        _bottomView.frame = CGRectMake(0, ScreenHeight - ScaleW(50) - Height_NavBar, ScreenWidth, ScaleW(50));
        UIButton *leftBtn = [UIButton new];
        leftBtn.backgroundColor = RGBCOLOR(0, 181, 112);
        leftBtn.frame = CGRectMake(0, 0,ScreenWidth - ScaleW(140), ScaleW(50));
        UILabel *countLabel = [WLTools allocLabel:SSKJLocalized(@"共1件", nil) font:systemFont(ScaleW(14)) textColor:kMainWihteColor frame:CGRectMake(ScaleW(15), ScaleW(16), ScaleW(44), ScaleW(14)) textAlignment:NSTextAlignmentCenter];
//        countLabel.adjustsFontSizeToFitWidth = NO;
//        [countLabel sizeToFit];
        self.cTotalLabel = countLabel;
        
        UILabel *totalLabel = [WLTools allocLabel:SSKJLocalized(@"合计：236.02 油乐券", nil) font:systemFont(ScaleW(16)) textColor:kMainWihteColor frame:CGRectMake(ScaleW(71), 0, ScaleW(130), ScaleW(16)) textAlignment:NSTextAlignmentCenter];

        self.totalLabel = totalLabel;
        totalLabel.centerY = countLabel.centerY;
        [totalLabel text:@"油乐券" color:kMainWihteColor font:systemFont(12)];
        [leftBtn addSubview:countLabel];
        [leftBtn addSubview:totalLabel];
        UILabel *couponLabel = [WLTools allocLabel:SSKJLocalized(@"20购物券", nil) font:systemFont(ScaleW(16)) textColor:kMainWihteColor frame:CGRectMake(ScaleW(71), ScaleW(6), ScaleW(130), ScaleW(16)) textAlignment:NSTextAlignmentCenter];
        couponLabel.hidden = YES;
        self.totalCouponLabel = couponLabel;
        UILabel *balanceLabel = [WLTools allocLabel:SSKJLocalized(@"15余额", nil) font:systemFont(ScaleW(16)) textColor:kMainWihteColor frame:CGRectMake(ScaleW(71), couponLabel.bottom + ScaleW(6), ScaleW(130), ScaleW(16)) textAlignment:NSTextAlignmentCenter];
        balanceLabel.hidden = YES;
        self.totalBalanceLabel = balanceLabel;
        [leftBtn addSubview:couponLabel];
        [leftBtn addSubview:balanceLabel];
        
        [leftBtn addTarget:self action:@selector(testEvent) forControlEvents:UIControlEventTouchUpInside];

        
        UIButton *rightBtn = [FactoryUI createButtonWithFrame:CGRectZero title:SSKJLocalized(@"立即支付", nil) titleColor:kMainWihteColor imageName:nil backgroundImageName:nil target:self selector:@selector(gotoBuyEvent) font:systemFont(ScaleW(16))];
        rightBtn.backgroundColor = kTheMeColor;
        rightBtn.frame = CGRectMake(leftBtn.right, 0, ScaleW(140), ScaleW(50));
        [_bottomView addSubview:rightBtn];
        [_bottomView addSubview:leftBtn];
    }
    return _bottomView;
}

- (void)requstData {
    
    NSDictionary * params = @{
                              @"goods_id":self.goodsID,
                              };
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    WS(weakSelf);
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:JB_Account_Malls_confirm_order RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        WL_Network_Model *network_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if ([network_model.status integerValue] == SUCCESSED) {
            YLJConfimOrderModel *cModel = [YLJConfimOrderModel mj_objectWithKeyValues:network_model.data];
            self.cModel = cModel;
            [self handleDataWithModel];
        }else{
//                    [MBProgressHUD showError:network_model.msg];
        }
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        [MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
    }];
}

-(void)handleDataWithModel{

    NSURL *url = [NSURL URLWithString:[WLTools imageURLWithURL:self.cModel.data.thumbnail_pic]];
    [self.shopImgView sd_setImageWithURL:url];
    self.shopTitleLabel.text = self.cModel.data.goods_name;
    self.shopDescLabel.text = [NSString stringWithFormat:@"库存%@件",self.cModel.data.skus];
    [self.shopDescLabel sizeToFit];
    self.shopPriceLabel.text = [WLTools setTotalPriceWithJifen:self.cModel.data.can_sell_price andPrice:self.cModel.data.rmb_price];
    [self.shopPriceLabel sizeToFit];
    
    if (!self.cModel.address_info) {
        self.normalNameLabel.hidden = YES;
        self.normalAddressLabel.textColor = kTheMeColor;
        self.normalAddressLabel.attributedText = [WLTools setUnderLine:@"添加收货地址"];
        self.normalAddressLabel.font = systemBoldFont(16);
    } else {
        self.normalNameLabel.hidden = NO;
        self.normalAddressLabel.textColor = kMainTextColor;
        self.normalAddressLabel.font = systemBoldFont(12);
        self.normalNameLabel.text = [NSString stringWithFormat:@"%@ %@",self.cModel.address_info.name,self.cModel.address_info.phone];
        [self.normalNameLabel sizeToFit];
        self.normalAddressLabel.text = [NSString stringWithFormat:@"%@%@%@%@",self.cModel.address_info.province,self.cModel.address_info.city,self.cModel.address_info.country,self.cModel.address_info.detail];
        
    }
    
//    self.totalLabel.text = [WLTools setTotalPriceWithJifen:self.cModel.data.can_sell_price
//                                                  andPrice:self.cModel.data.rmb_price];
    [self configTotalWithPrice:self.cModel.data.rmb_price andJifen:self.cModel.data.can_sell_price];


}

- (void)configTotalWithPrice:(NSString *)rmb andJifen:(NSString *)jifen {
        if (jifen.length > 0 && rmb.length > 0) {
            self.totalBalanceLabel.hidden = NO;
            self.totalCouponLabel.hidden = NO;
            self.totalLabel.hidden = YES;
            self.totalBalanceLabel.text = [NSString stringWithFormat:@"%@余额",[WLTools noroundingStringWith:[rmb doubleValue] afterPointNumber:2]];
            self.totalCouponLabel.text = [NSString stringWithFormat:@"%@购物券",[WLTools noroundingStringWith:[jifen doubleValue] afterPointNumber:2]];

        } else if (jifen.length > 0 &&rmb.length == 0){
            self.totalBalanceLabel.hidden = YES;
            self.totalCouponLabel.hidden = YES;
            self.totalLabel.hidden = NO;
            self.totalLabel.text = [NSString stringWithFormat:@"%@购物券",[WLTools noroundingStringWith:[jifen doubleValue] afterPointNumber:2]];
        } else {
            self.totalBalanceLabel.hidden = YES;
            self.totalCouponLabel.hidden = YES;
            self.totalLabel.hidden = NO;
            self.totalLabel.text = [NSString stringWithFormat:@"%@余额",[WLTools noroundingStringWith:[rmb doubleValue] afterPointNumber:2]];
        }
}
@end
