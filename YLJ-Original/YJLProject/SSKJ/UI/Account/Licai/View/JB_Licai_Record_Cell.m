//
//  JB_Licai_Record_Cell.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/5/16.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "JB_Licai_Record_Cell.h"
#import "JB_PledgeRecordItemView.h"

@interface JB_Licai_Record_Cell ()
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UILabel *timeLB;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIButton *cancleButton;

@property (nonatomic, strong) JB_PledgeRecordItemView *typeItemView;        // 类别
@property (nonatomic, strong) JB_PledgeRecordItemView *amountItemView;  // 数额
@property (nonatomic, strong) JB_PledgeRecordItemView *fdqxItemView;        // 房贷期限
@property (nonatomic, strong) JB_PledgeRecordItemView *autoFdItemView;  // 是否自动放贷
@property (nonatomic, strong) JB_PledgeRecordItemView *stautsItemView;  // 转态
@property (nonatomic, strong) JB_PledgeRecordItemView *lvItemView;      // 利率
@property (nonatomic, strong) JB_PledgeRecordItemView *progressItemView;    // 进度
@property (nonatomic, strong) JB_PledgeRecordItemView *incomeItemView;  // 预期收益

@property (nonatomic, strong) JB_Account_Licai_Record_Index_Model *recordModel;



@end

@implementation JB_Licai_Record_Cell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = kMainBackgroundColor;
        [self addSubview:self.bgView];
        [self.bgView addSubview:self.timeLB];
        [self.bgView addSubview:self.lineView];
        [self.bgView addSubview:self.cancleButton];
        [self.bgView addSubview:self.typeItemView];
        [self.bgView addSubview:self.amountItemView];
        [self.bgView addSubview:self.fdqxItemView];
        [self.bgView addSubview:self.autoFdItemView];
        [self.bgView addSubview:self.stautsItemView];
        [self.bgView addSubview:self.lvItemView];
        [self.bgView addSubview:self.progressItemView];
        [self.bgView addSubview:self.incomeItemView];
        
        
        [self setupMasnory];
    }
    return self;
}



-(void)setCellWihtModel:(JB_Account_Licai_Record_Index_Model *)recordModel
{
    self.recordModel = recordModel;
    self.typeItemView.subTitleLB.text = recordModel.pname;
    
    NSString *status;
    if (recordModel.status.integerValue == 1) {
        status = SSKJLocalized(@"理财中", nil);
        self.cancleButton.hidden = NO;
    }else{
        status = SSKJLocalized(@"已赎回", nil);
        self.cancleButton.hidden = YES;
    }
    
    
    self.stautsItemView.subTitleLB.text = status;
    
    self.amountItemView.subTitleLB.text = [NSString stringWithFormat:@"%@%@",[WLTools noroundingStringWith:recordModel.num.doubleValue afterPointNumber:4],recordModel.pname];
    
    self.lvItemView.subTitleLB.text = [NSString stringWithFormat:@"%@%%",recordModel.interest_rate];
    
    self.fdqxItemView.subTitleLB.text = [NSString stringWithFormat:@"%@%@",recordModel.days,SSKJLocalized(@"天", nil)];
    self.progressItemView.subTitleLB.text = [NSString stringWithFormat:@"%@%@",recordModel.dayth,SSKJLocalized(@"天", nil)];
    self.autoFdItemView.subTitleLB.text = recordModel.is_auto.integerValue == 1 ? SSKJLocalized(@"是", nil):SSKJLocalized(@"否", nil);
    
    self.incomeItemView.subTitleLB.text = [NSString stringWithFormat:@"%@%@",recordModel.income,recordModel.pname];
    self.timeLB.text = [WLTools convertTimestamp:recordModel.addtime.doubleValue andFormat:@"yyyy-MM-dd HH:mm:ss"];
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
    [self.cancleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.bgView).offset(-ScaleW(17));
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
    [self.amountItemView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView).offset(ScaleW(15));
        make.top.equalTo(self.typeItemView.mas_bottom).offset(ScaleW(18));
    }];
    [self.fdqxItemView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView).offset(ScaleW(15));
        make.top.equalTo(self.amountItemView.mas_bottom).offset(ScaleW(18));
    }];
    [self.autoFdItemView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView).offset(ScaleW(15));
        make.top.equalTo(self.fdqxItemView.mas_bottom).offset(ScaleW(18));
        
    }];
    
    [self.stautsItemView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView).offset(ScreenWidth/2);
        make.top.equalTo(self.lineView.mas_bottom).offset(ScaleW(18));
    }];
    [self.lvItemView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView).offset(ScreenWidth/2);
        make.top.equalTo(self.stautsItemView.mas_bottom).offset(ScaleW(18));
    }];
    [self.progressItemView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView).offset(ScreenWidth/2);
        make.top.equalTo(self.lvItemView.mas_bottom).offset(ScaleW(18));
    }];
    [self.incomeItemView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView).offset(ScreenWidth/2);
        make.top.equalTo(self.progressItemView.mas_bottom).offset(ScaleW(18));
        make.bottom.equalTo(self.bgView).offset(-ScaleW(30));
