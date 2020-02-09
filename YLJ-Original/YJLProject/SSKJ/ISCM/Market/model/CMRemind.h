//
//  CMRemind.h
//  JiLogistics
//
//  Created by zzzzz on 15/12/26.
//  Copyright (c) 2015年 zzzzz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CMRemind : NSObject

+ (void)success:(NSString *)str;
+ (void)error:(NSString *)str;
+ (void)show;
+ (void)dismiss;


+ (UIViewController *)currentVC;

+ (void)remindWithTitle:(NSString *)title cancle:(NSString *)cancle ensure:(NSString *)ensure uncomplete:(void(^)(void))uncomplete complete:(void(^)(void))complete;
@end
