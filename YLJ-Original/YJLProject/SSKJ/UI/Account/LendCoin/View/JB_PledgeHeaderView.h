//
//  JB_PledgeHeaderView.h
//  SSKJ
//
//  Created by James on 2019/5/16.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JB_PledgeHeaderView : UIView
@property (nonatomic, copy) void (^submitButtonBlock)(void);
@property (nonatomic, copy) void (^recordButtonBlock)(void);

@end

NS_ASSUME_NONNULL_END
