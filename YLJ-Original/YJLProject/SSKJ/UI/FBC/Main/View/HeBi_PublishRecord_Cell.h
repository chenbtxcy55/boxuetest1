//
//  HeBi_PublishRecord_Cell.h
//  SSKJ
//
//  Created by 刘小雨 on 2019/4/15.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeBi_Publish_AlertView.h"
#import "HeBi_FB_PublishRecord_Index_Model.h"
NS_ASSUME_NONNULL_BEGIN

@interface HeBi_PublishRecord_Cell : UITableViewCell

@property (nonatomic, copy) void (^cancleBlock)(void);

-(void)setCellWithPublishType:(PublishType)publishType;

-(void)setCellWithModel:(HeBi_FB_PublishRecord_Index_Model *)model;
@end

NS_ASSUME_NONNULL_END
