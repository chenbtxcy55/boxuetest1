//
//  YLJ_MyRootHeaderView.m
//  SSKJ
//
//  Created by cy5566 on 2019/11/21.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "YLJ_MyRootHeaderView.h"
#import "MyLayout.h"
#import "SPButton.h"
@interface YLJ_MyRootHeaderView()

@property (nonatomic,strong) UIImageView *bgImgView;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *numberLabel;
@property (nonatomic,strong) SPButton *exchangeBtn;

@property (nonatomic,strong) UIView *midView;
@property (nonatomic,strong) UILabel *serveTitleLabel;
@property (nonatomic,strong) UILabel *supTitleLabel;
@property (nonatomic,strong) UILabel *supLabel;
@property (nonatomic,strong) UILabel *serveLabel;
@property (nonatomic,strong) MyLinearLayout *horzLayout;
@property (nonatomic,strong) MyLinearLayout *contentLayout;

@property (nonatomic,strong) UIView *leftMView;
@property (nonatomic,strong) UIView *midMView;
@property (nonatomic,strong) UIView *rightMView;
@property (nonatomic,strong) UILabel *accountTitleLabel;
@property (nonatomic,strong) UILabel *ticketsTitleLabel;
@property (nonatomic,strong) UILabel *voucherTitleLabel;
@property (nonatomic,strong) UILabel *accountLabel;
@property (nonatomic,strong) UILabel *ticketsLabel;
@property (nonatomic,strong) UILabel *voucherLabel;


@property (nonatomic,strong) UIView *signBackView;

@property (nonatomic, strong) SSKJ_UserInfo_Model *userInfoModel;
@end
@implementation YLJ_MyRootHeaderView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupUI];
    }
    return self;
}
- (void)setupUI {
    MyLinearLayout *contentLayout = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    self.contentLayout = contentLayout;
    //    contentLayout.padding = UIEdgeInsetsMake(ScaleW(0), ScaleW(10), ScaleW(10), ScaleW(10)); //设置布局内的子视图离自己的边距.
    contentLayout.myHorzMargin = 0;                          //同时指定左右边距为0表示宽度和父视图一样宽
    contentLayout.heightSize.lBound(self.heightSize, ScaleW(10), 1);//高度虽然是wrapContentHeight的。但是最小的高度不能低于父视图的高度加10.
    [self addSubview:contentLayout];
    [contentLayout addSubview:self.bgImgView];
    [contentLayout addSubview:self.midView];
    [contentLayout addSubview:self.signBackView];
    
    //测试隐藏后效果
//    self.horzLayout.hidden = YES;
    
}

- (UIImageView *)bgImgView {
    if (!_bgImgView) {
        _bgImgView = [FactoryUI createImageViewWithFrame:CGRectZero imageName:@"wd-bg-img"];
        _bgImgView.userInteractionEnabled = YES;
        _bgImgView.myHeight = ScaleW(170);
        _bgImgView.myHorzMargin = 0;
        [_bgImgView addSubview:self.nameLabel];
        [_bgImgView addSubview:self.numberLabel];
        UIButton *loginBtn = [UIButton new];
        [loginBtn addTarget:self action:@selector(loginEvent) forControlEvents:UIControlEventTouchUpInside];
        loginBtn.frame = CGRectMake(ScaleW(15), self.nameLabel.y, ScaleW(150), ScaleW(44));
        [_bgImgView addSubview:loginBtn];
        [_bgImgView addSubview:self.exchangeBtn];
    }
    return _bgImgView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [FactoryUI createLabelWithFrame:CGRectMake(ScaleW(15), ScaleW(69), ScaleW(150), ScaleW(20)) text:SSKJLocalized(@"您还未登录", nil) textColor:kMainWihteColor font:systemBoldFont(ScaleW(20))];
    }
    return _nameLabel;
}

- (UILabel *)numberLabel {
    if (!_numberLabel) {
        _numberLabel = [FactoryUI createLabelWithFrame:CGRectMake(ScaleW(15), self.nameLabel.bottom + ScaleW(10), ScaleW(150), ScaleW(12)) text:SSKJLocalized(@"欢迎加入油乐嘉", nil) textColor:kMainWihteColor font:systemFont(ScaleW(12))];
    }
    return _numberLabel;
}

