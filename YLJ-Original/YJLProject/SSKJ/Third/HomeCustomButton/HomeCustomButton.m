//
//  HomeCustomButton.m
//  SSKJ
//
//  Created by 赵亚明 on 2019/4/9.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "HomeCustomButton.h"

@implementation HomeCustomButton

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // Center image
    CGPoint center = self.imageView.center;
    center.x = self.frame.size.width/2;
    center.y = self.bounds.size.height/2 - self.imageView.frame.size.height/2 ;
    self.imageView.center = center;
    
    //Center text
    CGRect newFrame = [self titleLabel].frame;
    newFrame.origin.x = 0;
    newFrame.origin.y = self.imageView.frame.origin.y + self.imageView.frame.size.height + 5;
    newFrame.size.width = self.frame.size.width;
    
    self.titleLabel.frame = newFrame;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

@end
