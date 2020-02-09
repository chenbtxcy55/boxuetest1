//
//  JB_PledgeRecordTableViewCell.m
//  SSKJ
//
//  Created by James on 2019/5/16.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "JB_PledgeRecordTableViewCell.h"
#import "JB_PledgeRecordItemView.h"
@interface JB_PledgeRecordTableViewCell()
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UILabel *timeLB;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIButton *buyBackButton;
@property (nonatomic, strong) UIButton *addButton;  // 补仓按钮

@property (nonatomic, strong) JB_PledgeRecordItemView *typeItemView;
@property (nonatomic, strong) JB_PledgeRecordItemView *dybzjItemView;
@property (nonatomic, strong) JB_PledgeRecordItemView *lvItemView;
@property (nonatomic, strong) JB_PledgeRecordItemView *dqrqItemView;
@property (nonatomic, strong) JB_PledgeRecordItemView *fxztItemView;
@property (nonatomic, strong) JB_PledgeRecordItemView *jrjeItemView;
@property (nonatomic, strong) JB_PledgeRecordItemView *ycslxItemView;
@property (nonatomic, strong) JB_PledgeRecordItemView *zqItemView;
@property (nonatomic, strong) JB_PledgeRecordItemView *sjshrqItemView;



@end

@implementation JB_PledgeRecordTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = kMainBackgroundColor;
        [self addSubview:self.bgView];
        [self.bgView addSubview:self.timeLB];
        [self.bgView addSubview:self.lineView];
        [self.bgView addSubview:self.buyBackButton];
        [self.bgView addSubview:self.addButton];
        [self.bgView addSubview:self.typeItemView];
        [self.bgView addSubview:self.dybzjItemView];
        [self.bgView addSubview:self.lvItemView];
        [self.bgView addSubview:self.dqrqItemView];
        [self.bgView addSubview:self.fxztItemView];
        [self.bgView addSubview:self.jrjeItemView];
        [self.bgView addSubview:self.ycslxItemView];
        [self.bgView addSubview:self.zqItemView];
        [self.bgView addSubview:self.sjshrqItemView];

        
        [self setupMasnory];
    }
    return self;
}

- (void)buyBackClick {
    if (self.delegate && [self.delegate respondsToSelector:@selector(buyBackDidSelectedWithModel:)]) {
        [self.delegate buyBackDidSelectedWithModel:self.recordModel];
    }
}

-(void)addBtnClick
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(addDidSelectedWithModel:)]) {
        [self.delegate addDidSelectedWithModel:self.recordModel];
    }
}

