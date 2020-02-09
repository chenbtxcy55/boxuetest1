//
//  EAEGesterVC.m
//  SSKJ
//
//  Created by 晶雪之恋 on 2018/9/10.
//  Copyright © 2018年 James. All rights reserved.
//

#import "EAEGesterVC.h"
#import "SSKJ_BaseNavigationController.h"
#import <LocalAuthentication/LocalAuthentication.h>
#import "Tools.h"
#import "AppDelegate.h"

@interface EAEGesterVC ()

@property (nonatomic, strong) UIImageView *backImageView1;
@property (nonatomic, strong) UIImageView *logoImageView;
@property (nonatomic, strong) UIImageView *zhiwenImageView;
@property (nonatomic, strong) UIButton *pinButton;

@end

@implementation EAEGesterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setUI];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setNavigationBarHidden:NO];
    [self setNavgationBackgroundColor:[UIColor clearColor] alpha:0.2];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
}
#pragma mark - UI
-(void)setUI
{
    [self.view addSubview:self.backImageView1];
    [self.view addSubview:self.logoImageView];
    [self.view addSubview:self.zhiwenImageView];
    [self.view addSubview:self.pinButton];
}


-(UIImageView *)backImageView1
{
    if (nil == _backImageView1) {
        _backImageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        _backImageView1.image = [UIImage imageNamed:@"img_zhiwen_bg"];
    }
    return _backImageView1;
}

-(UIImageView *)logoImageView
{
    if (nil == _logoImageView) {
        _logoImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, ScaleW(130), ScaleW(164), ScaleW(130))];
        _logoImageView.centerX = ScreenWidth / 2;
        _logoImageView.image = [UIImage imageNamed:@"img_logo_zhiwen"];
    }
    return _logoImageView;
}


-(UIImageView *)zhiwenImageView
{
    if (nil == _zhiwenImageView) {
        _zhiwenImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, self.logoImageView.bottom + ScaleW(70), ScaleW(120), ScaleW(120))];
        _zhiwenImageView.centerX = ScreenWidth / 2;
        _zhiwenImageView.image = [UIImage imageNamed:@"img_zhiwen"];
        _zhiwenImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(safeToFaceID)];
        [_zhiwenImageView addGestureRecognizer:tap];
    }
    return _zhiwenImageView;
}


-(UIButton *)pinButton
{
    if (nil == _pinButton) {
        _pinButton = [[UIButton alloc]initWithFrame:CGRectMake(ScaleW(15), ScreenHeight - ScaleW(20) - ScaleW(45), ScreenWidth - ScaleW(30), ScaleW(45))];
        [_pinButton setTitle:SSKJLocalized(@"使用PIN码解锁", nil) forState:UIControlStateNormal];
        [_pinButton setTitleColor:kMainWihteColor forState:UIControlStateNormal];
        _pinButton.titleLabel.font = systemFont(ScaleW(14));
        [_pinButton addTarget:self action:@selector(handlePawOpen) forControlEvents:UIControlEventTouchUpInside];
    }
    return _pinButton;
}


// 使用密码解锁
- (void)handlePawOpen{
//    CV_AddressUnlock_ViewController *vc = [[CV_AddressUnlock_ViewController alloc]init];
//    [self.navigationController pushViewController:vc animated:YES];
}

//指纹识别
-(void)safeToFaceID
{
    //首先判断版本
    if (NSFoundationVersionNumber < NSFoundationVersionNumber_iOS_8_0) {
        showAlert(@"系统版本不支持TouchID");
        return;
    }
    
    LAContext *context = [[LAContext alloc] init];
    context.localizedFallbackTitle = @"输入密码";
    if (@available(iOS 10.0, *)) {
        //        context.localizedCancelTitle = @"22222";
    } else {
        // Fallback on earlier versions
    }
    NSError *error = nil;
    
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
        WS(weakSelf);
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:@"通过Home键验证已有手机指纹" reply:^(BOOL success, NSError * _Nullable error) {
            
            if (success) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSLog(@"TouchID 验证成功");
                    AppDelegate *appDelegate =  (AppDelegate *)[UIApplication sharedApplication].delegate;
                    weakSelf.isShow = NO;
                    [weakSelf.navigationController dismissViewControllerAnimated:NO completion:nil];
                    [appDelegate gotoMain];
                });
            }else if(error){
                
                switch (error.code) {
                    case LAErrorAuthenticationFailed:{
                        dispatch_async(dispatch_get_main_queue(), ^{
                            showAlert(@"TouchID 验证失败");
                        });
                        break;
                    }
                    case LAErrorUserCancel:{
                        dispatch_async(dispatch_get_main_queue(), ^{
                            showAlert(@"TouchID 被用户手动取消");
                        });
                    }
                        break;
                    case LAErrorUserFallback:{
                        dispatch_async(dispatch_get_main_queue(), ^{
                            showAlert(@"用户不使用指纹解锁,选择手动输入密码");
                        });
                    }
                        break;
                    case LAErrorSystemCancel:{
                        dispatch_async(dispatch_get_main_queue(), ^{
                            showAlert(@"指纹解锁被系统取消 (如遇到来电,锁屏,按了Home键等)");
                        });
                    }
                        break;
                    case LAErrorPasscodeNotSet:{
                        dispatch_async(dispatch_get_main_queue(), ^{
                            showAlert(@"指纹解锁无法启动,因为用户没有设置密码");
                        });
                    }
                        break;
                    case LAErrorTouchIDNotEnrolled:{
                        dispatch_async(dispatch_get_main_queue(), ^{
                            showAlert(@"指纹解锁无法启动,因为用户没有设置TouchID");
                        });
                    }
                        break;
                    case LAErrorTouchIDNotAvailable:{
                        dispatch_async(dispatch_get_main_queue(), ^{
                            showAlert(@"指纹解锁无效");
                        });
                    }
                        break;
                    case LAErrorTouchIDLockout:{
                        dispatch_async(dispatch_get_main_queue(), ^{
                            showAlert(@"指纹解锁被锁定(连续多次验证TouchID失败,系统需要用户手动输入密码)");
                        });
                    }
                        break;
                    case LAErrorAppCancel:{
                        dispatch_async(dispatch_get_main_queue(), ^{
                            showAlert(@"当前软件被挂起并取消了授权 (如App进入了后台等)");
                        });
                    }
                        break;
                    case LAErrorInvalidContext:{
                        dispatch_async(dispatch_get_main_queue(), ^{
                            showAlert(@"当前软件被挂起并取消了授权 (LAContext对象无效)");
                        });
                    }
                        break;
                    default:
                        break;
                }
            }
        }];
        
    }else{
        showAlert(@"请开启TouchID或使用密码解锁");
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
