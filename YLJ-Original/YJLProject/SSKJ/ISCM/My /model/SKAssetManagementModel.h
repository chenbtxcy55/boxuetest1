//
//  SKAssetManagementModel.h
//  SSKJ
//
//  Created by 孙克强 on 2019/7/26.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SKAssetManagementModel : NSObject

@property (nonatomic, strong) NSString *type;   //  可用

@property (nonatomic, strong) NSNumber *usableETH;   //  可用
@property (nonatomic, strong) NSNumber *frostETH;//冻结



@property (nonatomic, strong) NSNumber *usableISCM;//  可用

@property (nonatomic, strong) NSNumber *frostISCM;   //冻结
@property (nonatomic, strong) NSString *daishou;    //待售
@property (nonatomic, strong) NSString *keshou;    //可售

@end

NS_ASSUME_NONNULL_END
