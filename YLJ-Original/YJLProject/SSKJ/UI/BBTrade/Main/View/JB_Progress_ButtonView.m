//
//  JB_Progress_ButtonView.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/5/27.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "JB_Progress_ButtonView.h"

@interface JB_Progress_ButtonView ()
@property (nonatomic, strong) UIView *centerView;
@property (nonatomic, strong) UIColor *btnColor;
@end

@implementation JB_Progress_ButtonView

-(instancetype)initWithFrame:(CGRect)frame btnColor:(UIColor *)btnColor;
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kSubBackgroundColor;
        self.btnColor = btnColor;
        [self addSubview:self.centerView];
    }
    return self;
}

-(UIView *)centerView
{
    if (nil == _centerView) {
        _centerView = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(2), 0, ScaleW(4), self.height)];
        _centerView.backgroundColor = GREEN_HEX_COLOR;
    }
    return _centerView;
}

-(void)setSelected:(BOOL)selected
{
    if (selected) {
        self.centerView.backgroundColor = self.btnColor;
    }else{
        self.centerView.backgroundColor = kTextLightBlueColor;
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
