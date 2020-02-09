//
//  JB_Login_Google_ActionSheetView.h
//  SSKJ
//
//  Created by 刘小雨 on 2019/5/28.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JB_Login_Google_ActionSheetView : UIView
@property (nonatomic, copy) void (^confirmBlock)(NSString *code);
-(void)show;
-(void)hide;
@end

NS_ASSUME_NONNULL_END
