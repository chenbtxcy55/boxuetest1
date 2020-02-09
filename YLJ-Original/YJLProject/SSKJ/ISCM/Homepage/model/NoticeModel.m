//
//  NoticeModel.m
//  SSKJ
//
//  Created by 张本超 on 2019/7/24.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "NoticeModel.h"

@implementation NoticeModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
  
}
+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"ID":@"id"
             };
    
}
@end
