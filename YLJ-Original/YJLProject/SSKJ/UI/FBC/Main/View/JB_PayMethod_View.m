//
//  JB_PayMethod_View.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/5/17.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "JB_PayMethod_View.h"

@interface JB_PayMethod_View ()

@property (nonatomic, strong) NSMutableArray *imagesArray;

@end

@implementation JB_PayMethod_View

-(NSMutableArray *)imagesArray
{
    if (nil == _imagesArray) {
        _imagesArray = [NSMutableArray arrayWithCapacity:10];
    }
    return _imagesArray;
}


-(void)setViewWithModel:(JB_FBC_DealHall_OrderModel *)model
{
    for (UIImageView *imageView in self.imagesArray) {
        [imageView removeFromSuperview];
    }
    
    [self.imagesArray removeAllObjects];
    
    CGFloat startX = 0;
    
    if (model.pay_backcard.integerValue == 1) {
        UIImageView *bankImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScaleW(15), ScaleW(15))];
        bankImageView.image = [UIImage imageNamed:@"bankCard"];
        [self addSubview:bankImageView];
        bankImageView.centerY = self.height / 2;
        startX = bankImageView.right + ScaleW(9);
        [self.imagesArray addObject:bankImageView];
    }
    
    if (model.pay_alipay.integerValue == 1) {
        UIImageView *aliImageView = [[UIImageView alloc]initWithFrame:CGRectMake(startX, 0, ScaleW(15), ScaleW(15))];
        aliImageView.image = [UIImage imageNamed:@"alpay_payways"];
        [self addSubview:aliImageView];
        aliImageView.centerY = self.height / 2;
        startX = aliImageView.right + ScaleW(9);
        [self.imagesArray addObject:aliImageView];

    }
    
    if (model.pay_wx.integerValue == 1) {
        UIImageView *wxImageView = [[UIImageView alloc]initWithFrame:CGRectMake(startX, 0, ScaleW(15), ScaleW(15))];
        wxImageView.image = [UIImage imageNamed:@"wechatPayWay"];

        [self addSubview:wxImageView];
        wxImageView.centerY = self.height / 2;
        startX = wxImageView.right + ScaleW(9);
        [self.imagesArray addObject:wxImageView];

    }
    
    self.width = startX - ScaleW(9);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