- (void)setRecordModel:(JB_PledgeRecordModel *)recordModel {
    _recordModel = recordModel;
    self.timeLB.text =  [WLTools convertTimestamp:recordModel.addtime.doubleValue
                                        andFormat:@"yyyy-MM-dd HH:mm:ss"];
    //类型
    if (recordModel.type.integerValue == 1) {//借款
        self.typeItemView.subTitleLB.text = SSKJLocalized(@"借款", nil);
    }else{//借币
        self.typeItemView.subTitleLB.text = SSKJLocalized(@"借币", nil);
    }
    
    //风险/状态
    self.fxztItemView.subTitleLB.text = [NSString stringWithFormat:@"%@%%",[WLTools noroundingStringWith:recordModel.risk_rate.doubleValue afterPointNumber:2]];
    
    //抵押保证金
    self.dybzjItemView.subTitleLB.text = [NSString stringWithFormat:@"%@ %@",[WLTools noroundingStringWith:recordModel.out_num.doubleValue afterPointNumber:3],recordModel.out_pname?:@""];
    
    //借入金额
    self.jrjeItemView.subTitleLB.text = [NSString stringWithFormat:@"%@ %@",[WLTools noroundingStringWith:recordModel.in_num.doubleValue afterPointNumber:3],recordModel.in_pname?:@""];
    //利率
    self.lvItemView.subTitleLB.text = [NSString stringWithFormat:@"%@%%",[WLTools noroundingStringWith:recordModel.rate.doubleValue afterPointNumber:2]];
    
    //已产生利息
    self.ycslxItemView.subTitleLB.text = [NSString stringWithFormat:@"%@ %@",[WLTools noroundingStringWith:recordModel.fee.doubleValue afterPointNumber:4],recordModel.in_pname?:@""];
    
    //到期时间
    self.dqrqItemView.subTitleLB.text =  [WLTools convertTimestamp:recordModel.endtime.doubleValue
                                        andFormat:@"yyyy-MM-dd HH:mm:ss"];
    //周期
    self.zqItemView.subTitleLB.text =  [NSString stringWithFormat:@"%@%@",[WLTools noroundingStringWith:recordModel.days.doubleValue afterPointNumber:2],SSKJLocalized(@"天/按天", nil)];
    
    //实际赎回日期
    self.sjshrqItemView.subTitleLB.text =  [WLTools convertTimestamp:recordModel.selltime.doubleValue
                                                         andFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    if (recordModel.status.integerValue == 1) { // 计息中
        self.buyBackButton.enabled = YES;
        [self.buyBackButton setTitle:SSKJLocalized(@"赎回", nil) forState:UIControlStateNormal];
        self.buyBackButton.layer.borderWidth = 0.5;
        self.addButton.hidden = NO;
        self.addButton.enabled = YES;
        [self showSjshrqItemViewWithShow:NO];

    }else if (recordModel.status.integerValue == 2) { // 已赎回
        self.buyBackButton.enabled = NO;
        [self.buyBackButton setTitle:SSKJLocalized(@"已赎回", nil) forState:UIControlStateDisabled];
        self.buyBackButton.layer.borderWidth = 0;
        self.addButton.hidden = YES;
        self.addButton.enabled = NO;
        [self showSjshrqItemViewWithShow:YES];
    }
}

- (void)showSjshrqItemViewWithShow:(BOOL)isShow {
    if (isShow) {
        self.sjshrqItemView.hidden = NO;
        [self.zqItemView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.bgView).offset(ScreenWidth/2);
            make.top.equalTo(self.ycslxItemView.mas_bottom).offset(ScaleW(18));
        }];
        [self.sjshrqItemView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.bgView).offset(ScaleW(15));
            make.top.equalTo(self.dqrqItemView.mas_bottom).offset(ScaleW(18));
            make.bottom.equalTo(self.bgView).offset(-ScaleW(30));
        }];
    }else{
        self.sjshrqItemView.hidden = YES;
        [self.zqItemView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.bgView).offset(ScreenWidth/2);
            make.top.equalTo(self.ycslxItemView.mas_bottom).offset(ScaleW(18));
            make.bottom.equalTo(self.bgView).offset(-ScaleW(30));
        }];
        [self.sjshrqItemView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.bgView).offset(ScaleW(15));
            make.top.equalTo(self.dqrqItemView.mas_bottom).offset(ScaleW(18));
            
        }];
    }
}


#pragma mark -- Private Method

