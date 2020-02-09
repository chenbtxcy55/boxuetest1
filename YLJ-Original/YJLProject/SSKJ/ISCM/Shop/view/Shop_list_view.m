//
//  Shop_list_view.m
//  SSKJ
//
//  Created by 张本超 on 2019/6/9.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "Shop_list_view.h"
@interface Shop_list_view()
@property (nonatomic, strong) UILabel  *titleLabel;

@property (nonatomic, strong) UIView *bottomView;

@property (nonatomic, strong) UIView *movingLine;


@end

@implementation Shop_list_view

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
    self.frame = CGRectMake(0, 0 , ScreenWidth, ScaleW(90));
    [self addSubview:self.titleLabel];
    [self addSubview:self.bottomView];
}
-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [WLTools allocLabel:SSKJLocalized(@"商品列表", nil) font:systemBoldFont(ScaleW(15)) textColor:kMainTextColor frame:CGRectMake(ScaleW(20), ScaleW(20), ScreenWidth - ScaleW(40), ScaleW(15)) textAlignment:(NSTextAlignmentLeft)];
        
    }
    return _titleLabel;
}
-(UIView *)bottomView
{
    if (!_bottomView) {
        _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, ScaleW(10) + _titleLabel.bottom, ScreenWidth, ScaleW(45))];
        _bottomView.backgroundColor = kBgColor353750;
        [_bottomView addSubview:self.detailBtn];
        [_bottomView addSubview:self.scoreBtn];
        [_bottomView addSubview:self.movingLine];
    }
    return _bottomView;
}

-(UIButton *)detailBtn
{
    if (!_detailBtn) {
        _detailBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _detailBtn.frame = CGRectMake(0, 0, ScreenWidth/2.f, ScaleW(43));
        [_detailBtn btn:_detailBtn font:ScaleW(15) textColor:kMainTextColor text:SSKJLocalized(@"已上架", nil) image:nil sel:@selector(detailBtnAction:) taget:self];
        [_detailBtn setTitleColor:UIColorFromRGB(0x5ba56f) forState:(UIControlStateSelected)];
        _detailBtn.selected = YES;
    }
    return _detailBtn;
}
-(UIButton *)scoreBtn
{
    if (!_scoreBtn) {
        _scoreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _scoreBtn.frame = CGRectMake(ScreenWidth/2.f, 0, ScreenWidth/2.f, ScaleW(43));
        [_scoreBtn btn:_scoreBtn font:ScaleW(15) textColor:kMainTextColor text:SSKJLocalized(@"已下架", nil) image:nil sel:@selector(detailBtnAction:) taget:self];
        [_scoreBtn setTitleColor:UIColorFromRGB(0x5ba56f) forState:(UIControlStateSelected)];
        _scoreBtn.selected = NO;
    }
    return _scoreBtn;
}
-(UIView *)movingLine
{
    if (!_movingLine) {
        _movingLine = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(15), _detailBtn.bottom, ScaleW(40), ScaleW(2))];
        _movingLine.centerX = _detailBtn.centerX;
        _movingLine.backgroundColor = UIColorFromRGB(0x5ba56f);
        
    }
    return _movingLine;
}


-(void)detailBtnAction:(UIButton *)sender
{
    if (sender == _detailBtn) {
        self.selectIndex = 0;
        
    }else
    {
        self.selectIndex = 1;
    }
    !self.selectBlock?:self.selectBlock(_selectIndex);
}
-(void)setSelectIndex:(NSInteger)selectIndex
{
    _selectIndex = selectIndex;
    
    if (_selectIndex == 0) {
        _movingLine.centerX = _detailBtn.centerX;
        _detailBtn.selected = YES;
        _scoreBtn.selected = NO;
    }else
    {
        _movingLine.centerX = _scoreBtn.centerX;
        _scoreBtn.selected = YES;
        _detailBtn.selected = NO;
    }
}
@end
