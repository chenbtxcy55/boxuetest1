//
//  ColorDefine.h
//  SSKJ
//
//  Created by James on 2018/6/13.
//  Copyright © 2018年 James. All rights reserved.
//

//#import "UIColor+Hex.h"

#define SSKJIMAGE_NAMED(name) [UIImage imageNamed:name]

//颜色
#define WLColor(r,g,b,a) [UIColor colorWithRed:(r)/255.f green:(g)/255.f blue:(b)/255.f alpha:a]

//由十六进制转换成是十进制
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 \
alpha:1.0]
//由十六进制转换成是十进制
#define UIColorFromARGB(rgbValue,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 \
alpha:a]


// 导航栏title颜色
#define kNavigationTitleColor  UIColorFromRGB(0x878ff5)

#define kNavBGColor  UIColorFromRGB(0x0dcb83)

#define kTheMeColor UIColorFromRGB(0x0dcb83)
// 纯白色
#define kMainWihteColor UIColorFromRGB(0xffffff)

 #define kDeepBgColor UIColorFromRGB(0x071724)

// 主题色
//#define kMainColor UIColorFromRGB(0x1A1A22)
#define kMainColor UIColorFromRGB(0xffffff)

#define kMTextColor UIColorFromRGB(0x666666)

//主题字色
//#define kMainTextColor UIColorFromRGB(0xffffff)
#define kMainTextColor UIColorFromRGB(0x333333)

//绿色
#define kGreenTextColor   UIColorFromRGB(0x5ba56f)

// 亮蓝色
#define kTextLightBlueColor UIColorFromRGB(0x878ff5)

// 暗蓝色
#define kTextDarkBlueColor UIColorFromRGB(0x5b5e95)

// a7蓝色
#define kTextA7BlueColor UIColorFromRGB(0xa7abdb)

// 蓝灰色
#define kTextGrayBlueColor UIColorFromRGB(0x494983)

// 亮白色

// 亮白色
#define kBGGrayColor UIColorFromRGB(0x282A4C)

// 灰色线
#define kLineGrayColor UIColorFromRGB(0xe8e8e8)

// 粉红色
#define kTextPinkWhiteColor UIColorFromRGB(0xd31ba4)

// 橘色
#define kTextOrangeColor UIColorFromRGB(0xe76d42)

// 蓝色
#define kTextBlueColor UIColorFromRGB(0x664fe5)

// K线图颜色
// 红色
#define RED_HEX_COLOR UIColorFromRGB(0xff5755)

// 黄色
#define YELLOW_HEX_COLOR UIColorFromRGB(0xffff00)

// 绿色
#define GREEN_HEX_COLOR UIColorFromRGB(0x08be88)
//1d213a
#define kMianBgColor UIColorFromRGB(0x1d213a)
//151a2e
#define kMianDeepBgColor UIColorFromRGB(0x151a2e)
//5b5e95
#define kTextColor5b5e95 UIColorFromRGB(0x5b5e95)
//d31ba4
#define kTextColord31ba4 UIColorFromRGB(0xd31ba4)
//ff5755
#define kTextColorff5755 UIColorFromRGB(0xff5755)

#define kTextColorClearRed UIColorFromARGB(0xff5755,.5)

#define kWhiteColorClear UIColorFromARGB(0xffffff,.5)
//878ff5
#define kText878ff5 UIColorFromRGB(0x878ff5)
//b9b9b9
#define kTextb9b9b9 UIColorFromRGB(0xb9b9b9)

//32b28f
#define kTextColor32b28f UIColorFromRGB(0x32b28f)
//3c4068
#define kBgColor3c4068 UIColorFromRGB(0x3c4068)
//b3b7e9
#define kTextColorb3b7e9 UIColorFromRGB(0xb3b7e9)
//313359
#define kTextColor313359 UIColorFromRGB(0x313359)
//6b6fb9
#define kTextColor6b6fb9 UIColorFromRGB(0x6b6fb9)
//b2b9e7
#define kTextColorb2b9e7 UIColorFromRGB(0xb2b9e7)
//282c4f
#define kTextColor282c4f UIColorFromRGB(0x282c4f)
//664fe5
#define kTextColor664fe5 UIColorFromRGB(0x664fe5)
//e76d42
#define kTextOrgleColor UIColorFromRGB(0xe76d42)
//353750
#define kBgColor353750 UIColorFromRGB(0x353750)


