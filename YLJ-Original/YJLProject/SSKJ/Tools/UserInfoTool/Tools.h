//
//  Tools.h
//  SSKJ
//
//  Created by 晶雪之恋 on 2018/9/11.
//  Copyright © 2018年 James. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tools : NSObject

+ (void)creatPlistWithName:(NSString *)name;

+ (void)savePlistWithName:(NSString *)name
                    Param:(id)param;
+ (BOOL)getPlistWithName:(NSString *)name
                               key:(NSString *)key;
+ (void)removePlistWithName:(NSString *)name;
+ (void)removePlistWithName:(NSString *)name
                        key:(NSString *)key;

@end
