//
//  ScreenDefine.h
//  SSKJ
//
//  Created by James on 2018/6/13.
//  Copyright © 2018年 James. All rights reserved.
//

//屏幕相关
#define AppWindow ([UIApplication sharedApplication].keyWindow)

#define WindowContent  ([[UIScreen mainScreen] bounds])

#define ScreenSize      [UIScreen mainScreen].bounds.size

#define ScreenWidth     ([[UIScreen mainScreen] bounds].size.width)

#define ScreenHeight    ([[UIScreen mainScreen] bounds].size.height)

#define ScreenMaxLength (MAX(ScreenWidth,ScreenHeight))

#define ScreenMinLength (MIN(ScreenWidth,ScrrenHeight))


//各屏幕尺寸比例

#define ScaleW(width)  width*ScreenWidth/375