#define KLeftImgName @"left_my_baise"

#define KleftImg2 @"fanhuiheise"

//--------------Colordefine----//
//主题红色
#define kMainRedColor  UIColorFromRGB(0x5ba56f)
//辅助黄色
#define kSubYellowColor  UIColorFromRGB(0xffbf34)
// 主背景色
#define kMainBackgroundColor UIColorFromRGB(0xffffff)
// 副背景色
#define kSubBackgroundColor UIColorFromRGB(0xf3f3f3)
//主要文字颜色
#define kSMainTxtColor UIColorFromRGB(0x323232)
//次要文字颜色
#define kSubTxtColor UIColorFromRGB(0xb5b8c2)


//最次要文字颜色（placeholder 字体 和其他最次颜色）
#define kSubSubTxtColor UIColorFromRGB(0x969696)
//分割线颜色
#define kMainLineColor UIColorFromRGB(0x121218)
//背景半透明颜色
#define kClearColorBack UIColorFromARGB(0x000000,0.04)

#define kClearBackColor UIColorFromARGB(0x000000,0.5)

#define kClearBackWhiteColor UIColorFromARGB(0xffffff,0.3)

#define kGrayWhiteColor UIColorFromRGB(0xF9F9F9)


#define kSubClearBackColor UIColorFromARGB(0x000000,0.2)

#define kWhiteColorHaveClear UIColorFromARGB(0xffffff,.5)

/*! 颜色 */
//#define kColorA(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]
///*! 微信字体 */
//#define KweixinFont(r) [UIFont fontWithName:@"Helvetica" size:r]
///*! 黑体 */
//#define KHeitiSCMedium(r) [UIFont fontWithName:@"STHeitiSC-Medium" size:r]
///*! 绿色 */
#define ZDGreenColor  [UIColor colorWithRed:68.00f/255.0f green:186.00f/255.0f blue:37.00f/255.0f alpha:1]
//
///*! 背景颜色 */
#define ZDBackgroundColor  [UIColor colorWithRed:239.00f/255.0f green:239.00f/255.0f blue:244.00f/255.0f alpha:1]
#pragma mark - ISCM

/**
 蓝色
 */
#define kMainBlueColor UIColorFromRGB(0x5071d2)

/**
 主黑色
 */
#define kTitleColor UIColorFromRGB(0x323232)

/**
 浅黑色
 */
#define kSubTitleColor UIColorFromRGB(0x646464)
//订单副标题d色

#define KOrderSubTitle UIColorFromRGB(0x979dab)
/**
 背景色
 */
#define kBgColor UIColorFromRGB(0xf5f5f5)

//随机色
#define SKRandomColor [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0]

/**
 灰色
 */
#define kGrayTitleColor UIColorFromRGB(0xaaaaaa)

#define kGrayVersionColor UIColorFromRGB(0x999999)

/**
 绿色(跌)
 */
#define kGreenColor UIColorFromRGB(0x03c087)

/**
 红色(涨)
 */
#define kRedColor UIColorFromRGB(0xff5755)

/**
 行情分割线
 */
#define kMarketLineColor UIColorFromRGB(0xe7eaed)

/**
 字体浅灰色
 */
#define kTitleGrayColor UIColorFromRGB(0x8e94a3)

//RGBCOLOR16(0x4fa0fc)
#define kWhiteBlueColor UIColorFromRGB(0x4fa0fc)


#define kMBBgColor  UIColorFromRGB(0xffffff)

//color03c087
//#define kGreenColor  UIColorFromARGB(0x03c087,.5)

//3e3a39
#define kTextBlackColor UIColorFromRGB(0x3e3a39)

//greenColor 28a07c
#define kTextGreenColor UIColorFromRGB(0x28a07c)

//6d95ff
//#define kTextBlueColor UIColorFromRGB(0x3776fb)
//
/**
 下划线颜色
 */
