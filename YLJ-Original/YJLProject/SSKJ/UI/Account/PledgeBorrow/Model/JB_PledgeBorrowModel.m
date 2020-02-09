//
//  JB_PledgeBorrowModel.m
//  SSKJ
//
//  Created by James on 2019/5/16.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "JB_PledgeBorrowModel.h"

@implementation JB_PledgeBorrowModel
+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"outString":@"out",
             @"inString":@"in"
             };
    
}
@end
