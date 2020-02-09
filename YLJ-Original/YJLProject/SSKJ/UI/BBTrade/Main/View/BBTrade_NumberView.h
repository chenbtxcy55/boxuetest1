//
//  BBTrade_NumberView.h
//  SSKJ
//
//  Created by 刘小雨 on 2019/1/15.
//  Copyright © 2019年 James. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BBTrade_NumberView : UIView

@property (nonatomic, copy) void (^numberChangeBlock)(NSString *number);

@property (nonatomic, assign) NSInteger dotNumber;

@property (nonatomic, strong) UILabel *unitLabel;

@property (nonatomic, strong) UITextField *numberTextField;

@end

NS_ASSUME_NONNULL_END
