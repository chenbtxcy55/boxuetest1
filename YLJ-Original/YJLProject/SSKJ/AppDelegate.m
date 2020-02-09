//
//  AppDelegate.m
//  SSKJ
//
//  Created by 刘小雨 on 2018/12/6.
//  Copyright © 2018年 刘小雨. All rights reserved.
//

#import "AppDelegate.h"

// controller
#import "SSKJ_BaseNavigationController.h"
#import "SSKJ_TabbarController.h"
#import "JB_Login_ViewController.h"
#import "Tools.h"
#import <LocalAuthentication/LocalAuthentication.h>
#import "JB_Gesture_ViewController.h"
#import "JB_Login_ViewController.h"
// 启动图（动态）
#import "WL_Launch_ViewController.h"

//中英切换
#import "SSKJLocalized.h"
// 防crash
#import "AvoidCrash.h"
// bug监控 统计
#import <Bugly/Bugly.h>


@interface AppDelegate ()

@property (nonatomic, strong) SSKJ_BaseNavigationController *lockVc;

@property (nonatomic, strong) JB_Gesture_ViewController *gestureVc;

@end

@implementation AppDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
//      [[NSBundle bundleWithPath:@"/Users/apple/Downloads/InjectionIII.app/Contents/Resources/iOSInjection.bundle"] load];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    //点击屏幕 消失键盘
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside=YES;
    
    [IQKeyboardManager sharedManager].shouldShowToolbarPlaceholder=YES;
    
    // 初始化语言
    [[SSKJLocalized sharedInstance]initLanguage];
    
    //监听token是否过期
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginToken:) name:@"LoginToken" object:nil];
    //gotoMainView
//     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gotoMainView:) name:@"gotoMainView" object:nil];
    
    //Bug 监控 统计
    [Bugly startWithAppId:Bugly_App_ID];
    // 防crash
    [self aviodCreash];
    
//    SSKJ_TabbarController *tabVc = [[SSKJ_TabbarController alloc]init];
    
//    tabVc.selectedIndex = 1;
    
//    self.window.rootViewController = tabVc;
    
    
//    [self gotoMain];
    WL_Launch_ViewController *launchVc = [[WL_Launch_ViewController alloc]init];
    self.window.rootViewController = launchVc;
//
//    [self.window makeKeyAndVisible];
    //[self.window makeKeyAndVisible];
    //[self requstUserInfor];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gotoLoginVc) name:@"loginOffAction" object:nil];
    
    [kNotifyCenter addObserver:self selector:@selector(gotoMain) name:@"gotoMianViewAction" object:nil];
    return YES;
}

-(void)aviodCreash
{
    [AvoidCrash makeAllEffective];
    
    
    //================================================
    //   1、unrecognized selector sent to instance（方式1）
    //================================================
    
    //若出现unrecognized selector sent to instance并且控制台输出:
    //-[__NSCFConstantString initWithName:age:height:weight:]: unrecognized selector sent to instance
    //你可以将@"__NSCFConstantString"添加到如下数组中，当然，你也可以将它的父类添加到下面数组中
    //比如，对于部分字符串，继承关系如下
    //__NSCFConstantString --> __NSCFString --> NSMutableString --> NSString
    //你可以将上面四个类随意一个添加到下面的数组中，建议直接填入 NSString
    
    
    //我所开发的项目中所防止unrecognized selector sent to instance的类有下面几个，主要是防止后台数据格式错乱导致的崩溃。个人觉得若要防止后台接口数据错乱，用下面的几个类即可。
    
    NSArray *noneSelClassStrings = @[
                                     @"NSNull",
                                     @"NSNumber",
                                     @"NSString",
                                     @"NSDictionary",
                                     @"NSArray"
                                     ];
    [AvoidCrash setupNoneSelClassStringsArr:noneSelClassStrings];
    
    
    //================================================
    //   2、unrecognized selector sent to instance（方式2）
    //================================================
    
    //若需要防止某个前缀的类的unrecognized selector sent to instance
    //比如你所开发项目中使用的类的前缀:CC、DD
    //你可以调用如下方法
    //[AvoidCrash setupNoneSelClassStringPrefixsArr:noneSelClassPrefix];
}

