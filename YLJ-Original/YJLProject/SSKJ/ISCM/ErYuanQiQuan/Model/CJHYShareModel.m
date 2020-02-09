//
//  CJHYShareModel.m
//  SSKJ
//
//  Created by 张本超 on 2019/6/27.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "CJHYShareModel.h"

@implementation CJHYShareModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
}
@end
