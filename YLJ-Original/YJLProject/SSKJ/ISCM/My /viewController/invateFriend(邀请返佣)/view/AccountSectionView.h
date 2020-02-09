//
//  AccountSectionView.h
//  SSKJ
//
//  Created by 张本超 on 2019/4/18.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AccountSectionView : UIView
@property (nonatomic, copy) void(^btnClickedBlock)(NSInteger index);

@property (nonatomic, strong) UIButton *oneLabel;

@property (nonatomic, strong) UIButton *twoLabel;

@property (nonatomic, strong) UIButton *threeLabel;

@end

NS_ASSUME_NONNULL_END
