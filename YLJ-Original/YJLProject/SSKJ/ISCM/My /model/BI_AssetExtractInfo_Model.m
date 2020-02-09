//
//  BI_AssetExtractInfo_Model.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/7/1.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "BI_AssetExtractInfo_Model.h"
//@property (nonatomic, copy) NSString *tbFeeRate;    //提币手续费
//@property (nonatomic, copy) NSString *tbMinRate;    //最小提币数
//@property (nonatomic, copy) NSString *tbMaxRate;    //最大提币数
//@property (nonatomic, copy) NSString *useFund;    //账号余额

@implementation BI_AssetExtractInfo_Model
+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"tbFeeRate":@"tb_fee",
             @"tbMaxRate":@"tb_max",

             @"tbMinRate":@"tb_min",
             @"useFund":@"user_usable",

             };
    
}

@end
