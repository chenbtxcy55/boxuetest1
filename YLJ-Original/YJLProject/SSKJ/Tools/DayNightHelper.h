//
//  DayNightHelper.h
//  SSKJ
//
//  Created by 姚立志 on 2019/8/22.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DayNightHelper : NSObject

/**
 白天设置为NO 夜间设置YES

 @param day BOOL
 */
+(void)setDayNight:(BOOL)day;





#pragma mark 获取当前是白天还是黑夜
/**
 白天NO 夜间YES

 @return BOOL
 */
+(BOOL)getDayNight;

#pragma mark 设置黑白夜间模式
/**
 黑白夜间模式
 @param day 白天标题/图片...
 @param night 晚上标题/图片...
 */
+(id)day:(id)day night:(id)night;





@end

NS_ASSUME_NONNULL_END
