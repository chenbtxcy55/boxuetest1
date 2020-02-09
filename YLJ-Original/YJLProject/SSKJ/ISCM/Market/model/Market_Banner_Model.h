//
//  Market_Banner_Model.h
//  SSKJ
//
//  Created by zpz on 2019/7/24.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Market_Banner_Model : NSObject

/**
 图片URL
 */
@property(nonatomic, copy)NSString *path;
@property(nonatomic, copy)NSString *banner_url;


/**
 
 */
@property(nonatomic, copy)NSString *name;

/**
 
 */
@property(nonatomic, copy)NSString *url;

@end

NS_ASSUME_NONNULL_END
