//
//  LockedView.h
//  SSKJ
//
//  Created by 张本超 on 2019/7/19.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LockHeaderModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface LockedView : UIView

@property (nonatomic, strong) void(^recodeBlcok)(void);

@property (nonatomic, strong) void(^gobackBlcok)(void);

@property (nonatomic, strong) LockHeaderModel *model;

@end

NS_ASSUME_NONNULL_END
