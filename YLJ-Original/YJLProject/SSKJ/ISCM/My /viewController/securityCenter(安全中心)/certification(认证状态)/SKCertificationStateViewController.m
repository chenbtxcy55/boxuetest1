//
//  SKCertificationStateViewController.m
//  SSKJ
//
//  Created by 孙 on 2019/7/23.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "SKCertificationStateViewController.h"
#import "My_PrimaryCertificate_ViewController.h"
#import "My_AdvancedCertificate_ViewController.h"



@interface SKCertificationStateViewController ()

@end

@implementation SKCertificationStateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = kBgColor;
    [self initView];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO];
    
    
}
-(void)initView
{
    UIImageView * stateImageView =[[UIImageView alloc] init];
    stateImageView.frame = CGRectMake(0, 0, ScaleW(100), ScaleW(100));
    stateImageView.centerX = ScreenWidth/2;
    stateImageView.centerY = ScaleW(112)+stateImageView.height/2;
    [self.view addSubview:stateImageView];
    
    UIButton * stateButton = [UIButton buttonWithType:UIButtonTypeCustom];
    stateButton.frame = CGRectMake(ScaleW(15), stateImageView.bottom + ScaleW(30), ScreenWidth - ScaleW(30), ScaleW(20));
    
    [stateButton addTarget:self action:@selector(stateEvent:) forControlEvents:UIControlEventTouchUpInside];
    stateButton.backgroundColor = [UIColor clearColor];
    
    
    stateButton.titleLabel.font = systemScaleFont(15);
    [stateButton setTitleColor:kTitleColor forState:UIControlStateNormal];
    
    [self.view addSubview:stateButton];
    
    
    UILabel * yuanYinLab =[[UILabel alloc] initWithFrame:CGRectMake(ScaleW(15), stateButton.bottom + ScaleW(16),ScreenWidth - ScaleW(30), ScaleW(20))];
    yuanYinLab.textColor = kTitleGrayColor;
    yuanYinLab.font =  systemScaleFont(12);
    yuanYinLab.textAlignment = NSTextAlignmentCenter;
    yuanYinLab.backgroundColor =[UIColor clearColor];
    [self.view addSubview:yuanYinLab];
    switch (self.state) {
        case CertificationOngoing:
        {
            self.title = @"认证中";
            [stateButton setTitle:@"认证中" forState:UIControlStateNormal];
            yuanYinLab.text = @"请耐心等待...";
            stateImageView.image= [UIImage imageNamed:@"my_CertificationOngoing"];
            
        }
            break;
        case CertificationSuccess:
        {
            self.title = @"认证成功";
            [stateButton setTitle:@"恭喜您认证成功！" forState:UIControlStateNormal];
            yuanYinLab.text = @"";
            stateImageView.image= [UIImage imageNamed:@"my_CertificationSuccess"];

        }
            break;
        case CertificationFailure:
        {
            self.title = @"认证失败";
            stateImageView.image= [UIImage imageNamed:@"my_CertificationFailure"];

            NSString * colorStr1 = @"认证失败，请重新认证！";
            NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:colorStr1];
            [attString addAttribute:(NSString*)NSForegroundColorAttributeName value:kTitleColor range:[colorStr1 rangeOfString:@"认证失败，"]];
            
            [attString addAttribute:(NSString*)NSFontAttributeName value:systemScaleFont(15) range:[colorStr1 rangeOfString:@"认证失败，"]];
            
            [attString addAttribute:(NSString*)NSForegroundColorAttributeName value:kMainBlueColor range:[colorStr1 rangeOfString:@"重新认证"]];
            [attString addAttribute:(NSString*)NSFontAttributeName value:systemScaleFont(15) range:[colorStr1 rangeOfString:@"重新认证"]];
            [stateButton setAttributedTitle:attString forState:UIControlStateNormal];
            
            stateButton.titleLabel.textAlignment = NSTextAlignmentLeft;
            stateButton.titleLabel.lineBreakMode = NSLineBreakByCharWrapping;
            
            stateButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
            if (self.type == 1) {
                yuanYinLab.text = @"";
            }
            else
            {
                
                yuanYinLab.text = [SSKJ_User_Tool sharedUserTool].userInfoModel.apply_reason;

            }
//            [stateButton setTitle:@"认证失败，请重新认证！" forState:UIControlStateNormal];
        }
            break;
            
        default:
            break;
    }
    
    
}
-(void)stateEvent:(UIButton *)sender
{
    
    switch (self.type) {
        case 1:
        {
            My_PrimaryCertificate_ViewController *vc = [[My_PrimaryCertificate_ViewController alloc]init];
            vc.successBlock = ^(NSString * _Nonnull name, NSString * _Nonnull idCard)
            {
               
            };
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 2:
        {
            My_AdvancedCertificate_ViewController *vc = [[My_AdvancedCertificate_ViewController alloc]init];
            vc.successBlock = ^{
                
                
            };
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        default:
            break;
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
