//
//  LogDefine.h
//  SSKJ
//
//  Created by James on 2018/6/13.
//  Copyright © 2018年 James. All rights reserved.
//

//自定义日志输出宏
#if (DEBUG || TESTCASE)
  #define SsLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
  #define SsLog(...)
#endif


