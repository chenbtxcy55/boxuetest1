//
//  JB_Gesture_ViewController.h
//  SSKJ
//
//  Created by 刘小雨 on 2019/5/27.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "SSKJ_BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface JB_Gesture_ViewController : SSKJ_BaseViewController
@property (nonatomic, assign) BOOL isShow;
@property (nonatomic, copy) void (^gestureBlock)(void);
@end

NS_ASSUME_NONNULL_END
