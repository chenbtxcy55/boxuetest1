//
//  ActivateWarmAlertView.h
//  SSKJ
//
//  Created by zhao on 2019/10/9.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ActivateWarmAlertView : UIView
@property (nonatomic, strong) UILabel *titlelab;
@property (nonatomic, strong) UILabel *detailLab;
@property (nonatomic, strong) UIButton *cancleButton;
@property (nonatomic, strong) UIButton *confirmButton;
@property (nonatomic, copy) void (^confirmBlock)(void);
@property (nonatomic, copy) void (^cancelClickBlock)(void);

-(void)show;
-(void)hide;
@end

NS_ASSUME_NONNULL_END
