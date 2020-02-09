//
//  FBDeal_Segment_Control.m
//  ZYW_MIT
//
//  Created by 刘小雨 on 2018/9/11.
//  Copyright © 2018年 Wang. All rights reserved.
//

#import "FBDeal_Segment_Control.h"

@interface FBDeal_Segment_Control()
@property (nonatomic, strong) NSMutableArray *buttonArray;
@property (nonatomic, strong) NSArray *titlesArray;
@property (nonatomic, assign) CGFloat fontSize;
@property (nonatomic, strong) UIColor *normalColor;
@property (nonatomic, strong) UIColor *selectedColor;

@end

@implementation FBDeal_Segment_Control

-(instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles normalColor:(UIColor *)normalColor selectedColor:(UIColor *)selectedColor fontSize:(CGFloat)fontSize
{
    if (self = [super initWithFrame:frame]) {
        _titlesArray = titles;
        _fontSize = fontSize;
        _normalColor = normalColor;
        _selectedColor = selectedColor;
        [self addButtons];
        [self addSubview:self.lineView];
    }
    return self;
}

-(NSMutableArray *)buttonArray
{
    if (nil == _buttonArray) {
        _buttonArray = [NSMutableArray arrayWithCapacity:10];
    }
    return _buttonArray;
}


-(void)addButtons
{
    CGFloat width = self.width / self.titlesArray.count;
    for (int i = 0; i < self.titlesArray.count; i++) {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(width * i, 0, width, self.height)];
        [self addSubview:btn];
        btn.titleLabel.font = systemFont(_fontSize);
        [btn setTitle:self.titlesArray[i] forState:UIControlStateNormal];
        [btn setTitleColor:self.normalColor forState:UIControlStateNormal];
        [btn setTitleColor:self.selectedColor forState:UIControlStateSelected];
        btn.tag = 100 + i;
        [self.buttonArray addObject:btn];
        if (i == 0) {
            self.lineView.centerX = btn.centerX;
            btn.selected = YES;
        }
        btn.titleLabel.adjustsFontSizeToFitWidth = YES;
        [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
}

-(UIView *)lineView
{
    if (nil == _lineView) {
        CGFloat width = self.width / self.titlesArray.count * 0.3;

        _lineView = [[UIImageView alloc]initWithFrame:CGRectMake(0, self.height - ScaleW(2), width, ScaleW(2))];
//        _lineView.image = [UIImage imageNamed:@"segment_line"];
        _lineView.backgroundColor = kMainBlueColor;
    }
    return _lineView;
}

-(void)setSelectedIndex:(NSInteger)selectedIndex
{
    _selectedIndex = selectedIndex;
    for (UIButton *btn in self.buttonArray) {
        if (btn.tag == 100 + selectedIndex) {
            btn.selected = YES;
            WS(weakSelf);
            [UIView animateWithDuration:0.3 animations:^{
                weakSelf.lineView.centerX = btn.centerX;
            }];
        }else{
            btn.selected = NO;
        }
    }
}


-(void)btnClicked:(UIButton *)sender
{

    if (sender.selected) {
        return;
    }
    
    NSInteger tag = sender.tag - 100;
    BOOL shouldSelect;
    if (self.selectedIndexBlock) {
        shouldSelect = self.selectedIndexBlock(tag);
    }
    
    if (!shouldSelect) {
        return;
    }
    
    for (UIButton *button in self.buttonArray) {
        if (button == sender) {
            button.selected = YES;
            _selectedIndex = sender.tag - 100;
            WS(weakSelf);
            [UIView animateWithDuration:0.3 animations:^{
                weakSelf.lineView.centerX = sender.centerX;
            }];
        }else{
            button.selected = NO;
        }
    }
    
}



@end
