//
//  JB_Account_LicaiDetail_Model.h
//  SSKJ
//
//  Created by 刘小雨 on 2019/5/16.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JB_Account_LicaiDetail_Model : NSObject
@property (nonatomic, copy) NSString *pname;
@property (nonatomic, copy) NSString *usable;   //账户余额
@property (nonatomic, copy) NSString *lend_sum; //累计理财
@property (nonatomic, copy) NSString *in_come;  //累计收益

@end


NS_ASSUME_NONNULL_END
