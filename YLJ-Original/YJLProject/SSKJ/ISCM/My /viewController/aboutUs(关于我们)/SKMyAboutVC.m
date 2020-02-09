//
//  SKMyAboutVC.m
//  SSKJ
//
//  Created by 孙 on 2019/7/19.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "SKMyAboutVC.h"

@interface SKMyAboutVC ()
@property (nonatomic, strong) UIView *mainView;

@property (nonatomic, strong) UIView *whiteColorVaiew;
@property (nonatomic, strong) UIButton *confimBtn;

@property (nonatomic, strong) UILabel *emaillabel;

@property (nonatomic, strong) UIView *septorLine;


@end

@implementation SKMyAboutVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self viewConfig];
    self.view.backgroundColor = kClearBackColor;
}

-(void)viewConfig
{
    [self.view addSubview:self.mainView];
    
    [self.mainView addSubview:self.emaillabel];
    
    [self.mainView addSubview:self.septorLine];
    
    [self.mainView addSubview:self.confimBtn];
    
    
}

-(UIView *)mainView
{
    if (!_mainView) {
        _mainView = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(25), ScaleW(325), ScaleW(325), ScaleW(129))];
        _mainView.centerY = ScreenHeight/2.f;
        _mainView.layer.cornerRadius = ScaleW(10);
        _mainView.backgroundColor = kMainWihteColor;
    }
    return _mainView;
}

-(UILabel *)emaillabel
{
    if (!_emaillabel) {
        _emaillabel = [WLTools allocLabel:self.addressStr font:systemFont(ScaleW(15)) textColor:kTitleColor frame:CGRectMake(0, ScaleW(39), ScaleW(325), ScaleW(15)) textAlignment:(NSTextAlignmentCenter)];
        
        
    }
    return _emaillabel;
}

-(UIView *)septorLine
{
    if (!_septorLine) {
        _septorLine = [[UIView alloc]initWithFrame:CGRectMake(0, ScaleW(78), ScaleW(325), 1)];
        _septorLine.backgroundColor = kBgColor;
        
    }
    return _septorLine;
}

-(UIButton *)confimBtn

{
    if (!_confimBtn) {
        _confimBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _confimBtn.frame = CGRectMake(0, _septorLine.bottom, ScaleW(325), ScaleW(50));
        [_confimBtn btn:_confimBtn font:ScaleW(16) textColor:kMainBlueColor text:@"确定" image:nil sel:@selector(canformAction:) taget:self];
        
        
    }
    return _confimBtn;
}

-(void)canformAction:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

@end
