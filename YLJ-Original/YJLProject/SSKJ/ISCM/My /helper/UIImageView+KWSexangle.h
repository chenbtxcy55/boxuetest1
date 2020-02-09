//
//  UIImageView+KWSexangle.h
//  SSKJ
//
//  Created by 孙克强 on 2019/7/27.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (KWSexangle)
/**
 *  绘制六边形
 */
- (instancetype)initWithDrawSexangleWithImageViewWidth:(CGFloat)width withLineWidth:(CGFloat)lineWidth withStrokeColor:(UIColor *)color;
@end

NS_ASSUME_NONNULL_END
