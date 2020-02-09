//
//  JB_PledgeRecordItemView.m
//  SSKJ
//
//  Created by James on 2019/5/16.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "JB_PledgeRecordItemView.h"

@interface JB_PledgeRecordItemView()
@property (nonatomic, strong) UIView *bgView;

@end

@implementation JB_PledgeRecordItemView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.bgView];
        [self.bgView addSubview:self.titleLB];
        [self.bgView addSubview:self.subTitleLB];
        [self setupMasnory];
    }
    return self;
}

#pragma mark -- Private Method

- (void)setupMasnory {
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(self);
    }];
    [self.titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView);
        make.top.equalTo(self.bgView);
        make.bottom.equalTo(self.bgView);
    }];
    [self.subTitleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLB.mas_right).offset(ScaleW(12));
        make.top.equalTo(self.bgView);
        make.width.mas_equalTo(ScaleW(100));
    }];
}

- (void)configureView {
    
}

- (void)updateSubTitle {
    [self.subTitleLB mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLB.mas_right).offset(ScaleW(12));
        make.top.equalTo(self.bgView);
    }];
}

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc]init];
//        _bgView.backgroundColor = kSubBackgroundColor;
    }
    return _bgView;
}



- (UILabel *)titleLB {
    if (!_titleLB) {
        _titleLB = [[UILabel alloc]init];
        _titleLB.textColor = kTextDarkBlueColor;
        _titleLB.font = [UIFont systemFontOfSize:ScaleW(13)];
        _titleLB.adjustsFontSizeToFitWidth = YES;
    }
    return _titleLB;
}

- (UILabel *)subTitleLB {
    if (!_subTitleLB) {
        _subTitleLB = [[UILabel alloc]init];
        _subTitleLB.textColor = kTextA7BlueColor;
        _subTitleLB.font = [UIFont systemFontOfSize:ScaleW(13)];
        _subTitleLB.adjustsFontSizeToFitWidth = YES;
    }
    return _subTitleLB;
}
#pragma mark -- Setter Method

@end
