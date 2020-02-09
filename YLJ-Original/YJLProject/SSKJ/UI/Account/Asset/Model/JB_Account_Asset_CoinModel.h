//
//  JB_Account_Asset_CoinModel.h
//  SSKJ
//
//  Created by 刘小雨 on 2019/5/16.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JB_Account_Asset_Index_Model.h"
#import "JB_Account_AssetTotal_Model.h"

NS_ASSUME_NONNULL_BEGIN

@interface JB_Account_Asset_CoinModel : NSObject

@property (nonatomic, strong) NSArray<JB_Account_Asset_Index_Model *> *asset;

@property (nonatomic, strong) JB_Account_AssetTotal_Model *total;//账户使用
// 理财账户使用
@property (nonatomic, copy) NSString *ttl_money;    // //折合AB
@property (nonatomic, copy) NSString *ttl_cnymoney;    // //折合cny

// 交易账户使用
@property (nonatomic, copy) NSString *wallone;    // //折合AB


@end

NS_ASSUME_NONNULL_END