-(void)judgeGesture
{
    BOOL saveTouch = [Tools getPlistWithName:@"Gestrue" key: kPhoneNumber];
    
    if (saveTouch) {
        [self showGestureVc];
    }else{
        [self gotoMain];
    }
    
}
// 加载主视图
-(void)gotoMain
{
   
    SSKJ_TabbarController *tabVc = [[SSKJ_TabbarController alloc]init];
    
    self.window.rootViewController = tabVc;
//    if ([kUserDefaults objectForKey:@"token"]&&[[kUserDefaults objectForKey:@"token"] length]>0) {
//        SSKJ_TabbarController *tabVc = [[SSKJ_TabbarController alloc]init];
//    
//        self.window.rootViewController = tabVc;
//    }else{
//        JB_Login_ViewController *vc = [[JB_Login_ViewController alloc]init];
//        SSKJ_BaseNavigationController *navc = [[SSKJ_BaseNavigationController alloc]initWithRootViewController:vc];
//        [self.window.rootViewController presentViewController:navc animated:YES completion:nil];
//
//         [self gotoLoginVc];
//    }
    
   
}
/*
-(void)requstUserInfor
{
    //AB_user_info_url
    NSDictionary *params = @{};

    [[WLHttpManager shareManager]requestWithURL_HTTPCode:AB_user_info_url RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        WL_Network_Model * netWorkModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
   
        if ([netWorkModel.status isEqualToString:@"200"]) {
            
            SSKJ_UserInfo_Model *model = [SSKJ_UserInfo_Model mj_objectWithKeyValues:netWorkModel.data];
            
            // model.upic = [WLTools dictionaryWithJsonString:(NSString *)netWorkModel.data[@"upic"]];
            [SSKJ_User_Tool sharedUserTool].userInfoModel = model;
            
            [kUserDefaults setObject:[SSKJ_User_Tool sharedUserTool].userInfoModel.mobile forKey:@"mobile"];
            
            
            
            //[self gotoMain];
        }
        else
        {
            [MBProgressHUD showError:netWorkModel.msg];
        }
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
     
    }];
    
}*/

-(void)gotoLoginVc
{
     JB_Login_ViewController *login = [[JB_Login_ViewController alloc]init];
    SSKJ_BaseNavigationController *navi = [[SSKJ_BaseNavigationController alloc]initWithRootViewController:login];
    self.window.rootViewController = navi;
}
//-(void)gotoMainView:(NSNotification *)notifacation
//
//{
//
//    SSKJ_TabbarController *tabVc = [[SSKJ_TabbarController alloc]init];
//
//    self.window.rootViewController = tabVc;
//
//
//
//}

// 退出登录（单点登录被挤掉，弹出登录页面）
-(void)loginToken:(NSNotification *)notification
{
    
    SSKJ_TabbarController *tabVc = (SSKJ_TabbarController *)self.window.rootViewController;
    if ([tabVc isKindOfClass:[SSKJ_TabbarController class]]) {
        tabVc.selectedIndex = 0;
        if (self.gestureVc.isShow) {
            [self.lockVc dismissViewControllerAnimated:NO completion:nil];
            self.gestureVc.isShow = NO;
        }
    }else{
        self.window.rootViewController = [[SSKJ_TabbarController alloc]init];
    }
    
    [SSKJ_User_Tool clearUserInfo];
    JB_Login_ViewController *vc = [[JB_Login_ViewController alloc]init];
    SSKJ_BaseNavigationController *navc = [[SSKJ_BaseNavigationController alloc]initWithRootViewController:vc];
    navc.modalPresentationStyle = UIModalPresentationFullScreen;

    [self.window.rootViewController presentViewController:navc animated:YES completion:nil];    
}

