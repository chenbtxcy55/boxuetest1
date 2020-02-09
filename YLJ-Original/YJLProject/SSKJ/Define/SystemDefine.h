//
//  SystemDefines.h
//  WeiLv
//
//  Created by James on 15/12/17.
//  Copyright © 2015年 WeiLv Technology. All rights reserved.
//

//获取当前iOS系统版本号
#define SystemVersion   [[[UIDevice currentDevice] systemVersion] floatValue]

//获取当前APP版本号
#define AppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]


//日志宏定义、日志函数 宏定义
#import "LogDefine.h"

//屏幕尺寸、比例、视图坐标、导航栏高度、状态栏高度
#import "ScreenDefine.h"

//iPhone机型设备 宏定义
#import "DeviceDefine.h"

//颜色 宏定义
#import "ColorDefine.h"

//字体 宏定义
#import "FontDefine.h"

//系统常用（获取系统版本号、App版本、沙盒路径、NSUserDefault、字符串、字典、数组、对象为空等等）
#import "CommonDefine.h"

//接口地址 宏定义
#import "URLDefine.h"


#import "ThirdDefine.h"


