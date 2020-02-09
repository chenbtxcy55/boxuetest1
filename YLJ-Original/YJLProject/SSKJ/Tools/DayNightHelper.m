//
//  DayNightHelper.m
//  SSKJ
//
//  Created by 姚立志 on 2019/8/22.
//  Copyright © 2019 刘小雨. All rights reserved.
//


#define DayNight @"DayNight"

#import "AppDelegate.h"


#import "DayNightHelper.h"

@implementation DayNightHelper

#pragma mark 设置黑白夜间模式
/**
 黑白夜间模式
 @param day 白天标题/图片...
 @param night 晚上标题/图片...
 */
+(id)day:(id)day night:(id)night
{
    if ([DayNightHelper getDayNight])
    {
        return night;
    }
    else
    {
        return day;
    }
}



+(void)setDayNight:(BOOL)day
{
    [[NSUserDefaults standardUserDefaults] setBool:day forKey:DayNight];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    AppDelegate * appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    [appDelegate gotoMain];
}



#pragma mark 获取当前是白天还是黑夜
/**
 白天NO 夜间YES
 
 @return BOOL
 */

+(BOOL)getDayNight
{
    return [[[NSUserDefaults standardUserDefaults] objectForKey:DayNight] boolValue];
}

@end
