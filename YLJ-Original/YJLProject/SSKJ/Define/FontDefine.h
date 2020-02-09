//
//  FontDefine.h
//  SSKJ
//
//  Created by James on 2018/6/13.
//  Copyright © 2018年 James. All rights reserved.
//

//系统字体对应字号
#define systemFont(x) [UIFont systemFontOfSize:x]

// 粗体
#define systemBoldFont(s) [UIFont fontWithName:@"Helvetica-Bold" size:s]

// 细体
#define systemThinFont(s) [UIFont systemFontOfSize:s weight:UIFontWeightThin]

// 中等体
#define systemMediumFont(s) [UIFont fontWithName:@"PingFangSC-Medium" size:ScaleW(s)]

#define KweixinFont(s) systemThinFont(s)
//对应调整大小后普通字号
#define systemScaleFont(x) [UIFont systemFontOfSize:ScaleW(x)]

//对应调整大小后粗体字号
#define systemScaleBoldFont(x) [UIFont fontWithName:@"Helvetica-Bold" size:ScaleW(x)]
