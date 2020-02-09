//
//  My_Generalize_View.m
//  ZYW_MIT
//
//  Created by 刘小雨 on 2019/3/29.
//  Copyright © 2019年 Wang. All rights reserved.
//

#import "My_Generalize_View.h"

@interface My_Generalize_View ()

@property (nonatomic, strong) UIImageView *headerImageView;

@property (nonatomic, strong) UILabel *kehuTitleLabel;
@property (nonatomic, strong) UILabel *kehuNumberLabel;

//@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) UILabel *todayIncomeTitleLabel;
@property (nonatomic, strong) UILabel *todayIncomeLabel;

@property (nonatomic, strong) UILabel *totalIncomeTitleLabel;
@property (nonatomic, strong) UILabel *totalIncomeLabel;

@end

@implementation My_Generalize_View

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor = kSubBackgroundColor;
        [self setUI];
    }
    return self;
}

-(void)setUI
{
    [self addSubview:self.headerImageView];
    [self addSubview:self.kehuTitleLabel];
    [self addSubview:self.kehuNumberLabel];
    
    [self addSubview:self.todayIncomeTitleLabel];
    [self addSubview:self.todayIncomeLabel];
    
    [self addSubview:self.totalIncomeTitleLabel];
    [self addSubview:self.totalIncomeLabel];
    
    self.height = self.totalIncomeTitleLabel.bottom + ScaleW(18);
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, self.totalIncomeTitleLabel.bottom+ScaleW(8), ScreenWidth, ScaleW(10))];
    line.backgroundColor = kMainBackgroundColor;
    [self addSubview:line];
}


-(UIImageView *)headerImageView
{
    if (nil == _headerImageView) {
        _headerImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleW(150))];
        _headerImageView.image = [UIImage imageNamed:SSKJLocalized(@"tuiguang_header", nil)];
    }
    return _headerImageView;
}

-(UILabel *)kehuNumberLabel
{
    if (nil == _kehuNumberLabel) {
        _kehuNumberLabel = [WLTools allocLabel:SSKJLocalized(@"4", nil) font:systemBoldFont(ScaleW(15)) textColor:kMainWihteColor frame:CGRectMake(0, self.headerImageView.bottom + ScaleW(20), self.width / 3, ScaleW(15)) textAlignment:NSTextAlignmentCenter];
    }
    return _kehuNumberLabel;
}

-(UILabel *)kehuTitleLabel
{
    if (nil == _kehuTitleLabel) {
        _kehuTitleLabel = [WLTools allocLabel:SSKJLocalized(@"累计开户", nil) font:systemFont(ScaleW(13)) textColor:kTextLightBlueColor frame:CGRectMake(0, self.kehuNumberLabel.bottom + ScaleW(15), self.kehuNumberLabel.width, ScaleW(13)) textAlignment:NSTextAlignmentCenter];
    }
    return _kehuTitleLabel;
}

-(UILabel *)todayIncomeLabel
{
    if (nil == _todayIncomeLabel) {
        _todayIncomeLabel = [WLTools allocLabel:SSKJLocalized(@"0", nil) font:systemBoldFont(ScaleW(15)) textColor:kMainWihteColor frame:CGRectMake(self.kehuNumberLabel.right, self.kehuNumberLabel.y, self.width / 3, ScaleW(15)) textAlignment:NSTextAlignmentCenter];
    }
    return _todayIncomeLabel;
}

-(UILabel *)todayIncomeTitleLabel
{
    if (nil == _todayIncomeTitleLabel) {
        _todayIncomeTitleLabel = [WLTools allocLabel:SSKJLocalized(@"今日收益", nil) font:systemFont(ScaleW(13)) textColor:kTextLightBlueColor frame:CGRectMake(self.todayIncomeLabel.x, self.kehuTitleLabel.y, self.kehuNumberLabel.width, ScaleW(13)) textAlignment:NSTextAlignmentCenter];
    }
    return _todayIncomeTitleLabel;
}


-(UILabel *)totalIncomeLabel
{
    if (nil == _totalIncomeLabel) {
        _totalIncomeLabel = [WLTools allocLabel:SSKJLocalized(@"0", nil) font:systemBoldFont(ScaleW(15)) textColor:kMainWihteColor frame:CGRectMake(self.todayIncomeLabel.right, self.kehuNumberLabel.y, self.width / 3, ScaleW(15)) textAlignment:NSTextAlignmentCenter];
    }
    return _totalIncomeLabel;
}

-(UILabel *)totalIncomeTitleLabel
{
    if (nil == _totalIncomeTitleLabel) {
        _totalIncomeTitleLabel = [WLTools allocLabel:SSKJLocalized(@"累计收益", nil) font:systemFont(ScaleW(13)) textColor:kTextLightBlueColor frame:CGRectMake(self.totalIncomeLabel.x, self.kehuTitleLabel.y, self.kehuNumberLabel.width, ScaleW(13)) textAlignment:NSTextAlignmentCenter];
    }
    return _totalIncomeTitleLabel;
}


-(void)setViewWithModel:(My_PromoteDetail_Model *)model
{
    self.kehuNumberLabel.text = model.count;
    
    self.todayIncomeLabel.text = [WLTools noroundingStringWith:model.today_sum.doubleValue afterPointNumber:2];
    
    self.totalIncomeLabel.text = [WLTools noroundingStringWith:model.total_sum.doubleValue afterPointNumber:2];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
