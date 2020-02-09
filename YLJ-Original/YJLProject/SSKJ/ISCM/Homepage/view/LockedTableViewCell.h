//
//  LockedTableViewCell.h
//  SSKJ
//
//  Created by 张本超 on 2019/7/19.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LockedModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface LockedTableViewCell : UITableViewCell

@property (nonatomic, copy) void(^buyBlock)(void);

@property (nonatomic, strong) LockedModel *model;

@end

NS_ASSUME_NONNULL_END
