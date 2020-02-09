//
//  MyTeamHeardView.m
//  SSKJ
//
//  Created by zhao on 2019/10/8.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "MyTeamHeardView.h"

@interface MyTeamHeardView()
@property (nonatomic,strong)UIView *topView;//
@property (nonatomic,strong)UIImageView *bgView;//
@property (nonatomic,strong)UIView *titleView;//
@property (nonatomic,strong)UIView *lineView;//

@property (nonatomic,strong)UILabel *leftBottomLab;//新增
@property (nonatomic,strong)UILabel *rightBottomLab;//团队人数

@property (nonatomic,strong)UILabel *oneLab;//UID
@property (nonatomic,strong)UILabel *twoLab;//级别
@property (nonatomic,strong)UILabel *threeLab;//层级
@property (nonatomic,strong)UILabel *fourLab;//注册时间


@end

@implementation MyTeamHeardView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = kNavBGColor;
        [self createView];
        [self layoutChildViews];
    }
    return self;
}
-(UIView *)topView{
    if (!_topView) {
        _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleW(5))];
        _topView.backgroundColor = kMainColor;
    }
    return _topView;
}
-(UIImageView *)bgView{
    if (!_bgView) {
        _bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, _topView.bottom, ScreenWidth, ScaleW(100))];
        _bgView.image = [UIImage imageNamed:@"my_team_heard"];
    }
    return _bgView;
}
-(UIView *)titleView{
    if (!_titleView) {
        _titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleW(60))];
        _titleView.backgroundColor = kMainWihteColor;
    }
    return _titleView;
}

-(UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, _titleView.height - ScaleW(1) , ScreenWidth, ScaleW(1))];
        _lineView.backgroundColor = kLineBgColor;
    }
    return _lineView;
}
-(UILabel *)leftBottomLab
{
    if (!_leftBottomLab) {
        _leftBottomLab = [WLTools allocLabel:SSKJLocalized(@"今日新增(USDT)", nil) font:systemFont(ScaleW(14)) textColor:kMainTextColor frame:CGRectMake(0, 0, ScaleW(120), ScaleW(14)) textAlignment:(NSTextAlignmentCenter)];
    }
    return _leftBottomLab;
}
-(UILabel *)leftLab
{
    if (!_leftLab) {
        _leftLab = [WLTools allocLabel:@"" font:systemFont(ScaleW(18)) textColor:kMainTextColor frame:CGRectMake(0, 0, ScaleW(120), ScaleW(14)) textAlignment:(NSTextAlignmentCenter)];
        _leftLab.adjustsFontSizeToFitWidth = YES;
    }
    return _leftLab;
}
-(UILabel *)rightBottomLab
{
    if (!_rightBottomLab) {
        _rightBottomLab = [WLTools allocLabel:SSKJLocalized(@"团队人数(人)", nil) font:systemFont(ScaleW(14)) textColor:kMainTextColor frame:CGRectMake(0, 0, ScaleW(120), ScaleW(14)) textAlignment:(NSTextAlignmentCenter)];
    }
    return _rightBottomLab;
}
-(UILabel *)rightLab
{
    if (!_rightLab) {
        _rightLab = [WLTools allocLabel:@"" font:systemFont(ScaleW(15)) textColor:kMainTextColor frame:CGRectMake(0, 0, ScaleW(120), ScaleW(14)) textAlignment:(NSTextAlignmentCenter)];
        _rightLab.adjustsFontSizeToFitWidth = YES;

    }
    return _rightLab;
}

