//
//  WLLAssetsInfoModel.h
//  ZYW_MIT
//
//  Created by 李赛 on 2017/02/14.
//  Copyright © 2018年 Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WLLAssetsInfoModel : NSObject
@property (nonatomic, copy) NSString *cny;  // 折合人民币
@property (nonatomic, copy) NSString *pname;  // 币名
@property (nonatomic, copy) NSString *usable;  // 可用
@property (nonatomic, copy) NSString *frost;   // 冻结
@property (nonatomic, copy) NSString *uptime; // 钱包
@property (nonatomic, copy) NSString *pid;
@property (nonatomic, copy) NSString *stockCode;  // 币code
@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *apply_reason; // 审核失败原因
@end
