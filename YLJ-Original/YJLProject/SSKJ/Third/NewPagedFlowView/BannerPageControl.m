//
//  BannerPageControl.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/7/8.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "BannerPageControl.h"

@implementation BannerPageControl
- (void)setCurrentPage:(NSInteger)page {
        [super setCurrentPage:page];
    for (NSUInteger subviewIndex = 0; subviewIndex < [self.subviews count]; subviewIndex++) {
        UIView *subview = [self.subviews objectAtIndex:subviewIndex];
        UIImageView *imageView = nil;
        if (subviewIndex == page) {
            CGFloat w = 12;
            CGFloat h = 2;
            imageView = [[UIImageView alloc] initWithFrame:CGRectMake(-1.5, -1.5, w, h)];
            imageView.backgroundColor = kTheMeColor;
            //            imageView.image = [UIImage imageNamed:@"banner_red"];
            [subview setFrame:CGRectMake(subview.frame.origin.x, subview.frame.origin.y, w, h)];
        } else {
            CGFloat w = 12;
            CGFloat h = 2;
            imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -1.5, w, h)];
            //            imageView.image = [UIImage imageNamed:@"banner_gray"];
            imageView.backgroundColor = kMainWihteColor;
            
            [subview setFrame:CGRectMake(subview.frame.origin.x, subview.frame.origin.y, w, h)];
        }
        imageView.tag = 10010;
        UIImageView *lastImageView = (UIImageView *) [subview viewWithTag:10010];
        [lastImageView removeFromSuperview]; //把上一次添加的view移除
        [subview addSubview:imageView];
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
