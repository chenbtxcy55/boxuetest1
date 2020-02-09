//
//  SSKJ_inputPwdAlertView.h
//  SSKJ
//
//  Created by GT on 2019/9/17.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface SSKJ_inputPwdAlertView : UIView

@property (nonatomic, copy) void (^submitBlock)(NSString *pwdCode);
-(void)showAlert;
-(void)hide;
@end

NS_ASSUME_NONNULL_END
