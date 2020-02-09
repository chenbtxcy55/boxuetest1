//
//  JB_Default_AlertView.h
//  SSKJ
//
//  Created by James on 2019/5/17.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JB_Default_AlertView : UIView
@property (nonatomic, strong) UILabel *titleLB;
@property (nonatomic, strong) UILabel *contentLB;
- (instancetype)initWithConfirmBlock:(nonnull void (^)(void))confirmBlock
                         cancelBlock:(nonnull void (^)(void))cancelBlock;
- (void)show;
- (void)dismiss;
@end

NS_ASSUME_NONNULL_END
