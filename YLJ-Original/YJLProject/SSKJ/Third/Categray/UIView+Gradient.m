//
//  UIButton+Gradient.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/3/4.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "UIView+Gradient.h"

@implementation UIView (Gradient)
-(void)addGradientColor
{
    self.backgroundColor = kMainBlueColor;
    return;
    NSArray *colors = @[(id)[UIColor colorWithHexStringToColor:@"4b8ff2"].CGColor,
                        (id)[UIColor colorWithHexStringToColor:@"8a3dcb"].CGColor,
                        (id)[UIColor colorWithHexStringToColor:@"c90092"].CGColor];
    
    CAGradientLayer* gradinentlayer=[CAGradientLayer layer];
    gradinentlayer.colors = colors;
    //分割点  设置 风电设置不同渐变的效果也不相同
    gradinentlayer.locations=@[@0.0,@0.5,@1.0];
    gradinentlayer.startPoint=CGPointMake(0, 0);
    gradinentlayer.endPoint=CGPointMake(1.0, 0.0);
    gradinentlayer.frame = self.bounds;
    [self.layer insertSublayer:gradinentlayer atIndex:0];
    
//    self.layer.masksToBounds = YES;
//    [self setBackgroundImage:[UIImage imageNamed:@"btn_default"] forState:UIControlStateNormal];
}
@end
