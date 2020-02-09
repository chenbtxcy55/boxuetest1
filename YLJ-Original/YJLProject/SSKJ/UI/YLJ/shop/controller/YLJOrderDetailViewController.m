//
//  YLJOrderDetailViewController.m
//  SSKJ
//
//  Created by cy5566 on 2019/11/20.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "YLJOrderDetailViewController.h"
#import "MyLayout.h"
#import "UILabel+WJFUN.h"
#import "YLJOrderSubView.h"
#import "YLJOrderDetailModel.h"
#import "GoCoin_Login_NavView.h"
@interface YLJOrderDetailViewController ()
@property (nonatomic,strong) UILabel *titleNavLabel;
@property (nonatomic,strong) UIButton *leftNavBtn;

@property (nonatomic,strong) GoCoin_Login_NavView *navView;

@property (nonatomic,strong) UIView *topBgView;
@property (nonatomic,strong) UILabel *topStateLabel;


@property (nonatomic,strong) UIImageView *shopImgView;
@property (nonatomic,strong) UILabel *shopTitleLabel;
@property (nonatomic,strong) UILabel *shopDescLabel;
@property (nonatomic,strong) UILabel *shopCountLabel;
@property (nonatomic,strong) UILabel *shopPriceLabel;
@property (nonatomic,strong) UILabel *peisongLabel;

@property (nonatomic,strong) MyLinearLayout *addressView;
@property (nonatomic,strong) UILabel *normalAddressLabel;
@property (nonatomic,strong) UILabel *normalNameLabel;
//下单时间
@property (nonatomic,strong) YLJOrderSubView *list1View;
//快递类型
@property (nonatomic,strong) YLJOrderSubView *list2View;
//快递单号
@property (nonatomic,strong) YLJOrderSubView *list3View;
//订单号
@property (nonatomic,strong) YLJOrderSubView *list4View;
//订单备注
@property (nonatomic,strong) YLJOrderSubView *list5View;

@property (nonatomic,strong) YLJOrderDetailModel *yModel;
@property (nonatomic,strong) YLJShopAddressInfoModel *user_detail;
@property (nonatomic,strong) YLJOrderInfoDetailModel *order_detail;
@end

@implementation YLJOrderDetailViewController

- (void)loadView {
    [super loadView];
 
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
    [self requestOrderDetail];
}


