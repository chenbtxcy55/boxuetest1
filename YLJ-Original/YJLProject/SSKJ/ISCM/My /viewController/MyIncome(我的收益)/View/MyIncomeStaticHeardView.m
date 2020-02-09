//
//  MyIncomeStaticHeardView.m
//  SSKJ
//
//  Created by zhao on 2019/10/8.
//  Copyright © 2019 刘小雨. All rights reserved.
//
/*
 静态收益  头视图
 */
#import "MyIncomeStaticHeardView.h"
#import "MyDirectPushBaseHeardView.h"

@interface MyIncomeStaticHeardView ()
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic,strong) UIImageView *bgImageView;

@property (nonatomic,strong) MyDirectPushBaseHeardView *titleView;

@end
@implementation MyIncomeStaticHeardView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self createView];
        [self layoutChildViews];
    }
    return self;
}
- (UIImageView *)bgImageView{
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, ScaleW(5), Screen_Width, ScaleW(100))];
        _bgImageView.image = [UIImage imageNamed:@"my_team_heard"];
        
    }
    return _bgImageView;
}
- (MyDirectPushBaseHeardView *)titleView{
    if (!_titleView) {
        _titleView = [[MyDirectPushBaseHeardView alloc] initWithFrame:CGRectMake(0, _bgImageView.bottom, ScreenWidth, ScaleW(40))];
        [_titleView layoutFenHong];
        _titleView.oneLab.text = SSKJLocalized(@"释放类型", nil);
        _titleView.twoLab.text = SSKJLocalized(@"释放数量(YEC)", nil);
        _titleView.threeLab.text = SSKJLocalized(@"释放日期", nil);
    }
    return _titleView;
}
- (UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [WLTools stringToColor:@"#ffffff" andAlpha:0.41];
    }
    return _lineView;
}
- (void)createView {
    [self addSubview:self.bgImageView];
    [self.bgImageView addSubview:self.lineView];
    [self addSubview:self.titleView];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bgImageView.mas_top).offset(ScaleW(42));
        make.centerX.mas_equalTo(self.bgImageView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(ScaleW(318), ScaleW(1)));
    }];
//    self.lineView.hidden = YES;
}

- (void)layoutChildViews {
    NSArray *tArr = @[SSKJLocalized(@"类型", nil),SSKJLocalized(@"待释放", nil),SSKJLocalized(@"已释放(YEC)", nil)];
    
    CGFloat item = ScaleW(5);
    CGFloat itemWith = (Screen_Width - 3*item)/3;
    for (int i = 0; i<tArr.count; i++) {
        
        UILabel *labT = [[UILabel alloc] initWithFrame:CGRectMake(ScaleW(2.5) + i * (itemWith + item), ScaleW(20), itemWith, ScaleW(15))];
        labT.text = tArr[i];
        labT.textColor = kWhiteColorClear;
        labT.font = systemFont(ScaleW(14));
        [self.bgImageView addSubview:labT];
        labT.textAlignment = NSTextAlignmentCenter;
        labT.adjustsFontSizeToFitWidth = YES;
        
    
        
        UILabel *labB = [[UILabel alloc] initWithFrame:CGRectMake(ScaleW(5) + i * (itemWith + item), ScaleW(54), itemWith, ScaleW(13))];
        labB.textColor = kWhiteColorClear;
        labB.font = systemFont(ScaleW(12));
        labB.textAlignment = NSTextAlignmentCenter;
        labB.adjustsFontSizeToFitWidth = YES;
        
        [self.bgImageView addSubview:labB];
        
        UILabel *labB1 = [[UILabel alloc] initWithFrame:CGRectMake(ScaleW(5) + i * (itemWith + item), ScaleW(6) + labB.bottom, itemWith, ScaleW(13))];
        
        labB1.textColor = kWhiteColorClear;
        labB1.font = systemFont(ScaleW(12));
        labB1.textAlignment = NSTextAlignmentCenter;
        labB1.adjustsFontSizeToFitWidth = YES;
        
        [self.bgImageView addSubview:labB1];
    
        labB.text = SSKJLocalized(@"A价值", nil);
        labB1.text = SSKJLocalized(@"B价值", nil);
        if (i == 0) {
            labB.text = SSKJLocalized(@"A价值", nil);
            labB1.text = SSKJLocalized(@"B价值", nil);
        }else if (i == 1){
            self.aOneLab = labB ;
             self.bOneLab =labB1 ;
        }else if (i == 2){
             self.aTwoLab =labB ;
            self.bTwoLab= labB1 ;
        }else if (i == 3){
            self.aThreeLab = labB ;
            self.bThreeLab = labB1 ;
        }
    }
}

@end
