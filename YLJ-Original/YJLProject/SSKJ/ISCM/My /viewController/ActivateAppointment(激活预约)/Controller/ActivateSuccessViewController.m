//
//  ActivateSuccessViewController.m
//  SSKJ
//
//  Created by zhao on 2019/10/9.
//  Copyright © 2019 刘小雨. All rights reserved.
//
/*
 激活成功
 */
#import "ActivateSuccessViewController.h"

@interface ActivateSuccessViewController ()

@end

@implementation ActivateSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self createUI];
}
-(void)createUI{
    
    UIImageView *bgView = [[UIImageView alloc] init];
    bgView.image = [UIImage imageNamed:@"sucessBg"];
    bgView.userInteractionEnabled = YES;
    [self.view addSubview:bgView];
    CGFloat heght = ScaleW(269);
    if (Height_NavBar == 88) {
        heght = ScaleW(269) + ScaleW(24);
    }
    bgView.frame = CGRectMake(0, 0, Screen_Width, heght);
    
    
    
    UIButton *btn = [[UIButton alloc] init];
    [btn setImage:[UIImage imageNamed:@"commentWhite"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"commentWhite"] forState:UIControlStateSelected];
    [bgView addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgView.mas_left);
        if (Height_NavBar == 88) {
            make.top.equalTo(bgView.mas_top).offset(44);
        }else{
            make.top.equalTo(bgView.mas_top).offset(20);
        }
        make.size.mas_equalTo(CGSizeMake(50, 44));
    }];
    [btn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];

    UILabel *titleLab = [WLTools allocLabel:SSKJLocalized(@"激活成功", nil) font:systemFont(ScaleW(18)) textColor:kMainWihteColor frame:CGRectZero textAlignment:NSTextAlignmentCenter];
    [bgView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(btn.mas_centerY);
        make.centerX.equalTo(bgView.mas_centerX);
    }];
    
    UIImageView *showImage = [[UIImageView alloc] init];
    showImage.image = [UIImage imageNamed:@"sucessDuiBg"];
    
    [self.view addSubview:showImage];
    [showImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(bgView.mas_centerX);
        make.top.equalTo(btn.mas_bottom).offset(ScaleW(46));
        make.size.mas_equalTo(CGSizeMake(ScaleW(100), ScaleW(100)));
    }];

    
    UILabel *oneLab = [WLTools allocLabel:SSKJLocalized(@"激活成功", nil) font:systemFont(ScaleW(18)) textColor:kGreenTextColor frame:CGRectZero textAlignment:NSTextAlignmentCenter];
    [self.view addSubview:oneLab];
    [oneLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView.mas_bottom).offset(ScaleW(53));
        make.centerX.equalTo(bgView.mas_centerX);
    }];
    
    UILabel *twoLab = [WLTools allocLabel:SSKJLocalized(@"您已成功激活，接下来您可以交易或者推广了！", nil) font:systemFont(ScaleW(14)) textColor:TextGraye1e1e1 frame:CGRectZero textAlignment:NSTextAlignmentCenter];
    [self.view addSubview:twoLab];
    [twoLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(oneLab.mas_bottom).offset(ScaleW(20));
        make.left.equalTo(self.view.mas_left).offset(ScaleW(15));
        make.right.equalTo(self.view.mas_right).offset(ScaleW(-15));
    }];
    
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(Screen_Width/2 - ScaleW(136)/2, ScreenHeight - ScaleW(40), ScaleW(136), ScaleW(40))];
    [backBtn setTitle:SSKJLocalized(@"返回", nil) forState:UIControlStateNormal];
//    [backBtn setBackgroundImage:[UIImage imageNamed:@"login_Btn_bg"] forState:UIControlStateNormal];
//    [backBtn setBackgroundImage:[UIImage imageNamed:@"login_Btn_bg"] forState:UIControlStateHighlighted];
    backBtn.backgroundColor = kTheMeColor;
    backBtn.clipsToBounds = YES;
    backBtn.layer.cornerRadius = ScaleW(20);
    [backBtn setTitleColor:kMainWihteColor forState:UIControlStateNormal];
    backBtn.titleLabel.font = systemBoldFont(ScaleW(16));
    [backBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(twoLab.mas_bottom).offset(ScaleW(87));
        make.size.mas_equalTo(CGSizeMake(ScaleW(136), ScaleW(40)));

    }];
}
- (void)backClick{
    [self.navigationController popToRootViewControllerAnimated:false];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];

}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];

}
@end
