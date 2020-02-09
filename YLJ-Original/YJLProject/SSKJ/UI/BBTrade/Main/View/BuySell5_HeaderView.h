//
//  BuySell5_HeaderView.h
//  SSKJ
//
//  Created by 刘小雨 on 2019/1/15.
//  Copyright © 2019年 James. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BuySell5_HeaderView : UIView
@property (nonatomic, copy) void (^changeDotBlock)(NSInteger dotNumber);
-(void)setMaxDotNumber:(NSInteger)maxDotNumber showDotNumber:(BOOL)isShowDot;

@end

NS_ASSUME_NONNULL_END
