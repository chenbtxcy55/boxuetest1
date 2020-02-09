//
//  ETF_Mine_CellItemView.m
//  SSKJ
//
//  Created by James on 2019/5/5.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "JB_Mine_CellItemView.h"

@interface JB_Mine_CellItemView()
@property (nonatomic, strong) UIImageView *bgIM;
@property (nonatomic, strong) UILabel *titleLB;
@property (nonatomic, strong) UIButton *moneyBT;
@property (nonatomic, strong) UILabel *cnyLB;
@end

@implementation JB_Mine_CellItemView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.bgIM];
        [self.bgIM addSubview:self.titleLB];
        [self.bgIM addSubview:self.moneyBT];
        [self.bgIM addSubview:self.cnyLB];
        [self setupMasnory];
    }
    return self;
}

#pragma mark -- Private Method

- (void)setupMasnory {
    [self.bgIM mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.top.equalTo(self);
        make.right.equalTo(self);
//        make.width.mas_equalTo(ScaleW(164));
//        make.height.mas_equalTo(ScaleW(110));
    }];
    
    [self.titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgIM).offset(ScaleW(15));
        make.top.equalTo(self.bgIM).offset(ScaleW(22));
        make.width.mas_equalTo(ScaleW(120));
    }];
    [self.moneyBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgIM).offset(ScaleW(15));
        make.top.equalTo(self.titleLB.mas_bottom).offset(ScaleW(3));
//        make.right.equalTo(self.bgIM).offset(-ScaleW(15));
        make.width.mas_equalTo(ScaleW(150));
    }];
    
    [self.cnyLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgIM).offset(ScaleW(15));
        make.top.equalTo(self.moneyBT.mas_bottom).offset(ScaleW(3));
    }];
}

- (void)configureViewWithMoney:(NSString *)money cny:(NSString *)cny {
    if (money.floatValue == 0) {
        [self.moneyBT setTitle:@"0.0000" forState:UIControlStateNormal];
    }else{
        [self.moneyBT setTitle:[WLTools noroundingStringWith:money.doubleValue afterPointNumber:4] forState:UIControlStateNormal];
    }
    if (cny.floatValue == 0) {
        self.cnyLB.text = [NSString stringWithFormat:@"≈ %@ CNY",@"0.00"];
    }else{
        self.cnyLB.text = [NSString stringWithFormat:@"≈ %@ CNY",[WLTools noroundingStringWith:cny.doubleValue afterPointNumber:2]];
    }
    
}

- (void)configureViewWithImage:(NSString *)image title:(NSString *)title {
    self.bgIM.image = [UIImage imageNamed:image];
    self.titleLB.text = title?:@"";
    
}

#pragma mark -- Public Method
- (void)tapButtonClick {
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectedItem:)]) {
        [self.delegate didSelectedItem:self];
    }
}

#pragma mark -- Getter Method
- (UIImageView *)bgIM {
    if (!_bgIM) {
        _bgIM = [[UIImageView alloc]init];
//        _bgIM.layer.cornerRadius = ScaleW(15);
//        _bgIM.layer.masksToBounds = YES;
        
//        _bgIM.contentMode =  UIViewContentModeScaleAspectFill;
//
//        _bgIM.autoresizingMask = UIViewAutoresizingFlexibleHeight;
//
//        _bgIM.clipsToBounds  = YES;
        _bgIM.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapButtonClick)];
        [_bgIM addGestureRecognizer:tap];
    }
    return _bgIM;
}

- (UILabel *)titleLB {
    if (!_titleLB) {
        _titleLB = [[UILabel alloc]init];
        _titleLB.textColor = kMainWihteColor;
        _titleLB.font = [UIFont systemFontOfSize:ScaleW(12)];
        _titleLB.text = SSKJLocalized(@"", nil);
        _titleLB.adjustsFontSizeToFitWidth = YES;
        _titleLB.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapButtonClick)];
        [_titleLB addGestureRecognizer:tap];
    }
    return _titleLB;
}

- (UIButton *)moneyBT {
    if (!_moneyBT) {
        _moneyBT = [[UIButton alloc]init];
        [_moneyBT setTitle:@"0.0000" forState:UIControlStateNormal];
        [_moneyBT setTitleColor:kMainWihteColor forState:UIControlStateNormal];
        _moneyBT.titleLabel.font = [UIFont boldSystemFontOfSize:ScaleW(18)];
        [_moneyBT setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        _moneyBT.titleLabel.adjustsFontSizeToFitWidth = YES;
        _moneyBT.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _moneyBT.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapButtonClick)];
        [_moneyBT addGestureRecognizer:tap];
        _moneyBT.titleLabel.adjustsFontSizeToFitWidth = YES;
//        _moneyBT.titleEdgeInsets = UIEdgeInsetsMake(0, ScaleW(5), 0, 0);
    }
    return _moneyBT;
}

- (UILabel *)cnyLB {
    if (!_cnyLB) {
        _cnyLB = [[UILabel alloc]init];
        _cnyLB.textColor = kMainWihteColor;
        _cnyLB.font = [UIFont systemFontOfSize:ScaleW(10)];
        _cnyLB.text = @"≈0.00 CNY";
        _cnyLB.adjustsFontSizeToFitWidth = YES;
        _cnyLB.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapButtonClick)];
        [_cnyLB addGestureRecognizer:tap];
    }
    return _cnyLB;
}
#pragma mark -- Setter Method

@end
