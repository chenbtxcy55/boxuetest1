//
//  LXY_DeepView.h
//  深度
//
//  Created by 刘小雨 on 2019/3/19.
//  Copyright © 2019年 MingShao. All rights reserved.
//

#import <UIKit/UIKit.h>



NS_ASSUME_NONNULL_BEGIN

@interface LXY_DeepView : UIView
@property(nonatomic,assign) BOOL isNeedPrice;

-(void)setData:(NSDictionary *)data;

@end

NS_ASSUME_NONNULL_END
