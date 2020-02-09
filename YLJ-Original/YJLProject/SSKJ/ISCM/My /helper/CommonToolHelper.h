//
//  CommonToolHelper.h
//  MyNewProject
//
//  Created by sun on 2019/2/26.
//  Copyright © 2019 sun. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CommonToolHelper : NSObject
+(instancetype) shareInstance ;


@property(nonatomic,strong) UIViewController * currentVC;

@end

NS_ASSUME_NONNULL_END
