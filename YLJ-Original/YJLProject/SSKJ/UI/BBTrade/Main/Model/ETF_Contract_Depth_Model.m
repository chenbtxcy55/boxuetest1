//
//  ETF_Contract_Depth_Model.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/1/25.
//  Copyright © 2019年 James. All rights reserved.
//

#import "ETF_Contract_Depth_Model.h"

@implementation ETF_Contract_Depth_Model
+(NSDictionary *)mj_objectClassInArray
{
    return @{
             @"asks" : @"ETF_Contract_Depth_Index_Model",
             @"bids" : @"ETF_Contract_Depth_Index_Model",
             };
}
@end
