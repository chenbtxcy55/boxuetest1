//
//  MyIncomeDynamicHeardView.m
//  SSKJ
//
//  Created by zhao on 2019/10/8.
//  Copyright © 2019 刘小雨. All rights reserved.
//
/*
 动态收益  头视图
 */
#import "MyIncomeDynamicHeardView.h"
@interface MyIncomeDynamicHeardView ()

@property (nonatomic, strong) UIView *lineView;
@property (nonatomic,strong) UIImageView *bgImageView;



@end
@implementation MyIncomeDynamicHeardView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self createView];
        [self layoutChildViews];
    }
    return self;
}
- (UIImageView *)bgImageView{
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, ScaleW(5), Screen_Width, ScaleW(140))];
        _bgImageView.image = [UIImage imageNamed:@"my_team_heard"];
        
    }
    return _bgImageView;
}
- (UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [WLTools stringToColor:@"#ffffff" andAlpha:0.4];
    }
    return _lineView;
}
- (void)createView {
    [self addSubview:self.bgImageView];
    [self.bgImageView addSubview:self.lineView];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.bgImageView.mas_centerX);
        make.centerY.mas_equalTo(self.bgImageView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(ScaleW(345), ScaleW(1)));
    }];
}

- (void)layoutChildViews {
    NSArray *tArr = @[SSKJLocalized(@"社区人数(人)", nil),SSKJLocalized(@"分享奖励(YEC)", nil),SSKJLocalized(@"管理奖励(YEC)", nil),SSKJLocalized(@"累计业绩(USDT)", nil)];
    NSArray *bArr = @[SSKJLocalized(@"级差奖励(YEC)", nil),SSKJLocalized(@"团队奖(YEC)", nil),SSKJLocalized(@"持币量(YEC)", nil),SSKJLocalized(@"大区业绩(USDT)", nil)];
    
    CGFloat item = ScaleW(5);
    CGFloat itemWith = (Screen_Width - 4*item)/4;
    for (int i = 0; i<bArr.count; i++) {
        
        UILabel *labT = [[UILabel alloc] initWithFrame:CGRectMake(ScaleW(2.5) + i * (itemWith + item), ScaleW(43), itemWith, ScaleW(12))];
        labT.text = tArr[i];
        labT.textColor = kWhiteColorClear;
        labT.font = systemFont(ScaleW(11));
        [self addSubview:labT];
        labT.textAlignment = NSTextAlignmentCenter;
        labT.adjustsFontSizeToFitWidth = YES;
        
        UILabel *labT1 = [[UILabel alloc] initWithFrame:CGRectMake(ScaleW(2.5) + i * (itemWith + item), ScaleW(22), itemWith, ScaleW(16))];
        
        labT1.textColor = kWhiteColorClear;
        labT1.font = systemFont(ScaleW(15));
        [self addSubview:labT1];
        labT1.textAlignment = NSTextAlignmentCenter;
        labT1.adjustsFontSizeToFitWidth = YES;
        
        
        
        
        
        UILabel *labB = [[UILabel alloc] initWithFrame:CGRectMake(ScaleW(5) + i * (itemWith + item), ScaleW(104), itemWith, ScaleW(12))];
        labB.text = bArr[i];
        labB.textColor = kWhiteColorClear;
        labB.font = systemFont(ScaleW(11));
        labB.textAlignment = NSTextAlignmentCenter;
        labB.adjustsFontSizeToFitWidth = YES;
        
        [self addSubview:labB];
        
        UILabel *labB1 = [[UILabel alloc] initWithFrame:CGRectMake(ScaleW(5) + i * (itemWith + item), ScaleW(82), itemWith, ScaleW(15))];
        
        labB1.textColor = kWhiteColorClear;
        labB1.font = systemFont(ScaleW(16));
        labB1.textAlignment = NSTextAlignmentCenter;
        labB1.adjustsFontSizeToFitWidth = YES;
        
        [self addSubview:labB1];
        
        
        if (i == 0) {
             self.tOneLab = labT1 ;
            self.bOneLab = labB1 ;
        }else if (i == 1){
            self.tTwoLab = labT1  ;
            self.bTwoLab = labB1  ;
        }else if (i == 2){
            self.tThreeLab = labT1  ;
            self.bThreeLab = labB1  ;
        }else if (i == 3){
            self.tFoutLab = labT1  ;
            self.bFoutLab = labB1  ;
        }
    }
}


@end
