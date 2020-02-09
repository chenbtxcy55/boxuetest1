//
//  JB_PledgeBorrowTableViewCell.m
//  SSKJ
//
//  Created by James on 2019/5/16.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "JB_PledgeBorrowTableViewCell.h"

@interface JB_PledgeBorrowTableViewCell()
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UILabel *coinNameLB;
@property (nonatomic, strong) UILabel *dybzjLB;
@property (nonatomic, strong) UILabel *coinNumberLB;
@property (nonatomic, strong) UIImageView *arrowIM;
@property (nonatomic, strong) UILabel *rightCoinNameLB;
@property (nonatomic, strong) UILabel *jrLB;
@property (nonatomic, strong) UILabel *rightNumberLB;
@property (nonatomic, strong) UIView *lineView;
@end

@implementation JB_PledgeBorrowTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.bgView];
        [self.bgView addSubview:self.coinNameLB];
        [self.bgView addSubview:self.dybzjLB];
        [self.bgView addSubview:self.coinNumberLB];
        [self.bgView addSubview:self.arrowIM];
        [self.bgView addSubview:self.rightCoinNameLB];
        [self.bgView addSubview:self.jrLB];
        [self.bgView addSubview:self.rightNumberLB];
        [self.bgView addSubview:self.lineView];
        [self setupMasnory];
    }
    return self;
}

#pragma mark -- Private Method

- (void)setupMasnory {
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(self);
    }];
    [self.coinNameLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView).offset(ScaleW(15));
        make.top.equalTo(self.bgView).offset(ScaleW(20));
    }];
    [self.dybzjLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView).offset(ScaleW(15));
        make.top.equalTo(self.coinNameLB.mas_bottom).offset(ScaleW(20));
    }];
    [self.coinNumberLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView).offset(ScaleW(15));
        make.top.equalTo(self.dybzjLB.mas_bottom).offset(ScaleW(20));
        
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView);
        make.right.equalTo(self.bgView);
        make.top.equalTo(self.coinNumberLB.mas_bottom).offset(ScaleW(20));
        make.height.mas_equalTo(1);
        make.bottom.equalTo(self.bgView);
    }];
    
    [self.arrowIM mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.bgView).offset(-ScaleW(15));
        make.centerY.equalTo(self.coinNameLB);
    }];
    [self.rightCoinNameLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.arrowIM.mas_left).offset(-ScaleW(10));
        make.centerY.equalTo(self.coinNameLB);
    }];
    [self.jrLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.rightCoinNameLB);
        make.centerY.equalTo(self.dybzjLB);
    }];
    [self.rightNumberLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.bgView).offset(-ScaleW(15));
        make.centerY.equalTo(self.coinNumberLB);
    }];
    
}

- (void)configureCellWithModel:(JB_PledgeBorrowModel *)model {
    self.coinNameLB.text = model.mark?:@"";
    self.rightCoinNameLB.text = model.mark?:@"";
    self.coinNumberLB.text = [NSString stringWithFormat:@"%@ %@",[WLTools noroundingStringWith:model.outString.doubleValue afterPointNumber:4],model.mark?:@""];
    self.rightNumberLB.text = [NSString stringWithFormat:@"%@ %@",[WLTools noroundingStringWith:model.inString.doubleValue afterPointNumber:4],model.mark?:@""];
}

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc]init];
        _bgView.backgroundColor = kSubBackgroundColor;
    }
    return _bgView;
}



- (UILabel *)coinNameLB {
    if (!_coinNameLB) {
        _coinNameLB = [[UILabel alloc]init];
        _coinNameLB.textColor = kMainWihteColor;
        _coinNameLB.font = [UIFont boldSystemFontOfSize:ScaleW(17)];
        _coinNameLB.text = SSKJLocalized(@"BTC", nil);
        _coinNameLB.adjustsFontSizeToFitWidth = YES;
    }
    return _coinNameLB;
}

- (UILabel *)dybzjLB {
    if (!_dybzjLB) {
        _dybzjLB = [[UILabel alloc]init];
        _dybzjLB.textColor = kTextDarkBlueColor;
        _dybzjLB.font = [UIFont systemFontOfSize:ScaleW(11)];
        _dybzjLB.text = SSKJLocalized(@"抵押保证金", nil);
        _dybzjLB.adjustsFontSizeToFitWidth = YES;
    }
    return _dybzjLB;
}

- (UILabel *)coinNumberLB {
    if (!_coinNumberLB) {
        _coinNumberLB = [[UILabel alloc]init];
        _coinNumberLB.textColor = kTextA7BlueColor;
        _coinNumberLB.font = [UIFont systemFontOfSize:ScaleW(14)];
        _coinNumberLB.text = SSKJLocalized(@"0 BTC", nil);
        _coinNumberLB.adjustsFontSizeToFitWidth = YES;
    }
    return _coinNumberLB;
}

- (UIImageView *)arrowIM {
    if (!_arrowIM) {
        _arrowIM = [[UIImageView alloc]init];
        _arrowIM.image = [UIImage imageNamed:@"arrow_right_icon"];
    }
    return _arrowIM;
}

- (UILabel *)rightCoinNameLB {
    if (!_rightCoinNameLB) {
        _rightCoinNameLB = [[UILabel alloc]init];
        _rightCoinNameLB.textColor = kTextA7BlueColor;
        _rightCoinNameLB.font = [UIFont systemFontOfSize:ScaleW(15)];
        _rightCoinNameLB.text = SSKJLocalized(@"BTC", nil);
        _rightCoinNameLB.adjustsFontSizeToFitWidth = YES;
    }
    return _rightCoinNameLB;
}

- (UILabel *)jrLB {
    if (!_jrLB) {
        _jrLB = [[UILabel alloc]init];
        _jrLB.textColor = kTextDarkBlueColor;
        _jrLB.font = [UIFont systemFontOfSize:ScaleW(12)];
        _jrLB.text = SSKJLocalized(@"借入", nil);
        _jrLB.adjustsFontSizeToFitWidth = YES;
    }
    return _jrLB;
}

- (UILabel *)rightNumberLB {
    if (!_rightNumberLB) {
        _rightNumberLB = [[UILabel alloc]init];
        _rightNumberLB.textColor = kTextA7BlueColor;
        _rightNumberLB.font = [UIFont systemFontOfSize:ScaleW(14)];
        _rightNumberLB.text = SSKJLocalized(@"0 BTC", nil);
        _rightNumberLB.adjustsFontSizeToFitWidth = YES;
    }
    return _rightNumberLB;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = kLineGrayColor;
    }
    return _lineView;
}
#pragma mark -- Setter Method

@end
