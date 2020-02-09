//
//  SystemRequstMethods.h
//  SSKJ
//
//  Created by 张本超 on 2019/7/1.
//  Copyright © 2019 刘小雨. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^XMCompletioBlock)(NSDictionary *dic, NSURLResponse *response, NSError *error);
typedef void (^XMSuccessBlock)(NSDictionary *data);
typedef void (^XMFailureBlock)(NSError *error);

@interface SystemRequstMethods : NSObject

/**
 *  get请求
 */
+ (void)getWithUrlString:(NSString *)url parameters:(id)parameters success:(XMSuccessBlock)successBlock failure:(XMFailureBlock)failureBlock;

/**
 * post请求
 */
+ (void)postWithUrlString:(NSString *)url parameters:(id)parameters success:(XMSuccessBlock)successBlock failure:(XMFailureBlock)failureBlock;
@end