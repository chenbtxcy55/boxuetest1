//
//  Shop_Root_headerView.h
//  SSKJ
//
//  Created by 张本超 on 2019/6/6.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Shop_Root_headerView : UIView
@property (nonatomic, copy) void(^rightAction)(void);
@property (nonatomic, copy) void(^leftAction)(void);

@property (nonatomic, strong) UIButton *rightBtn;
@property (nonatomic, strong) UIButton *lefttBtn;

@end

NS_ASSUME_NONNULL_END
