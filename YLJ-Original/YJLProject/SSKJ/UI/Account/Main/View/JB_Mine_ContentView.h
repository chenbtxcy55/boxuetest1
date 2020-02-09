//
//  JB_Mine_ContentView.h
//  SSKJ
//
//  Created by James on 2019/5/14.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JB_Mine_ContentView : UIView
@property (nonatomic, copy) void (^selectedIndexBlock)(NSInteger index);
- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles icons:(NSArray *)icons;
@end

NS_ASSUME_NONNULL_END