- (void)setupMasnory {
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self);
        make.bottom.equalTo(self).offset(-ScaleW(10));
    }];
    [self.timeLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView).offset(ScaleW(15));
        make.top.equalTo(self.bgView).offset(ScaleW(25));
    }];
    [self.buyBackButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.bgView).offset(-ScaleW(17));
        make.centerY.equalTo(self.timeLB);
        make.height.mas_equalTo(ScaleW(36));
        make.width.mas_equalTo(ScaleW(60));
    }];
    
    [self.addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.buyBackButton.mas_left).offset(-ScaleW(10));
        make.centerY.equalTo(self.timeLB);
        make.height.mas_equalTo(ScaleW(36));
        make.width.mas_equalTo(ScaleW(60));
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView);
        make.right.equalTo(self.bgView);
        make.top.equalTo(self.timeLB.mas_bottom).offset(ScaleW(25));
        make.height.mas_equalTo(1);
    }];
    
    [self.typeItemView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView).offset(ScaleW(15));
        make.top.equalTo(self.lineView.mas_bottom).offset(ScaleW(18));
    }];
    [self.dybzjItemView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView).offset(ScaleW(15));
        make.top.equalTo(self.typeItemView.mas_bottom).offset(ScaleW(18));
    }];
    [self.lvItemView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView).offset(ScaleW(15));
        make.top.equalTo(self.dybzjItemView.mas_bottom).offset(ScaleW(18));
    }];
    [self.dqrqItemView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView).offset(ScaleW(15));
        make.top.equalTo(self.lvItemView.mas_bottom).offset(ScaleW(18));
        
    }];
    
    [self.fxztItemView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView).offset(ScreenWidth/2);
        make.top.equalTo(self.lineView.mas_bottom).offset(ScaleW(18));
    }];
    [self.jrjeItemView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView).offset(ScreenWidth/2);
        make.top.equalTo(self.fxztItemView.mas_bottom).offset(ScaleW(18));
    }];
    [self.ycslxItemView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView).offset(ScreenWidth/2);
        make.top.equalTo(self.jrjeItemView.mas_bottom).offset(ScaleW(18));
    }];
    [self.zqItemView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView).offset(ScreenWidth/2);
        make.top.equalTo(self.ycslxItemView.mas_bottom).offset(ScaleW(18));
        make.bottom.equalTo(self.bgView).offset(-ScaleW(30));
    }];
    [self.sjshrqItemView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView).offset(ScaleW(15));
        make.top.equalTo(self.dqrqItemView.mas_bottom).offset(ScaleW(18));
    }];

}

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc]init];
        _bgView.backgroundColor = kSubBackgroundColor;
    }
    return _bgView;
}

- (UILabel *)timeLB {
    if (!_timeLB) {
        _timeLB = [[UILabel alloc]init];
        _timeLB.textColor = kMainWihteColor;
        _timeLB.font = [UIFont boldSystemFontOfSize:ScaleW(15)];
        _timeLB.text = @"2019-02-01 16:22:22";
        _timeLB.adjustsFontSizeToFitWidth = YES;
    }
    return _timeLB;
}

