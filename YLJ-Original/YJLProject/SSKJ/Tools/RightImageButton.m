//
//  RightImageButton.m
//  JYYunSystem
//
//  Created by zpz on 2018/1/19.
//  Copyright © 2018年 zpz. All rights reserved.
//

#import "RightImageButton.h"

@implementation RightImageButton

- (void)layoutSubviews
{
    [super layoutSubviews];

    CGFloat textW = self.titleLabel.width;
    CGFloat imageW = self.imageView.width;
    CGFloat space = 8;
    
    self.titleLabel.x = (self.width - textW - imageW - space) * 0.5 ;
    self.imageView.x = self.titleLabel.x + self.titleLabel.width + space;
}
@end