- (void)configUI {
    MyLinearLayout *contentLayout = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    contentLayout.myHorzMargin = 0;                          //同时指定左右边距为0表示宽度和父视图一样宽
    contentLayout.heightSize.lBound(self.view.heightSize, 10, 1);
    [self.view addSubview:contentLayout];
    [contentLayout addSubview:self.topBgView]; //顶部布局

    //用来统一距离左边15
    MyLinearLayout *contentLayout1 = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    contentLayout1.padding = UIEdgeInsetsMake(0, ScaleW(15), 0, ScaleW(0)); //设置布局内的子视图离自己的边距.
    contentLayout1.myHorzMargin = 0;
    [contentLayout addSubview:contentLayout1];
    [contentLayout1 addSubview:self.normalNameLabel];
    [contentLayout1 addSubview:self.addressView];
    MyLinearLayout *addressLayout = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];//地址布局
    [self.addressView addSubview:addressLayout];
    
    //    [self.addressView addSubview:self.noneAddressLabel];
    addressLayout.wrapContentHeight = YES;
    [addressLayout addSubview:self.normalAddressLabel];
    UIView *lineView = [UIView new];
    lineView.backgroundColor = kGrayWhiteColor;
    lineView.mySize = CGSizeMake(ScreenWidth, ScaleW(5));
    lineView.myTop = ScaleW(20);
    [contentLayout addSubview:lineView];
    
    //用来统一距离左边15
    MyLinearLayout *contentLayout2 = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    contentLayout2.padding = UIEdgeInsetsMake(0, ScaleW(15), 0, ScaleW(0)); //设置布局内的子视图离自己的边距.
    contentLayout2.myHorzMargin = 0;
    [contentLayout addSubview:contentLayout2];
    
    MyLinearLayout *hLayout = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    //    hLayout.myHeight = ScaleW(90);
    hLayout.myHorzMargin = ScaleW(0);
    hLayout.wrapContentHeight = YES;
    [contentLayout2 addSubview:hLayout];
    [hLayout addSubview:self.shopImgView];
    
    MyLinearLayout *nameLayout = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    nameLayout.weight = 1.0;
    nameLayout.myLeading = ScaleW(15);
    [hLayout addSubview:nameLayout];
    
    [nameLayout addSubview:self.shopTitleLabel];
    //    [nameLayout addSubview:self.shopDescLabel];
    
    MyLinearLayout *sLayout = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    sLayout.myHorzMargin = ScaleW(0);
    sLayout.wrapContentHeight = YES;
    [nameLayout addSubview:sLayout];
    [sLayout addSubview:self.shopPriceLabel];
    [sLayout addSubview:self.shopCountLabel];
    
    MyLinearLayout *bottomLayout = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    bottomLayout.myHorzMargin = 0;
    bottomLayout.myTop = ScaleW(15);
    [contentLayout addSubview:bottomLayout];
    WS(weakSelf);
    for (int i = 0;i < 5; i ++) {
        YLJOrderSubView *sView = [YLJOrderSubView new];
        if (i == 0) {
            self.list1View = sView;
            sView.leftLabel.text = @"下单时间";
            sView.copyBtn.hidden = YES;
        }
        if (i == 1) {
            self.list2View = sView;
            sView.leftLabel.text = @"快递类型";
            sView.copyBtn.hidden = YES;
        }
        if (i == 2) {
            self.list3View = sView;
            sView.leftLabel.text = @"快递单号";
            sView.copyBlock = ^{
                [weakSelf copyShipping_snEvent];
            };
        }
        if (i == 3) {
            self.list4View = sView;
            sView.leftLabel.text = @"订单号";
            sView.copyBlock = ^{
                [weakSelf copyOrder_snEvent];
            };
        }
        if (i == 4) {
            self.list5View = sView;
            sView.leftLabel.text = @"订单备注";
            sView.copyBtn.hidden = YES;
        }
        
        sView.myTop = ScaleW(15);
        sView.mySize = CGSizeMake(ScreenWidth, ScaleW(30));
        [bottomLayout addSubview:sView];
    }
    
    
    
    
    
//    self.title = SSKJLocalized(@"订单详情", nil);
//    [self.view addSubview:self.titleNavLabel];
//    [self.view addSubview:self.leftNavBtn];
    [self navView];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)backEvent {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)copyShipping_snEvent {
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = self.list3View.rightLabel.text;
        [MBProgressHUD showError:SSKJLocalized(@"复制成功", nil)];
}

- (void)copyOrder_snEvent {
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = self.list4View.rightLabel.text;
    [MBProgressHUD showError:SSKJLocalized(@"复制成功", nil)];
}

- (void)requestOrderDetail {
    NSDictionary * params = @{
//                              @"tpwd":[WLTools md5:self.currentPwd],
                              @"order_id":self.orderID
                              };
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    WS(weakSelf);
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:JB_Shop_OrderDetail RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        WL_Network_Model *network_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if ([network_model.status integerValue] == SUCCESSED) {
            YLJOrderDetailModel *yModel = [YLJOrderDetailModel mj_objectWithKeyValues:network_model.data];
            weakSelf.yModel = yModel;
            [weakSelf hanlderModel:yModel];
        }else{
            [MBProgressHUD showError:network_model.msg];
        }
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        [MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
    }];
}