#define kLineColor  UIColorFromRGB(0x25273f)
//878ff5
#define kText878ff5 UIColorFromRGB(0x878ff5)
//32b28f
#define kTextColor32b28f UIColorFromRGB(0x32b28f)
//3c4068
#define kBgColor3c4068 UIColorFromRGB(0x3c4068)
//b3b7e9
#define kTextColorb3b7e9 UIColorFromRGB(0xb3b7e9)
//313359
#define kTextColor313359 UIColorFromRGB(0x313359)
//6b6fb9
#define kTextColor6b6fb9 UIColorFromRGB(0x6b6fb9)
//b2b9e7
//282c4f
#define kTextColor282c4f UIColorFromRGB(0x282c4f)
//664fe5
#define kTextColor664fe5 UIColorFromRGB(0x664fe5)
//e76d42
//f1f3f6
#define kTextGrayColorF1f3f6 UIColorFromRGB(0xf1f3f6)
//333333
#define kTextGrayColor333333 UIColorFromRGB(0x333333)
//f1f3f6
#define kTextGrayColor9ea4b1 UIColorFromRGB(0x9ea4b1)

//5b5e95
#define kTextColor5b5e95 UIColorFromRGB(0x5b5e95)
//d31ba4
#define kTextColord31ba4 UIColorFromRGB(0xd31ba4)
//ff5755
#define kTextColorff5755 UIColorFromRGB(0xff5755)

#define kTextColorClearRed UIColorFromARGB(0xff5755,.5)

//kline627c9a
#define kTextLineColor UIColorFromRGB(0x627c9a)
#define kTextTabColor UIColorFromRGB(0xc6c6c6)

// 灰黑色字体颜色
#define TextGrayBlackColor1f2e44  [WLTools stringToColor:@"#1f2e44"]

#define TextGrayBlackColor979dab  [WLTools stringToColor:@"#979dab"]

#define TextGrayBlackColor627c9a  [WLTools stringToColor:@"#627c9a"]

#define TextGrayBlackColore3e5e8  [WLTools stringToColor:@"#e3e5e8"]

#define TextGrayBlackColor3776fb  [WLTools stringToColor:@"#3776fb"]

#define TextGrayBlackColord8dcf3  [WLTools stringToColor:@"#d8dcf3"]

#define TextGrayBlackColordb2b6c0  [WLTools stringToColor:@"#b2b6c0"]


#define TextGrayBlackColordb3b7c0  [WLTools stringToColor:@"#b3b7c0"]
//合约色调
//8e94a3
#define kTextColor8e94a3 UIColorFromRGB(0x8e94a3)
// 灰黑色字体颜色
#define TextGrayBlackColor  [WLTools stringToColor:@"#4d4d4d"]
//2f3452
#define kTextColor2f3452 UIColorFromRGB(0x2f3452)

// 灰黑色字体颜色
#define TextGrayBlackColore5e8eb  [WLTools stringToColor:@"#e5e8eb"]

/**
 button背景颜色
 */
#define kBtnBgColor UIColorFromRGB(0x5071d2)

#define TextGrayBlackColord2e6afe  [WLTools stringToColor:@"#2e6afe"]

#define kGreenMainColor  [WLTools stringToColor:@"#03c087"]


#define kLineBgColor  [WLTools stringToColor:@"#f2f2f2"]


#define CodeBtnColor  [WLTools stringToColor:@"#58a471"]

#define CopeBtnColor  [WLTools stringToColor:@"#11b67a"]

#define TextGraycecece  [WLTools stringToColor:@"#cecece"]

#define TextGrayb5b5b5  [WLTools stringToColor:@"#b5b5b5"]

#define TextGray990000 [WLTools stringToColor:@"#990000"]

#define TextGraye1e1e1 [WLTools stringToColor:@"#e1e1e1"]


#define TextGray1d312f [WLTools stringToColor:@"#1d312f"]

#define TextGray6a6b6e [WLTools stringToColor:@"#6a6b6e"]

#define TextGray666666 [WLTools stringToColor:@"#666666"]
