//
//  ZSJGradientBtnView.h
//  Tiger
//
//  Created by zhao on 2019/8/6.
//  Copyright © 2019 Tiger. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZSJGradientBtnView : UIView
@property (nonatomic,strong) UILabel *titleLab;
@property (nonatomic, copy) void (^confirmBlock)(void);

/**
 标题
 y圆角
 */
+(void)showWithTitle:(NSString *)title font:(NSInteger)font titleColor:(UIColor *)color frame:(CGRect)frame Radius:(int)radiu firstColor:(NSString *)firstColor lastColor:(NSString *)lastColor confirmBlock:(void(^)(void))confirmblock;

@end

NS_ASSUME_NONNULL_END
