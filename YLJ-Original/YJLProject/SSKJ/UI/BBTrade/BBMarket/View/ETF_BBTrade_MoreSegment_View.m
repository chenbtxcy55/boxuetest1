
//
//  ETF_BBTrade_MoreSegment_View.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/5/28.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "ETF_BBTrade_MoreSegment_View.h"

@interface ETF_BBTrade_MoreSegment_View ()
@property (nonatomic, strong) NSArray *titlesArray;
@property (nonatomic, strong) UIView *backView;

@end

@implementation ETF_BBTrade_MoreSegment_View

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.titlesArray = @[
                             [NSString stringWithFormat:@"5%@",SSKJLocalized(@"M", nil)],
                             [NSString stringWithFormat:@"30%@",SSKJLocalized(@"M", nil)],
                             [NSString stringWithFormat:@"%@",SSKJLocalized(@"周线", nil)],
                             [NSString stringWithFormat:@"%@",SSKJLocalized(@"月线", nil)]
                             ];
        [self addSubview:self.backView];
        [self addButons];
    }
    return self;
}

-(UIView *)backView
{
    if (nil == _backView) {
        _backView = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(5), 0, self.width - ScaleW(10), ScaleW(40))];
        _backView.backgroundColor = kBgColor353750;
        _backView.layer.masksToBounds = YES;
        _backView.layer.borderColor = kTextLightBlueColor.CGColor;
        _backView.layer.borderWidth = 0.5;
    }
    return _backView;
}

-(void)addButons
{
    CGFloat width = ScaleW(60);
    
    
    for (int i = 0; i < self.titlesArray.count; i++) {
        NSString *title = self.titlesArray[i];
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(width * i, 0, width, self.height)];
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:kTextLightBlueColor forState:UIControlStateNormal];
        [button setTitleColor:kTitleColor forState:UIControlStateSelected];
        button.titleLabel.font = systemFont(ScaleW(13));
        button.tag = 100 + i;
        [button addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
    }
    
}

-(void)btnClicked:(UIButton *)sender
{
    NSInteger index = sender.tag - 100;
    self.selectedIndex = index;
    NSString *title = [sender titleForState:UIControlStateNormal];
    if (self.selectBlock) {
        self.selectBlock(index,title);
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
