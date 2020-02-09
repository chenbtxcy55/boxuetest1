//
//  OTCVerifyDealTool.m
//  SSKJ
//
//  Created by zpz on 2019/7/31.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "OTCVerifyDealTool.h"

@implementation OTCVerifyDealTool

+ (void)startVerifyCompletion:(void (^)(void))completion{

    [CMRemind show];
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:ISCM_OTC_JudgeDeal RequestType:RequestTypePost Parameters:nil Success:^(NSInteger statusCode, id responseObject) {

        [CMRemind dismiss];
        
        WL_Network_Model *net_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if (net_model.status.integerValue == SUCCESSED) {
            NSInteger min = [net_model.data[@"am_startTime"] integerValue];
            NSInteger max = [net_model.data[@"am_endTime"] integerValue];
            
            NSInteger pm_min = [net_model.data[@"pm_startTime"] integerValue];
            NSInteger pm_max = [net_model.data[@"pm_endTime"] integerValue];
            NSInteger current = [net_model.data[@"currentHour"] integerValue];
            if ((current >= min && current <= max) || (current >= pm_min && current <= pm_max)) {
                completion();
            }else{
                [CMRemind error:@"当前时间不在交易时段"];
            }

        }else{
            [MBProgressHUD showError:net_model.msg];
        }
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [CMRemind dismiss];
    }];
}

@end
