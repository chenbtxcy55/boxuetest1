//
//  JB_Lend_BorrowInfoModel.h
//  SSKJ
//
//  Created by James on 2019/5/21.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JB_Lend_BorrowInfoModel : NSObject
@property (nonatomic, copy) NSString *out_code;//抵押币
@property (nonatomic, copy) NSString *in_code;//借入币
@property (nonatomic, copy) NSString *days;//周期天数
@property (nonatomic, copy) NSString *out_num;//抵押数量
@property (nonatomic, copy) NSString *in_num;//最多可借入数量
@property (nonatomic, copy) NSString *day_rate;//日息（%）
@property (nonatomic, copy) NSString *rate;//周期利息（%）

@end

NS_ASSUME_NONNULL_END
