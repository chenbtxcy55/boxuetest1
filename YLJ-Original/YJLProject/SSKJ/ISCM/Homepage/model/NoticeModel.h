//
//  NoticeModel.h
//  SSKJ
//
//  Created by 张本超 on 2019/7/24.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NoticeModel : NSObject
@property (nonatomic, strong) NSString *ID;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *create_time;

@property (nonatomic, strong) NSString *push_time;

@property (nonatomic,strong) NSString *content;

@end

NS_ASSUME_NONNULL_END
