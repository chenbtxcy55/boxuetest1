//
//  SliderTableHeader.m
//  SSKJ
//
//  Created by 张本超 on 2019/5/14.
//  Copyright © 2019 刘小雨. All rights reserved.
//
#define kBtnTag(a)  100000 + a
#import "FBCHeaderView.h"
@interface FBCHeaderView()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UIView *septorLine;
@property (nonatomic, strong) UIView *movingLine;
@property (nonatomic, strong) NSMutableArray *btnArray;


@end

@implementation FBCHeaderView

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
    self.backgroundColor = kMianBgColor;
    
    self.frame = CGRectMake(0, 0, ScreenWidth, ScaleW(50));
    
    self.dataArray = @[@"购买大厅",@"出售大厅",@"记录"].mutableCopy;
    
    [self addSubview:self.septorLine];
    
    [self addSubview:self.movingLine];
    
    self.height = self.septorLine.bottom;
}


-(void)setDataArray:(NSMutableArray *)dataArray
{
    
    _dataArray = dataArray;
    for (UIButton *btn in self.btnArray) {
        [btn removeFromSuperview];
    }
    for (int i = 0; i < _dataArray.count; i ++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn btn:btn font:ScaleW(14) textColor:kMainWihteColor text:_dataArray[i] image:nil sel:@selector(btnAction:) taget:self];
        [btn setTitleColor:kText878ff5 forState:UIControlStateSelected];
        btn.width = ScreenWidth/3.f;
        btn.height = ScaleW(40);
        btn.top = ScaleW(10);
        btn.tag = kBtnTag(i);
        if (i == 0) {
            btn.left = 0;
            btn.selected = YES;
        }
        if (i == 1) {
            btn.centerX = ScreenWidth/2.f;
        }
        if (i == 2) {
            btn.right = ScreenWidth;
        }
        [self addSubview:btn];
        [self.btnArray addObject:btn];
    }
}
-(UIView *)septorLine
{
    if (!_septorLine) {
        _septorLine = [[UIView alloc]initWithFrame:CGRectMake(0, ScaleW(57) + _titleLabel.bottom , ScaleW(255), 1)];
        _septorLine.backgroundColor = kTextColor313359;
        _septorLine.hidden = YES;
    }
    return _septorLine;
}
-(UIView *)movingLine
{
    if (!_movingLine) {
        _movingLine  = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(13), 0, ScaleW(70), 2)];
        _movingLine.backgroundColor = kText878ff5;
        _movingLine.bottom = _septorLine.bottom;
        _movingLine.centerX = ScreenWidth/6.f;
        
    }
    return _movingLine;
}

-(void)btnAction:(UIButton *)sender
{
    self.currentIndex = sender.tag - kBtnTag(0);
    !self.btnItemIndex?:self.btnItemIndex(self.currentIndex);
}
-(NSMutableArray *)btnArray{
    if (!_btnArray) {
        _btnArray = [NSMutableArray array];
        
    }
    return _btnArray;
}
-(void)setCurrentIndex:(NSInteger)currentIndex
{
    _currentIndex = currentIndex;
    for (UIButton *btn in self.btnArray) {
        btn.selected = NO;
    }
    UIButton *btn = [self viewWithTag: kBtnTag(_currentIndex)];
    btn.selected = YES;
    _movingLine.centerX = btn.centerX;
    
    
}
@end
