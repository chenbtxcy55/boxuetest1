//
//  My_BindGoogle_AlertView.h
//  ZYW_MIT
//
//  Created by 刘小雨 on 2019/3/28.
//  Copyright © 2019年 Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, GOOGLETYPE) {
    GOOGLETYPEADD,
    GOOGLETYPEDELETE,
};

NS_ASSUME_NONNULL_BEGIN

@interface My_BindGoogle_AlertView : UIView

@property (nonatomic, copy) void (^submitBlock)(NSString *googleCode,NSString *smsCode);
-(void)showWithType:(GOOGLETYPE)googleType;
-(void)hide;
@end

NS_ASSUME_NONNULL_END
