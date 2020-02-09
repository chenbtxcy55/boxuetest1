//
//  YLJOrderSubView.m
//  SSKJ
//
//  Created by cy5566 on 2019/11/20.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "YLJOrderSubView.h"

@implementation YLJOrderSubView
- (instancetype)init {
    self = [super init];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    MyLinearLayout *hLayout = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    self.hLayout = hLayout;
    hLayout.userInteractionEnabled = YES;
    //    hLayout.myHeight = ScaleW(90);
    hLayout.myHorzMargin = ScaleW(0);
    hLayout.wrapContentHeight = YES;
    [self addSubview:hLayout];
    
    [hLayout addSubview:self.leftLabel];
    [hLayout addSubview:self.rightLabel];
    [hLayout addSubview:self.copyBtn];
}

- (UILabel *)leftLabel {
    if (!_leftLabel) {
        _leftLabel = [FactoryUI createLabelWithFrame:CGRectZero text:SSKJLocalized(@"下单时间", nil) textColor:kGrayTitleColor font:systemFont(14)];
        //    leftLabel.textAlignment = NSTextAlignmentCenter;
        _leftLabel.mySize = CGSizeMake(ScaleW(70), ScaleW(13));
        _leftLabel.myLeading = ScaleW(15);
        _leftLabel.myCenterY = 0;
    }
    return _leftLabel;
}

- (UILabel *)rightLabel {
    if (!_rightLabel) {
        _rightLabel = [FactoryUI createLabelWithFrame:CGRectZero text:SSKJLocalized(@"2019-11-12 19:20:10", nil) textColor:kMainTextColor font:systemFont(14)];
        _rightLabel.textAlignment = NSTextAlignmentRight;
        _rightLabel.mySize = CGSizeMake(ScaleW(200), ScaleW(13));
        _rightLabel.myTrailing = ScaleW(15);
        _rightLabel.myCenterY = 0;
        _rightLabel.weight = 1;
    }
    return _rightLabel;
}

- (UIButton *)copyBtn {
    if (!_copyBtn) {
        _copyBtn = [FactoryUI createButtonWithFrame:CGRectZero title:nil titleColor:nil imageName:@"sc_icon_fz" backgroundImageName:nil target:self selector:@selector(copyEvent:) font:nil];
        _copyBtn.mySize = CGSizeMake(ScaleW(22), ScaleW(22));
        _copyBtn.myTrailing = ScaleW(15);
        _copyBtn.myCenterY = 0; //垂直居中，如果不等于0则会产生居中偏移
//        _copyBtn.hidden = YES;
    }
    return _copyBtn;
}

- (void)copyEvent:(UIButton *)sender {
    if (self.copyBlock) {
        self.copyBlock();
    }
}

@end
