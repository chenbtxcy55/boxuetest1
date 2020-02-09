//
//  BFEXShowChartView.h
//  ZYW_MIT
//
//  Created by 张本超 on 2018/7/3.
//  Copyright © 2018年 Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BLSafeCenterViewController.h"
#import "JB_PayWayModel.h"
@interface BFEXShowChartView : UIView
@property (nonatomic, strong) NSString *addType;
@property (nonatomic, strong) JB_PayWayModel *dataData;
@property (nonatomic, strong) UIViewController *viewController;
@property (nonatomic, copy) void(^sucessBlock)(void);
@property (nonatomic, copy) void (^cancellBlock)(void);
-(void)showView;
-(void)hiddenView;

@end
