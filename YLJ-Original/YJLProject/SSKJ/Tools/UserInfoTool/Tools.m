//
//  Tools.m
//  SSKJ
//
//  Created by 晶雪之恋 on 2018/9/11.
//  Copyright © 2018年 James. All rights reserved.
//

#import "Tools.h"

@implementation Tools

+ (void)creatPlistWithName:(NSString *)name
{
    NSFileManager *fm = [NSFileManager defaultManager];
    NSString *str = [NSString stringWithFormat:@"%@.plist",name];
    //获取本地沙盒路径
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    //获取完整路径
    NSString *documentsPath = [path objectAtIndex:0];
    NSString *plistPath = [documentsPath stringByAppendingPathComponent:str];
    NSDictionary *dic = [[NSDictionary alloc] initWithContentsOfFile:plistPath];

    if (!dic)
    {
        [fm createFileAtPath:plistPath contents:nil attributes:nil];
    }
}

+ (void)savePlistWithName:(NSString *)name
                    Param:(id)param
{
    NSString *str = [NSString stringWithFormat:@"%@.plist",name];
    //获取本地沙盒路径
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    //获取完整路径
    NSString *documentsPath = [path objectAtIndex:0];
    NSString *plistPath = [documentsPath stringByAppendingPathComponent:str];
    
    NSMutableDictionary *dataDictionary = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    [dataDictionary setObject:[param allObjects][0] forKey:[param allKeys][0]];
    
    //写入文件
    [param writeToFile:plistPath atomically:YES];
}

+ (BOOL)getPlistWithName:(NSString *)name
                     key:(NSString *)key
{
    NSString *str = [NSString stringWithFormat:@"%@.plist",name];
    //获取本地沙盒路径
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    //获取完整路径
    NSString *documentsPath = [path objectAtIndex:0];
    NSString *plistPath = [documentsPath stringByAppendingPathComponent:str];
    
    NSDictionary *dic = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    return [dic[key] boolValue];
}

+ (void)removePlistWithName:(NSString *)name
{
    NSFileManager *fm = [NSFileManager defaultManager];
    NSString *str = [NSString stringWithFormat:@"%@.plist",name];
    //获取本地沙盒路径
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    //获取完整路径
    NSString *documentsPath = [path objectAtIndex:0];
    NSString *plistPath = [documentsPath stringByAppendingPathComponent:str];
    [fm removeItemAtPath:plistPath error:nil];
}

+ (void)removePlistWithName:(NSString *)name
                        key:(NSString *)key
{
    NSString *str = [NSString stringWithFormat:@"%@.plist",name];
    //获取本地沙盒路径
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    //获取完整路径
    NSString *documentsPath = [path objectAtIndex:0];
    NSString *plistPath = [documentsPath stringByAppendingPathComponent:str];
    
    NSDictionary *dic = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    NSMutableDictionary *lastDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    [lastDic removeObjectForKey:key];
    //写入文件
    [lastDic writeToFile:plistPath atomically:YES];
}

@end
