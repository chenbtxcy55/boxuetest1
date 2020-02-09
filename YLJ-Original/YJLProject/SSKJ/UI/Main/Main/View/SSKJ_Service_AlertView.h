//
//  SSKJ_Service_AlertView.h
//  SSKJ
//
//  Created by cy5566 on 2019/11/25.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SSKJ_Service_AlertView : UIView
+(void)showWithModel:(NSString *)content confirmBlock:(void(^)(void))confirmblock cancleBlock:(void(^)(void))cancleBlock;

@end

NS_ASSUME_NONNULL_END
