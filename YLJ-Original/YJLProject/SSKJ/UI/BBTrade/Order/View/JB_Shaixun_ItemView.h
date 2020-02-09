//
//  JB_Shaixun_ItemView.h
//  SSKJ
//
//  Created by 刘小雨 on 2019/5/15.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JB_Shaixun_ItemView : UIView
@property (nonatomic, assign) BOOL selected;
@property (nonatomic, copy) void (^selectedBlock)(void);

-(instancetype)initWithFrame:(CGRect)frame title:(NSString *)title;

-(void)setValueString:(NSString *)valueString;

@end

NS_ASSUME_NONNULL_END
