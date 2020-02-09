//
//  JB_WebView_Controller.h
//  SSKJ
//
//  Created by 刘小雨 on 2019/5/13.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "SSKJ_BaseViewController.h"
#import "NoticeModel.h"

typedef NS_ENUM(NSUInteger, PROTOCOLTYPE) {
    PROTOCOLTYPEREGISTER,           // 注册协议
    PROTOCOLTYPEPRIVACY,             // 隐私条款
    PROTOCOLTYPEPTRADE,             // 交易规则
    PROTOCOLTYPEPLAW,             //法律说明
    PROTOCOLTYPEPABOUT,             //关于平台
    PROTOCOLTYPEPABOUTAML,             //关于反洗钱
};
NS_ASSUME_NONNULL_BEGIN

@interface JB_WebView_Controller : SSKJ_BaseViewController

@property (nonatomic, assign) PROTOCOLTYPE protocolType;

@property (nonatomic, strong) NSString *idString;
@property (nonatomic, strong) NoticeModel *nmodel;


@end

NS_ASSUME_NONNULL_END