-(JB_Gesture_ViewController *)gestureVc
{
    if (nil == _gestureVc) {
        _gestureVc = [[JB_Gesture_ViewController alloc] init];
        WS(weakSelf);
        _gestureVc.gestureBlock = ^{
            [weakSelf judgeFaceID];
        };
    }
    return _gestureVc;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}



- (void)applicationWillEnterForeground:(UIApplication *)application
{
    if (!self.gestureVc.isShow) {
        BOOL saveTouch = [Tools getPlistWithName:@"Gestrue" key: kPhoneNumber];
        
        if (saveTouch) {
            [self showGestureVc];
        }
    }
    
}


-(void)showGestureVc
{
    if ([[SSKJ_User_Tool sharedUserTool]getToken].length) {
        //                EAEGesterVC *vc = [[EAEGesterVC alloc] init];
        self.gestureVc.isShow = YES;
        self.lockVc = [[SSKJ_BaseNavigationController alloc]initWithRootViewController:self.gestureVc];
        self.lockVc.modalPresentationStyle = UIModalPresentationFullScreen;

        [self.window.rootViewController presentViewController:self.lockVc animated:YES completion:nil];
        //            self.window.rootViewController =  [[SSKJ_BaseNavigationController alloc]initWithRootViewController:vc];
//        [self judgeFaceID];
    }
}



#pragma mark - 指纹解锁

-(void)judgeFaceID
{
    LAContext *context = [[LAContext alloc] init];
    NSError *error = nil;
    
    // 判断设置是否支持指纹识别(iPhone5s+、iOS8+支持)
    BOOL support = [context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error];
    
    if (support) {
        //        return AllRight;
        [self safeToFaceID];

    }else{
        switch (error.code) {
                //        没有设置指纹（没有设置密码也会走到这），但是支持指纹识别
            case LAErrorTouchIDNotEnrolled:{
                showAlert(SSKJLocalized(@"请先设置指纹", nil));
            }
                break;
                //        理论上是没有设置密码,至今没有尝试出什么情况下走这个,希望有试出来场景的兄弟告知一下我
                //            case LAErrorPasscodeNotSet:{
                //                return TouchOK;
                //            }
                //                break;
                //       在使用touchID的场景中,错误太多次（根据策略不同为5次到6次）而导致touchID被锁不可用
            case LAErrorTouchIDLockout:{
                showAlert(SSKJLocalized(@"错误次数太多，touchID不可用", nil));
                
            }
                //        设备不支持指纹识别
            default:{
                showAlert(SSKJLocalized(@"不支持指纹识别", nil));
            }
                break;
        }
    }
}



-(void)safeToFaceID
{
    //首先判断版本
    if (NSFoundationVersionNumber < NSFoundationVersionNumber_iOS_8_0) {
        NSLog(@"系统版本不支持TouchID");
        return;
    }
    
    LAContext *context = [[LAContext alloc] init];
    context.localizedFallbackTitle = @"";
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
                    NSLog(@"指纹解锁验证成功");
                    weakSelf.gestureVc.isShow = NO;
                    if ([weakSelf.window.rootViewController isKindOfClass:[SSKJ_TabbarController class]]) {
                        [weakSelf.lockVc dismissViewControllerAnimated:NO completion:nil];
                        
                    }else{
                        [weakSelf gotoMain];
                    }
                });
            }else if(error){
                
                switch (error.code) {
                    case LAErrorAuthenticationFailed:{
                        dispatch_async(dispatch_get_main_queue(), ^{
                            showAlert(@"指纹解锁验证失败");
                        });
                        break;
                    }
                    case LAErrorUserCancel:{
                        dispatch_async(dispatch_get_main_queue(), ^{
//                            showAlert(@"指纹解锁被用户手动取消");
                        });
                    }
                        break;
                    case LAErrorUserFallback:{
                        dispatch_async(dispatch_get_main_queue(), ^{
//                            showAlert(@"不使用指纹解锁,请使用密码解锁");
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
        NSLog(@"当前设备不支持TouchID,请开启TouchID");
    }
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
