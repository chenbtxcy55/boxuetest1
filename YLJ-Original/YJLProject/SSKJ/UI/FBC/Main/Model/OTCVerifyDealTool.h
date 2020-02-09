//
//  OTCVerifyDealTool.h
//  SSKJ
//
//  Created by zpz on 2019/7/31.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface OTCVerifyDealTool : NSObject

+ (void)startVerifyCompletion:(void (^)(void))completion;


@end

NS_ASSUME_NONNULL_END
