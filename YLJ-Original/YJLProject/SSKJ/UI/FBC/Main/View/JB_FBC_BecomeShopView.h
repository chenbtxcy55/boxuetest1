//
//  JB_FBC_BecomeShopView.h
//  SSKJ
//
//  Created by James on 2019/5/23.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JB_FBC_BecomeShopView : UIView
+(void)showWithTitle:(NSString *)title confirmBlock:(void (^)(void))confirmBlock;
@end

NS_ASSUME_NONNULL_END
