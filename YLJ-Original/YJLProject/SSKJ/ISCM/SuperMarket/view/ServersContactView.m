//
//  ServersContactView.m
//  SSKJ
//
//  Created by 张本超 on 2019/6/14

#import "ServersContactView.h"
@interface ServersContactView()

@property (nonatomic, strong) UIView *mainView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *messageLabel;

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) UIView *sepLine;

@property (nonatomic, strong) UIButton *cancellBtn;

@property (nonatomic, strong) UIButton *commitBtn;


@end


@implementation ServersContactView

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
        
        [self.mainView addSubview:self.lineView];
        
        [self.mainView addSubview:self.sepLine];
        
        [self.mainView addSubview:self.commitBtn];
        
        [self.mainView addSubview:self.cancellBtn];
        
        self.mainView.centerY = ScreenHeight/2.f;
    }
    return self;
}

-(UIView *)mainView
{
    if (!_mainView) {
        _mainView = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(15), 0, ScreenWidth - ScaleW(30), ScaleW(200))];
        _mainView.backgroundColor = kMainWihteColor;
        
        [_mainView setCornerRadius:ScaleW(10)];
        
        
    }
    return _mainView;
}

-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [WLTools allocLabel:@"联系客服" font:systemBoldFont(ScaleW(17)) textColor:kMainTextColor frame:CGRectMake(0, 0, _mainView.width, ScaleW(67)) textAlignment:(NSTextAlignmentCenter)];
        
    }
    return _titleLabel;
}

-(UILabel *)messageLabel
{
    if (!_messageLabel) {
        _messageLabel = [WLTools allocLabel:@"emagle@AB.com" font:systemFont(ScaleW(15)) textColor:kMainTextColor frame:CGRectMake(0, ScaleW(12) + _titleLabel.bottom, _mainView.width, ScaleW(15)) textAlignment:(NSTextAlignmentCenter)];
    }
    return _messageLabel;
}
-(UIView *)lineView
{
    if (!_lineView ) {
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(0, _messageLabel.bottom + ScaleW(47), _mainView.width, ScaleW(1))];
        _lineView.backgroundColor = kMainLineColor;
    }
    return _lineView;
}

-(UIView *)sepLine
{
    if (!_sepLine) {
        _sepLine = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(172),_lineView.bottom, ScaleW(1), ScaleW(53))];
        _sepLine.backgroundColor = kMainLineColor;
        
    }
    return _sepLine;
}

-(UIButton *)commitBtn
{
    if (!_commitBtn) {
        _commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_commitBtn btn:_commitBtn font:ScaleW(15) textColor:kMainRedColor text:@"复制" image:nil sel:@selector(commitBtnAction:) taget:self];
        _commitBtn.titleLabel.font = systemBoldFont(ScaleW(16));
        _commitBtn.frame = CGRectMake(_sepLine.right, _sepLine.top, ScaleW(172),ScaleW(53));
        
        
    }
    return _commitBtn;
}

-(UIButton *)cancellBtn
{
    if (!_cancellBtn) {
        _cancellBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _cancellBtn.frame = CGRectMake(0, _sepLine.top, _sepLine.left, _commitBtn.height);
        
        [_cancellBtn btn:_cancellBtn font:ScaleW(16) textColor:kSubSubTxtColor text:SSKJLocalized(@"取消", nil) image:nil sel:@selector(cancellAction:) taget:self];
    }
    return _cancellBtn;
}
-(void)commitBtnAction:(UIButton *)sender
{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = self.messageLabel.text;
    [MBProgressHUD showError:SSKJLocalized(@"复制成功", nil)];
    !self.commitBlock?:self.commitBlock();
}
-(void)cancellAction:(UIButton *)sender
{
    !self.cancellBlock?:self.cancellBlock();
}
@end
