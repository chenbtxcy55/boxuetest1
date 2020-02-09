//
//  JB_AccountOtherTableViewCell.m
//  SSKJ
//
//  Created by James on 2019/5/22.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "JB_AccountOtherTableViewCell.h"

@interface JB_AccountOtherItemView : UIView
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UILabel *titleLB;
@property (nonatomic, strong) UILabel *subTitleLB;
@end


@implementation JB_AccountOtherItemView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.bgView];
        [self.bgView addSubview:self.titleLB];
        [self.bgView addSubview:self.subTitleLB];
        
        [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.bottom.equalTo(self);
        }];
        
        [self.titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(self.bgView);
        }];
        [self.subTitleLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleLB.mas_right).offset(ScaleW(18));
            make.centerY.equalTo(self.titleLB);
            make.right.equalTo(self.bgView);
        }];
    }
    return self;
}

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc]init];
    }
    return _bgView;
}

- (UILabel *)titleLB {
    if (!_titleLB) {
        _titleLB = [[UILabel alloc]init];
        _titleLB.textColor = kTextColorb3b7e9;
        _titleLB.font = [UIFont boldSystemFontOfSize:ScaleW(14)];
        _titleLB.text = SSKJLocalized(@"", nil);
        _titleLB.adjustsFontSizeToFitWidth = YES;
    }
    return _titleLB;
}

- (UILabel *)subTitleLB {
    if (!_subTitleLB) {
        _subTitleLB = [[UILabel alloc]init];
        _subTitleLB.textColor = kTextDarkBlueColor;
        _subTitleLB.font = [UIFont boldSystemFontOfSize:ScaleW(13)];
        _subTitleLB.text = SSKJLocalized(@"", nil);
        _subTitleLB.adjustsFontSizeToFitWidth = YES;
        _subTitleLB.numberOfLines = 0;
    }
    return _subTitleLB;
}

@end

@interface JB_AccountOtherTableViewCell()
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) JB_AccountOtherItemView *numberItemView;
@property (nonatomic, strong) JB_AccountOtherItemView *timeItemView;
@property (nonatomic, strong) JB_AccountOtherItemView *markItemView;
@property (nonatomic, strong) UIView *lineView;
@end

@implementation JB_AccountOtherTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.bgView];
        [self.bgView addSubview:self.numberItemView];
        [self.bgView addSubview:self.timeItemView];
        [self.bgView addSubview:self.markItemView];
        [self.bgView addSubview:self.lineView];
        [self setupMasnory];
    }
    return self;
}

- (void)setTradeModel:(JB_CoinTradeModel *)tradeModel {
    _tradeModel = tradeModel;
    self.numberItemView.subTitleLB.text = [NSString stringWithFormat:@"%@ %@",[WLTools noroundingStringWith:tradeModel.price.doubleValue afterPointNumber:6],tradeModel.ptype?:@""];
    self.timeItemView.subTitleLB.text = [WLTools convertTimestamp:tradeModel.addtime.doubleValue andFormat:@"yyyy-MM-dd HH:mm:ss"];
    self.markItemView.subTitleLB.text = tradeModel.memo?:@"";
}

#pragma mark -- Private Method

- (void)setupMasnory {
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(self);
    }];
    [self.numberItemView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView).offset(ScaleW(16));
        make.top.equalTo(self.bgView).offset(ScaleW(23));
    }];
    [self.timeItemView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView).offset(ScaleW(16));
        make.top.equalTo(self.numberItemView.mas_bottom).offset(ScaleW(23));
    }];
    [self.markItemView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView).offset(ScaleW(16));
        make.right.equalTo(self.bgView).offset(-ScaleW(16));
        make.top.equalTo(self.timeItemView.mas_bottom).offset(ScaleW(23));
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView);
        make.right.equalTo(self.bgView);
        make.top.equalTo(self.markItemView.mas_bottom).offset(ScaleW(40));
        make.height.mas_equalTo(1);
        make.bottom.equalTo(self.bgView);
    }];
}

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc]init];
        _bgView.backgroundColor = kMainBackgroundColor;
    }
    return _bgView;
}

- (JB_AccountOtherItemView *)numberItemView {
    if (!_numberItemView) {
        _numberItemView = [[JB_AccountOtherItemView alloc]init];
        _numberItemView.titleLB.text = SSKJLocalized(@"数量", nil);
    }
    return _numberItemView;
}

- (JB_AccountOtherItemView *)timeItemView {
    if (!_timeItemView) {
        _timeItemView = [[JB_AccountOtherItemView alloc]init];
        _timeItemView.titleLB.text = SSKJLocalized(@"时间", nil);
    }
    return _timeItemView;
}

- (JB_AccountOtherItemView *)markItemView {
    if (!_markItemView) {
        _markItemView = [[JB_AccountOtherItemView alloc]init];
        _markItemView.titleLB.text = SSKJLocalized(@"备注", nil);
    }
    return _markItemView;
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
