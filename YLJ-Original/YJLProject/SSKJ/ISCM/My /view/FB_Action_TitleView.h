//
//  FB_Action_TitleView.h
//  ZYW_MIT
//
//  Created by 刘小雨 on 2019/3/21.
//  Copyright © 2019年 Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FB_Action_TitleView : UIView

@property (nonatomic, copy) void (^titleChangeBlock)(NSInteger index);

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles;

@end

NS_ASSUME_NONNULL_END
