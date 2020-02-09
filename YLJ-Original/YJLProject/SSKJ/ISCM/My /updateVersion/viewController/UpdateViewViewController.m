//
//  UpdateViewViewController.m
//  SSKJ
//
//  Created by 张本超 on 2019/7/22.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "UpdateViewViewController.h"

@interface UpdateViewViewController ()
@property (nonatomic, strong) UIView *mainView;
@property (nonatomic, strong) UIImageView *headerImg;
@property (nonatomic, strong) UIView *whiteColorView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *versionlabel;
@property (nonatomic, strong) UILabel *contenLabel;
@property (nonatomic, strong) UIView *septorLine;
@property (nonatomic, strong) UIView *shuSeptorLine;

@property (nonatomic, strong) UIButton *imitlyBtn;
@property (nonatomic, strong) UIButton *cancellBtn;

@end

@implementation UpdateViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self viewConfig];
    self.view.backgroundColor = kClearBackColor;
}

-(void)viewConfig
{
//    [self.view addSubview:self.mainView];
//    [self.mainView addSubview:self.headerImg];
//    [self.headerImg addSubview:self.titleLabel];
//
//    [self.headerImg addSubview:self.versionlabel];
    
    
//    [self.mainView addSubview:self.whiteColorView];
//    [self.mainView addSubview:self.contenLabel];
//
//    [self.mainView addSubview:self.septorLine];
//
//    [self.mainView addSubview:self.imitlyBtn];
//
//    [self.mainView addSubview:self.cancellBtn];
    
}
-(UIView *)mainView
{
    if (!_mainView) {
        _mainView = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(58), ScaleW(100), ScaleW(260), ScaleW(327))];
        
        [_mainView setCornerRadius:ScaleW(5)];
        
        
    }
    return _mainView;
}
-(UIImageView *)headerImg
{
    if (!_headerImg) {
        _headerImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScaleW(260), ScaleW(130))];
        _headerImg.image = [UIImage imageNamed:@"updateImg"];
        
    }
    return _headerImg;
}
-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [WLTools allocLabel:@"发现新版本" font:systemFont(ScaleW(21)) textColor:kMainWihteColor frame:CGRectMake(ScaleW(20), ScaleW(36), ScaleW(200), ScaleW(20)) textAlignment:(NSTextAlignmentLeft)];
        
    }
    return _titleLabel;
}
-(UILabel *)versionlabel{
    if (!_versionlabel) {
        _versionlabel = [WLTools allocLabel:@"v0.0" font:systemFont(ScaleW(14)) textColor:kMainWihteColor frame:CGRectMake(ScaleW(20), ScaleW(10) + _titleLabel.bottom, ScaleW(200), ScaleW(20)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _versionlabel;
}
-(UIView *)whiteColorView
{
    if (!_whiteColorView) {
        _whiteColorView = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(0), _headerImg.bottom, ScaleW(260), _mainView.height - _headerImg.height)];
        _whiteColorView.backgroundColor = kMainWihteColor;
    }
    return _whiteColorView;
}
-(UILabel *)contenLabel
{
    if (!_contenLabel) {
        _contenLabel = [WLTools allocLabel:@"" font:systemFont(ScaleW(13)) textColor:kTitleColor frame:CGRectMake(ScaleW(22),  _headerImg.bottom, _mainView.width - ScaleW(44), ScaleW(40)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _contenLabel;
}

-(UIView *)septorLine
{
    if (!_septorLine) {
        _septorLine = [[UIView alloc]initWithFrame:CGRectMake(0, _mainView.height - ScaleW(50) - 1, _mainView.width, 1)];
        _septorLine.backgroundColor = kLineGrayColor;
    }
    return _septorLine;
}
-(UIView *)shuSeptorLine
{
    if (!_shuSeptorLine) {
        _shuSeptorLine = [[UIView alloc]initWithFrame:CGRectMake(_mainView.width/2, _mainView.height - ScaleW(50) , 1, ScaleW(50))];
        _shuSeptorLine.backgroundColor = kLineGrayColor;
    }
    return _shuSeptorLine;
}
-(UIButton *)imitlyBtn
{
    if (!_imitlyBtn) {
        _imitlyBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        
        [_imitlyBtn btn:_imitlyBtn font:ScaleW(16) textColor:kMainBlueColor text:@"升级" image:nil sel:@selector(imitlyBtnAction:) taget:self];
        _imitlyBtn.frame = CGRectMake(0, _septorLine.bottom, _mainView.width/2.f, ScaleW(50));
        
    }
    return _imitlyBtn;
}
-(UIButton *)cancellBtn
{
    if (!_cancellBtn) {
        _cancellBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        
        [_cancellBtn btn:_cancellBtn font:ScaleW(16) textColor:kMainBlueColor text:SSKJLocalized(@"取消", nil) image:nil sel:@selector(cancellAction:) taget:self];
        _cancellBtn.frame = CGRectMake(_mainView.width/2.f, _septorLine.bottom, _mainView.width/2.f, ScaleW(50));
        
    }
    return _cancellBtn;
}

-(void)imitlyBtnAction:(UIButton *)sender
{
//     [self dismissViewControllerAnimated:YES completion:nil];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.dataDic[@"data"][@"addr"]]];
}
-(void)cancellAction:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)setDataDic:(NSDictionary *)dataDic
{
    _dataDic = dataDic;
    
    [self.mainView addSubview:self.headerImg];
    [self.headerImg addSubview:self.titleLabel];
    
    [self.headerImg addSubview:self.versionlabel];
    
    [self.mainView addSubview:self.whiteColorView];

    
    self.versionlabel.text = dataDic[@"data"][@"version"];
    
    self.contenLabel.text = dataDic[@"data"][@"content"];
    
    NSDictionary *attributes = @{NSFontAttributeName: self.contenLabel.font};
    
    CGFloat titleHeight = [self.contenLabel.text boundingRectWithSize:CGSizeMake(self.contenLabel.width-20, 1000) options: NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size.height;
    if (titleHeight >ScaleW(100)) {
        
        self.contenLabel.height = titleHeight +30;

    }
    else
    {
        self.contenLabel.height = ScaleW(100);
        
    }
    
    [self.mainView addSubview:self.contenLabel];

    
    

    _mainView.height = self.contenLabel.bottom + ScaleW(50);

    [self.mainView addSubview:self.septorLine];

    
    
    [self.mainView addSubview:self.imitlyBtn];

//     1强制更新   2不强制更新
    if ([dataDic[@"data"][@"uptype"] intValue] == 1) {

        
        self.imitlyBtn.width = self.mainView.width;
        
    }
    else
    {
        [self.mainView addSubview:self.cancellBtn];

        
    }
    
    [self.mainView addSubview:self.shuSeptorLine];
    
    
    
    self.mainView.center = self.view.center;
    self.whiteColorView.height = self.mainView.height - self.headerImg.height;
    [self.view addSubview:self.mainView];

    
}
@end
