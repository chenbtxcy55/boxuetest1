//
//  JB_Main_BannerModel.h
//  SSKJ
//
//  Created by 刘小雨 on 2019/5/15.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JB_Main_BannerModel : NSObject
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *url;              // 跳转链接
@property (nonatomic, copy) NSString *path;

@end

NS_ASSUME_NONNULL_END
