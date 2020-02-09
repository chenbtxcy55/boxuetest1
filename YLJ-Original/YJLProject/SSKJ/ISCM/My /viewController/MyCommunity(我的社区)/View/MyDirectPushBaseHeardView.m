//
//  MyDirectPushBaseHeardView.m
//  SSKJ
//
//  Created by zhao on 2019/10/8.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "MyDirectPushBaseHeardView.h"
@interface MyDirectPushBaseHeardView()
@property (nonatomic,strong)UIView *titleView;//

@property (nonatomic,strong)UIView *lineView;//

@end

@implementation MyDirectPushBaseHeardView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = kNavBGColor;
        [self createView];
//        [self layoutChildViews];
    }
    return self;
}
-(UIView *)titleView{
    if (!_titleView) {
        _titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleW(40))];
        _titleView.backgroundColor = kNavBGColor;
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
-(UILabel *)oneLab
{
    if (!_oneLab) {
        _oneLab = [WLTools allocLabel:SSKJLocalized(@"UID", nil) font:systemFont(ScaleW(14)) textColor:TextGraycecece frame:CGRectMake(0, 0, ScaleW(120), ScaleW(14)) textAlignment:(NSTextAlignmentCenter)];
        
    }
    return _oneLab;
}
-(UILabel *)twoLab
{
    if (!_twoLab) {
        _twoLab = [WLTools allocLabel:SSKJLocalized(@"级别", nil) font:systemFont(ScaleW(14)) textColor:TextGraycecece frame:CGRectMake(0, 0, ScaleW(120), ScaleW(14)) textAlignment:(NSTextAlignmentCenter)];
        _twoLab.adjustsFontSizeToFitWidth = YES;
        
    }
    return _twoLab;
}
-(UILabel *)threeLab
{
    if (!_threeLab) {
        _threeLab = [WLTools allocLabel:SSKJLocalized(@"层级", nil) font:systemFont(ScaleW(14)) textColor:TextGraycecece frame:CGRectMake(0, 0, ScaleW(120), ScaleW(14)) textAlignment:(NSTextAlignmentCenter)];
        _threeLab.adjustsFontSizeToFitWidth = YES;
        
    }
    return _threeLab;
}
-(UILabel *)fourLab
{
    if (!_fourLab) {
        _fourLab = [WLTools allocLabel:SSKJLocalized(@"时间", nil) font:systemFont(ScaleW(14)) textColor:TextGraycecece frame:CGRectMake(0, 0, ScaleW(120), ScaleW(14)) textAlignment:(NSTextAlignmentCenter)];
        _fourLab.adjustsFontSizeToFitWidth = YES;
        
    }
    return _fourLab;
}
- (void)createView {
    [self addSubview:self.titleView];
    [self.titleView addSubview:self.lineView];

    self.oneLab.numberOfLines = 1;
    self.twoLab.numberOfLines = 1;
    self.threeLab.numberOfLines = 1;
    self.fourLab.numberOfLines = 1;
    [self.titleView addSubview:self.oneLab];
    [self.titleView addSubview:self.twoLab];
    [self.titleView addSubview:self.threeLab];
    [self.titleView addSubview:self.fourLab];
    [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.bottom.equalTo(self.titleView);
        make.height.equalTo(@(ScaleW(1)));
    }];
}
- (void)layoutChildViews {
    
    [self.oneLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_left).offset(ScaleW(48));
        make.centerY.equalTo(self.titleView.mas_centerY);
    }];
    [self.twoLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_left).offset(ScaleW(145));
        make.centerY.equalTo(self.titleView.mas_centerY);
        make.width.equalTo(@(ScaleW(74)));
    }];
    [self.threeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_left).offset(ScaleW(225));
        make.centerY.equalTo(self.titleView.mas_centerY);
        make.width.equalTo(@(ScaleW(74)));
    }];
    [self.fourLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_left).offset(ScaleW(313));
        make.centerY.equalTo(self.titleView.mas_centerY);
        make.width.equalTo(@(ScaleW(95)));
    }];
}
#pragma mark - 锁仓
//锁仓
- (void)layoutSuoCang{
    
    self.threeLab.hidden = YES;
     self.fourLab.hidden = YES;
    self.oneLab.text = SSKJLocalized(@"释放数量(YEC)", nil);
    self.twoLab.text = SSKJLocalized(@"释放时间", nil);
    [self.oneLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX).offset(-Screen_Width/4);
        make.centerY.equalTo(self.titleView.mas_centerY);
      make.width.equalTo(@(Screen_Width/2 - ScaleW(15)));
    }];
    [self.twoLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX).offset(Screen_Width/4);
        make.centerY.equalTo(self.titleView.mas_centerY);
        make.width.equalTo(@(Screen_Width/2 - ScaleW(15)));
    }];
}
#pragma mark - 加权分红

