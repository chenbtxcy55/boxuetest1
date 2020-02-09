//
//  JB_Account_Licai_Main_TitleView.h
//  SSKJ
//
//  Created by 刘小雨 on 2019/5/15.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JB_Account_Licai_Main_TitleView : UIView

@property (nonatomic, copy) void (^tapBlock)(void);
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) BOOL selected;
@end

NS_ASSUME_NONNULL_END
