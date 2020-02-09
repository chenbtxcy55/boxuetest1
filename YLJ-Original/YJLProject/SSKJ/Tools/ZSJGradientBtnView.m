//
//  ZSJGradientBtnView.m
//  Tiger
//
//  Created by zhao on 2019/8/6.
//  Copyright © 2019 Tiger. All rights reserved.
//

#import "ZSJGradientBtnView.h"

@interface ZSJGradientBtnView ()

@end

@implementation ZSJGradientBtnView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}
- (void)createUI
{
    
    self.clipsToBounds = YES;
    self.layer.cornerRadius = self.height/2;
    CAGradientLayer *gradientLayer =  [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(0, 0, self.width, self.height);
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 0);
    gradientLayer.locations = @[@(0.5),@(1.0)];//渐变点
    [gradientLayer setColors:@[(id)[UIColorFromRGB(0xbdd642) CGColor],(id)[UIColorFromRGB(0x00789a) CGColor]]];//渐变数组
    [self.layer addSublayer:gradientLayer];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickView)];
    [self addGestureRecognizer:tap];
    self.titleLab = [[UILabel alloc] init];
    self.titleLab.font = systemFont(ScaleW(17));
    self.titleLab.textColor = kMainWihteColor;
    [self addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
    }];
}
-(void)clickView
{
    if (self.confirmBlock)
    {
        self.confirmBlock();
    }
}
+(void)showWithTitle:(NSString *)title font:(NSInteger)font titleColor:(UIColor *)color frame:(CGRect)frame Radius:(int)radiu firstColor:(NSString *)firstColor lastColor:(NSString *)lastColor confirmBlock:(void(^)(void))confirmblock{
    ZSJGradientBtnView *btn = [[ZSJGradientBtnView alloc] initWithFrame:frame];
    btn.confirmBlock = confirmblock;
    
    btn.titleLab.font = systemFont(ScaleW(font));
    btn.titleLab.textColor = color;
    btn.titleLab.text = title;
    CAGradientLayer *gradientLayer =  [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(0, 0, btn.width, btn.height);
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 0);
    gradientLayer.locations = @[@(0.5),@(1.0)];//渐变点
    [gradientLayer setColors:@[(id)[[UIColor colorWithHexStringToColor:firstColor] CGColor],(id)[[UIColor colorWithHexStringToColor:lastColor] CGColor]]];//渐变数组
    [btn.layer addSublayer:gradientLayer];

}
@end
