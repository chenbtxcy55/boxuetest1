//
//  LockedModel.m
//  SSKJ
//
//  Created by 张本超 on 2019/7/24.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "LockedModel.h"

@implementation LockedModel

+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"ID":@"id"
             };
    
}
@end
