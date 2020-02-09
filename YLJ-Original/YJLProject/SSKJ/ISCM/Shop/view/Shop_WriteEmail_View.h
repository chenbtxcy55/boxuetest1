//
//  Shop_WriteEmail_View.h
//  SSKJ
//
//  Created by 张本超 on 2019/6/10.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Shop_WriteEmail_View : UIView
@property (nonatomic, copy) void(^cancellBlock)(void);
@property (nonatomic, copy) void(^commitBlock)(NSString *name,NSString *orderNum);


@end

NS_ASSUME_NONNULL_END
