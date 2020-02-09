//
//  JB_Lend_JieKuanCoinDetail_Model.h
//  SSKJ
//
//  Created by James on 2019/5/21.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JB_Lend_JieKuanCoinDetail_Model : NSObject
@property (nonatomic, copy) NSString *pname;        // 名称
@property (nonatomic, copy) NSString *usable;       // 可用
@property (nonatomic, copy) NSString *price_AB;   // 折合成AB
@property (nonatomic, copy) NSString *price_cny;    // 折合成CNY
@end

NS_ASSUME_NONNULL_END
