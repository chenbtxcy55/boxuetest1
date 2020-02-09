//
//  HeBi_FBC_SegmentView.h
//  SSKJ
//
//  Created by 刘小雨 on 2019/4/12.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HeBi_FBC_SegmentView : UIView
@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, copy) void (^segmentBlock)(NSInteger index);

-(void)changeAmountBtnTitle:(NSString *)title;

@end

NS_ASSUME_NONNULL_END
