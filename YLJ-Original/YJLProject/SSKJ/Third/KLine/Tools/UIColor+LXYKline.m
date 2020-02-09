//
//  UIColor+LXYKline.m
//  SSKJ
//
//  Created by 刘小雨 on 2018/10/22.
//  Copyright © 2018年 James. All rights reserved.
//

#import "UIColor+LXYKline.h"

@implementation UIColor (LXYKline)

+(UIColor *)lxy_kLineBoundsColor       // 边框色
{
//    return [WLTools stringToColor:@"#24374F"];
//    return [WLTools stringToColor:@"#dcdcdc"];
    return [WLTools stringToColor:@"#ffffff"];
    
}

+(UIColor *)lxy_kLineBGColor       // k线图背景色
{
    return kNavBGColor;
//    return UIColorFromRGB(0xffffff);
}

+(UIColor *)lxy_kLine_Main_BGColor       // k线图主k线图背景色
{
//    return [WLTools stringToColor:@"#131F2F"];
    return kNavBGColor;

//    return UIColorFromRGB(0xffffff);
}


+(UIColor *)lxy_kLine_Volume_BGColor       // k线图成交量图背景色
{
//    return [WLTools stringToColor:@"#131F2F"];
    return kNavBGColor;

//    return UIColorFromRGB(0xffffff);
}
+(UIColor *)lxy_kLine_BorderColor          // 边框颜色
{
//    return [WLTools stringToColor:@"#24374F"];
    return [WLTools stringToColor:@"#dcdcdc"];
}

+(UIColor *)lxy_kLine_Divider_Color       // 分割线颜色
{
    return [WLTools stringToColor:@"#31447e"];
//    return [WLTools stringToColor:@"#ffffff"];
}


+(UIColor *)lxy_riseColor      // 涨的颜色
{
    return kGreenColor;
}

+(UIColor *)lxy_fallColor      // 跌的颜色
{
    return kRedColor;
}

+(UIColor *)lxy_MA5Color      // MA5的颜色
{
    return [WLTools stringToColor:@"#FCDF99"];
}

+(UIColor *)lxy_MA10Color      // MA10的颜色
{
    return [WLTools stringToColor:@"#6CDDCB"];
}

+(UIColor *)lxy_MA20Color      // MA20的颜色
{
    return [WLTools stringToColor:@"#C7A1F2"];
}
+(UIColor *)lxy_BollMBColor      // Boll_mb的颜色
{
    return [WLTools stringToColor:@"#6CDDCB"];
}
+(UIColor *)lxy_BollUPColor      // Boll_up的颜色
{
    return [WLTools stringToColor:@"#6CDDCB"];
}

+(UIColor *)lxy_BollDNColor      // Boll_dn的颜色
{
    return [WLTools stringToColor:@"#C7A1F2"];
}


+(UIColor *)lxy_priceColor      // 价格的颜色
{
    return [WLTools stringToColor:@"#b5b8c2"];
//    return kTextGrayColorA4;
}

+(UIColor *)lxy_FloatPriceColor      // 浮动价格的颜色
{
        return kMainTextColor;
//    return kTextBlckColor;
}

+(UIColor *)lxy_volumeColor      // 成交量的颜色
{
    return [WLTools stringToColor:@"#7691B2"];
//    return kTextGrayColorA4;
}

+(UIColor *)lxy_timeColor      // 时间的颜色
{
    return [WLTools stringToColor:@"#bbbbbb"];
//    return kTextGrayBlackColor64;
}

+(UIColor *)lxy_crossLineColor      // 十字线的颜色
{
    return [WLTools stringToColor:@"#faf4eb"];
//    return [WLTools stringToColor:@"#a4a6bf"];
}

+(UIColor *)lxy_animationColor
{
    return [UIColor whiteColor];
//    return kTextPurpleColor;

}

+(UIColor *)lxy_tipBgColor      // 浮窗的颜色
{
    return [[WLTools stringToColor:@"#aaaaaa"] colorWithAlphaComponent:0.3];
//    return kTextBlckColor;
}

+(UIColor *)lxy_stockTimeLineColor      // 分时图线的颜色
{
//    return kTextLightBlueColor;
    return kGreenColor;
}

+(UIColor *)lxy_stockTimeFillColor      // 分时图线的填充色
{
//    return [WLTools stringToColor:@"#664fe5" andAlpha:0.3];
//    return kMainBlueColor;
    return [UIColor clearColor];

}

+(UIColor *)lxy_MACDColor      // MACD的颜色
{
    return [WLTools stringToColor:@"#7691B2"];
}


+(UIColor *)lxy_DIFColor      // DIF的颜色
{
    return [WLTools stringToColor:@"#FCDF99"];
}

+(UIColor *)lxy_DEAColor      // DEA的颜色
{
    return [WLTools stringToColor:@"#6CDDCB"];
}

+(UIColor *)lxy_KDJColor      // KDJ的颜色
{
    return [WLTools stringToColor:@"#7691B2"];
}

+(UIColor *)lxy_KDJ_KColor      // KDJ_K的颜色
{
    return [WLTools stringToColor:@"#FCDF99"];
}

+(UIColor *)lxy_KDJ_DColor      // KDJ_D的颜色
{
    return [WLTools stringToColor:@"#6CDDCB"];
}
+(UIColor *)lxy_KDJ_JColor      // KDJ_J的颜色
{
    return [WLTools stringToColor:@"#C7A1F2"];
}


+(UIColor *)lxy_RSI6Color      // RSI6的颜色
{
    return [WLTools stringToColor:@"#FCDF99"];
}

+(UIColor *)lxy_RSI12Color      // RSI12的颜色
{
    return [WLTools stringToColor:@"#6CDDCB"];
}

+(UIColor *)lxy_RSI24Color      // RSI24的颜色
{
    return [WLTools stringToColor:@"#C7A1F2"];
    
}

+(UIColor *)lxy_WR14Color      // WR14的颜色
{
    return [WLTools stringToColor:@"#FCDF99"];
}

@end
