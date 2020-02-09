//
//  WYVerifyTool.h
//  ICC
//
//  Created by zpz on 2019/7/17.
//  Copyright © 2019 WeiLv Technology. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WYVerifyTool : NSObject
+ (WYVerifyTool *)sharedInstance;;

- (void)startVerifyCompletion:(void (^)(BOOL result,NSString* __nullable validate,NSString *message))completion;


@end

NS_ASSUME_NONNULL_END