- (void)hanlderModel:(YLJOrderDetailModel *)model {
    self.user_detail = model.user_detail;
    self.order_detail = model.order_detail;


    switch ([self.order_detail.status intValue]) {
        case -1:
        {
            self.topStateLabel.text = @"已取消";
        }
            break;
        case 1:
        {
            self.topStateLabel.text = @"待发货";

        }
            break;
        case 2:
        {
            self.topStateLabel.text = @"已发货";

        }
            break;
            
        default:
            break;
    }
    NSString *urlStr = self.order_detail.pic_path;
    NSString *nUrlStr = [WLTools imageURLWithURL:urlStr];
    [self.shopImgView sd_setImageWithURL:[NSURL URLWithString:nUrlStr] placeholderImage:[UIImage imageNamed:@"suolueTu"]];
    self.shopTitleLabel.text = self.order_detail.goods_name;
//    NSString *price;
//    if (self.order_detail.price.length > 0) {
//        price = self.order_detail.price;
//        self.shopPriceLabel.text = [NSString stringWithFormat:@"%.2f余额",price.doubleValue];
//    }
//    if (self.order_detail.can_sell_price.length > 0) {
//        price = self.order_detail.can_sell_price;
//        self.shopPriceLabel.text = [NSString stringWithFormat:@"%.2f 购物券",price.doubleValue];
//    }
    self.shopPriceLabel.text = [WLTools setTotalPriceWithJifen:self.order_detail.can_sell_price andPrice:self.order_detail.price];
    [self.shopPriceLabel sizeToFit];
    self.shopCountLabel.text = [NSString stringWithFormat:@"X%@",self.order_detail.num];
    [self.shopCountLabel sizeToFit];
    self.normalNameLabel.text = [NSString stringWithFormat:@"%@ %@",self.user_detail.user_name,self.user_detail.phone];
    [self.normalNameLabel sizeToFit];
    self.normalAddressLabel.text = [NSString stringWithFormat:@"%@%@%@%@",self.user_detail.province,self.user_detail.city,self.user_detail.country,self.user_detail.detail];

    self.list1View.rightLabel.text = self.order_detail.create_time;
    self.list2View.rightLabel.text = self.order_detail.shipping_comp_name;
    self.list3View.rightLabel.text = self.order_detail.shipping_sn;
    self.list4View.rightLabel.text = self.order_detail.order_sn;
    self.list5View.rightLabel.text = self.order_detail.note;
    
    if (self.order_detail.shipping_comp_name.length == 0) {
        self.list2View.hidden = YES;
    }
    if (self.order_detail.shipping_sn.length == 0) {
        self.list3View.hidden = YES;
    }
    if (self.order_detail.note.length == 0) {
        self.list5View.hidden = YES;
    }
}

- (UILabel *)titleNavLabel {
    if (!_titleNavLabel) {
        _titleNavLabel = [WLTools allocLabel:SSKJLocalized(@"订单详情", nil) font:systemBoldFont(ScaleW(18)) textColor:kMainWihteColor frame:CGRectMake(ScaleW(0), ScaleW(34), ScaleW(85), ScaleW(18)) textAlignment:NSTextAlignmentCenter];
        _titleNavLabel.centerX = self.view.centerX;
    }
    return _titleNavLabel;
}

- (UIButton *)leftNavBtn {
    if (!_leftNavBtn) {
        _leftNavBtn = [WLTools allocButton:nil textColor:nil nom_bg:nil hei_bg:nil frame:CGRectMake(ScaleW(5), 0, ScaleW(60), ScaleW(44))];
        [_leftNavBtn setImage:[UIImage imageNamed:@"commentWhite"] forState:UIControlStateNormal];
        [_leftNavBtn addTarget:self action:@selector(backEvent) forControlEvents:UIControlEventTouchUpInside];
        _leftNavBtn.centerY = self.titleNavLabel.centerY;
    }
    return _leftNavBtn;
    
}

