//
//  LXY_KLineVolumeLabel_View.m
//  SSKJ
//
//  Created by 刘小雨 on 2018/10/25.
//  Copyright © 2018年 James. All rights reserved.
//

#import "LXY_KLineVolume_CoordinateView.h"

@interface LXY_KLineVolume_CoordinateView ()

@end

@implementation LXY_KLineVolume_CoordinateView

-(void)drawView
{
    [self setNeedsDisplay];
}

-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    for (int i = 0; i < LXY_NumberofVolumeLine + 2; i++) {
        
        double volume_scale = (self.maxVolume - self.maxVolume) / (LXY_NumberofPriceline + 1);
        
        double volume = self.maxVolume - volume_scale * i;
        
//        NSString *volumeString = [self volumeStringWithVolumeString:volume];
        
        NSString *volumeString = [WLTools noroundingStringWith:volume afterPointNumber:2];
        
        CGFloat width = [WLTools getWidthWithText:volumeString font:systemFont(10)];
        
        [[UIColor clearColor]setFill];//设置填充颜色
        [[UIColor whiteColor]setStroke];
        UIFont  *font = [UIFont boldSystemFontOfSize:10];//设置字体
        CGFloat y = 0;
        if (i == 0) {
            y = 0;
        }else if (i == LXY_NumberofVolumeLine + 1) {
            y = self.height - 10 - 1;
        }else{
            y =  10 + (self.height - 10) / (LXY_NumberofVolumeLine + 1) * i - 10 - 2;
        }
        NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
        [paragraphStyle setAlignment:NSTextAlignmentRight];
        NSDictionary *attribute = @{NSFontAttributeName:font,NSForegroundColorAttributeName:[UIColor lxy_priceColor],NSParagraphStyleAttributeName:paragraphStyle};
        
        [volumeString drawInRect:CGRectMake(0, y, self.width,10) withAttributes:attribute];
        
    }
}

-(NSString *)volumeStringWithVolumeString:(double)volume
{
    if (volume < 100000) {
        return [WLTools noroundingStringWith:volume afterPointNumber:LXY_DecimalNumber];
    }else if (volume < 1000000){
        return [NSString stringWithFormat:@"%@万",[WLTools noroundingStringWith:volume / 10000 afterPointNumber:2]];
    }else if (volume < 10000000){
        return [NSString stringWithFormat:@"%@万",[WLTools noroundingStringWith:volume / 10000 afterPointNumber:1]];
    }else if (volume < 100000000){
        return [NSString stringWithFormat:@"%ld万",(NSInteger)(volume / 10000)];
    }else if (volume < 10000000000){
        return [NSString stringWithFormat:@"%@亿",[WLTools noroundingStringWith:(volume / 100000000) afterPointNumber:2]];
    }else if (volume < 100000000000){
        return [NSString stringWithFormat:@"%@亿",[WLTools noroundingStringWith:(volume / 100000000) afterPointNumber:1]];
    }  else{
        return [NSString stringWithFormat:@"%ld亿",(NSInteger)(volume / 100000000)];
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
