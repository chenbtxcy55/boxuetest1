//
//  HeBi_Version_Model.h
//  SSKJ
//
//  Created by 刘小雨 on 2019/4/19.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HeBi_Version_Model : NSObject

//下载地址
@property(nonatomic,copy)NSString *addr;

//版本号
@property(nonatomic,copy)NSString *version;

//更新标题
@property(nonatomic,copy)NSString *title;

//更新内容
@property(nonatomic,copy)NSString *content;

//发布时间
@property(nonatomic,copy)NSString *uptime;

//1：强制更新  2：不强制更新
@property(nonatomic,copy)NSString *uptype;

//二维码地址
@property (nonatomic,copy) NSString *qrc;


@end

NS_ASSUME_NONNULL_END
