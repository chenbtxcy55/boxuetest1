//
//  ISCM_OTCLimit_Model.h
//  SSKJ
//
//  Created by zpz on 2019/7/27.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ISCM_OTCLimit_Model : NSObject

@property(nonatomic, copy)NSString *buy_min;
@property(nonatomic, copy)NSString *buy_max;
@property(nonatomic, copy)NSString *sell_min;
@property(nonatomic, copy)NSString *sell_max;

@end

NS_ASSUME_NONNULL_END
