//
//  ServersContactView.h
//  SSKJ
//
//  Created by 张本超 on 2019/6/14.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ServersContactView : UIView
@property (nonatomic, copy) void(^cancellBlock)(void);
@property (nonatomic, copy) void(^commitBlock)(void);


@end
NS_ASSUME_NONNULL_END
