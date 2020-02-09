//
//  Mine_PromotionCell.m
//  SSKJ
//
//  Created by zhao on 2019/10/8.
//  Copyright © 2019 刘小雨. All rights reserved.
//
/*
 推广业绩cell
 */
#import "Mine_PromotionCell.h"
@interface Mine_PromotionCell()

@property (nonatomic,strong)UIView *lineView;//

@end

@implementation Mine_PromotionCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = kMainWihteColor;
        [self createUI];
    }
    return self;
}
- (void)createUI{
    [self.contentView addSubview:self.oneLab];
    [self.contentView addSubview:self.twoLab];
    [self.contentView addSubview:self.threeLab];
    [self.contentView addSubview:self.lineView];

    
    [self.oneLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(ScaleW(5));
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.width.equalTo(@(ScreenWidth/3 - ScaleW(10)));

    }];
    [self.twoLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(ScaleW(5) + ScreenWidth/3);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.width.equalTo(@(ScreenWidth/3 - ScaleW(10)));
    }];
    [self.threeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(ScaleW(5) + ScreenWidth/3 *2);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.width.equalTo(@(ScreenWidth/3 - ScaleW(10)));
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(ScaleW(0));
        make.right.equalTo(self.contentView.mas_right).offset(ScaleW(-0));
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.height.equalTo(@(ScaleW(1)));
    }];
}
-(UILabel *)oneLab
{
    if (!_oneLab) {
        _oneLab = [WLTools allocLabel:SSKJLocalized(@"", nil) font:systemFont(ScaleW(14)) textColor:kMainTextColor frame:CGRectMake(0, 0, ScaleW(120), ScaleW(14)) textAlignment:(NSTextAlignmentCenter)];
        
    }
    return _oneLab;
}
-(UILabel *)twoLab
{
    if (!_twoLab) {
        _twoLab = [WLTools allocLabel:SSKJLocalized(@"", nil) font:systemFont(ScaleW(14)) textColor:kMainTextColor frame:CGRectMake(0, 0, ScaleW(120), ScaleW(14)) textAlignment:(NSTextAlignmentCenter)];
        _twoLab.adjustsFontSizeToFitWidth = YES;
        
    }
    return _twoLab;
}
-(UILabel *)threeLab
{
    if (!_threeLab) {
        _threeLab = [WLTools allocLabel:SSKJLocalized(@"", nil) font:systemFont(ScaleW(14)) textColor:kMainTextColor frame:CGRectMake(0, 0, ScaleW(120), ScaleW(14)) textAlignment:(NSTextAlignmentCenter)];
        _threeLab.adjustsFontSizeToFitWidth = YES;
        
    }
    return _threeLab;
}
-(UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, ScaleW(47) - ScaleW(1) , ScreenWidth, ScaleW(1))];
        _lineView.backgroundColor = kLineBgColor;
    }
    return _lineView;
}
@end
