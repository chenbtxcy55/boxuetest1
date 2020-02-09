//
//  HeBi_CertificateFail_ViewController.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/4/10.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "HeBi_CertificateFail_ViewController.h"
#import "HeBi_SecondCertificate_ViewController.h"
//@class HeBi_SecondCertificate_ViewController;
#import "ManagerSocket.h"
@interface HeBi_CertificateFail_ViewController ()
@property (nonatomic, strong) UIImageView *headerImageView;
@property (nonatomic, strong) UIImageView *successImageView;
@property (nonatomic, strong) UILabel *tipLabel;

@property (nonatomic, strong) UILabel *reasonLabel;
@end

@implementation HeBi_CertificateFail_ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = SSKJLocalized(@"认证失败", nil);
    // Do any additional setup after loading the view.
    [self.view addSubview:self.headerImageView];
//    [self.view addSubview:self.successImageView];
    [self.view addSubview:self.tipLabel];
    
    [self.view addSubview:self.reasonLabel];
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
        _headerImageView.image = [UIImage imageNamed:@"certificate_fail"];
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
        
        NSString *text1 = SSKJLocalized(@"认证失败，请", nil);
        NSString *text2 = SSKJLocalized(@"重新认证", nil);

        NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@%@!",text1,text2]];
        [attributeString addAttribute:NSForegroundColorAttributeName value:kTextLightBlueColor range:NSMakeRange(text1.length, text2.length)];
        
        _tipLabel = [WLTools allocLabel:SSKJLocalized(@"认证失败，请重新认证！", nil) font:systemFont(ScaleW(14)) textColor:kMainTextColor frame:CGRectMake(0, self.headerImageView.bottom + ScaleW(31), ScreenWidth, ScaleW(14)) textAlignment:NSTextAlignmentCenter];
        
        _tipLabel.attributedText = attributeString;
        _tipLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(toCertificate)];
        [_tipLabel addGestureRecognizer:tap];
    }
    return _tipLabel;
}

-(UILabel *)reasonLabel
{
    if (nil == _reasonLabel) {
        _reasonLabel = [WLTools allocLabel:[NSString stringWithFormat:@"失败原因：%@", [SSKJ_User_Tool sharedUserTool].userInfoModel.apply_reason] font:systemFont(ScaleW(12)) textColor:[UIColor colorWithHexStringToColor:@"5b5e95"] frame:CGRectMake(ScaleW(15), self.tipLabel.bottom + ScaleW(16), ScreenWidth - ScaleW(30), ScaleW(14)) textAlignment:NSTextAlignmentCenter];
        _reasonLabel.numberOfLines = 0;
        CGFloat height = [_reasonLabel.text boundingRectWithSize:CGSizeMake(_reasonLabel.width, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:_reasonLabel.font} context:nil].size.height;
        _reasonLabel.height = height;
    }
    return _reasonLabel;
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


-(void)toCertificate
{
    HeBi_SecondCertificate_ViewController *vc = [[HeBi_SecondCertificate_ViewController alloc]init];
    
    [self.navigationController pushViewController:vc animated:YES];
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
