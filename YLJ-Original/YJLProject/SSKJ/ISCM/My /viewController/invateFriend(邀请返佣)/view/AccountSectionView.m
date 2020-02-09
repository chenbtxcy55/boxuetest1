//
//  AccountSectionView.m
//  SSKJ
//
//  Created by 张本超 on 2019/4/18.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "AccountSectionView.h"
@interface AccountSectionView()
@property (nonatomic, strong) UIView *septorLine;
@property (nonatomic, strong) UIView *movingLine;
@property (nonatomic, strong) UILabel *userNameLabel;
@property (nonatomic, strong) UILabel *timeNameLable;
@property (nonatomic, strong) NSMutableArray *btnArray;

@end
@implementation AccountSectionView

-(instancetype)init
{
    if (self = [super init]) {
        [self viewConfig];
    }
    return self;
}

-(void)viewConfig
{
    self.frame = CGRectMake(0, 0, ScreenWidth, ScaleW(52));
    self.backgroundColor = kMainWihteColor;
    [self addSubview:self.septorLine];
    NSArray *array = @[@"一级",@"二级",@"三级"];
    self.btnArray = [NSMutableArray array];
    for (int i = 0; i < array.count; i ++) {
        UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        btn.frame = CGRectMake(i * (ScreenWidth/array.count), _septorLine.bottom, (ScreenWidth/array.count), ScaleW(50));
        [btn btn:btn font:ScaleW(14) textColor:kMainTextColor text:array[i] image:nil sel:@selector(btnAction:) taget:self];
        [btn setTitleColor:kMainTextColor forState:(UIControlStateSelected)];
        btn.tag = 10000000 + i;
        [self addSubview:btn];
        if (i == 0) {
            btn.selected = YES;
            _oneLabel = btn;
        }
        if (i == 1) {
         
            _twoLabel = btn;
        }
        
        if (i == 2) {
            _threeLabel = btn;
        }
        [self.btnArray addObject:btn];
        
    }
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, _septorLine.bottom + ScaleW(50), ScreenWidth, 1)];
    line.backgroundColor = kMainLineColor;
    [self addSubview:line];
    line.tag = 10000002;
    
    _movingLine = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(37), line.top, ScaleW(40), 2)];
    _movingLine.backgroundColor = kMainBlueColor;
    [self addSubview:_movingLine];
    self.height = _movingLine.bottom;

}
-(UIView *)septorLine
{
    if (!_septorLine) {
        _septorLine = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleW(10))];
        _septorLine.backgroundColor = kMainLineColor;
        
    }
    return _septorLine;
}


-(void)btnAction:(UIButton *)sender
{
    NSInteger index = sender.tag - 10000000;
    _movingLine.centerX = sender.centerX;
    for (UIButton *btn in self.btnArray) {
        btn.selected = NO;
    }
    sender.selected = YES;
    
    !self.btnClickedBlock?:self.btnClickedBlock(index + 1);
}

@end
