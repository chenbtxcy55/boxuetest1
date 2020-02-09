//
//  HeBi_Publish_PayMethodView.h
//  SSKJ
//
//  Created by 刘小雨 on 2019/4/15.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JB_PayWayModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HeBi_Publish_PayMethodView : UIView
@property (nonatomic, strong,readonly) NSMutableArray *selectedPayMethodArray;

@property (nonatomic, strong) NSMutableArray *payMethodArray;
@end

NS_ASSUME_NONNULL_END
