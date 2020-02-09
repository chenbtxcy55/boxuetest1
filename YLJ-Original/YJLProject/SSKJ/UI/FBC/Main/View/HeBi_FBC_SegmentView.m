//
//  HeBi_FBC_SegmentView.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/4/12.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "HeBi_FBC_SegmentView.h"

@interface HeBi_FBC_SegmentView ()
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSMutableArray *buttonArray;
@end

@implementation HeBi_FBC_SegmentView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addButtons];
//        [self addSubview:self.lineView];
        
        self.selectedIndex = 0;
    }
    return self;
}

-(NSArray *)titles
{
    if (nil == _titles) {
        _titles = @[SSKJLocalized(@"购买数量", nil)];
    }
    return _titles;
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
    CGFloat width = ScaleW(58);
    CGFloat startX = 0;
    for (int i = 0; i < self.titles.count; i++) {
        NSString *title = self.titles[i];
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(startX, 0, width, self.height)];
        button.centerY = self.height / 2;
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor: kMainBlueColor forState:UIControlStateNormal];
//        [button setTitleColor:UIColorFromRGB(0x5034db) forState:UIControlStateSelected];
        button.titleLabel.font = systemBoldFont(ScaleW(14));

        button.tag = 100 + i;
        
        [self addSubview:button];
        
        [self.buttonArray addObject:button];
        
        startX += width + ScaleW(23);
        
//        [button addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
}

-(UIView *)lineView
{
    if (nil == _lineView) {
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(0, self.height - 1, ScaleW(58), 1)];
        _lineView.backgroundColor = UIColorFromRGB(0x5034db);
    }
    return _lineView;
}

-(void)setSelectedIndex:(NSInteger)selectedIndex
{
    _selectedIndex = selectedIndex;
    
//    for (UIButton *button in self.buttonArray) {
//        if (button.tag - 100 == selectedIndex) {
//            button.selected = YES;
//            self.lineView.centerX = button.centerX;
//        }else{
//            button.selected = NO;
//        }
//    }
}


-(void)btnClicked:(UIButton *)button
{
    if (button.selected) {
        return;
    }
    
    for (UIButton *btn in self.buttonArray) {
        if (btn == button) {
            btn.selected = YES;
            self.lineView.centerX = btn.centerX;
            _selectedIndex = btn.tag - 100;
            
            if (self.segmentBlock) {
                self.segmentBlock(_selectedIndex);
            }
        }else{
            btn.selected = NO;
        }
    }
}

-(void)changeAmountBtnTitle:(NSString *)title
{
    for (UIButton *btn in self.buttonArray) {
//        if (btn.tag - 100 == 1) {
            [btn setTitle:title forState:UIControlStateNormal];
//            return;
//        }
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
