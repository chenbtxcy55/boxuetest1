//
//  MyIncomeBaseCell.m
//  SSKJ
//
//  Created by zhao on 2019/10/8.
//  Copyright © 2019 刘小雨. All rights reserved.
//
/*
 动态权益 cell
 */
#import "MyIncomeBaseCell.h"
@interface MyIncomeBaseCell()

@property (nonatomic,strong)UIView *lineView;//

@end
@implementation MyIncomeBaseCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = kNavBGColor;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self createUI];
    }
    return self;
}
- (void)createUI{
    [self.contentView addSubview:self.oneLab];
    [self.contentView addSubview:self.twoLab];
    [self.contentView addSubview:self.threeLab];
    [self.contentView addSubview:self.fourLab];
    [self.contentView addSubview:self.lineView];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(ScaleW(15));
        make.right.equalTo(self.contentView.mas_right).offset(ScaleW(-15));
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.height.equalTo(@(ScaleW(1)));
    }];
}
-(UILabel *)oneLab
{
    if (!_oneLab) {
        _oneLab = [WLTools allocLabel:SSKJLocalized(@"", nil) font:systemFont(ScaleW(14)) textColor:TextGraycecece frame:CGRectMake(0, 0, ScaleW(120), ScaleW(14)) textAlignment:(NSTextAlignmentCenter)];
        
    }
    return _oneLab;
}
-(UILabel *)twoLab
{
    if (!_twoLab) {
        _twoLab = [WLTools allocLabel:SSKJLocalized(@"", nil) font:systemFont(ScaleW(14)) textColor:TextGraycecece frame:CGRectMake(0, 0, ScaleW(120), ScaleW(14)) textAlignment:(NSTextAlignmentCenter)];
        _twoLab.adjustsFontSizeToFitWidth = YES;
        
    }
    return _twoLab;
}
-(UILabel *)threeLab
{
    if (!_threeLab) {
        _threeLab = [WLTools allocLabel:SSKJLocalized(@"", nil) font:systemFont(ScaleW(14)) textColor:TextGraycecece frame:CGRectMake(0, 0, ScaleW(120), ScaleW(14)) textAlignment:(NSTextAlignmentCenter)];
        _threeLab.adjustsFontSizeToFitWidth = YES;
        
    }
    return _threeLab;
}
-(UILabel *)fourLab
{
    if (!_fourLab) {
        _fourLab = [WLTools allocLabel:SSKJLocalized(@"", nil) font:systemFont(ScaleW(14)) textColor:TextGraycecece frame:CGRectMake(0, 0, ScaleW(120), ScaleW(14)) textAlignment:(NSTextAlignmentCenter)];
        _fourLab.adjustsFontSizeToFitWidth = YES;
        
    }
    return _fourLab;
}
-(UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, ScaleW(47) - ScaleW(1) , ScreenWidth, ScaleW(1))];
        _lineView.backgroundColor = kLineBgColor;
    }
    return _lineView;
}
#pragma mark - 分享奖励  4个lable

- (void)layoutChildViews {
    [self.oneLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_left).offset(ScaleW(48));
        make.centerY.equalTo(self.contentView.mas_centerY);
    }];
    [self.twoLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_left).offset(ScaleW(114));
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.width.equalTo(@(ScaleW(45)));
    }];
    [self.threeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_left).offset(ScaleW(202));
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.width.equalTo(@(ScaleW(105)));
    }];
    [self.fourLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_left).offset(ScaleW(325));
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.width.equalTo(@(ScaleW(105)));
    }];
    
}

#pragma mark - 锁仓
//锁仓
- (void)layoutSuoCang{
    
    self.threeLab.hidden = YES;
    self.fourLab.hidden = YES;
    [self.oneLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX).offset(-Screen_Width/4);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.width.equalTo(@(Screen_Width/2 - ScaleW(15)));
    }];
    [self.twoLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX).offset(Screen_Width/4);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.width.equalTo(@(Screen_Width/2 - ScaleW(15)));
    }];
}
#pragma mark - 加权分红

//加权分红
- (void)layoutFenHong{
    self.fourLab.hidden = YES;
    [self.oneLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX).offset(-Screen_Width/3);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.width.equalTo(@(Screen_Width/3 - ScaleW(15)));
    }];
    [self.twoLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.width.equalTo(@(Screen_Width/3 - ScaleW(15)));
    }];
    [self.threeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX).offset(Screen_Width/3);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.width.equalTo(@(Screen_Width/3 - ScaleW(15)));
    }];
}
#pragma mark -服务费

- (void)layoutFuWuFei{
    [self.oneLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_left).offset(ScaleW(48));
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.width.equalTo(@(ScaleW(95)));
        
    }];
    [self.twoLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_left).offset(ScaleW(145));
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.width.equalTo(@(ScaleW(90)));
    }];
    [self.threeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_left).offset(ScaleW(225));
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.width.equalTo(@(ScaleW(45)));
    }];
    [self.fourLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_left).offset(ScaleW(313));
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.width.equalTo(@(ScaleW(100)));
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(ScaleW(15));
        make.right.equalTo(self.contentView.mas_right).offset(ScaleW(-15));
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.height.equalTo(@(ScaleW(1)));
    }];
}
- (void)layoutYuE{
    
    
    self.fourLab.hidden = YES;
    
    [self.oneLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_left).offset(44);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.width.equalTo(@(ScaleW(50)));
    }];
    [self.twoLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_left).offset(144);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.width.equalTo(@(ScaleW(100)));
    }];
    [self.threeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_left).offset(298);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.width.equalTo(@(ScaleW(100)));
    }];
    
}
@end
