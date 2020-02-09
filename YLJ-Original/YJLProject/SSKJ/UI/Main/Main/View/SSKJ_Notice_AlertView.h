//
//  SSKJ_Notice_AlertView.h
//  SSKJ
//
//  Created by 孙克强 on 2019/9/18.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SSKJ_Notice_AlertView : UIView
+(void)showWithContent:(NSString *)content andTitle:(NSString *)title confirmBlock:(void(^)(void))confirmblock cancleBlock:(void(^)(void))cancleBlock;

@end

NS_ASSUME_NONNULL_END
