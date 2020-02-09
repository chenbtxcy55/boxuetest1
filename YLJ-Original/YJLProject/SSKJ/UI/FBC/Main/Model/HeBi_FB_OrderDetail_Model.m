//
//  HeBi_FB_OrderDetail_Model.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/4/17.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "HeBi_FB_OrderDetail_Model.h"

@implementation HeBi_FB_OrderDetail_Model


-(NSDictionary *)mj_objectClassInArray
{
    return @{
             @"pay_list" : @"HeBi_PayMethod_Index_Model",
             };
}

@end
