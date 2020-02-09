//
//  Shop_Root_BarView.m
//  SSKJ
//
//  Created by 张本超 on 2019/6/6.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "Shop_Root_BarView.h"
@interface Shop_Root_BarView()
@property (nonatomic, strong) UIButton *senderBtn;
@property (nonatomic, strong) UIButton *orderBtn;

@end

@implementation Shop_Root_BarView

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
    self.frame = CGRectMake(ScaleW(15), 0, ScreenWidth - ScaleW(30), ScaleW(90));
    self.backgroundColor = UIColorFromRGB(0x484b67);
    
    [self addSubview:self.senderBtn];
    
    [self addSubview:self.orderBtn];
    
    
    [self setCornerRadius:ScaleW(10)];
    
}
-(UIButton *)senderBtn
{
    if (!_senderBtn) {
        _senderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _senderBtn.frame = CGRectMake(0, 0, self.width/2.f, self.height);
        [_senderBtn btn:_senderBtn font:0 textColor:[UIColor whiteColor] text:@"" image:nil sel:@selector(senderAction:) taget:self];
        UIImageView *senderImg = [[UIImageView alloc]initWithFrame:CGRectMake(ScaleW(71), ScaleW(19), ScaleW(30), ScaleW(30))];
        senderImg.image = [UIImage imageNamed:@"publishGoods"];
        UILabel *label = [WLTools allocLabel:SSKJLocalized(@"发布商品", nil) font:systemFont(ScaleW(13)) textColor:kMainTextColor frame:CGRectMake(ScaleW(61), ScaleW(10) + senderImg.bottom, ScaleW(60), ScaleW(13)) textAlignment:(NSTextAlignmentLeft)];
        [_senderBtn addSubview:senderImg];
        [_senderBtn addSubview:label];
        
    }
    return _senderBtn;
}
-(UIButton *)orderBtn
{
    if (!_orderBtn) {
        _orderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _orderBtn.frame = CGRectMake(self.width/2.f, 0, self.width/2.f, self.height);
        [_orderBtn btn:_orderBtn font:0 textColor:[UIColor whiteColor] text:@"" image:nil sel:@selector(orderBtnAction:) taget:self];
        UIImageView *senderImg = [[UIImageView alloc]initWithFrame:CGRectMake(ScaleW(71), ScaleW(19), ScaleW(26), ScaleW(28))];
        senderImg.image = [UIImage imageNamed:@"shopOrderIcon"];
        UILabel *label = [WLTools allocLabel:SSKJLocalized(@"订单管理", nil) font:systemFont(ScaleW(13)) textColor:kMainTextColor frame:CGRectMake(ScaleW(61), ScaleW(10) + senderImg.bottom, ScaleW(60), ScaleW(13)) textAlignment:(NSTextAlignmentLeft)];
        [_orderBtn addSubview:senderImg];
        [_orderBtn addSubview:label];
        
    }
    return _orderBtn;
}
-(void)senderAction:(UIButton *)sender
{
    !self.pulishBlock?:self.pulishBlock();
}
-(void)orderBtnAction:(UIButton *)sender
{
    !self.orderMangedBlock?:self.orderMangedBlock();
}


@end
