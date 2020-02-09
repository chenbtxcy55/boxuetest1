//
//  ETF_WalletHeaderView.m
//  SSKJ
//
//  Created by James on 2019/5/7.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "JB_WalletHeaderView.h"

@interface JB_WalletHeaderView()

@property (nonatomic, strong) UIButton *moneyBT;
@property (nonatomic, strong) UILabel *cnyLB;

@end

@implementation JB_WalletHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.bgIM];
        
        [self.bgIM addSubview:self.titleLB];
        [self.bgIM addSubview:self.moneyBT];
        [self.bgIM addSubview:self.cnyLB];
        
        
        [self.bgIM addSubview:self.rechargeButton];
        [self.bgIM addSubview:self.carryButton];
        [self.bgIM addSubview:self.turnButton];
        [self setupMasnory];
    }
    return self;
}

#pragma mark -- Private Method

- (void)setupMasnory {
    [self.bgIM mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(ScaleW(15));
        make.height.mas_offset(ScaleW(127));
        make.left.equalTo(self).offset(ScaleW(15));
        make.right.equalTo(self).offset(-ScaleW(15));
        make.bottom.equalTo(self).offset(ScaleW(-15));
    }];
    
    [self.titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgIM).offset(ScaleW(36));
        make.top.equalTo(self.bgIM).offset(ScaleW(30));
    }];
    [self.moneyBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgIM).offset(ScaleW(36));
        make.top.equalTo(self.titleLB.mas_bottom).offset(ScaleW(8));
        //        make.right.equalTo(self.bgIM).offset(-ScaleW(15));
        make.width.mas_equalTo(ScaleW(120));
    }];
    
    [self.cnyLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgIM).offset(ScaleW(36));
        make.top.equalTo(self.moneyBT.mas_bottom).offset(ScaleW(8));
    }];
    
    [self.turnButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.bgIM);
        make.right.equalTo(self.bgIM.mas_right).offset(-ScaleW(30));
        make.width.mas_equalTo(ScaleW(40));
        make.height.mas_equalTo(ScaleW(45));
    }];
    [self.carryButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.bgIM);
        make.right.equalTo(self.turnButton.mas_left).offset(-ScaleW(15));
        make.width.mas_equalTo(ScaleW(40));
        make.height.mas_equalTo(ScaleW(45));
    }];
    [self.rechargeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.bgIM);
        make.right.equalTo(self.carryButton.mas_left).offset(-ScaleW(15));
        make.width.mas_equalTo(ScaleW(40));
        make.height.mas_equalTo(ScaleW(45));
    }];

}

- (UIImageView *)bgIM {
    if (!_bgIM) {
        _bgIM = [[UIImageView alloc]init];
        _bgIM.userInteractionEnabled = YES;
    }
    return _bgIM;
}

- (UILabel *)titleLB {
    if (!_titleLB) {
        _titleLB = [[UILabel alloc]init];
        _titleLB.textColor = kMainWihteColor;
        _titleLB.font = [UIFont systemFontOfSize:ScaleW(12)];
        _titleLB.text = SSKJLocalized(@"资产折合", nil);
        _titleLB.adjustsFontSizeToFitWidth = YES;
        _titleLB.userInteractionEnabled = YES;
    }
    return _titleLB;
}

- (UIButton *)moneyBT {
    if (!_moneyBT) {
        _moneyBT = [[UIButton alloc]init];
        [_moneyBT setTitle:@"0.0000 AB" forState:UIControlStateNormal];
        [_moneyBT setTitleColor:kMainWihteColor forState:UIControlStateNormal];
        _moneyBT.titleLabel.font = [UIFont boldSystemFontOfSize:ScaleW(18)];
        [_moneyBT setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        _moneyBT.titleLabel.adjustsFontSizeToFitWidth = YES;
        _moneyBT.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _moneyBT.titleLabel.adjustsFontSizeToFitWidth = YES;
//        _moneyBT.titleEdgeInsets = UIEdgeInsetsMake(0, ScaleW(5), 0, 0);
        
    }
    return _moneyBT;
}

- (UILabel *)cnyLB {
    if (!_cnyLB) {
        _cnyLB = [[UILabel alloc]init];
        _cnyLB.textColor =RGBACOLOR(255, 255, 255, 0.69);
        _cnyLB.font = [UIFont systemFontOfSize:ScaleW(11)];
        _cnyLB.text = @"≈ 0.00 CNY";
        _cnyLB.adjustsFontSizeToFitWidth = YES;
        _cnyLB.userInteractionEnabled = YES;
    }
    return _cnyLB;
}

- (HomeCustomButton *)rechargeButton {
    if (!_rechargeButton) {
        _rechargeButton = [[HomeCustomButton alloc]initWithFrame:CGRectMake(0, 0, ScaleW(40), ScaleW(45))];
        [_rechargeButton setImage:[UIImage imageNamed:@"recharge_icon"] forState:UIControlStateNormal];
        [_rechargeButton setTitle:SSKJLocalized(@"借款", nil) forState:UIControlStateNormal];
        _rechargeButton.titleLabel.font = [UIFont systemFontOfSize:ScaleW(10)];
        [_rechargeButton setTitleColor:kMainWihteColor forState:UIControlStateNormal];
    
    }
    return _rechargeButton;
}
- (HomeCustomButton *)carryButton {
    if (!_carryButton) {
        _carryButton = [[HomeCustomButton alloc]initWithFrame:CGRectMake(0, 0, ScaleW(40), ScaleW(45))];
        [_carryButton setImage:[UIImage imageNamed:@"carry_icon"] forState:UIControlStateNormal];
        [_carryButton setTitle:SSKJLocalized(@"借币", nil) forState:UIControlStateNormal];
        _carryButton.titleLabel.font = [UIFont systemFontOfSize:ScaleW(10)];
        [_carryButton setTitleColor:kMainWihteColor forState:UIControlStateNormal];
    }
    return _carryButton;
}
- (HomeCustomButton *)turnButton {
    if (!_turnButton) {
        _turnButton = [[HomeCustomButton alloc]initWithFrame:CGRectMake(0, 0, ScaleW(40), ScaleW(45))];
        [_turnButton setImage:[UIImage imageNamed:@"trun_icon"] forState:UIControlStateNormal];
        [_turnButton setTitle:SSKJLocalized(@"划转", nil) forState:UIControlStateNormal];
        _turnButton.titleLabel.font = [UIFont systemFontOfSize:ScaleW(10)];
        [_turnButton setTitleColor:kMainWihteColor forState:UIControlStateNormal];
    }
    return _turnButton;
}
#pragma mark -- Setter Method

-(void)setViewWithModel:(JB_Account_Asset_CoinModel *)model
{
    NSString *cnyS = [NSString stringWithFormat:@"%@ AB",[WLTools noroundingStringWith:model.ttl_money.doubleValue afterPointNumber:4]];
    [self.moneyBT setTitle:cnyS forState:UIControlStateNormal];
    self.cnyLB.text = [NSString stringWithFormat:@"≈ %@ CNY",[WLTools noroundingStringWith:model.ttl_cnymoney.doubleValue afterPointNumber:2]];
}

@end
