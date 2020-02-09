//
//  SSKJ_NewsDetail_ViewController.h
//  ZYW_MIT
//
//  Created by 刘小雨 on 2019/4/2.
//  Copyright © 2019年 Wang. All rights reserved.
//
#import "SSKJ_BaseViewController.h"
#import "SSKJ_NoticeIndex_Model.h"
NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, DetailType) {
    DetailTypeDealGuide,// 交易指南
    DetailTypeNews,     // 资讯
    DetailTypeNotice,    //  平台公告
    
    DetailTypeBB,    // 币币
    DetailTypeFB,    // 法币
    DetailTypeHelperCenter,    // 帮助中心
    
};

@interface SSKJ_NewsDetail_ViewController : SSKJ_BaseViewController

@property (nonatomic, assign) DetailType detailType;



@property (nonatomic, strong) SSKJ_NoticeIndex_Model *noticeModel;
@end

NS_ASSUME_NONNULL_END
