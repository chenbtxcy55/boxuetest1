//
//  JB_CoinTradeTableViewCell.m
//  SSKJ
//
//  Created by James on 2019/5/16.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "JB_CoinTradeTableViewCell.h"

@interface JB_CoinTradeTableViewCell()
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UILabel *timeLB;
@property (nonatomic, strong) UILabel *numberLB;
@property (nonatomic, strong) UILabel *markLB;
@end

@implementation JB_CoinTradeTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.bgView];
        [self.bgView addSubview:self.timeLB];
        [self.bgView addSubview:self.numberLB];
        [self.bgView addSubview:self.markLB];
        [self setupMasnory];
    }
    return self;
}

- (void)setTradeModel:(JB_CoinTradeModel *)tradeModel {
    _tradeModel = tradeModel;
    self.timeLB.text = [WLTools convertTimestamp:tradeModel.addtime.doubleValue andFormat:@"yyyy-MM-dd HH:mm:ss"];
    self.numberLB.text = [WLTools noroundingStringWith:tradeModel.price.doubleValue afterPointNumber:8];
    self.markLB.text = tradeModel.memo?:@"";
}

#pragma mark -- Private Method

- (void)setupMasnory {

    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(self);
//        make.height.mas_equalTo(ScaleW(44));
    }];
    [self.timeLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView).offset(ScaleW(15));
        make.top.equalTo(self.bgView).offset(ScaleW(15));
        make.bottom.equalTo(self.bgView).offset(-ScaleW(15));
    }];
    [self.numberLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView).offset(ScaleW(200));
        make.top.equalTo(self.bgView).offset(ScaleW(15));
    }];
    [self.markLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.bgView).offset(-ScaleW(15));
        make.centerY.equalTo(self.bgView);
        make.width.mas_equalTo(ScaleW(95));
        
    }];
}

- (void)configureView {
    
}

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc]init];
        //        _bgView.backgroundColor = kSubBackgroundColor;
    }
    return _bgView;
}



- (UILabel *)timeLB {
    if (!_timeLB) {
        _timeLB = [[UILabel alloc]init];
        _timeLB.textColor = kTextColorb2b9e7;
        _timeLB.font = [UIFont systemFontOfSize:ScaleW(14)];
        _timeLB.adjustsFontSizeToFitWidth = YES;
        _timeLB.text = @"2019-02-05 24:00:02";
    }
    return _timeLB;
}

- (UILabel *)numberLB {
    if (!_numberLB) {
        _numberLB = [[UILabel alloc]init];
        _numberLB.textColor = kTextColorb2b9e7;
        _numberLB.font = [UIFont systemFontOfSize:ScaleW(14)];
        _numberLB.adjustsFontSizeToFitWidth = YES;
        _numberLB.text = @"0.00";
    }
    return _numberLB;
}

- (UILabel *)markLB {
    if (!_markLB) {
        _markLB = [[UILabel alloc]init];
        _markLB.textColor = kTextColorb2b9e7;
        _markLB.textAlignment = NSTextAlignmentRight;
        _markLB.font = [UIFont systemFontOfSize:ScaleW(14)];
//        _markLB.adjustsFontSizeToFitWidth = YES;
        _markLB.numberOfLines = 2;
        _markLB.text = @"转入";
    }
    return _markLB;
}


#pragma mark -- Setter Method

@end
