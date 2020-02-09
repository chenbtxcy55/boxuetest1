//
//  HeBi_Publish_Limmit_View.h
//  SSKJ
//
//  Created by 刘小雨 on 2019/4/15.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HeBi_Publish_Limmit_View : UIView
@property (nonatomic, strong) UITextField *minTextField;
@property (nonatomic, strong) UITextField *maxTextField;

@property (nonatomic, copy) NSString *minlimmit;
@property (nonatomic, copy) NSString *maxlimmit;

@end

NS_ASSUME_NONNULL_END
