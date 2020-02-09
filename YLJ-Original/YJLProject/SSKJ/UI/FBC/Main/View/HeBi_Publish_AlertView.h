//
//  HeBi_Publish_AlertView.h
//  SSKJ
//
//  Created by 刘小雨 on 2019/4/15.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, PublishType) {
    PublishTypeBuy = 0,     // 发布购买
    PublishTypeSell = 1    // 发布出售
};
NS_ASSUME_NONNULL_BEGIN

@interface HeBi_Publish_AlertView : UIView

@property (nonatomic, copy) void (^confirmBlock)(NSString *pwd);
-(void)showWithPublishType:(PublishType)publishType price:(NSString *)price amount:(NSString *)amount;

-(void)hide;

@end

NS_ASSUME_NONNULL_END