- (UIView *)topBgView {
    if (!_topBgView) {
        _topBgView = [UIView new];
        _topBgView.mySize = CGSizeMake(ScaleW(375), ScaleW(160));
        _topBgView.backgroundColor = kTheMeColor;
        
        self.topStateLabel = [FactoryUI createLabelWithFrame:CGRectMake(ScaleW(15), ScaleW(103), ScaleW(100), ScaleW(18)) text:@"已发货" textColor:kMainWihteColor font:systemBoldFont(18)];
//        self.topStateLabel.myTop = ScaleW(103);
        [_topBgView addSubview:self.topStateLabel];
        
        UIImageView *imgView = [FactoryUI createImageViewWithFrame:CGRectMake(ScaleW(207), ScaleW(59), ScaleW(150), ScaleW(89)) imageName:@"ylj_shop_bg1"];
//        imgView.myLeading = ScaleW(140);
//        imgView.mySize = CGSizeMake(ScaleW(150), ScaleW(89));
//        imgView.top = ScaleW(59);
        [_topBgView addSubview:imgView];
    }
    return _topBgView;
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
        _shopTitleLabel = [FactoryUI createLabelWithFrame:CGRectMake(0, 0, ScaleW(200), ScaleW(34)) text:@"智能音箱无线蓝牙迷你家用小音箱小音箱小音箱小音箱" textColor:kMainTextColor font:systemFont(ScaleW(14))];
        _shopTitleLabel.numberOfLines = 2;
        _shopTitleLabel.myTop = ScaleW(15);
        _shopTitleLabel.myWidth = ScaleW(182);
        _shopTitleLabel.myHeight = ScaleW(34);
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

- (UILabel *)shopCountLabel {
    if (!_shopCountLabel) {
        _shopCountLabel = [FactoryUI createLabelWithFrame:CGRectMake(0, 0, ScaleW(20), ScaleW(14)) text:@"X2" textColor:kGrayTitleColor font:systemFont(ScaleW(14))];
        _shopCountLabel.weight = 1;
        _shopCountLabel.textAlignment = NSTextAlignmentRight;
        _shopCountLabel.myTrailing = ScaleW(15);
        _shopCountLabel.mySize = CGSizeMake(ScaleW(20), ScaleW(14));
        _shopCountLabel.myCenterY = self.shopPriceLabel.centerY;
    }
    return _shopCountLabel;
}

- (UILabel *)shopPriceLabel {
    if (!_shopPriceLabel) {
        _shopPriceLabel = [FactoryUI createLabelWithFrame:CGRectMake(0, 0, ScaleW(150), ScaleW(14)) text:@"10购物券+10余额" textColor:kTheMeColor font:systemFont(ScaleW(16))];
        _shopPriceLabel.myTop = ScaleW(25);
        
    }
    return _shopPriceLabel;
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
//        UITapGestureRecognizer* singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addressEvent)];
//        [_addressView addGestureRecognizer:singleTap];
        //        _addressView.mySize = CGSizeMake(ScreenWidth - ScaleW(30), 0)
    }
    return _addressView;
}

- (UILabel *)normalAddressLabel {
    if (!_normalAddressLabel) {
        _normalAddressLabel = [FactoryUI createLabelWithFrame:CGRectZero text:@"河南省郑州市中原区航海西路工人路帝湖花园-西王府4号楼2单元2号楼12C" textColor:kMainTextColor font:systemFont(ScaleW(12))];
        _normalAddressLabel.mySize = CGSizeMake(ScaleW(314), ScaleW(40));
        
        _normalAddressLabel.numberOfLines = 2;
    }
    return _normalAddressLabel;
}

- (GoCoin_Login_NavView *)navView
{
    if (_navView == nil) {
        
        _navView = [[GoCoin_Login_NavView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, Height_NavBar)];
        
        _navView.rightBtn.hidden = YES;
        _navView.titleLabel.text = SSKJLocalized(@"订单详情", nil);
        //        _navView.backBtn.hidden = YES;
        WS(weakSelf);
        
        _navView.BackBtnBlock = ^{
            [weakSelf.navigationController popViewControllerAnimated:YES];
        };
        
        [self.view addSubview:_navView];
    }
    return _navView;
}
@end
