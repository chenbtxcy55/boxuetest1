//
//  MyButton.m
//  ChangChang
//
//  Created by hu Jack on 2017/11/13.
//  Copyright © 2017年 HRHS. All rights reserved.
//

#import "MyButton.h"

@implementation MyButton


- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    
    if (_imgtop) {
        
        return CGRectMake(0, contentRect.size.height-15, contentRect.size.width, 15);
    }
    if (_imgHeight) {
        
        
        
        return CGRectMake(0, (contentRect.size.height-_imgHeight)/2+_imgHeight+10, contentRect.size.width, 15);
    }
    return [super titleRectForContentRect:contentRect];
}
-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    
    CGFloat width=9;
    
    CGFloat height=16.5;
    CGFloat top=(contentRect.size.height-_imgHeight)/2;
    
    if (_imgtop) {
        
        top=_imgtop;
        
    }
    if (_imgWidth) {
        return CGRectMake((contentRect.size.width-_imgWidth)/2,top, _imgWidth, _imgWidth);

        
    }
    if (_imgHeight) {
        return CGRectMake((contentRect.size.width-_imgWidth)/2,top, _imgWidth, _imgHeight);
        
        
    }
    return CGRectMake(10,top, width, height);
    
    
}

@end
