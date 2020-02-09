//
//  CMRemind.m
//  JiLogistics
//
//  Created by zzzzz on 15/12/26.
//  Copyright (c) 2015年 zzzzz. All rights reserved.
//

#import "CMRemind.h"

@implementation CMRemind


+ (void)success:(NSString *)str
{
    [MBProgressHUD showSuccess:str];
}

+ (void)error:(NSString *)str
{
    [MBProgressHUD showError:str];
}

+ (void)show
{
    [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
}

+ (void)dismiss
{
    [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:YES];
}

+ (void)remindWithTitle:(NSString *)title cancle:(NSString *)cancle ensure:(NSString *)ensure uncomplete:(void (^)(void))uncomplete complete:(void (^)(void))complete
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:title preferredStyle:UIAlertControllerStyleAlert];
    
    if (cancle.length) {
        UIAlertAction *cancel11 = [UIAlertAction actionWithTitle:cancle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            if (uncomplete) {
                uncomplete();
            }
        }];
        [alert addAction:cancel11];
    }
    
    if (ensure.length) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:ensure style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            if (complete) {
                complete();
            }
        }];
        [alert addAction:action];
    }
    alert.modalPresentationStyle = UIModalPresentationFullScreen;

    [[self currentVC] presentViewController:alert animated:YES completion:nil];
}

+ (UIViewController *)currentVC{
    UIWindow * window = [UIApplication sharedApplication].delegate.window;

    UIViewController *result = window.rootViewController;
    
    if ([result isKindOfClass:[UITabBarController class]]) {
        result = [(UITabBarController *)result selectedViewController];
    }
    while (result.presentedViewController) {
        result = result.presentedViewController;
    }
    if ([result isKindOfClass:[UINavigationController class]]) {
        result = [(UINavigationController *)result topViewController];
    }
    return result;
}

@end
