//
//  Shop_ApplyToBeShop.m
//  SSKJ
//
//  Created by 张本超 on 2019/6/6.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "Shop_ApplyToBeShop.h"
@interface Shop_ApplyToBeShop()
@property (nonatomic, strong) UIView *mainView;

@property (nonatomic, strong) UILabel *titleLabel;


@property (nonatomic, strong) UIView *shuLineView;

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) UIButton *cancellBtn;

@property (nonatomic, strong) UIButton *coyEmailBtn;

@end

@implementation Shop_ApplyToBeShop

-(instancetype)init
{
    if (self = [super init])
    {
        UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
        
        self.frame = keyWindow.bounds;
        
        self.backgroundColor = kClearBackColor;
        
        [keyWindow addSubview:self];
        
        [self addSubview:self.mainView];
        
        
        
        
    }
    return self;
}

-(UIView *)mainView
{
    if (!_mainView) {
        _mainView = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(15), ScaleW(240), ScaleW(345), ScaleW(260))];
        _mainView.backgroundColor = kBgColor353750;
        [_mainView addSubview:self.titleLabel];
        [_mainView addSubview:self.sub2label];



        [_mainView addSubview:self.title2label];
//        self.title2label.hidden = YES;
//         self.sub2label.hidden = YES;
        [_mainView addSubview:self.subLabel];

        
        
        [_mainView addSubview:self.lineView];
        [_mainView addSubview:self.cancellBtn];
        
        [_mainView addSubview:self.shuLineView];

        [_mainView addSubview:self.coyEmailBtn];
        [_mainView setCornerRadius:ScaleW(10)];
        
    }
    return _mainView;
}
-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [WLTools allocLabel:SSKJLocalized(@"申请成为商家", nil) font:systemBoldFont(17) textColor:kMainTextColor frame:CGRectMake(0, ScaleW(25), _mainView.width, ScaleW(17)) textAlignment:(NSTextAlignmentCenter)];
        
    }
    return _titleLabel;
}
-(UILabel *)sub2label
{
    if (!_sub2label) {
        
        _sub2label = [WLTools allocLabel:SSKJLocalized(@"发送邮件名为“成为商家”的邮件至，内容需包含以下内容：", nil) font:systemFont(ScaleW(14)) textColor:kMainTextColor frame:CGRectMake(ScaleW(30), ScaleW(14) + _titleLabel.bottom, ScaleW(285), ScaleW(40)) textAlignment:(NSTextAlignmentLeft)];
        
        _sub2label.numberOfLines = 0;
        
        _sub2label.lineBreakMode=NSLineBreakByCharWrapping;
        
        [_sub2label sizeToFit];
    }
    return _sub2label;
}
-(UILabel *)title2label
{
    if (!_title2label) {
        _title2label = [WLTools allocLabel:SSKJLocalized(@"1.账户名       2.UID          3.联系方式", nil) font:systemBoldFont(14) textColor:kMainTextColor frame:CGRectMake(ScaleW(30), ScaleW(14) + _sub2label.bottom, _mainView.width, ScaleW(14)) textAlignment:(NSTextAlignmentLeft)];
        _sub2label.numberOfLines = 0;
        
        _sub2label.lineBreakMode=NSLineBreakByCharWrapping;
    }
    return _title2label;
}

-(UILabel *)subLabel
{
    if (!_subLabel) {
        _subLabel = [WLTools allocLabel:SSKJLocalized(@"发送完成后，客服会在3个工作日内联系您进行一对一服务", nil) font:systemFont(ScaleW(14)) textColor:kMainTextColor frame:CGRectMake(ScaleW(30), ScaleW(28) + _title2label.bottom, ScaleW(285), ScaleW(40)) textAlignment:(NSTextAlignmentLeft)];
        _subLabel.numberOfLines = 0;
        [_subLabel sizeToFit];
    }
    return _subLabel;
}
-(UIView *)lineView
{
    if (!_lineView) {
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(0, ScaleW(207), _mainView.width, ScaleW(1))];
        _lineView.backgroundColor = kMainLineColor;
        
    }
    return _lineView;
}

-(UIView *)shuLineView
{
    if (!_shuLineView) {
        _shuLineView = [[UIView alloc]initWithFrame:CGRectMake(_mainView.width/2.f, ScaleW(207), ScaleW(1), ScaleW(53))];
        _shuLineView.backgroundColor = kMainLineColor;
        
    }
    return _shuLineView;
}
-(UIButton *)cancellBtn
{
    if (!_cancellBtn) {
        _cancellBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancellBtn.frame = CGRectMake(0, _lineView.bottom, _mainView.width/2.f, ScaleW(53));
        [_cancellBtn btn:_cancellBtn font:ScaleW(16) textColor:kSubSubTxtColor text:SSKJLocalized(@"取消", nil) image:nil sel:@selector(cancellAction:) taget:self];
    }
    return _cancellBtn;
}

-(UIButton *)coyEmailBtn
{
    if (!_coyEmailBtn) {
        _coyEmailBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _coyEmailBtn.frame = CGRectMake(_mainView.width/2.f, _cancellBtn.top, _cancellBtn.width, _cancellBtn.height);
        [_coyEmailBtn btn:_coyEmailBtn font:ScaleW(16) textColor:kMainRedColor text:SSKJLocalized(@"申请", nil) image:nil sel:@selector(coyEmailBtnAction:) taget:self];
        
    }
    return _coyEmailBtn;
}

-(void)cancellAction:(UIButton *)sender
{
    !self.cancellBlock?:self.cancellBlock();
}
-(void)coyEmailBtnAction:(UIButton *)sender
{
//    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
//    pasteboard.string = self.subLabel.text;
//    [MBProgressHUD showError:SSKJLocalized(@"复制成功", nil)];
    
    !self.copBlock?:self.copBlock();
}






@end
