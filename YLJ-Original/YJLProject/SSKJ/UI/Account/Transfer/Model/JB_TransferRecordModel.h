//
//  JB_TransferRecordModel.h
//  SSKJ
//
//  Created by James on 2019/5/16.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JB_TransferRecordModel : NSObject
@property (nonatomic, copy) NSString *pid;
@property (nonatomic, copy) NSString *ptype;//名字
@property (nonatomic, copy) NSString *price;//价格
@property (nonatomic, copy) NSString *memo;//名称
@property (nonatomic, copy) NSString *addtime;//时间

@end

NS_ASSUME_NONNULL_END
