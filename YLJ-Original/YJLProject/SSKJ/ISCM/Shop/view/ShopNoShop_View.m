//
//  ShopNoShop_View.m
//  SSKJ
//
//  Created by 张本超 on 2019/6/6.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "ShopNoShop_View.h"
@interface ShopNoShop_View()
@property (nonatomic, strong) UIImageView *mainImgView;
@property (nonatomic, strong) UILabel *messageLabel;
@property (nonatomic, strong) UIButton *toBeShopBtn;
@end

@implementation ShopNoShop_View

-(instancetype)init
{
    if (self = [super init])
    {
        [self viewConfig];
    }
    return self;
}
-(void)viewConfig
{
    self.frame = CGRectMake(0, 0, ScreenWidth, ScaleW(488));
    [self addSubview:self.mainImgView];
    [self addSubview:self.messageLabel];
    [self addSubview:self.toBeShopBtn];
}

-(UIImageView *)mainImgView
{
    if (!_mainImgView) {
        _mainImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"shopCode"]];
        _mainImgView.frame = CGRectMake(ScaleW(138), ScaleW(105), ScaleW(100), ScaleW(92));
        
    }
    return _mainImgView;
}
-(UILabel *)messageLabel{
    if (!_messageLabel) {
        _messageLabel = [WLTools allocLabel:SSKJLocalized(@"您还不是商家，快去申请成为商家哦~", nil) font:systemFont(ScaleW(12)) textColor:kSubSubTxtColor frame:CGRectMake(0, ScaleW(20) + _mainImgView.bottom, ScreenWidth, ScaleW(13)) textAlignment:(NSTextAlignmentCenter)];
    }
    return _messageLabel;
}
-(UIButton *)toBeShopBtn
{
    if (!_toBeShopBtn) {
        _toBeShopBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _toBeShopBtn.frame = CGRectMake(ScaleW(113), ScaleW(21) + _messageLabel.bottom, ScaleW(150), ScaleW(40));
        [_toBeShopBtn btn:_toBeShopBtn font:ScaleW(16) textColor:kMainWihteColor text:SSKJLocalized(@"去成为商家", nil) image:nil sel:@selector(toBeShopBtnAction:) taget:self];
        [_toBeShopBtn setCornerRadius:ScaleW(20)];
        
//        [_toBeShopBtn setBackgroundImage:[UIImage imageNamed:@"login_Btn_bg"] forState:UIControlStateNormal];
//        [_toBeShopBtn setBackgroundImage:[UIImage imageNamed:@"login_Btn_bg"] forState:UIControlStateHighlighted];
        _toBeShopBtn.backgroundColor = kTheMeColor;
    }
    return _toBeShopBtn;
}
-(void)toBeShopBtnAction:(UIButton *)sender
{
    !self.tobeShopBlock?:self.tobeShopBlock();
}
-(void)setIsShowBt:(BOOL)isShowBt{
    
  
    _toBeShopBtn.hidden=!isShowBt;
}
-(void)setMsg:(NSString *)msg{
    
    _messageLabel.text=msg;
    
}
@end
