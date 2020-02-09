//
//  JB_PledgeHeaderView.m
//  SSKJ
//
//  Created by James on 2019/5/16.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "JB_PledgeHeaderView.h"

@interface JB_PledgeHeaderView()
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UILabel *topLB;
@property (nonatomic, strong) UIButton *submitButton;
@property (nonatomic, strong) UILabel *currentDYLB;
@property (nonatomic, strong) UIImageView *iconIM;
@property (nonatomic, strong) UIButton *recordButton;
@property (nonatomic, strong) UILabel *recordLB;
@end

@implementation JB_PledgeHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.bgView];
        [self.bgView addSubview:self.topLB];
        [self.bgView addSubview:self.submitButton];
        [self.bgView addSubview:self.currentDYLB];
        [self.bgView addSubview:self.recordButton];
        [self.bgView addSubview:self.iconIM];
        [self.bgView addSubview:self.recordLB];
        [self setupMasnory];
    }
    return self;
}

#pragma mark -- Private Method

- (void)submitButtonClick {
    if (self.submitButtonBlock) {
        self.submitButtonBlock();
    }
}

- (void)recordButtonClick {
    if (self.recordButtonBlock) {
        self.recordButtonBlock();
    }
}


- (void)setupMasnory {
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(self);
        make.height.mas_equalTo(ScaleW(205));
    }];
    [self.topLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView).offset(ScaleW(15));
        make.right.equalTo(self.bgView).offset(ScaleW(-15));
        make.top.equalTo(self.bgView).offset(ScaleW(24));
        
    }];
    [self.submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView).offset(ScaleW(25));
        make.right.equalTo(self.bgView).offset(-ScaleW(25));
        make.top.equalTo(self.topLB.mas_bottom).offset(ScaleW(30));
        make.height.mas_equalTo(ScaleW(45));
    }];
    [self.currentDYLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView).offset(ScaleW(15));
        make.bottom.equalTo(self.bgView).offset(-ScaleW(20));
    }];
    [self.recordButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.bgView);
        make.bottom.equalTo(self.bgView);
        make.height.mas_equalTo(ScaleW(44));
        make.width.mas_equalTo(ScaleW(160));
    }];
    [self.iconIM mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.bgView).offset(ScaleW(-15));
        make.centerY.equalTo(self.currentDYLB);
    }];
    [self.recordLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.iconIM.mas_left).offset(ScaleW(-10));
        make.centerY.equalTo(self.currentDYLB);
    }];
}


- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc]init];
        _bgView.backgroundColor = kMainBackgroundColor;
    }
    return _bgView;
}

- (UILabel *)topLB {
    if (!_topLB) {
        _topLB = [[UILabel alloc]init];
        _topLB.textColor = [UIColor colorWithHexStringToColor:@"8d93bc"];
        _topLB.font = [UIFont systemFontOfSize:ScaleW(12)];
        _topLB.text = SSKJLocalized(@"由于市场价格实时变动，实际到账的借入数量以市场实时价格为准", nil);
        _topLB.adjustsFontSizeToFitWidth = YES;
        _topLB.numberOfLines = 0;
    }
    return _topLB;
}

- (UIButton *)submitButton {
    if (!_submitButton) {
        _submitButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth-ScaleW(25*2), ScaleW(45))];
        [_submitButton setTitle:SSKJLocalized(@"提交", nil) forState:UIControlStateNormal];
        [_submitButton setTitleColor:kMainWihteColor forState:UIControlStateNormal];
        _submitButton.titleLabel.font = [UIFont systemFontOfSize:ScaleW(15)];
        [_submitButton addGradientColor];
        _submitButton.layer.cornerRadius = ScaleW(5);
        _submitButton.layer.masksToBounds = YES;
        [_submitButton addTarget:self action:@selector(submitButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitButton;
}

- (UILabel *)currentDYLB {
    if (!_currentDYLB) {
        _currentDYLB = [[UILabel alloc]init];
        _currentDYLB.textColor = kMainWihteColor;
        _currentDYLB.font = [UIFont boldSystemFontOfSize:ScaleW(17)];
        _currentDYLB.text = SSKJLocalized(@"当前抵押", nil);
        _currentDYLB.adjustsFontSizeToFitWidth = YES;
    }
    return _currentDYLB;
}

- (UIButton *)recordButton {
    if (!_recordButton) {
        _recordButton = [[UIButton alloc]init];
        [_recordButton addTarget:self action:@selector(recordButtonClick) forControlEvents:UIControlEventTouchUpInside];

    }
    return _recordButton;
}

- (UILabel *)recordLB {
    if (!_recordLB) {
        _recordLB = [[UILabel alloc]init];
        _recordLB.textColor = kTextA7BlueColor;
        _recordLB.font = [UIFont systemFontOfSize:ScaleW(12)];
        _recordLB.text = SSKJLocalized(@"全部记录", nil);
        _recordLB.adjustsFontSizeToFitWidth = YES;
    }
    return _recordLB;
}

- (UIImageView *)iconIM {
    if (!_iconIM) {
        _iconIM = [[UIImageView alloc]init];
        _iconIM.image = [UIImage imageNamed:@"arrow_right_icon"];
    }
    return _iconIM;
}
@end
