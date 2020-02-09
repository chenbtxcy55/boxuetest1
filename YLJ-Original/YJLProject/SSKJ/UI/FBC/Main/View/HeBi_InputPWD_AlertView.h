//
//  HeBi_InputPWD_AlertView.h
//  SSKJ
//
//  Created by 刘小雨 on 2019/4/18.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HeBi_InputPWD_AlertView : UIView
@property (nonatomic, copy) void (^confirmBlock)(NSString *pwd);
@property (nonatomic, assign) BOOL isShow;
-(void)showWithTitle:(NSString *)title cancleTitle:(NSString *)cancleTitle confirmTitle:(NSString *)confirmTitle;
@end

NS_ASSUME_NONNULL_END
