//
//  ShopDetailBoomView.h
//  SSKJ
//
//  Created by 张本超 on 2019/6/13.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ShopDetailBoomView : UIView

@property (nonatomic, copy) void(^shopBlock)(void);

@property (nonatomic, copy) void(^serverBlock)(void);

@property (nonatomic, copy) void(^commitBlock)(void);

@end

NS_ASSUME_NONNULL_END
