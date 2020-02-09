//
//  AddressMessageModel.m
//  SSKJ
//
//  Created by 张本超 on 2019/6/14.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "AddressMessageModel.h"

@implementation AddressMessageModel
+ (NSDictionary *)replacedKeyFromPropertyName {
    
       return @{  @"address_id":@"ID",
                  @"phone":@"mobile",
                  @"province":@"sheng",
                  @"city":@"shi",
                  @"country":@"qu",
                  @"is_default":@"default_status",
                  @"address_name":@"name",
                  @"detail":@"address",
                                 };
   
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"address_id"]) {
        self.ID = value;
    }
    if ([key isEqualToString:@"phone"]) {
        self.mobile = value;
    }
    if ([key isEqualToString:@"province"]) {
        self.sheng = value;
    }
    if ([key isEqualToString:@"city"]) {
        self.shi = value;
    }
    if ([key isEqualToString:@"country"]) {
        self.qu = value;
    }
    if ([key isEqualToString:@"is_default"]) {
        self.default_status = value;
    }
    if ([key isEqualToString:@"address_name"]) {
        self.name = value;
    }
    if ([key isEqualToString:@"detail"]) {
        self.address = value;
    }
    
//    "province": "安徽省",
//    //"city": "安庆",
//    //"country": "大庆区",
}

@end
