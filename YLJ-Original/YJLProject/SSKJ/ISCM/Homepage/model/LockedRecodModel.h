//
//  LockedRecodModel.h
//  SSKJ
//
//  Created by 张本超 on 2019/7/25.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <Foundation/Foundation.h>
/*  {
 "rname": "10000锁仓套餐",套餐名字
 "addtime": "1564022182",时间
 "ynum": "0.0000",已解锁
 "lnum": "10000.0000"未解锁
 },*/
NS_ASSUME_NONNULL_BEGIN

@interface LockedRecodModel : NSObject
@property (nonatomic, strong) NSString *rname;
@property (nonatomic, strong) NSString *addtime;
@property (nonatomic, strong) NSString *ynum;
@property (nonatomic, strong) NSString *lnum;
@end

NS_ASSUME_NONNULL_END
