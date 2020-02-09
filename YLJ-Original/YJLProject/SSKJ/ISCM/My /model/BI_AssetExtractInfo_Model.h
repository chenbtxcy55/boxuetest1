//
//  BI_AssetExtractInfo_Model.h
//  SSKJ
//
//  Created by 刘小雨 on 2019/7/1.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BI_AssetExtractInfo_Model : NSObject
@property (nonatomic, copy) NSString *tbFeeRate;    //提币手续费
@property (nonatomic, copy) NSString *tbMinRate;    //最小提币数
@property (nonatomic, copy) NSString *tbMaxRate;    //最大提币数
@property (nonatomic, copy) NSString *useFund;    //账号余额

@end

NS_ASSUME_NONNULL_END
