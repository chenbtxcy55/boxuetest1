//
//  JB_BBTrade_SliderHeaderView.h
//  SSKJ
//
//  Created by 刘小雨 on 2019/5/14.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JB_BBTrade_SliderHeaderView : UIView
@property (nonatomic, copy) void (^dismissBlock)(void);

@property (nonatomic, copy) void (^selectblock)(NSInteger index);
@end

NS_ASSUME_NONNULL_END
