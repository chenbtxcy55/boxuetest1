//
//  JB_FBC_Publish_TitleView.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/5/17.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "JB_FBC_Publish_TitleView.h"

@interface JB_FBC_Publish_TitleView ()
@property (nonatomic, strong) UIButton *sellButton;
@property (nonatomic, strong) UIButton *buyButton;
@property (nonatomic, strong) UIView *vlineView;
@property (nonatomic, strong) UIView *bottomLineView;
@end

@implementation JB_FBC_Publish_TitleView

-(instancetype)initWithFrame:(CGRect)frame buyTitle:(NSString *)buyTitle sellTitle:(NSString *)sellTitle;
{
    self = [super initWithFrame:frame];
    if (self) {
        self.height = 44;
        [self addSubview:self.sellButton];
        [self addSubview:self.buyButton];
        [self addSubview:self.vlineView];
        [self addSubview:self.bottomLineView];
        self.width = self.buyButton.right;
        
        [self.buyButton setTitle:buyTitle forState:UIControlStateNormal];
        [self.sellButton setTitle:sellTitle forState:UIControlStateNormal];
        
        [self selectBtn:self.sellButton];
    }
    return self;
}

-(UIButton *)sellButton
{
    if (nil == _sellButton) {
        _sellButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, ScaleW(100), self.height)];
        [_sellButton setTitle:SSKJLocalized(@"发布出售", nil) forState:UIControlStateNormal];
        [_sellButton setTitleColor:kTextLightBlueColor forState:UIControlStateSelected];
        [_sellButton setTitleColor: kMainTextColor forState:UIControlStateNormal];
        _sellButton.titleLabel.font = systemFont(ScaleW(15));
        _sellButton.tag = 1001;
        [_sellButton addTarget:self action:@selector(selectBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sellButton;
}


-(UIButton *)buyButton
{
    if (nil == _buyButton) {
        _buyButton = [[UIButton alloc]initWithFrame:CGRectMake(self.sellButton.right, 0, ScaleW(100), self.height)];
        [_buyButton setTitle:SSKJLocalized(@"发布购买", nil) forState:UIControlStateNormal];
        [_buyButton setTitleColor:kTextLightBlueColor forState:UIControlStateSelected];
        [_buyButton setTitleColor: kMainTextColor forState:UIControlStateNormal];
        _buyButton.titleLabel.font = systemFont(ScaleW(15));
        _buyButton.tag = 1002;
        [_buyButton addTarget:self action:@selector(selectBtn:) forControlEvents:UIControlEventTouchUpInside];

    }
    return _buyButton;
}

- (UIView *)vlineView
{
    if (nil == _vlineView) {
        _vlineView = [[UIView alloc]initWithFrame:CGRectMake(self.sellButton.right, 0, 0.5, ScaleW(19))];
        _vlineView.backgroundColor = kTextDarkBlueColor;
        _vlineView.centerY = self.height / 2;
    }
    return _vlineView;
}

-(UIView *)bottomLineView
{
    if (nil == _bottomLineView) {
        _bottomLineView = [[UIView alloc]initWithFrame:CGRectMake(0, self.height - ScaleW(2), ScaleW(30), ScaleW(2))];
        _bottomLineView.backgroundColor = kTextLightBlueColor;
        _bottomLineView.centerX = self.sellButton.centerY;
    }
    return _bottomLineView;
}

-(void)selectBtn:(UIButton *)button
{
    if (button.selected == YES) {
        return;
    }
    self.bottomLineView.centerX = button.centerX;

    if (button == self.sellButton) {
        self.sellButton.selected = YES;
        self.buyButton.selected = NO;
        if (self.changeTypeBlock) {
            self.changeTypeBlock(BuySellTypeSell);
        }
        
    }else {
        self.sellButton.selected = NO;
        self.buyButton.selected = YES;
        if (self.changeTypeBlock) {
            self.changeTypeBlock(BuySellTypeBuy);
        }
    }
    
    
    
}

-(void)setSelectIndex:(NSInteger)index
{
    if (index == 0) {
        self.sellButton.selected = YES;
        self.buyButton.selected = NO;
        self.bottomLineView.centerX = self.sellButton.centerX;
    }else{
        self.sellButton.selected = NO;
        self.buyButton.selected = YES;
        self.bottomLineView.centerX = self.buyButton.centerX;

    }
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
