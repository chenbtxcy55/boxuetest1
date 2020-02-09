//
//  CommonToolHelper.m
//  MyNewProject
//
//  Created by sun on 2019/2/26.
//  Copyright © 2019 sun. All rights reserved.
//

#import "CommonToolHelper.h"

@implementation CommonToolHelper
static CommonToolHelper* _instance = nil;

+(instancetype) shareInstance
{
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        _instance = [[super allocWithZone:NULL] init] ;
        //不是使用alloc方法，而是调用[[super allocWithZone:NULL] init]
        //已经重载allocWithZone基本的对象分配方法，所以要借用父类（NSObject）的功能来帮助出处理底层内存分配的杂物
    }) ;
    
    return _instance ;
}

+(id) allocWithZone:(struct _NSZone *)zone
{
    return [CommonToolHelper shareInstance] ;
}

-(id) copyWithZone:(NSZone *)zone
{
    return [CommonToolHelper shareInstance] ;//return _instance;
}

-(id) mutablecopyWithZone:(NSZone *)zone
{
    return [CommonToolHelper shareInstance] ;
}

//当前屏幕显示的viewcontroller
-(UIViewController *)currentVC{
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *controller = [self getCurrentVCFrom:rootViewController];
    return controller;
}

////获取当前屏幕显示的viewcontroller
//- (UIViewController *)getCurrentVC
//{
//    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
//
//    UIViewController *currentVC = [self getCurrentVCFrom:rootViewController];
//
//    return currentVC;
//}

- (UIViewController *)getCurrentVCFrom:(UIViewController *)rootVC
{
    UIViewController *currentVC;
    
    if ([rootVC presentedViewController]) {
        // 视图是被presented出来的
        rootVC = [rootVC presentedViewController];
    }
    
    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        // 根视图为UITabBarController
        currentVC = [self getCurrentVCFrom:[(UITabBarController *)rootVC selectedViewController]];
    } else if ([rootVC isKindOfClass:[UINavigationController class]]){
        // 根视图为UINavigationController
        currentVC = [self getCurrentVCFrom:[(UINavigationController *)rootVC visibleViewController]];
    } else {
        // 根视图为非导航类
        currentVC = rootVC;
    }
    
    return currentVC;
}

@end
