//
//  LockHeaderModel.h
//  SSKJ
//
//  Created by 张本超 on 2019/7/24.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <Foundation/Foundation.h>
/* "ttlnum": 0, 总数量
 "synum": 0, 锁仓中
 "rmb_ttl": 0, 人民币*/
NS_ASSUME_NONNULL_BEGIN

@interface LockHeaderModel : NSObject

@property (nonatomic, strong) NSString *ttlnum;

@property (nonatomic, strong) NSString *synum;

@property (nonatomic, strong) NSString *rmb_ttl;

@end

NS_ASSUME_NONNULL_END
