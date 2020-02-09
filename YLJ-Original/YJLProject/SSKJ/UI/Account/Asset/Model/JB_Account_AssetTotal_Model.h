//
//  JB_Account_AssetTotal_Model.h
//  SSKJ
//
//  Created by James on 2019/5/21.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JB_Account_AssetTotal_Model : NSObject
@property (nonatomic, copy) NSString *ttl_usable;//可用
@property (nonatomic, copy) NSString *ttl_frost;//冻结
@property (nonatomic, copy) NSString *ttl_money;//钱数
@property (nonatomic, copy) NSString *ttl_cnymoney;//cny钱数

@end

NS_ASSUME_NONNULL_END
