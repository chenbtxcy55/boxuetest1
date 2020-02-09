//
//  SSKJ_QR_AlertView.h
//  SSKJ
//
//  Created by cy5566 on 2019/12/2.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SSKJ_QR_AlertView : UIView
+(void)showWithUrl:(NSString *)urlstr confirmBlock:(void(^)(void))confirmblock cancleBlock:(void(^)(void))cancleBlock;

@end

NS_ASSUME_NONNULL_END
