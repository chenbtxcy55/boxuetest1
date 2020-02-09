//
//  FBRecodDetailHeaderView.h
//  SSKJ
//
//  Created by 张本超 on 2019/5/15.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FBRecodDetailHeaderView : UIView
/*1待放币2代付款3等待对方放币4等待对方付款5申诉中
 6申诉成功7申述失败8订单已取消9订单已完成*/
@property (nonatomic, assign) NSInteger recodStatus;
@end

NS_ASSUME_NONNULL_END
