//
//  JB_Account_Asset_CoinModel.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/5/16.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "JB_Account_Asset_CoinModel.h"

@implementation JB_Account_Asset_CoinModel
+(NSDictionary *)mj_objectClassInArray
{
    return @{
             @"asset" : @"JB_Account_Asset_Index_Model",
             @"total":@"JB_Account_AssetTotal_Model"
             };
    
}
@end