-(UILabel *)oneLab
{
    if (!_oneLab) {
        _oneLab = [WLTools allocLabel:SSKJLocalized(@"用户名", nil) font:systemFont(ScaleW(15)) textColor:kTextGrayColor333333 frame:CGRectMake(ScaleW(10), 0, ScaleW(120), ScaleW(15)) textAlignment:(NSTextAlignmentCenter)];
        
    }
    return _oneLab;
}
-(UILabel *)twoLab
{
    if (!_twoLab) {
        _twoLab = [WLTools allocLabel:SSKJLocalized(@"用户级别", nil) font:systemFont(ScaleW(15)) textColor:kTextGrayColor333333 frame:CGRectMake(0, 0, ScaleW(120), ScaleW(15)) textAlignment:(NSTextAlignmentCenter)];
        _twoLab.adjustsFontSizeToFitWidth = YES;

    }
    return _twoLab;
}
-(UILabel *)threeLab
{
    if (!_threeLab) {
        _threeLab = [WLTools allocLabel:SSKJLocalized(@"注册时间", nil) font:systemFont(ScaleW(15)) textColor:kTextGrayColor333333 frame:CGRectMake(0, 0, ScaleW(120), ScaleW(15)) textAlignment:(NSTextAlignmentCenter)];
        _threeLab.adjustsFontSizeToFitWidth = YES;

    }
    return _threeLab;
}
-(UILabel *)fourLab
{
    if (!_fourLab) {
        _fourLab = [WLTools allocLabel:SSKJLocalized(@"状态", nil) font:systemFont(ScaleW(15)) textColor:kTextGrayColor333333 frame:CGRectMake(0, 0, ScaleW(120), ScaleW(15)) textAlignment:(NSTextAlignmentCenter)];
        _fourLab.adjustsFontSizeToFitWidth = YES;
        
    }
    return _fourLab;
}
- (void)createView {
//    [self addSubview:self.topView];
//    [self addSubview:self.bgView];
//    [self.bgView addSubview:self.leftLab];
//    [self.bgView addSubview:self.leftBottomLab];
//    [self.bgView addSubview:self.rightLab];
//    [self.bgView addSubview:self.rightBottomLab];
    
    [self addSubview:self.titleView];
    [self.titleView addSubview:self.lineView];
    
    
    [self.titleView addSubview:self.oneLab];
    [self.titleView addSubview:self.twoLab];
    [self.titleView addSubview:self.threeLab];
    [self.titleView addSubview:self.fourLab];

}

- (void)layoutChildViews {
//    [self.leftBottomLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.bgView.mas_top).offset(ScaleW(62));
//        make.centerX.equalTo(self.bgView.mas_centerX).offset(-ScaleW(74));
//        make.width.equalTo(@(ScaleW(120)));
//
//    }];
//    [self.leftLab mas_makeConstraints:^(MASConstraintMaker *make) {
//     make.top.equalTo(self.bgView.mas_top).offset(ScaleW(32));
//        make.centerX.equalTo(self.leftBottomLab.mas_centerX);
//        make.width.equalTo(@(ScaleW(120)));
//
//    }];
//    [self.rightBottomLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.bgView.mas_top).offset(ScaleW(62));
//        make.centerX.equalTo(self.bgView.mas_centerX).offset(ScaleW(74));
//        make.width.equalTo(@(ScaleW(120)));
//
//    }];
//    [self.rightLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.bgView.mas_top).offset(ScaleW(32));
//        make.centerX.equalTo(self.rightBottomLab.mas_centerX);
//        make.width.equalTo(@(ScaleW(120)));
//
//    }];
    [self.oneLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_left).offset(ScreenWidth/8);
        make.centerY.equalTo(self.titleView.mas_centerY);
        make.width.equalTo(@(ScreenWidth/4 - ScaleW(10) ));
    }];
    [self.twoLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_left).offset(ScreenWidth/8 * 3);
        make.centerY.equalTo(self.titleView.mas_centerY);
        make.width.equalTo(@(ScreenWidth/4 - ScaleW(10) ));
    }];
    [self.threeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_left).offset(ScreenWidth/8 * 5);
        make.centerY.equalTo(self.titleView.mas_centerY);
        make.width.equalTo(@(ScreenWidth/4 - ScaleW(10) ));
    }];
    [self.fourLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_left).offset(ScreenWidth/8 * 7);
        make.centerY.equalTo(self.titleView.mas_centerY);
        make.width.equalTo(@(ScreenWidth/4 - ScaleW(10) ));
    }];
}

@end
