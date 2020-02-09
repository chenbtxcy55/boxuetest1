//
//  JB_Progress_ButtonView.h
//  SSKJ
//
//  Created by 刘小雨 on 2019/5/27.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JB_Progress_ButtonView : UIView

-(instancetype)initWithFrame:(CGRect)frame btnColor:(UIColor *)btnColor;

@property (nonatomic, assign) BOOL selected;
@end

NS_ASSUME_NONNULL_END
