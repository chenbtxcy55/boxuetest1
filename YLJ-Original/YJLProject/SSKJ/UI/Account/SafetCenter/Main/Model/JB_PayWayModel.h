//
//  JB_PayWayModel.h
//  SSKJ
//
//  Created by James on 2019/5/17.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JB_PayWayModel : NSObject
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *name;//姓名
@property (nonatomic, copy) NSString *number;//账号
@property (nonatomic, copy) NSString *img;//图片
@property (nonatomic, copy) NSString *type;//类型
@property (nonatomic, copy) NSString *status;//开启状态
@property (nonatomic, copy) NSString *tip;//类型名称
@property (nonatomic, copy) NSString *bank;
@property (nonatomic, copy) NSString *branch;



@end

NS_ASSUME_NONNULL_END
