//
//  My_Certificate_ViewController.m
//  ZYW_MIT
//
//  Created by 刘小雨 on 2019/3/28.
//  Copyright © 2019年 Wang. All rights reserved.
//

#import "My_Certificate_ViewController.h"

// controller
#import "My_AdvancedCertificate_ViewController.h"
#import "My_PrimaryCertificate_ViewController.h"


// view
#import "My_AdvancedCertificate_View.h"
#import "My_PrimaryCertificate_View.h"

@interface My_Certificate_ViewController ()

@property (nonatomic, strong) My_PrimaryCertificate_View *primaryView;   //!< 实名认证
@property (nonatomic, strong) My_AdvancedCertificate_View *advancedView; //!< 高级认证




@end

@implementation My_Certificate_ViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = SSKJLocalized(@"身份认证", nil);
    self.view.backgroundColor = kBgColor;
    
    [self setUI];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self.primaryView setUserModel:[SSKJ_User_Tool sharedUserTool].userInfoModel];
    [self.advancedView setUserModel:[SSKJ_User_Tool sharedUserTool].userInfoModel];
}



#pragma mark 认证触发事件
#pragma mark 实名认证
-(void)primaryAuthAction:(UIControl*)sender
{
    
//    NSInteger baseStatus = [SSKJ_User_Tool sharedUserTool].userInfoModel.basicAuthenticationStatus.integerValue;
    if (1) {
        My_PrimaryCertificate_ViewController *vc = [[My_PrimaryCertificate_ViewController alloc]init];
        vc.successBlock = ^(NSString * _Nonnull name, NSString * _Nonnull idCard)
        {
            [self.primaryView setUserModel:[SSKJ_User_Tool sharedUserTool].userInfoModel];
        };
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        [MBProgressHUD showError:SSKJLocalized(@"初级认证已通过，无需重复认证", nil)];
    }
}


#pragma mark 高级认证
-(void)advancedAuthAction:(UIControl*)sender
{
    
//    NSInteger baseStatus = [SSKJ_User_Tool sharedUserTool].userInfoModel.basicAuthenticationStatus.integerValue;
    NSInteger baseStatus = 1;

    if (baseStatus == 0) {
        [MBProgressHUD showError:SSKJLocalized(@"请先进行初级认证", nil)];
        return;
    }
    
//    NSInteger advanceStatus = [SSKJ_User_Tool sharedUserTool].userInfoModel.highAuthenticationStatus.integerValue;
    NSInteger advanceStatus = 1;

    if (advanceStatus == 1 || advanceStatus == 4) {
        My_AdvancedCertificate_ViewController *vc = [[My_AdvancedCertificate_ViewController alloc]init];
        vc.successBlock = ^{};
        [self.navigationController pushViewController:vc animated:YES];
    }else if (advanceStatus == 2){
        [MBProgressHUD showError:SSKJLocalized(@"高级认证审核中，请耐心等待！", nil)];
        
    }else if (advanceStatus == 3){
        [MBProgressHUD showError:SSKJLocalized(@"高级认证已通过，无需重复认证", nil)];
    }
    
    
}











#pragma mark - Getter / Setter
-(void)setUI
{
    [self.view addSubview:self.primaryView];
    [self.view addSubview:self.advancedView];
}


#pragma mark 实名认证
-(My_PrimaryCertificate_View *)primaryView
{
    if (!_primaryView)
    {
        _primaryView = [[My_PrimaryCertificate_View alloc]initWithFrame:CGRectMake(0, ScaleW(15), ScreenWidth, ScaleW(105))];
        [_primaryView addTarget:self action:@selector(primaryAuthAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _primaryView;
}


#pragma mark 高级认证
-(My_AdvancedCertificate_View *)advancedView
{
    if (!_advancedView)
    {
        _advancedView = [[My_AdvancedCertificate_View alloc]initWithFrame:CGRectMake(0, self.primaryView.bottom + ScaleW(15), ScreenWidth, ScaleW(105))];
        [_advancedView addTarget:self action:@selector(advancedAuthAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _advancedView;
}

@end
