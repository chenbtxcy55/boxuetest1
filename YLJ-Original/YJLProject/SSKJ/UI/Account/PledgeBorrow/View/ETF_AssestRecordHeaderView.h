//
//  ETF_AssestRecordHeaderView.h
//  SSKJ
//
//  Created by James on 2019/5/8.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ETF_AssestRecordItemView : UIView
@property (nonatomic, strong) UILabel *titleLB;
@property (nonatomic, strong) UILabel *contentLB;
@end

@interface ETF_AssestRecordHeaderView : UIView
@property (nonatomic, copy) void (^coinBlock)(void);
@property (nonatomic, copy) void (^typeBlock)(void);
@property (nonatomic, strong) ETF_AssestRecordItemView *coinItem;
@property (nonatomic, strong) ETF_AssestRecordItemView *typeItem;

//设置title
- (void)setupItemOneTitle:(NSString *)left itemTwoTitle:(NSString *)right;
@end

NS_ASSUME_NONNULL_END
