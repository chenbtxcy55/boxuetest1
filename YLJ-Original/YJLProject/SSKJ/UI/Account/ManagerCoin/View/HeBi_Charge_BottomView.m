//
//  HeBi_Charge_BottomView.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/4/15.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "HeBi_Charge_BottomView.h"

@interface HeBi_Charge_BottomView ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *huodongBackView;
@property (nonatomic, strong) UILabel *huodongTitleLabel1;
@property (nonatomic, strong) UILabel *huodongLabel1;

//@property (nonatomic, strong) UIView *lineView;
//
//@property (nonatomic, strong) UILabel *huodongTitleLabel2;
//@property (nonatomic, strong) UILabel *huodongLabel2;


@property (nonatomic, strong) UILabel *warningLabel;
@property (nonatomic, strong) UIButton *helpButton;
@end

@implementation HeBi_Charge_BottomView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kMainWihteColor;
        [self setUI];
    }
    return self;
}


-(void)setUI
{
    [self addSubview:self.titleLabel];
    [self addSubview:self.huodongBackView];
    [self.huodongBackView addSubview:self.huodongTitleLabel1];
    [self.huodongBackView addSubview:self.huodongLabel1];
//    [self.huodongBackView addSubview:self.huodongTitleLabel2];
//    [self.huodongBackView addSubview:self.huodongLabel2];
//    [self.huodongBackView addSubview:self.lineView];

    
    [self addSubview:self.warningLabel];
    
//    [self addSubview:self.helpButton];
    
    self.height = self.helpButton.bottom;
}


-(UILabel *)titleLabel
{
    if (nil == _titleLabel) {
        _titleLabel = [WLTools allocLabel:SSKJLocalized(@"限时活动", nil) font:systemFont(ScaleW(15)) textColor:kMainWihteColor frame:CGRectMake(ScaleW(15), ScaleW(25), ScaleW(200), ScaleW(15)) textAlignment:NSTextAlignmentLeft];
    }
    return _titleLabel;
}

-(UIView *)huodongBackView
{
    if (nil == _huodongBackView) {
        _huodongBackView = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(15), self.titleLabel.bottom + ScaleW(22), ScreenWidth - ScaleW(30), ScaleW(73))];
        _huodongBackView.layer.masksToBounds = YES;
        _huodongBackView.layer.borderColor = kMainBackgroundColor.CGColor;
        _huodongBackView.layer.borderWidth = 0.5;
        _huodongBackView.layer.cornerRadius = 4.0f;
    }
    return _huodongBackView;
}

-(UILabel *)huodongTitleLabel1
{
    if (nil == _huodongTitleLabel1) {
        _huodongTitleLabel1 = [WLTools allocLabel:SSKJLocalized(@"首次充币1AB", nil) font:systemThinFont(ScaleW(13)) textColor:kTextDarkBlueColor frame:CGRectMake(0, ScaleW(19), self.huodongBackView.width, ScaleW(13)) textAlignment:NSTextAlignmentCenter];
    }
    return _huodongTitleLabel1;
}

-(UILabel *)huodongLabel1
{
    if (nil == _huodongLabel1) {
        _huodongLabel1 = [WLTools allocLabel:SSKJLocalized(@"送8AB", nil) font:systemFont(ScaleW(13)) textColor:kTextDarkBlueColor frame:CGRectMake(self.huodongTitleLabel1.x, self.huodongTitleLabel1.bottom + ScaleW(11), self.huodongTitleLabel1.width, ScaleW(13)) textAlignment:NSTextAlignmentCenter];
    }
    return _huodongLabel1;
}


//
//-(UILabel *)huodongTitleLabel2
//{
//    if (nil == _huodongTitleLabel2) {
//        _huodongTitleLabel2 = [WLTools allocLabel:SSKJLocalized(@"首次充币100AB", nil) font:systemThinFont(ScaleW(13)) textColor:kTextDarkBlueColor4c frame:CGRectMake(self.huodongBackView.width / 2, ScaleW(19), self.huodongBackView.width / 2, ScaleW(13)) textAlignment:NSTextAlignmentCenter];
//    }
//    return _huodongTitleLabel2;
//}
//
//-(UILabel *)huodongLabel2
//{
//    if (nil == _huodongLabel2) {
//        _huodongLabel2 = [WLTools allocLabel:SSKJLocalized(@"送38AB", nil) font:systemFont(ScaleW(13)) textColor:kTextBlckColor frame:CGRectMake(self.huodongTitleLabel2.x, self.huodongTitleLabel2.bottom + ScaleW(11), self.huodongTitleLabel2.width, ScaleW(13)) textAlignment:NSTextAlignmentCenter];
//    }
//    return _huodongLabel2;
//}
//
//-(UIView *)lineView
//{
//    if (nil == _lineView) {
//        _lineView = [[UIView alloc]initWithFrame:CGRectMake(self.huodongBackView.width / 2, ScaleW(10), 0.5, self.huodongBackView.height - ScaleW(20))];
//        _lineView.backgroundColor = kMainBackgroundColor;
//    }
//    return _lineView;
//}


-(UILabel *)warningLabel
{
    if (nil == _warningLabel) {
        
        NSString *text = SSKJLocalized(@"温馨提示：\n1、请勿向上述地址充值任何非AB资产，否则无法找回\n2、您充值至上述地址后，需1个网络确认后方可到账\n3、每次充值前请务必到本页面复制地址，以防地址更新导致充币失败。", nil);
        
        CGFloat height = [text boundingRectWithSize:CGSizeMake(ScreenWidth - ScaleW(30), 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:systemFont(ScaleW(12))} context:nil].size.height;
        _warningLabel = [WLTools allocLabel:text font:systemFont(ScaleW(12)) textColor:kTextDarkBlueColor frame:CGRectMake(ScaleW(15), self.huodongBackView.bottom + ScaleW(20), ScreenWidth - ScaleW(30), height) textAlignment:NSTextAlignmentLeft];
        _warningLabel.numberOfLines = 0;
    }
    return _warningLabel;
}

-(UIButton *)helpButton
{
    if (nil == _helpButton) {
        _helpButton = [[UIButton alloc]initWithFrame:CGRectMake(ScaleW(15), self.warningLabel.bottom, ScaleW(50), ScaleW(56))];
        [_helpButton setTitle:SSKJLocalized(@"充值帮助", nil) forState:UIControlStateNormal];
        [_helpButton setTitleColor:kTextDarkBlueColor forState:UIControlStateNormal];
        _helpButton.titleLabel.font = systemFont(ScaleW(12));
        [_helpButton addTarget:self action:@selector(helpEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _helpButton;
}


-(void)helpEvent
{
    if (self.helpBlock) {
        self.helpBlock();
    }
}


-(void)setViewWithModel:(HeBi_Charge_Model *)model
{    
    self.huodongTitleLabel1.text = [NSString stringWithFormat:@"首次充币%@AB",model.mining_rcmax[@"mining_rcmax1"]];
    self.huodongLabel1.text = [NSString stringWithFormat:@"送%@AB",model.mining_rcmax[@"mining_rcnum1"]];
    
//    self.huodongTitleLabel2.text = [NSString stringWithFormat:@"首次充币%@AB",model.mining_rcmax[@"mining_rcmax1"]];
//    self.huodongLabel2.text = [NSString stringWithFormat:@"送%@AB",model.mining_rcmax[@"mining_rcnum1"]];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
