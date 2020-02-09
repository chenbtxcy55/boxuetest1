//
//  YLJOrderSubView.h
//  SSKJ
//
//  Created by cy5566 on 2019/11/20.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyLayout.h"

NS_ASSUME_NONNULL_BEGIN

@interface YLJOrderSubView : UIView
@property (nonatomic,strong)  UILabel *leftLabel;
@property (nonatomic,strong)  UILabel *rightLabel;
@property (nonatomic,strong)  UIButton *copyBtn;
@property (nonatomic,strong)  MyLinearLayout *hLayout;

@property (nonatomic, copy) void(^copyBlock)(void);

@end

NS_ASSUME_NONNULL_END
