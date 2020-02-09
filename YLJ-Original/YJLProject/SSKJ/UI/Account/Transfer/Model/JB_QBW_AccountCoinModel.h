//
//  JB_QBW_AccountCoinModel.h
//  SSKJ
//
//  Created by James on 2019/5/23.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JB_QBW_AccountCoinModel : NSObject
@property (nonatomic, copy) NSString *pid;
@property (nonatomic, copy) NSString *mark;
@property (nonatomic, copy) NSString *usable;
@property (nonatomic, copy) NSString *is_transfer;//是否可划转  1是  0否
@end

NS_ASSUME_NONNULL_END
