//
//  ShopDetailBoomView.m
//  SSKJ
//
//  Created by 张本超 on 2019/6/13.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "ShopDetailBoomView.h"

@interface ShopDetailBoomView()
@property (nonatomic, strong) UIButton *shopBtn;
@property (nonatomic, strong) UIButton *serverBtn;
@property (nonatomic, strong) UIButton *inmitiyBtn;

@end

@implementation ShopDetailBoomView
-(instancetype)init
{
    if (self = [super init]) {
//        self.backgroundColor = kBgColor353750;
        self.frame = CGRectMake(0, 0, ScreenWidth, ScaleW(44));
        [self viewConfig];
    }
    return self;
}

-(void)viewConfig
{
//    [self addSubview:self.shopBtn];
    [self addSubview:self.serverBtn];
    [self addSubview:self.inmitiyBtn];
}

//-(UIButton *)shopBtn
//{
//    if (!_shopBtn) {
//        _shopBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        _shopBtn.frame =CGRectMake(0, 0, ScaleW(90), ScaleW(49));
//        [_shopBtn addTarget:self action:@selector(shopBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
//        UIImageView *imag = [[UIImageView alloc]initWithFrame:CGRectMake(ScaleW(34), ScaleW(5), ScaleW(18), ScaleW(17))];
//        imag.image = [UIImage imageNamed:@"shop_dian_icon"];
//
//        UILabel *shopLabel = [WLTools allocLabel:SSKJLocalized(@"店铺", nil) font:systemFont(ScaleW(11)) textColor:kMainTextColor frame:CGRectMake(-4, ScaleW(4) + imag.bottom , _shopBtn.width+8, ScaleW(12)) textAlignment:(NSTextAlignmentCenter)];
//        shopLabel.centerX=imag.centerX;
//
//        [_shopBtn addSubview:imag];
//        [_shopBtn addSubview:shopLabel];
//    }
//    return _shopBtn;
//}
//-(UIButton *)serverBtn
//{
//    if (!_serverBtn) {
//        _serverBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        _serverBtn.frame =CGRectMake(_shopBtn.right, 0, ScaleW(90), ScaleW(49));
//        [_serverBtn addTarget:self action:@selector(serverBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
//        UIImageView *imag = [[UIImageView alloc]initWithFrame:CGRectMake(ScaleW(34), ScaleW(5), ScaleW(18), ScaleW(17))];
//        imag.image = [UIImage imageNamed:@"shop_serve_icon"];
//
//        UILabel *shopLabel = [WLTools allocLabel:SSKJLocalized(@"客服", nil) font:systemFont(ScaleW(11)) textColor:kMainTextColor frame:CGRectMake(-4, ScaleW(4) + imag.bottom , _shopBtn.width+8, ScaleW(12)) textAlignment:(NSTextAlignmentCenter)];
//        [_serverBtn addSubview:imag];
//        [_serverBtn addSubview:shopLabel];
//        shopLabel.centerX=imag.centerX;
//
//        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, ScaleW(12), ScaleW(1), ScaleW(27))];
//        lineView.backgroundColor = kMainWihteColor;
//        [_serverBtn addSubview:lineView];
//    }
//    return _serverBtn;
//}

- (UIButton *)serverBtn {
    if (!_serverBtn) {
        _serverBtn = [FactoryUI createButtonWithFrame:CGRectMake(0, 0, ScaleW(140), ScaleW(44)) title:SSKJLocalized(@"联系客服", nil) titleColor:kMainWihteColor imageName:nil backgroundImageName:nil target:self selector:@selector(serverBtnAction:) font:systemFont(ScaleW(16))];
        _serverBtn.backgroundColor = RGBCOLOR(0, 181, 112);
    }
    return _serverBtn;
}

-(UIButton *)inmitiyBtn
{
    if (!_inmitiyBtn) {
        _inmitiyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _inmitiyBtn.frame = CGRectMake(_serverBtn.right, 0, ScreenWidth - _serverBtn.right, ScaleW(44));
        [_inmitiyBtn btn:_inmitiyBtn font:ScaleW(16) textColor:kMainWihteColor text:SSKJLocalized(@"立即购买", nil) image:nil sel:@selector(commitAction:) taget:self];
        _inmitiyBtn.titleLabel.font = [UIFont boldSystemFontOfSize:ScaleW(16)];
//        _inmitiyBtn.backgroundColor = kMainRedColor;
//        [_inmitiyBtn setBackgroundImage:[UIImage imageNamed:@"login_Btn_bg"] forState:UIControlStateNormal];
        _inmitiyBtn.backgroundColor = kTheMeColor;
    }
    return _inmitiyBtn;
}
//-(void)shopBtnAction:(UIButton *)sender
//{
//    !self.shopBlock?:self.shopBlock();
//}
-(void)serverBtnAction:(UIButton *)sender
{
    !self.serverBlock?:self.serverBlock();
}
-(void)commitAction:(UIButton *)sender
{
    !self.commitBlock?:self.commitBlock();
}
@end
