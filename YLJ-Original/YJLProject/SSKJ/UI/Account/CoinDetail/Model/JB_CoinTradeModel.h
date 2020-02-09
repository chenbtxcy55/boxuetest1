//
//  JB_CoinTradeModel.h
//  SSKJ
//
//  Created by James on 2019/5/16.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JB_CoinTradeModel : NSObject
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *userid;
@property (nonatomic, copy) NSString *account;
@property (nonatomic, copy) NSString *ptype;
@property (nonatomic, copy) NSString *pid;
@property (nonatomic, copy) NSString *yprice;
@property (nonatomic, copy) NSString *nprice;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *addtime;
@property (nonatomic, copy) NSString *is_frost;
@property (nonatomic, copy) NSString *state;
@property (nonatomic, copy) NSString *dtime;
@property (nonatomic, copy) NSString *memo;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *stype;

@end

NS_ASSUME_NONNULL_END