//        make.bottom.lessThanOrEqualTo(self.bgView).offset(-ScaleW(30));

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

- (UIButton *)cancleButton {
    if (!_cancleButton) {
        _cancleButton = [[UIButton alloc]init];
        [_cancleButton setTitle:SSKJLocalized(@"赎回", nil) forState:UIControlStateNormal];
        [_cancleButton setTitleColor:[UIColor colorWithHexStringToColor:@"878ff5"] forState:UIControlStateNormal];
        _cancleButton.titleLabel.font = [UIFont boldSystemFontOfSize:ScaleW(15)];
        _cancleButton.layer.cornerRadius = ScaleW(18);
        _cancleButton.layer.masksToBounds = YES;
        _cancleButton.layer.borderColor = [UIColor colorWithHexStringToColor:@"878ff5"].CGColor;
        _cancleButton.layer.borderWidth = 1;
        [_cancleButton addTarget:self action:@selector(cancleEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancleButton;
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
        _typeItemView.titleLB.text = SSKJLocalized(@"类别", nil);
        _typeItemView.subTitleLB.text = @"BTC/ETH";
        _typeItemView.subTitleLB.textColor = kTextDarkBlueColor;
        _typeItemView.subTitleLB.font = [UIFont boldSystemFontOfSize:ScaleW(13)];
    }
    return _typeItemView;
}
- (JB_PledgeRecordItemView *)amountItemView {
    if (!_amountItemView) {
        _amountItemView = [[JB_PledgeRecordItemView alloc]init];
        _amountItemView.titleLB.text = SSKJLocalized(@"数额", nil);
        _amountItemView.subTitleLB.text = @"0.00BTC";
    }
    return _amountItemView;
}

- (JB_PledgeRecordItemView *)fdqxItemView {
    if (!_fdqxItemView) {
        _fdqxItemView = [[JB_PledgeRecordItemView alloc]init];
        _fdqxItemView.titleLB.text = SSKJLocalized(@"放贷期限", nil);
        _fdqxItemView.subTitleLB.text = @"10天";
    }
    return _fdqxItemView;
}

- (JB_PledgeRecordItemView *)autoFdItemView {
    if (!_autoFdItemView) {
        _autoFdItemView = [[JB_PledgeRecordItemView alloc]init];
        _autoFdItemView.titleLB.text = SSKJLocalized(@"是否自动放贷", nil);
        _autoFdItemView.subTitleLB.text = @"是";
    }
    return _autoFdItemView;
}

- (JB_PledgeRecordItemView *)stautsItemView {
    if (!_stautsItemView) {
        _stautsItemView = [[JB_PledgeRecordItemView alloc]init];
        _stautsItemView.titleLB.text = SSKJLocalized(@"状态", nil);
        _stautsItemView.subTitleLB.text = @"理财中";
        _stautsItemView.subTitleLB.textColor = [UIColor colorWithHexStringToColor:@"5ea2f4"];
    }
    return _stautsItemView;
}

- (JB_PledgeRecordItemView *)lvItemView {
    if (!_lvItemView) {
        _lvItemView = [[JB_PledgeRecordItemView alloc]init];
        _lvItemView.titleLB.text = SSKJLocalized(@"利率", nil);
        _lvItemView.subTitleLB.text = @"10%";
    }
    return _lvItemView;
}

- (JB_PledgeRecordItemView *)progressItemView {
    if (!_progressItemView) {
        _progressItemView = [[JB_PledgeRecordItemView alloc]init];
        _progressItemView.titleLB.text = SSKJLocalized(@"进度", nil);
        _progressItemView.subTitleLB.text = @"15天";
    }
    return _progressItemView;
}
- (JB_PledgeRecordItemView *)incomeItemView {
    if (!_incomeItemView) {
        _incomeItemView = [[JB_PledgeRecordItemView alloc]init];
        _incomeItemView.titleLB.text = SSKJLocalized(@"预期收益", nil);
        _incomeItemView.subTitleLB.text = @"30ETH";
    }
    return _incomeItemView;
}


-(void)cancleEvent
{
    if (self.cancleBlock) {
        self.cancleBlock(self.recordModel);
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
