//
//  JB_TransferRecordTableViewCell.m
//  SSKJ
//
//  Created by James on 2019/5/16.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "JB_TransferRecordTableViewCell.h"
#import "JB_PledgeRecordItemView.h"
@interface JB_TransferRecordTableViewCell()
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) JB_PledgeRecordItemView *accountItemView;
@property (nonatomic, strong) JB_PledgeRecordItemView *numberItemView;
@property (nonatomic, strong) JB_PledgeRecordItemView *timeItemView;
@property (nonatomic, strong) UIView *lineView;
@end

@implementation JB_TransferRecordTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.bgView];
        [self.bgView addSubview:self.accountItemView];
        [self.bgView addSubview:self.numberItemView];
        [self.bgView addSubview:self.timeItemView];
        [self.bgView addSubview:self.lineView];
        [self setupMasnory];
    }
    return self;
}

- (void)setRecordModel:(JB_TransferRecordModel *)recordModel {
    _recordModel = recordModel;
    self.accountItemView.subTitleLB.text = recordModel.memo?:@"";
    self.numberItemView.subTitleLB.text = [NSString stringWithFormat:@"%@ %@",[WLTools noroundingStringWith:recordModel.price.doubleValue afterPointNumber:4],recordModel.ptype?:@""];
    self.timeItemView.subTitleLB.text = [WLTools convertTimestamp:recordModel.addtime.doubleValue andFormat:@"yyyy-MM-dd HH:mm:ss"];
}

#pragma mark -- Private Method

- (void)setupMasnory {
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self);
    }];
    [self.accountItemView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView).offset(ScaleW(15));
        make.right.equalTo(self.bgView).offset(ScaleW(-15));
        make.top.equalTo(self.bgView).offset(ScaleW(20));
    }];
    [self.numberItemView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView).offset(ScaleW(15));
        make.right.equalTo(self.bgView).offset(ScaleW(-15));
        make.top.equalTo(self.accountItemView.mas_bottom).offset(ScaleW(20));
    }];
    [self.timeItemView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView).offset(ScaleW(15));
        make.right.equalTo(self.bgView).offset(ScaleW(-15));
        make.top.equalTo(self.numberItemView.mas_bottom).offset(ScaleW(20));
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView);
        make.right.equalTo(self.bgView);
        make.top.equalTo(self.timeItemView.mas_bottom).offset(ScaleW(20));
        make.height.mas_equalTo(1);
        make.bottom.mas_equalTo(self.bgView);
    }];
}

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc]init];
        _bgView.backgroundColor = kSubBackgroundColor;
    }
    return _bgView;
}

- (JB_PledgeRecordItemView *)accountItemView {
    if (!_accountItemView) {
        _accountItemView = [[JB_PledgeRecordItemView alloc]init];
        _accountItemView.titleLB.text = SSKJLocalized(@"账户", nil);
        _accountItemView.subTitleLB.text = @"从交易账户划转到理财账户";
        _accountItemView.subTitleLB.textColor = [UIColor colorWithHexStringToColor:@"5ea2f4"];
        _accountItemView.subTitleLB.font = [UIFont boldSystemFontOfSize:ScaleW(13)];
        _accountItemView.subTitleLB.adjustsFontSizeToFitWidth = NO;
        [_accountItemView.subTitleLB mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(ScreenWidth-ScaleW(40));
        }];
    }
    return _accountItemView;
}
- (JB_PledgeRecordItemView *)numberItemView {
    if (!_numberItemView) {
        _numberItemView = [[JB_PledgeRecordItemView alloc]init];
        _numberItemView.titleLB.text = SSKJLocalized(@"数量", nil);
        _numberItemView.subTitleLB.text = @"0.00 CQTF";
        _numberItemView.subTitleLB.adjustsFontSizeToFitWidth = NO;
        [_numberItemView.subTitleLB mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(ScreenWidth-ScaleW(40));
        }];
    }
    return _numberItemView;
}
- (JB_PledgeRecordItemView *)timeItemView {
    if (!_timeItemView) {
        _timeItemView = [[JB_PledgeRecordItemView alloc]init];
        _timeItemView.titleLB.text = SSKJLocalized(@"时间", nil);
        _timeItemView.subTitleLB.text = @"2019-06-05 05：59：23";
        _timeItemView.subTitleLB.adjustsFontSizeToFitWidth = NO;
        [_timeItemView.subTitleLB mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(ScreenWidth-ScaleW(40));
        }];
    }
    return _timeItemView;
}
- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = kLineGrayColor;
    }
    return _lineView;
}

@end
