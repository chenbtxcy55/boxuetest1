//
//  JB_BBTrade_SliderHeaderView.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/5/14.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "JB_BBTrade_SliderHeaderView.h"
#import "FBDeal_Segment_Control.h"
@interface JB_BBTrade_SliderHeaderView ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *sliderButton;
@property (nonatomic, strong) FBDeal_Segment_Control *segmentControl;
@end

@implementation JB_BBTrade_SliderHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.titleLabel];
        [self addSubview:self.sliderButton];
        [self addSubview:self.segmentControl];
        
        self.height = self.segmentControl.bottom;
       
    }
    return self;
}

-(UILabel *)titleLabel
{
    if (nil == _titleLabel) {
        _titleLabel = [WLTools allocLabel:SSKJLocalized(@"行情", nil) font:systemFont(ScaleW(20)) textColor:kMainWihteColor frame:CGRectMake(ScaleW(15), Height_StatusBar, ScaleW(100), Height_NavBar) textAlignment:NSTextAlignmentLeft];
    }
    return _titleLabel;
}


-(UIButton *)sliderButton
{
    if (nil == _sliderButton) {
        _sliderButton = [[UIButton alloc]initWithFrame:CGRectMake(self.width - ScaleW(15) - ScaleW(30), Height_StatusBar, ScaleW(40), ScaleW(40))];
        _sliderButton.centerY = self.titleLabel.centerY;
        [_sliderButton setImage:[UIImage imageNamed:@"position_slider_left"] forState:UIControlStateNormal];
        [_sliderButton addTarget:self action:@selector(sliderDismiss) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sliderButton;
}

-(FBDeal_Segment_Control *)segmentControl
{
    if (nil == _segmentControl) {
        _segmentControl = [[FBDeal_Segment_Control alloc]initWithFrame:CGRectMake(0, self.titleLabel.bottom, self.width, ScaleW(40)) titles:@[@"AB",@"BTC",@"ETH"] normalColor:kMainWihteColor selectedColor:kTextLightBlueColor fontSize:ScaleW(13)];
        WS(weakSelf);
        _segmentControl.selectedIndexBlock = ^BOOL(NSInteger index) {
            if (weakSelf.selectblock) {
                weakSelf.selectblock(index);
            }
            return YES;
        };
    }
    return _segmentControl;
}



-(void)sliderDismiss
{
    if (self.dismissBlock) {
        self.dismissBlock();
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
