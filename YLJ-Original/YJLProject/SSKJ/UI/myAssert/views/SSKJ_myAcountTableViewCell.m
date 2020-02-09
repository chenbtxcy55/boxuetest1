//
//  SSKJ_myAcountTableViewCell.m
//  SSKJ
//
//  Created by GT on 2019/9/10.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "SSKJ_myAcountTableViewCell.h"

@interface SSKJ_myAcountTableViewCell ()

@property (nonatomic ,strong) UILabel *coinNameLb;
@property (nonatomic ,strong) UILabel *countNumLb;
@property (nonatomic, strong) UILabel *frozenNumLb;
@property (nonatomic ,strong) UIButton *moreBtn;

@end



@implementation SSKJ_myAcountTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addChildrenViews];
    }
    return self;
}

- (void)addChildrenViews{
    
    self.backgroundColor = self.contentView.backgroundColor = kNavBGColor;
    [self.contentView addSubview:self.coinNameLb];
    [self.contentView addSubview:self.countNumLb];
    [self.contentView addSubview:self.frozenNumLb];
    [self.contentView addSubview:self.moreBtn];
    self.moreBtn.userInteractionEnabled = NO;
    
//    self.countNumLb.adjustsFontSizeToFitWidth = self.frozenNumLb.adjustsFontSizeToFitWidth = YES;
    
//    self.coinNameLb.text = @"ETH";
//    self.countNumLb.text = @"2.00";
//    self.frozenNumLb.text = @"冻结 123";
}

- (void)setModel:(WLLAssetsInfoModel *)model{
    _model = model;
    NSString *frozeStr = [WLTools noroundingStringWith:model.frost.doubleValue afterPointNumber:6];
    self.frozenNumLb.text = [NSString stringWithFormat:@"%@ %@",SSKJLocalized(@"冻结",nil), frozeStr ? frozeStr : @"0.00"];
    
//    self.countNumLb.text = [WLTools roundingStringWith:model.usable.doubleValue afterPointNumber:[WLTools dotNumberOfCoinName:model.pname]];
    //所有币种数量保留8位。 资产综合折算成USDT 保留4位，约等于CNY 2位。
    
    NSString *countNum =  [WLTools noroundingStringWith:model.usable.doubleValue afterPointNumber:6];
    self.countNumLb.text =[NSString stringWithFormat:@"%@ %@",SSKJLocalized(@"可用",nil), countNum ? countNum : @"0.00"] ;
    
    NSString * name = [model.pname componentsSeparatedByString:@"_"].firstObject;
    self.coinNameLb.text = [NSString stringWithFormat:@"%@", name ? name : @""];
//    self.coinNameLb.text = @"etc";
}





- (void)layoutSubviews{
    [super layoutSubviews];
    [self.coinNameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(ScaleW(16));
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.width.mas_equalTo(ScaleW(50));
    }];
    
    [self.countNumLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.coinNameLb.mas_right).offset(ScaleW(10));
        make.right.mas_equalTo(self.contentView.right).offset(ScaleW(30));
        make.centerY.mas_equalTo(self.coinNameLb.mas_centerY).offset(ScaleW(-10));
    }];
    
    [self.frozenNumLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.coinNameLb.mas_right).offset(ScaleW(10));
        make.right.mas_equalTo(self.contentView.right).offset(ScaleW(30));
        make.centerY.mas_equalTo(self.coinNameLb.mas_centerY).offset(ScaleW(10));
    }];
    [self.moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView.mas_right).offset(ScaleW(-16));
        make.centerY.mas_equalTo(self.coinNameLb.mas_centerY);
//        make.left.mas_equalTo(self.frozenNumLb.mas_right);
//        make.width.mas_equalTo(ScaleW(50));

    }];
}

- (UILabel *)coinNameLb{
    if (!_coinNameLb) {
        _coinNameLb = [UILabel new];
        _coinNameLb.font = systemBoldFont(16);
        _coinNameLb.textColor = kMainTextColor;
    }
    return _coinNameLb;
}
- (UILabel *)countNumLb{
    if (!_countNumLb) {
        _countNumLb = [UILabel new];
        _countNumLb.font = systemFont(15);
        _countNumLb.textColor = kSubTxtColor;
//        _countNumLb.lineBreakMode = NSLineBreakByTruncatingTail;
        _countNumLb.numberOfLines = 0;
        
    }
    return _countNumLb;
}
- (UILabel *)frozenNumLb{
    if (!_frozenNumLb) {
        _frozenNumLb = [UILabel new];
        _frozenNumLb.font = systemFont(16);
        _frozenNumLb.textColor = kSubTxtColor;
        _frozenNumLb.textAlignment = NSTextAlignmentLeft;
        _frozenNumLb.numberOfLines = 0;

//        _frozenNumLb.lineBreakMode = NSLineBreakByTruncatingTail;

    }
    return _frozenNumLb;
}
- (UIButton *)moreBtn{
    if (!_moreBtn) {
        _moreBtn = [UIButton new];
        [_moreBtn setImage:[UIImage imageNamed:@"more_icon"] forState:UIControlStateNormal];
    }
    return _moreBtn;
}


@end
