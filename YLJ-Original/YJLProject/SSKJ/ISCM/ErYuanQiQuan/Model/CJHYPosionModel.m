//
//  CJHYPosionModel.m
//  SSKJ
//
//  Created by 张本超 on 2019/6/27.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "CJHYPosionModel.h"

@implementation CJHYPosionModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
  
    if ([key isEqualToString:@"order_cycle"]) {
        self.time = value;
    }
    if ([key isEqualToString:@"profit"]) {
        self.income = value;
    }
    
    if ([key isEqualToString:@"order_type"]) {
        self.type = value;
    }
}
@end
