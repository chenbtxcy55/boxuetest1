//
//  YLJ_SetPwdViewController.h
//  SSKJ
//
//  Created by cy5566 on 2019/11/22.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "SSKJ_BaseViewController.h"
typedef NS_ENUM(NSInteger, SetPWDType) {
    SetPWDTypeDefault,
    SetPWDTypeSafeAdd,
    SetPWDTypeSafeEdit
};
NS_ASSUME_NONNULL_BEGIN

@interface YLJ_SetPwdViewController : SSKJ_BaseViewController
@property (nonatomic) SetPWDType type;


@end

NS_ASSUME_NONNULL_END
