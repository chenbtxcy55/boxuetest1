//
//  SuperDetail_HeaderView.h
//  SSKJ
//
//  Created by 张本超 on 2019/6/13.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SuperDetail_HeaderView : UIView
@property (nonatomic, strong) NSDictionary *dataDic;

@property (nonatomic, strong) UILabel *currentCountLabel;

@property (nonatomic, copy) void (^reloadBlock)(void);
@property (nonatomic, copy) void (^typeBlock)(NSInteger type);

@end

NS_ASSUME_NONNULL_END
