//
//  ETF_Mine_CellItemView.h
//  SSKJ
//
//  Created by James on 2019/5/5.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JB_Mine_CellItemView;
NS_ASSUME_NONNULL_BEGIN

@protocol JB_Mine_CellItemViewDelegate <NSObject>

- (void)didSelectedItem:(JB_Mine_CellItemView *)item;

@end

@interface JB_Mine_CellItemView : UIView
@property (nonatomic, weak) id <JB_Mine_CellItemViewDelegate> delegate;

- (void)configureViewWithMoney:(NSString *)money cny:(NSString *)cny;
- (void)configureViewWithImage:(NSString *)image title:(NSString *)title;
@end

NS_ASSUME_NONNULL_END
