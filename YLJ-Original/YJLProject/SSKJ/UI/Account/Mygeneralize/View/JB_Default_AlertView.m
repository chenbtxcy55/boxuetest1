//
//  JB_Default_AlertView.m
//  SSKJ
//
//  Created by James on 2019/5/17.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "JB_Default_AlertView.h"

@interface JB_Default_AlertView()
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, copy) void (^cancelBlock)(void);
@property (nonatomic, copy) void (^confirmBlock)(void);
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIView *topLine;
@property (nonatomic, strong) UIView *bottomLine;
@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UIButton *applyButton;
@end

@implementation JB_Default_AlertView

- (instancetype)initWithConfirmBlock:(nonnull void (^)(void))confirmBlock cancelBlock:(nonnull void (^)(void))cancelBlock
{
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        self.cancelBlock = cancelBlock;
        self.confirmBlock = confirmBlock;
        [self addSubview:self.backView];
        [self addSubview:self.bgView];
        [self.bgView addSubview:self.titleLB];
        [self.bgView addSubview:self.topLine];
        [self.bgView addSubview:self.contentLB];
        [self.bgView addSubview:self.bottomLine];
        [self.bgView addSubview:self.cancelButton];
        [self.bgView addSubview:self.applyButton];
        [self setupMasnory];
    }
    return self;
}

#pragma mark -- Private Method

- (void)setupMasnory {
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(ScaleW(15));
        make.right.equalTo(self).offset(-ScaleW(15));
        make.centerX.equalTo(self);
        make.centerY.equalTo(self);
    }];
    [self.titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView).offset(ScaleW(30));
        make.top.equalTo(self.bgView).offset(ScaleW(18));
    }];
    [self.topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView).offset(ScaleW(15));
        make.right.equalTo(self.bgView).offset(-ScaleW(15));
        make.top.equalTo(self.titleLB.mas_bottom).offset(ScaleW(18));
        make.height.mas_equalTo(1);
    }];
    [self.contentLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView).offset(ScaleW(30));
        make.right.equalTo(self.bgView).offset(-ScaleW(30));
        make.top.equalTo(self.topLine.mas_bottom).offset(ScaleW(25));
    }];
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView).offset(ScaleW(15));
        make.right.equalTo(self.bgView).offset(-ScaleW(15));
        make.top.equalTo(self.contentLB.mas_bottom).offset(ScaleW(25));
        make.height.mas_equalTo(1);
    }];
    [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView);
        make.width.mas_equalTo((ScreenWidth-ScaleW(15)*2)/2);
        make.height.mas_equalTo(ScaleW(50));
        make.top.equalTo(self.bottomLine.mas_bottom);
    }];
    [self.applyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.cancelButton.mas_right);
        make.width.mas_equalTo((ScreenWidth-ScaleW(15)*2)/2);
        make.height.mas_equalTo(ScaleW(50));
        make.top.equalTo(self.bottomLine.mas_bottom);
        make.bottom.equalTo(self.bgView);
    }];
}

- (void)show {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
}

- (void)dismiss {
    [self removeFromSuperview];
}

- (void)cancelButtonClick {
    if (self.cancelBlock) {
        self.cancelBlock();
    }
    [self dismiss];
}

- (void)applyButtonClick {
    if (self.confirmBlock) {
        self.confirmBlock();
    }
    [self dismiss];
}

- (UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc]initWithFrame:self.bounds];
        _backView.backgroundColor = [UIColor blackColor];
        _backView.alpha = 0.4;
    }
    return _backView;
}

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc]init];
        _bgView.backgroundColor = kSubBackgroundColor;
        _bgView.layer.cornerRadius = ScaleW(5);
        _bgView.layer.masksToBounds = YES;
    }
    return _bgView;
}

- (UIView *)topLine {
    if (!_topLine) {
        _topLine = [[UIView alloc]init];
        _topLine.backgroundColor = kLineGrayColor;
    }
    return _topLine;
}
- (UIView *)bottomLine {
    if (!_bottomLine) {
        _bottomLine = [[UIView alloc]init];
        _bottomLine.backgroundColor = kLineGrayColor;
    }
    return _bottomLine;
}


- (UILabel *)titleLB {
    if (!_titleLB) {
        _titleLB = [[UILabel alloc]init];
        _titleLB.textColor = [UIColor colorWithHexStringToColor:@"b2b9e7"];
        _titleLB.font = [UIFont systemFontOfSize:ScaleW(16)];
        _titleLB.adjustsFontSizeToFitWidth = YES;
    }
    return _titleLB;
}

- (UILabel *)contentLB {
    if (!_contentLB) {
        _contentLB = [[UILabel alloc]init];
        _contentLB.textColor = [UIColor colorWithHexStringToColor:@"8d93bc"];
        _contentLB.font = [UIFont systemFontOfSize:ScaleW(12)];
        _contentLB.adjustsFontSizeToFitWidth = YES;
        _contentLB.numberOfLines = 0;
    }
    return _contentLB;
}


- (UIButton *)cancelButton {
    if (!_cancelButton) {
        _cancelButton = [[UIButton alloc]init];
        [_cancelButton setTitle:SSKJLocalized(@"取消", nil) forState:UIControlStateNormal];
        [_cancelButton setTitleColor:[UIColor colorWithHexStringToColor:@"6b6fb9"] forState:UIControlStateNormal];
        _cancelButton.titleLabel.font = [UIFont systemFontOfSize:ScaleW(15)];
        [_cancelButton addTarget:self action:@selector(cancelButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}

- (UIButton *)applyButton {
    if (!_applyButton) {
        _applyButton = [[UIButton alloc]init];
        [_applyButton setTitle:SSKJLocalized(@"申请", nil) forState:UIControlStateNormal];
        [_applyButton setTitleColor:[UIColor colorWithHexStringToColor:@"878ff5"] forState:UIControlStateNormal];
        _applyButton.titleLabel.font = [UIFont systemFontOfSize:ScaleW(15)];
        [_applyButton addTarget:self action:@selector(applyButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _applyButton;
}
#pragma mark -- Setter Method

@end
