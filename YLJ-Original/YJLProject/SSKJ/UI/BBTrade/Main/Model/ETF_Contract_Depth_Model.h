//
//  ETF_Contract_Depth_Model.h
//  SSKJ
//
//  Created by 刘小雨 on 2019/1/25.
//  Copyright © 2019年 James. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ETF_Contract_Depth_Index_Model.h"
NS_ASSUME_NONNULL_BEGIN

@interface ETF_Contract_Depth_Model : NSObject
@property (nonatomic, copy) NSString *code; // 币种Code
@property (nonatomic, strong) NSArray<ETF_Contract_Depth_Index_Model *> *asks; //  卖价
@property (nonatomic, strong) NSArray<ETF_Contract_Depth_Index_Model *> *bids; //  买价


@end

NS_ASSUME_NONNULL_END
