//
//  SSKJ_NoticeIndex_Model.h
//  SSKJ
//
//  Created by 刘小雨 on 2019/6/28.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SSKJ_NoticeIndex_Model : NSObject
@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *article_id;      // 时间
@property (nonatomic, copy) NSString *title;        // 标题内容
@property (nonatomic, copy) NSString *content;      // 内容
@property (nonatomic, copy) NSString *create_time;      // 时间
@property (nonatomic,copy) NSString *push_time;


@end

NS_ASSUME_NONNULL_END
