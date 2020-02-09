//
//  HomeHeader.h
//  SSKJ
//
//  Created by 张本超 on 2019/7/19.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeHeader : UIView

@property (nonatomic, copy) void(^lockedBlock)(void);

@property (nonatomic, copy) void(^notifacationBlock)(void);

@property (nonatomic, copy) void(^showAddressBlock)(NSString *address);

@property (nonatomic, strong) UILabel *moneyValueLabel;


@property (nonatomic, strong) UILabel *addressLabel;
@end

NS_ASSUME_NONNULL_END