//加权分红
- (void)layoutFenHong{
    
     self.fourLab.hidden = YES;
    self.oneLab.text = SSKJLocalized(@"当月业绩(USDT)", nil);
    self.twoLab.text = SSKJLocalized(@"奖励数量(YEC)", nil);
    self.threeLab.text = SSKJLocalized(@"日期", nil);

    [self.oneLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX).offset(-Screen_Width/3);
        make.centerY.equalTo(self.titleView.mas_centerY);
        make.width.equalTo(@(Screen_Width/3 - ScaleW(15)));
    }];
    [self.twoLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.centerY.equalTo(self.titleView.mas_centerY);
        make.width.equalTo(@(Screen_Width/3 - ScaleW(15)));
    }];
    [self.threeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX).offset(Screen_Width/3);
        make.centerY.equalTo(self.titleView.mas_centerY);
        make.width.equalTo(@(Screen_Width/3 - ScaleW(15)));
    }];
}
#pragma mark -服务费

- (void)layoutFuWuFei{
    self.oneLab.text = SSKJLocalized(@"UID", nil);
    self.twoLab.text = SSKJLocalized(@"报价额(USDT)", nil);
    self.threeLab.text = SSKJLocalized(@"奖励数量(YEC)", nil);
    
    self.fourLab.text = SSKJLocalized(@"时间", nil);

    [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.bottom.equalTo(self.titleView);
        make.height.equalTo(@(ScaleW(1)));
    }];
    [self.oneLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_left).offset(ScaleW(48));
        make.centerY.equalTo(self.titleView.mas_centerY);
    }];
    [self.twoLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_left).offset(ScaleW(145));
        make.centerY.equalTo(self.titleView.mas_centerY);
        make.width.equalTo(@(ScaleW(78)));
    }];
    [self.threeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_left).offset(ScaleW(225));
        make.centerY.equalTo(self.titleView.mas_centerY);
        make.width.equalTo(@(ScaleW(78)));
    }];
    [self.fourLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_left).offset(ScaleW(313));
        make.centerY.equalTo(self.titleView.mas_centerY);
        make.width.equalTo(@(ScaleW(95)));
    }];
}

#pragma mark - 商城余额
- (void)layoutYuE{
    
        
        self.oneLab.text = SSKJLocalized(@"来源", nil);
        self.twoLab.text = SSKJLocalized(@"数量", nil);
        self.threeLab.text = SSKJLocalized(@"余额", nil);
        self.fourLab.text = SSKJLocalized(@"时间", nil);


//        [self.oneLab mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerX.mas_equalTo(self.mas_left).offset(44);
//            make.centerY.equalTo(self.titleView.mas_centerY);
//            make.width.equalTo(@(ScaleW(50)));
//        }];
//        [self.twoLab mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerX.mas_equalTo(self.mas_left).offset(144);
//            make.centerY.equalTo(self.titleView.mas_centerY);
//            make.width.equalTo(@(ScaleW(100)));
//        }];
//        [self.threeLab mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerX.mas_equalTo(self.mas_left).offset(298);
//            make.centerY.equalTo(self.titleView.mas_centerY);
//            make.width.equalTo(@(ScaleW(100)));
//        }];
    [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.bottom.equalTo(self.titleView);
        make.height.equalTo(@(ScaleW(1)));
    }];
    [self.oneLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_left).offset(ScaleW(48));
        make.centerY.equalTo(self.titleView.mas_centerY);
    }];
    [self.twoLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_left).offset(ScaleW(145));
        make.centerY.equalTo(self.titleView.mas_centerY);
        make.width.equalTo(@(ScaleW(78)));
    }];
    [self.threeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_left).offset(ScaleW(225));
        make.centerY.equalTo(self.titleView.mas_centerY);
        make.width.equalTo(@(ScaleW(78)));
    }];
    [self.fourLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_left).offset(ScaleW(313));
        make.centerY.equalTo(self.titleView.mas_centerY);
        make.width.equalTo(@(ScaleW(95)));
    }];
}
    


@end
