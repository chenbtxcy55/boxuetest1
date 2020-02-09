//
//  YLJ_MyRootHeaderView.h
//  SSKJ
//
//  Created by cy5566 on 2019/11/21.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YLJ_MyRootHeaderView : UIView
@property (nonatomic, copy) void(^signBlock)(void);
@property (nonatomic, copy) void(^exchangeBlock)(void);
@property (nonatomic, copy) void(^loginBlock)(void);

- (void)reloadData;
- (void)hiddenHorzLayout;
@end

NS_ASSUME_NONNULL_END
