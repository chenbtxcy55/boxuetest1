//
//  JB_PledgeRecordItemView.h
//  SSKJ
//
//  Created by James on 2019/5/16.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JB_PledgeRecordItemView : UIView
@property (nonatomic, strong) UILabel *titleLB;
@property (nonatomic, strong) UILabel *subTitleLB;
- (void)updateSubTitle;
@end

NS_ASSUME_NONNULL_END
