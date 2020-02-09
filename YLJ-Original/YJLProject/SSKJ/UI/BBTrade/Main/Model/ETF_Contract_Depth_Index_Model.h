//
//  ETF_Contract_Depth_Index_Model.h
//  SSKJ
//
//  Created by 刘小雨 on 2019/1/25.
//  Copyright © 2019年 James. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ETF_Contract_Depth_Index_Model : NSObject
@property (nonatomic, copy) NSString *price;    // 价格
@property (nonatomic, copy) NSString *totalSize;    // 成交量
@property (nonatomic, assign) BOOL isMax;//是最大

@end

NS_ASSUME_NONNULL_END
