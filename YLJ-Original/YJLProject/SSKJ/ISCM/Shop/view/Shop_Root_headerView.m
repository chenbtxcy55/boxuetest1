//
//  Shop_Root_headerView.m
//  SSKJ
//
//  Created by 张本超 on 2019/6/6.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "Shop_Root_headerView.h"

@interface Shop_Root_headerView()
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *headerImg;

@end

@implementation Shop_Root_headerView

-(instancetype)init
{
    if (self = [super init])
    {
        self.frame = CGRectMake(0, 0, ScreenWidth, ScaleW(200));
//        [self addSubview:self.headerView];
         [self addSubview:self.headerImg];
        [self addSubview:self.titleLabel];
       
        self.height = self.headerImg.bottom;
        [self addSubview:self.rightBtn];
        [self addSubview:self.lefttBtn];
        
    }
    return self;
}

-(UIView *)headerView
{
    if (!_headerView) {
        _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleW(45) + Height_StatusBar)];
        _headerView.backgroundColor = kMainRedColor;
    }
    return _headerView;
}

-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [WLTools allocLabel:SSKJLocalized(@"我的店铺", nil) font:systemBoldFont(18) textColor:kMainWihteColor frame:CGRectMake(0, Height_StatusBar, ScreenWidth, ScaleW(45)) textAlignment:(NSTextAlignmentCenter)];
        
    }
    return _titleLabel;
}
-(UIImageView *)headerImg
{
    if (!_headerImg) {
        _headerImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleW(130)+Height_StatusBar)];
        _headerImg.image = [UIImage imageNamed:@"shop_header1_icon"];
        
    }
    return _headerImg;
}
-(UIButton *)rightBtn{
    if (!_rightBtn) {
        _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightBtn.frame = CGRectMake(ScreenWidth - ScaleW(80), _titleLabel.top, ScaleW(80), _titleLabel.height);
        [_rightBtn btn:_rightBtn font:ScaleW(15) textColor:kMainWihteColor text:SSKJLocalized(@"编辑商铺", nil) image:nil sel:@selector(rightBtnAction:) taget:self];
    }
    return _rightBtn;
}
-(UIButton *)lefttBtn{
    if (!_lefttBtn) {
        _lefttBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _lefttBtn.frame = CGRectMake(0, _titleLabel.top, ScaleW(70), _titleLabel.height+ScaleW(5));
        [_lefttBtn btn:_lefttBtn font:ScaleW(15) textColor:kMainWihteColor text:nil image:[UIImage imageNamed:KLeftImgName] sel:@selector(leftAction:) taget:self];
    }
    return _lefttBtn;
}
-(void)leftAction:(UIButton *)sender
{
    !self.leftAction?:self.leftAction();
}
-(void)rightBtnAction:(UIButton *)sender
{
    !self.rightAction?:self.rightAction();
}
@end