- (SPButton *)exchangeBtn {
    if (!_exchangeBtn) {
        _exchangeBtn = [[SPButton alloc] initWithImagePosition:SPButtonImagePositionTop];
        _exchangeBtn.imageTitleSpace = ScaleW(8);
        _exchangeBtn.frame = CGRectMake(ScreenWidth - ScaleW(15) - ScaleW(44), ScaleW(69), ScaleW(44), ScaleW(44));
        [_exchangeBtn setTitle:SSKJLocalized(@"兑换", nil) forState:UIControlStateNormal];
        _exchangeBtn.titleLabel.font = systemFont(ScaleW(12));
        [_exchangeBtn setImage:[UIImage imageNamed:@"wd_icon_dh"] forState:UIControlStateNormal];
        [_exchangeBtn addTarget:self action:@selector(exchangeEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _exchangeBtn;
}

- (UIView *)midView {
    if (!_midView) {
        _midView = [UIView new];
//        _midView.backgroundColor = kMainWihteColor;
        _midView.backgroundColor = RED_HEX_COLOR;
        _midView.mySize = CGSizeMake(ScreenWidth - ScaleW(30), ScaleW(125));
        _midView.wrapContentHeight = YES;
        _midView.myLeading = ScaleW(15);
        _midView.myTop = -ScaleW(42);
        [_midView setCornerRadius:ScaleW(3)];
        _midView.layer.borderWidth = ScaleW(1);
        _midView.layer.borderColor = kLineGrayColor.CGColor;
        
//        MyLinearLayout *cornerLayout = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
//        cornerLayout.mySize = CGSizeMake(ScreenWidth - ScaleW(40), ScaleW(115));
//        cornerLayout.backgroundColor = YELLOW_HEX_COLOR;
//        cornerLayout.myLeading = ScaleW(5);
//        cornerLayout.myTop = ScaleW(5);
//        cornerLayout.wrapContentHeight = YES;
//        [_midView addSubview:cornerLayout];
//
        MyLinearLayout *vertLayout = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];

        vertLayout.myHorzMargin = ScaleW(5);
        vertLayout.backgroundColor = YELLOW_HEX_COLOR;

        [_midView addSubview:vertLayout];

        MyLinearLayout *horzLayout = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
        self.horzLayout = horzLayout;
        [vertLayout addSubview:horzLayout];

        horzLayout.padding = UIEdgeInsetsMake(ScaleW(15), ScaleW(0), ScaleW(0), ScaleW(0));
        horzLayout.myHeight = ScaleW(42);
//        horzLayout.wrapContentWidth = NO;
        [horzLayout addSubview:self.serveTitleLabel];
        [horzLayout addSubview:self.serveLabel];
        [horzLayout addSubview:self.supTitleLabel];
        [horzLayout addSubview:self.supLabel];

        
        
        MyLinearLayout *horzLayout1 = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
        [vertLayout addSubview:horzLayout1];
        horzLayout1.myHeight = ScaleW(82);
//        horzLayout1.wrapContentHeight = YES;
        horzLayout1.myHorzMargin = 0;
//        horzLayout.weight = 1;
        horzLayout1.gravity = MyGravity_Horz_Fill;   //布局视图里面的所有子视图的宽度和布局相等。
        horzLayout1.subviewHSpace = ScaleW(0);   //里面所有子视图之间的水平间距。

//        horzLayout.
        [horzLayout1 addSubview:self.leftMView];
        [horzLayout1 addSubview:self.midMView];
        [horzLayout1 addSubview:self.rightMView];

    }
    return _midView;
}

- (UILabel *)serveTitleLabel {
    if (!_serveTitleLabel) {
        _serveTitleLabel = [FactoryUI createLabelWithFrame:CGRectZero text:SSKJLocalized(@"服务中心", nil) textColor:kMainTextColor font:systemBoldFont(ScaleW(12))];
        _serveTitleLabel.numberOfLines = 1;
        _serveTitleLabel.myLeft = ScaleW(15);
        _serveTitleLabel.myTop = ScaleW(2);
    }
    return _serveTitleLabel;
}

- (UILabel *)serveLabel {
    if (!_serveLabel) {
//        _serveLabel = [FactoryUI createLabelWithFrame:CGRectZero text:@"" textColor:kTheMeColor font:systemBoldFont(ScaleW(14))];
        _serveLabel = [WLTools allocLabel:SSKJLocalized(@"雅诗达庭院", nil) font:systemBoldFont(ScaleW(14)) textColor:kTheMeColor frame:CGRectZero textAlignment:NSTextAlignmentLeft];
        _serveLabel.numberOfLines = 1;
        _serveLabel.myLeft = ScaleW(10);
        _serveLabel.myWidth = ScaleW(70);
        _serveLabel.myHeight = ScaleW(14);
    }
    return _serveLabel;
}

- (UILabel *)supTitleLabel {
    if (!_supTitleLabel) {
        _supTitleLabel = [FactoryUI createLabelWithFrame:CGRectZero text:SSKJLocalized(@"我的上级", nil) textColor:kMainTextColor font:systemBoldFont(ScaleW(12))];
        _supTitleLabel.numberOfLines = 1;
//        _supTitleLabel.weight = 1;
        _supTitleLabel.myLeft = ScaleW(55);
        _supTitleLabel.myTop = ScaleW(2);
    }
    return _supTitleLabel;
}

- (UILabel *)supLabel {
    if (!_supLabel) {
        _supLabel = [WLTools allocLabel:SSKJLocalized(@"雅诗达庭院", nil) font:systemBoldFont(ScaleW(14)) textColor:kTheMeColor frame:CGRectZero textAlignment:NSTextAlignmentLeft];
        _supLabel.numberOfLines = 1;
        _supLabel.myLeft = ScaleW(10);
        _supLabel.myWidth = ScaleW(70);
        _supLabel.myHeight = ScaleW(14);

    }
    return _supLabel;
}

- (UIView *)leftMView {
    if (!_leftMView) {
        _leftMView = [UIView new];
        _leftMView.weight = 1;
        _leftMView.myVertMargin = 0;
        MyLinearLayout *vLayout = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
        vLayout.myHorzMargin = 0;
        
        [_leftMView addSubview:vLayout];
        
        [vLayout addSubview:self.accountTitleLabel];
        [vLayout addSubview:self.accountLabel];

    }
    return _leftMView;
}

- (UIView *)midMView {
    if (!_midMView) {
        _midMView = [UIView new];
        _midMView.weight = 1;
        _midMView.myVertMargin = 0;
        MyLinearLayout *vLayout = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
        vLayout.myHorzMargin = 0;
        [_midMView addSubview:vLayout];
        [vLayout addSubview:self.ticketsTitleLabel];
        [vLayout addSubview:self.ticketsLabel];
    }
    return _midMView;
}

- (UIView *)rightMView {
    if (!_rightMView) {
        _rightMView = [UIView new];
        _rightMView.weight = 1;
        _rightMView.myVertMargin = 0;
        MyLinearLayout *vLayout = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
        vLayout.myHorzMargin = 0;
        [_rightMView addSubview:vLayout];
        [vLayout addSubview:self.voucherTitleLabel];
        [vLayout addSubview:self.voucherLabel];
    }
    return _rightMView;
}

- (UILabel *)accountTitleLabel {
    if (!_accountTitleLabel) {
        _accountTitleLabel = [FactoryUI createLabelWithFrame:CGRectMake(0, ScaleW(18), self.leftMView.width, ScaleW(12)) text:SSKJLocalized(@"账户余额", nil) textColor:kMTextColor font:systemFont(ScaleW(12))];
        _accountTitleLabel.myTop = ScaleW(18);
        _accountTitleLabel.myCenterX = 0;
    }
    return _accountTitleLabel;
}

-(UILabel *)accountLabel {
    if (!_accountLabel) {
        _accountLabel = [FactoryUI createLabelWithFrame:CGRectMake(0, self.accountTitleLabel.bottom + ScaleW(19), self.leftMView.width, ScaleW(16)) text:SSKJLocalized(@"0", nil) textColor:kTheMeColor font:systemBoldFont(ScaleW(16))];
        _accountLabel.myTop = ScaleW(18);
        _accountLabel.myCenterX = 0;
    }
    return _accountLabel;
}

- (UILabel *)ticketsTitleLabel {
    if (!_ticketsTitleLabel) {
        _ticketsTitleLabel = [FactoryUI createLabelWithFrame:CGRectZero text:SSKJLocalized(@"购物券", nil) textColor:kMTextColor font:systemBoldFont(ScaleW(12))];
        _ticketsTitleLabel.myTop = ScaleW(18);
        _ticketsTitleLabel.myCenterX = 0;
    }
    return _ticketsTitleLabel;
}

- (UILabel *)ticketsLabel {
    if (!_ticketsLabel) {
        _ticketsLabel = [FactoryUI createLabelWithFrame:CGRectZero text:SSKJLocalized(@"0", nil) textColor:kTheMeColor font:systemBoldFont(ScaleW(16))];
        _ticketsLabel.myTop = ScaleW(18);
        _ticketsLabel.myCenterX = 0;
    }
    return _ticketsLabel;
}

- (UILabel *)voucherTitleLabel {
    if (!_voucherTitleLabel) {
        _voucherTitleLabel = [FactoryUI createLabelWithFrame:CGRectZero text:SSKJLocalized(@"油乐券", nil) textColor:kMTextColor font:systemBoldFont(ScaleW(12))];
        _voucherTitleLabel.myTop = ScaleW(18);
        _voucherTitleLabel.myCenterX = 0;
    }
    return _voucherTitleLabel;
}

- (UILabel *)voucherLabel {
    if (!_voucherLabel) {
        _voucherLabel = [FactoryUI createLabelWithFrame:CGRectZero text:SSKJLocalized(@"0", nil) textColor:kTheMeColor font:systemBoldFont(ScaleW(16))];
        _voucherLabel.myTop = ScaleW(18);
        _voucherLabel.myCenterX = 0;
    }
    return _voucherLabel;
}

- (UIView *)signBackView {
    if (nil == _signBackView) {
        _signBackView = [UIView new];
        _signBackView.backgroundColor = kMainWihteColor;
        _signBackView.mySize = CGSizeMake(ScreenWidth - ScaleW(30), ScaleW(90));
        _signBackView.myLeading = ScaleW(0);
        _signBackView.myTop = ScaleW(5);
//        _signBackView.frame = CGRectMake(ScaleW(15), self.notifacationView.bottom + ScaleW(10), ScreenWidth - ScaleW(30), ScaleW(90));
        UIImageView *imgView = [FactoryUI createImageViewWithFrame:CGRectMake(ScaleW(15), ScaleW(15), ScaleW(60), ScaleW(60)) imageName:@"homepage_sign"];
        //        imgView.backgroundColor = [UIColor redColor];
        UILabel *titleLabel = [FactoryUI createLabelWithFrame:CGRectMake(imgView.right + ScaleW(20), ScaleW(25), ScaleW(180), ScaleW(16)) text:SSKJLocalized(@"您还有一份惊喜未领取", nil) textColor:kTheMeColor font:systemFont(ScaleW(16))];
        UILabel *subLabel = [FactoryUI createLabelWithFrame:CGRectMake(titleLabel.x, titleLabel.bottom + ScaleW(14), ScaleW(130), ScaleW(14)) text:SSKJLocalized(@"每日签到，惊喜多多", nil) textColor:kGrayTitleColor font:systemFont(ScaleW(14))];
        UIButton *signBtn = [FactoryUI createButtonWithFrame:CGRectMake(titleLabel.right + ScaleW(39), ScaleW(34), ScaleW(60), ScaleW(22)) title:SSKJLocalized(@"立即签到", nil) titleColor:kMainWihteColor imageName:nil backgroundImageName:nil target:self selector:@selector(signEvent) font:systemFont(ScaleW(12))];
        signBtn.backgroundColor = kTheMeColor;
        [signBtn setCornerRadius:ScaleW(11)];
        
        [_signBackView addSubview:imgView];
        [_signBackView addSubview:titleLabel];
        [_signBackView addSubview:subLabel];
        [_signBackView addSubview:signBtn];
        
    }
    return _signBackView;
}


/**
 签到事件
 */
- (void)signEvent {
    if (self.signBlock) {
        self.signBlock();
    }
}

- (void)loginEvent {
    if (self.loginBlock) {
        self.loginBlock();
    }
}

- (void)exchangeEvent {
    if (self.exchangeBlock) {
        self.exchangeBlock();
    }
}

- (void)reloadData {
    self.userInfoModel = [SSKJ_User_Tool sharedUserTool].userInfoModel;
    self.nameLabel.text = self.userInfoModel.account;
    [self.nameLabel sizeToFit];
    self.numberLabel.text = [NSString stringWithFormat:@"手机号:%@",[WLTools simpleHashWithTel:self.userInfoModel.mobile]];
    [self.numberLabel sizeToFit];
    self.horzLayout.hidden = NO;
    self.serveLabel.text = self.userInfoModel.level_account;
    self.supLabel.text = self.userInfoModel.tgaccount;
    self.accountLabel.text = [WLTools noroundingStringWith:self.userInfoModel.money.doubleValue afterPointNumber:2];
    self.ticketsLabel.text = [WLTools noroundingStringWith:self.userInfoModel.shop_blance.doubleValue afterPointNumber:2];
    self.voucherLabel.text = [WLTools noroundingStringWith:self.userInfoModel.coupon.doubleValue afterPointNumber:2];
    [self.accountLabel sizeToFit];
    [self.ticketsLabel sizeToFit];
    [self.voucherLabel sizeToFit];
}



- (void)hiddenHorzLayout {
    self.horzLayout.hidden = YES;
    self.accountLabel.text = @"0";
    self.ticketsLabel.text = @"0";
    self.voucherLabel.text = @"0";
    self.nameLabel.text = @"您还未登录";
    [self.nameLabel sizeToFit];
    self.numberLabel.text = @"欢迎加入油乐嘉";
    [self.signBackView removeFromSuperview];
    [self.contentLayout addSubview:self.signBackView];
}
@end
