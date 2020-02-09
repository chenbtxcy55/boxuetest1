//
//  JB_PledgeBorrowModel.h
//  SSKJ
//
//  Created by James on 2019/5/16.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JB_PledgeBorrowModel : NSObject
@property (nonatomic, copy) NSString *pid;//id
@property (nonatomic, copy) NSString *mark;//币种信息
@property (nonatomic, copy) NSString *outString;//抵押总数
@property (nonatomic, copy) NSString *inString;//借入总数
@end

NS_ASSUME_NONNULL_END
