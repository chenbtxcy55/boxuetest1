//
//  SuperPayMoney_View.m
//  SSKJ
//
//  Created by 张本超 on 2019/6/14.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "SuperPayMoney_View.h"
@interface SuperPayMoney_View()

@property (nonatomic, strong) UIView *mainView;

@property (nonatomic, strong) UILabel *titleLabel;


@property (nonatomic, strong) UIButton *cancellBtn;

@property (nonatomic, strong) UIButton *commitBtn;


@end


@implementation SuperPayMoney_View

-(instancetype)init
{
    if (self = [super init])
    {
        self.frame = [UIApplication sharedApplication].keyWindow.bounds;
        
        [[UIApplication sharedApplication].keyWindow addSubview:self];
        
        self.backgroundColor = kClearBackColor;
        
        [self addSubview:self.mainView];
        
        [self.mainView addSubview:self.titleLabel];
        
        [self.mainView addSubview:self.messageLabel];
        
        [self.mainView addSubview:self.conTextFild];
        
        [self.mainView addSubview:self.commitBtn];
        
        
       
    }
    return self;
}
-(void)tapDissMiss
{
    
}

-(UIView *)mainView
{
    if (!_mainView) {
        _mainView = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight - ScaleW(254), ScreenWidth , ScaleW(254))];
        _mainView.backgroundColor = kBgColor353750;
        
    }
    return _mainView;
}

-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [WLTools allocLabel:SSKJLocalized(@"确认支付", nil) font:systemBoldFont(ScaleW(14)) textColor:kMainTextColor frame:CGRectMake(ScaleW(15), ScaleW(16), _mainView.width, ScaleW(14)) textAlignment:(NSTextAlignmentLeft)];
        
    }
    return _titleLabel;
}

-(UILabel *)messageLabel
{
    if (!_messageLabel) {
        _messageLabel = [WLTools allocLabel:@"价格：--" font:systemFont(ScaleW(13)) textColor:kMainTextColor frame:CGRectMake(ScaleW(15), ScaleW(10) + _titleLabel.bottom, _mainView.width, ScaleW(13)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _messageLabel;
}

-(UITextField *)conTextFild
{
    if (!_conTextFild) {
        _conTextFild = [[UITextField alloc]initWithFrame:CGRectMake(ScaleW(15), ScaleW(30) + _messageLabel.bottom, ScaleW(345), ScaleW(50))];
        [_conTextFild textField:_conTextFild textFont:ScaleW(15) placeHolderFont:ScaleW(15) text:nil placeText:@"请输入安全密码" textColor:kMainTextColor placeHolderTextColor:kSubSubTxtColor];
    }
    return _conTextFild;
}

-(UIButton *)commitBtn
{
    if (!_commitBtn) {
        _commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_commitBtn btn:_commitBtn font:ScaleW(15) textColor:kMainWihteColor text:@"确定" image:nil sel:@selector(commitBtnAction:) taget:self];
        _commitBtn.titleLabel.font = systemBoldFont(ScaleW(16));
        _commitBtn.frame = CGRectMake(ScaleW(15), _conTextFild.bottom + ScaleW(50), ScaleW(345),ScaleW(53));
        
        [_commitBtn setCornerRadius:ScaleW(5)];
//        [_commitBtn setBackgroundImage:[UIImage imageNamed:@"login_Btn_bg"] forState:UIControlStateNormal];
//        [_commitBtn setBackgroundImage:[UIImage imageNamed:@"login_Btn_bg"] forState:UIControlStateHighlighted];
        _commitBtn.backgroundColor = kTheMeColor;
        
        
    }
    return _commitBtn;
}


-(void)commitBtnAction:(UIButton *)sender
{
    
    !self.commitBlock?:self.commitBlock();
}

@end
