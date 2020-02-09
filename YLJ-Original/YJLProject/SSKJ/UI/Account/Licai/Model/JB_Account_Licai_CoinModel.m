//
//  JB_Account_Licai_CoinModel.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/5/15.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "JB_Account_Licai_CoinModel.h"

@implementation JB_Account_Licai_CoinModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{
             @"tenday_rate": @"10day_rate",
             @"tweentyday_rate": @"20day_rate",
             @"thirtyday_rate": @"30day_rate",
             };
}

+(NSDictionary *)mj_objectClassInArray
{
    return @{
             @"day_rate" : @"JB_Account_LicaiCycle_Model"
             };
    
}
@end
