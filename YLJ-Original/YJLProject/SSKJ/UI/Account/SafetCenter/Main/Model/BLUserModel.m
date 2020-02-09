//
//  BLUserModel.m
//  ZYW_MIT
//
//  Created by 李赛 on 2017/02/14.
//  Copyright © 2018年 Wang. All rights reserved.
//

#import "BLUserModel.h"

@implementation BLUserModel

+ (instancetype)userModelWithDictionary:(NSDictionary *)dict {
    BLUserModel *userModel = [[BLUserModel alloc] init];
    [userModel setValuesForKeysWithDictionary:dict];
    return userModel;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}
-(NSString *)qd_status{
    return @"0";
}


@end
