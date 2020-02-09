//
//  JB_LendCoinModel.h
//  SSKJ
//
//  Created by James on 2019/5/16.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JB_LendCoinModel : NSObject
@property (nonatomic, copy) NSString *title;//标题
@property (nonatomic, copy) NSString *subTitle;//副标题
@property (nonatomic, copy) NSString *inputText;//输入框文字
@property (nonatomic, copy) NSString *inputPlaceHolder;//输入框holder
@property (nonatomic, assign) NSInteger type;//类型
@property (nonatomic, assign) UIKeyboardType keyboardType;//键盘类型
@end

NS_ASSUME_NONNULL_END