- (UIButton *)buyBackButton {
    if (!_buyBackButton) {
        _buyBackButton = [[UIButton alloc]init];
        [_buyBackButton setTitle:SSKJLocalized(@"赎回", nil) forState:UIControlStateNormal];
        [_buyBackButton setTitleColor:[UIColor colorWithHexStringToColor:@"878ff5"] forState:UIControlStateNormal];
        [_buyBackButton setTitleColor:kTextDarkBlueColor forState:UIControlStateDisabled];
        _buyBackButton.titleLabel.font = [UIFont boldSystemFontOfSize:ScaleW(15)];
        _buyBackButton.layer.cornerRadius = ScaleW(18);
        _buyBackButton.layer.masksToBounds = YES;
        _buyBackButton.layer.borderColor = [UIColor colorWithHexStringToColor:@"878ff5"].CGColor;
        _buyBackButton.layer.borderWidth = 1;
        [_buyBackButton addTarget:self action:@selector(buyBackClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _buyBackButton;
}

- (UIButton *)addButton {
    if (!_addButton) {
        _addButton = [[UIButton alloc]init];
        [_addButton setTitle:SSKJLocalized(@"补仓", nil) forState:UIControlStateNormal];
        [_addButton setTitleColor:[UIColor colorWithHexStringToColor:@"878ff5"] forState:UIControlStateNormal];
        [_addButton setTitleColor:kTextDarkBlueColor forState:UIControlStateDisabled];
        _addButton.titleLabel.font = [UIFont boldSystemFontOfSize:ScaleW(15)];
        _addButton.layer.cornerRadius = ScaleW(18);
        _addButton.layer.masksToBounds = YES;
        _addButton.layer.borderColor = [UIColor colorWithHexStringToColor:@"878ff5"].CGColor;
        _addButton.layer.borderWidth = 1;
        [_addButton addTarget:self action:@selector(addBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addButton;
}


- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = kLineGrayColor;
    }
    return _lineView;
}

- (JB_PledgeRecordItemView *)typeItemView {
    if (!_typeItemView) {
        _typeItemView = [[JB_PledgeRecordItemView alloc]init];
        _typeItemView.titleLB.text = SSKJLocalized(@"类型", nil);
        _typeItemView.subTitleLB.text = SSKJLocalized(@"借款", nil);
        _typeItemView.subTitleLB.textColor = [UIColor colorWithHexStringToColor:@"5ea2f4"];
        _typeItemView.subTitleLB.font = [UIFont boldSystemFontOfSize:ScaleW(13)];
    }
    return _typeItemView;
}
- (JB_PledgeRecordItemView *)dybzjItemView {
    if (!_dybzjItemView) {
        _dybzjItemView = [[JB_PledgeRecordItemView alloc]init];
        _dybzjItemView.titleLB.text = SSKJLocalized(@"抵押保证金", nil);
        _dybzjItemView.subTitleLB.text = @"0.00BTC";
    }
    return _dybzjItemView;
}

- (JB_PledgeRecordItemView *)lvItemView {
    if (!_lvItemView) {
        _lvItemView = [[JB_PledgeRecordItemView alloc]init];
        _lvItemView.titleLB.text = SSKJLocalized(@"利率", nil);
        _lvItemView.subTitleLB.text = @"10%";
    }
    return _lvItemView;
}

- (JB_PledgeRecordItemView *)dqrqItemView {
    if (!_dqrqItemView) {
        _dqrqItemView = [[JB_PledgeRecordItemView alloc]init];
        _dqrqItemView.titleLB.text = SSKJLocalized(@"到期时间", nil);
        _dqrqItemView.subTitleLB.text = @"2019-10-20";
    }
    return _dqrqItemView;
}

- (JB_PledgeRecordItemView *)fxztItemView {
    if (!_fxztItemView) {
        _fxztItemView = [[JB_PledgeRecordItemView alloc]init];
        _fxztItemView.titleLB.text = SSKJLocalized(@"风险/状态", nil);
        _fxztItemView.subTitleLB.text = @"高/计息中";
    }
    return _fxztItemView;
}

- (JB_PledgeRecordItemView *)jrjeItemView {
    if (!_jrjeItemView) {
        _jrjeItemView = [[JB_PledgeRecordItemView alloc]init];
        _jrjeItemView.titleLB.text = SSKJLocalized(@"借入金额", nil);
        _jrjeItemView.subTitleLB.text = @"0.00 CQTF";
    }
    return _jrjeItemView;
}

- (JB_PledgeRecordItemView *)ycslxItemView {
    if (!_ycslxItemView) {
        _ycslxItemView = [[JB_PledgeRecordItemView alloc]init];
        _ycslxItemView.titleLB.text = SSKJLocalized(@"已产生利息", nil);
        _ycslxItemView.subTitleLB.text = @"0.00 BTC";
    }
    return _ycslxItemView;
}
- (JB_PledgeRecordItemView *)zqItemView {
    if (!_zqItemView) {
        _zqItemView = [[JB_PledgeRecordItemView alloc]init];
        _zqItemView.titleLB.text = SSKJLocalized(@"周期", nil);
        _zqItemView.subTitleLB.text = @"30天/按天";
    }
    return _zqItemView;
}

- (JB_PledgeRecordItemView *)sjshrqItemView {
    if (!_sjshrqItemView) {
        _sjshrqItemView = [[JB_PledgeRecordItemView alloc]init];
        _sjshrqItemView.titleLB.text = SSKJLocalized(@"实际赎回日期", nil);
        _sjshrqItemView.subTitleLB.text = @"";
        _sjshrqItemView.hidden = YES;
        _sjshrqItemView.subTitleLB.adjustsFontSizeToFitWidth = NO;
        [_sjshrqItemView updateSubTitle];
    }
    return _sjshrqItemView;
}

@end
