//
//  HeBi_CertificateSuccessed_ViewController.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/4/10.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "HeBi_CertificateSuccessed_ViewController.h"

@class HeBi_Mine_Certificate_ViewController;

@interface HeBi_CertificateSuccessed_ViewController ()
@property (nonatomic, strong) UIImageView *headerImageView;
@property (nonatomic, strong) UIImageView *successImageView;
@property (nonatomic, strong) UILabel *tipLabel;
@end

@implementation HeBi_CertificateSuccessed_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = SSKJLocalized(@"认证成功", nil);
    // Do any additional setup after loading the view.
    [self.view addSubview:self.headerImageView];
//    [self.view addSubview:self.successImageView];
    [self.view addSubview:self.tipLabel];
}

-(void)backBtnAction:(id)sender
{
    [self backToLastVc];
}

-(UIImageView *)headerImageView
{
    if (nil == _headerImageView) {
        _headerImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, Height_NavBar + ScaleW(110), ScaleW(100), ScaleW(100))];
        _headerImageView.centerX = ScreenWidth / 2;
//        _headerImageView.layer.masksToBounds = YES;
//        _headerImageView.layer.cornerRadius = _headerImageView.height / 2;
        _headerImageView.image = [UIImage imageNamed:@"certificate_success"];
    }
    return _headerImageView;
}

-(UIImageView *)successImageView
{
    if (nil == _successImageView) {
        _successImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, ScaleW(110), ScaleW(32), ScaleW(32))];
        _successImageView.layer.masksToBounds = YES;
        _successImageView.layer.cornerRadius = _successImageView.height / 2;
        _successImageView.backgroundColor = [UIColor greenColor];
        _successImageView.bottom = self.headerImageView.bottom;
        _successImageView.right = self.headerImageView.right;
    }
    return _successImageView;
}

-(UILabel *)tipLabel
{
    if (nil == _tipLabel) {
        _tipLabel = [WLTools allocLabel:SSKJLocalized(@"恭喜您认证成功！", nil) font:systemFont(ScaleW(14)) textColor:kMainTextColor frame:CGRectMake(0, self.headerImageView.bottom + ScaleW(31), ScreenWidth, ScaleW(14)) textAlignment:NSTextAlignmentCenter];
    }
    return _tipLabel;
}

-(void)backToLastVc
{
    NSArray *controllers = self.navigationController.viewControllers;
    for (SSKJ_BaseViewController *vc in controllers) {
        if ([NSStringFromClass([vc class]) isEqualToString:@"HeBi_Mine_Certificate_ViewController"]) {
            [self.navigationController popToViewController:vc animated:YES];
        }
    }
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
