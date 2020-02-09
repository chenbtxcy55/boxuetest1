//
//  CJHYTradeHandsView.h
//  SSKJ
//
//  Created by 张本超 on 2019/6/25.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CJHYTradeHandsView : UIView
@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, copy) void(^handBackBlock)(NSInteger index);
@end

NS_ASSUME_NONNULL_END
